package com.yiTian.view.modules.paoku.userCom.eComp
{
   import com.yiTian.view.modules.kupao.KPMap;
   import com.yiTian.view.modules.paoku.core.entity.Entity;
   import com.yiTian.view.modules.paoku.model.Model_KuPao;
   import com.yiTian.view.modules.paoku.userCom.KuPaoEntity;
   import com.yiTian.view.modules.paoku.userCom.KuPaoEntityMsgConst;
   import com.yiTian.view.modules.paoku.userCom.role.state.KuPaoRoleStates;
   
   public class HeroMoveCtrl extends EntityMoveCtrl
   {
      
      private var tempMsgObj:Object = {};
      
      public function HeroMoveCtrl()
      {
         super();
      }
      
      override public function enter(entity:Entity) : void
      {
         super.enter(entity);
         _entity.moveData.xPos = 0;
         _entity.moveData.yPos = 160;
         this.updateModelXY();
      }
      
      public function updateQuad() : void
      {
         _entity.quadRect.x = _entity.moveData.xPos - _entity.getQuad().width / 2;
         _entity.quadRect.y = _entity.moveData.yPos;
      }
      
      private function updateModelXY() : void
      {
         Model_KuPao.heroX = _entity.moveData.xPos;
         Model_KuPao.heroY = _entity.moveData.yPos;
      }
      
      override public function update(entity:Entity) : void
      {
         var e:KuPaoEntity = null;
         super.update(entity);
         Model_KuPao.movePixel = _entity.moveData.xPos;
         if(_entity.moveData.yPos >= 0)
         {
            if(_entity.moveData.yPos > 479)
            {
               if(!_entity.moveData.limitInScreen)
               {
                  _entity.moveData.yPos = 479;
               }
            }
         }
         this.updateModelXY();
         this.updateQuad();
         var gv:KPMap = KPMap.instance;
         if(_entity.moveData.xPos + gv._view.x < 0 || _entity.moveData.yPos <= 0)
         {
            this.gotoDieState();
            return;
         }
         var hurtInfo:Array = entity.getMsg(KuPaoEntityMsgConst.HURT);
         if(Boolean(hurtInfo))
         {
            entity.deleteMsg(KuPaoEntityMsgConst.HURT);
            entity.unAcceptMsg(KuPaoEntityMsgConst.HURT);
            _entity.deleteMsg(KuPaoEntityMsgConst.CHANGE_STATE);
            this.gotoDieState();
            return;
         }
         var rects:Array = KPMap.instance.getHitItems(_entity.getQuad());
         for each(e in rects)
         {
            if(e != _entity)
            {
               e.addMsg(KuPaoEntityMsgConst.HERO_HIT,entity);
            }
         }
      }
      
      private function gotoDieState() : void
      {
         if(Model_KuPao.getNumTool(Model_KuPao.INDEX_ENDFLOAT) > 0)
         {
            this.tempMsgObj.state = KuPaoRoleStates.ST_DIEFLOAT;
            _entity.addMsg(KuPaoEntityMsgConst.CHANGE_STATE,this.tempMsgObj);
            ++Model_KuPao.numDieFLoatUse;
         }
         else
         {
            this.tempMsgObj.state = KuPaoRoleStates.ST_DIE;
            _entity.addMsg(KuPaoEntityMsgConst.CHANGE_STATE,this.tempMsgObj);
         }
         _entity.unAcceptMsg(KuPaoEntityMsgConst.CHANGE_STATE);
      }
   }
}

