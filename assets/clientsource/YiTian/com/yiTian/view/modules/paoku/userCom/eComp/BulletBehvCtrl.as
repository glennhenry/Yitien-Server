package com.yiTian.view.modules.paoku.userCom.eComp
{
   import com.yiTian.view.modules.kupao.KPMap;
   import com.yiTian.view.modules.paoku.core.entity.Entity;
   import com.yiTian.view.modules.paoku.model.Model_KuPao;
   import com.yiTian.view.modules.paoku.userCom.KuPaoEntity;
   import com.yiTian.view.modules.paoku.userCom.KuPaoEntityMsgConst;
   import com.yiTian.view.modules.paoku.userCom.role.EntityFactory;
   import flash.geom.Rectangle;
   import flash.utils.setTimeout;
   
   public class BulletBehvCtrl extends EntityMoveCtrl
   {
      
      private var _isHit:Boolean = false;
      
      public function BulletBehvCtrl()
      {
         super();
      }
      
      override public function enter(entity:Entity) : void
      {
         this._isHit = false;
         super.enter(entity);
      }
      
      override public function active(entity:Entity) : void
      {
         _entity = entity as KuPaoEntity;
         this.updateQuad();
         _entity.moveData.canCrossWall = true;
      }
      
      override public function update(entity:Entity) : void
      {
         var hitInfo:Array;
         var hero:KuPaoEntity = null;
         _entity.moveData.xSpeed = -10;
         super.update(entity);
         hitInfo = entity.getMsg(KuPaoEntityMsgConst.HERO_HIT);
         entity.deleteMsg(KuPaoEntityMsgConst.HERO_HIT);
         if(hitInfo != null && !this._isHit)
         {
            hero = hitInfo[0];
            this._isHit = true;
            if(Model_KuPao.numShieldUse <= 0 && Model_KuPao.getNumTool(Model_KuPao.INDEX_BULLET_SHEILD) > 0 || hero.moveData.imbaTime)
            {
               hitInfo[0].addMsg(KuPaoEntityMsgConst.REMOVE_EFFECT,"36131");
               ++Model_KuPao.numShieldUse;
               KPMap.instance.removeEntity(entity);
               if(hero.moveData.imbaTime == false)
               {
                  hero.moveData.imbaTime = true;
                  setTimeout(function():void
                  {
                     hero.moveData.imbaTime = false;
                  },1000);
               }
            }
            else
            {
               hero.addMsg(KuPaoEntityMsgConst.HURT,this);
               hero.addMsg(KuPaoEntityMsgConst.ADD_EFFECT,{
                  "id":"36133",
                  "time":700,
                  "x":0,
                  "y":-40,
                  "isLoop":false
               });
            }
         }
         if(_entity == null)
         {
            return;
         }
         this.updateQuad();
         if(_entity.moveData.xPos < -30)
         {
            KPMap.instance.removeEntity(_entity);
         }
      }
      
      override public function unActive(entity:Entity) : void
      {
         EntityFactory.saveEntity(_entity,100);
         _entity = null;
         this._isHit = false;
      }
      
      private function updateQuad() : void
      {
         var quad:Rectangle = _entity.getQuad();
         _entity.quadRect.x = _entity.moveData.xPos - quad.width / 2;
         _entity.quadRect.y = _entity.moveData.yPos - quad.height / 2;
      }
   }
}

