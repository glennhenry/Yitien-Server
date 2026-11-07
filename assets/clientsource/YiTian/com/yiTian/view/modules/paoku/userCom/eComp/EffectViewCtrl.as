package com.yiTian.view.modules.paoku.userCom.eComp
{
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.view.modules.kupao.KPMap;
   import com.yiTian.view.modules.paoku.core.entity.Entity;
   import com.yiTian.view.modules.paoku.core.entity.eComponent.IEntityCtrl;
   import com.yiTian.view.modules.paoku.userCom.KuPaoEntity;
   import com.yiTian.view.modules.paoku.userCom.util.KuPaoUtil;
   
   public class EffectViewCtrl implements IEntityCtrl
   {
      
      public var effectID:String;
      
      public var time:int;
      
      public var effect:Effect;
      
      public var _target:KuPaoEntity;
      
      public var way:int = 1;
      
      public function EffectViewCtrl()
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
         return 10000;
      }
      
      public function enter(entity:Entity) : void
      {
         this._target = entity as KuPaoEntity;
      }
      
      public function exit(entity:Entity) : void
      {
         this._target = null;
      }
      
      public function update(entity:Entity) : void
      {
         if(this.effect == null)
         {
            return;
         }
         this.effect.invalidate = true;
         this.effect.px = this._target.moveData.xPos;
         this.effect.py = KuPaoUtil.convertViewY(this._target.moveData.yPos);
      }
      
      public function unActive(entity:Entity) : void
      {
         if(this.effect != null)
         {
            EffectManager.removeEffect(this.effect);
            this.effect = null;
         }
      }
      
      public function active(entity:Entity) : void
      {
         if(this.effect == null)
         {
            this.effect = EffectManager.addEffect(this.effectID,KPMap.instance._view,this.time,this._target.moveData.xPos,KuPaoUtil.convertViewY(this._target.moveData.yPos),true);
            this.effect.direct = 1;
         }
      }
   }
}

