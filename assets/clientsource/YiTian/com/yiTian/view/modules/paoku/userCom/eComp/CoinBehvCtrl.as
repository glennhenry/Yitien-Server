package com.yiTian.view.modules.paoku.userCom.eComp
{
   import com.yiTian.view.modules.kupao.KPMap;
   import com.yiTian.view.modules.paoku.core.entity.Entity;
   import com.yiTian.view.modules.paoku.core.entity.MoveData;
   import com.yiTian.view.modules.paoku.core.entity.eComponent.IEntityCtrl;
   import com.yiTian.view.modules.paoku.model.Model_KuPao;
   import com.yiTian.view.modules.paoku.userCom.KuPaoEntity;
   import com.yiTian.view.modules.paoku.userCom.KuPaoEntityMsgConst;
   import com.yiTian.view.modules.paoku.userCom.role.EntityFactory;
   import flash.geom.Rectangle;
   
   public class CoinBehvCtrl implements IEntityCtrl
   {
      
      private var _target:KuPaoEntity;
      
      private var _autoMoveTargeMD:MoveData;
      
      public function CoinBehvCtrl()
      {
         super();
      }
      
      public function setName(v:String) : void
      {
      }
      
      public function getName() : String
      {
         return null;
      }
      
      public function setSortIndex(v:int) : void
      {
      }
      
      public function getSortIndex() : int
      {
         return 100000;
      }
      
      public function enter(entity:Entity) : void
      {
         this._target = entity as KuPaoEntity;
         this._autoMoveTargeMD = null;
      }
      
      public function exit(entity:Entity) : void
      {
         this._target = null;
      }
      
      public function update(entity:Entity) : void
      {
         var degree:Number = NaN;
         if(this._autoMoveTargeMD != null)
         {
            degree = Math.PI / 2 - Math.atan2(this._autoMoveTargeMD.xPos + this._autoMoveTargeMD.xSpeed - this._target.moveData.xPos,this._autoMoveTargeMD.yPos - this._target.moveData.yPos + 45);
            this._target.moveData.xPos += Math.cos(degree) * 40;
            this._target.moveData.yPos += Math.sin(degree) * 40;
         }
         var body:Array = entity.getMsg(KuPaoEntityMsgConst.HERO_HIT);
         entity.deleteMsg(KuPaoEntityMsgConst.HERO_HIT);
         if(body != null)
         {
            KPMap.instance.removeEntity(entity);
            ++Model_KuPao.gameingCoin;
            return;
         }
         this.updateQuad();
         body = entity.getMsg(KuPaoEntityMsgConst.AUTO_TOHERO);
         entity.deleteMsg(KuPaoEntityMsgConst.AUTO_TOHERO);
         if(body != null)
         {
            this._autoMoveTargeMD = (body[0] as KuPaoEntity).moveData;
            entity.unAcceptMsg(KuPaoEntityMsgConst.AUTO_TOHERO);
         }
         var view:KPMap = KPMap.instance;
         if(this._target.moveData.xPos < -view._view.x - 100)
         {
            view.removeEntity(entity);
         }
      }
      
      public function unActive(entity:Entity) : void
      {
         this._autoMoveTargeMD = null;
         this._target = null;
         EntityFactory.saveEntity(this._target,1);
      }
      
      public function active(entity:Entity) : void
      {
         this._autoMoveTargeMD = null;
         this._target = entity as KuPaoEntity;
         this.updateQuad();
      }
      
      public function updateQuad() : void
      {
         var quad:Rectangle = this._target.getQuad();
         quad.x = this._target.moveData.xPos - quad.width / 2;
         quad.y = this._target.moveData.yPos - quad.height / 2;
      }
   }
}

