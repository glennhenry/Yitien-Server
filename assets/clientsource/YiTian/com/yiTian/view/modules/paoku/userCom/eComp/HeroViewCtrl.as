package com.yiTian.view.modules.paoku.userCom.eComp
{
   import com.ui.controls.MyTextField;
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.view.modules.kupao.KPMap;
   import com.yiTian.view.modules.paoku.core.entity.Entity;
   import com.yiTian.view.modules.paoku.core.entity.eComponent.IEntityCtrl;
   import com.yiTian.view.modules.paoku.userCom.KuPaoEntity;
   import com.yiTian.view.modules.paoku.userCom.KuPaoEntityMsgConst;
   import com.yiTian.view.modules.paoku.userCom.util.KuPaoUtil;
   import com.yiTian.view.modules.tianTi.Child_tianTiUnit;
   import flash.utils.Dictionary;
   
   public class HeroViewCtrl implements IEntityCtrl
   {
      
      private var _view:Child_tianTiUnit;
      
      private var _hero:KuPaoEntity;
      
      private var _tfPos:MyTextField;
      
      private var _effectDict:Dictionary = new Dictionary();
      
      public function HeroViewCtrl()
      {
         super();
      }
      
      public function setName(v:String) : void
      {
      }
      
      public function getName() : String
      {
         return "heroViewCtrl";
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
         this._view = new Child_tianTiUnit();
         this._view.type = Child_tianTiUnit.SPEC;
         this._view.state = Action.RUN;
         this.changeView();
         this._hero = entity as KuPaoEntity;
      }
      
      public function exit(entity:Entity) : void
      {
         this._hero = null;
      }
      
      public function update(entity:Entity) : void
      {
         var info:Object = null;
         var frameInterval:int = 0;
         var fi:int = 0;
         var act:int = 0;
         var body:Array = entity.getMsg(KuPaoEntityMsgConst.CHANGE_ACTIONVIEW);
         if(body != null)
         {
            info = body[body.length - 1];
            frameInterval = int(info.frameInterval);
            if(act > 1)
            {
               act = 1;
            }
            fi = Boolean(info.frameIndex) ? int(info.frameIndex) : -1;
            act = Boolean(info.action) ? int(info.action) : -1;
            this.changeView(act,-1,-1,frameInterval,fi);
            entity.deleteMsg(KuPaoEntityMsgConst.CHANGE_ACTIONVIEW);
            body = null;
         }
         this.processEffect(entity);
         this.processFilters(entity);
         this.updateView();
      }
      
      private function processEffect(entity:Entity) : void
      {
         var body:Array = null;
         var eff:Effect = null;
         var effectID:String = null;
         var effectInfo:Object = null;
         body = entity.getMsg(KuPaoEntityMsgConst.REMOVE_EFFECT);
         if(body != null)
         {
            for each(effectID in body)
            {
               eff = this._effectDict[effectID];
               if(eff != null)
               {
                  EffectManager.removeEffect(eff);
                  delete this._effectDict[effectID];
               }
            }
            entity.deleteMsg(KuPaoEntityMsgConst.REMOVE_EFFECT);
         }
         body = entity.getMsg(KuPaoEntityMsgConst.ADD_EFFECT);
         if(body != null)
         {
            for each(effectInfo in body)
            {
               if(effectInfo.isLoop == true)
               {
                  if(!this._effectDict[effectInfo.id])
                  {
                     this._effectDict[effectInfo.id] = EffectManager.addEffect(effectInfo.id,this._view,effectInfo.time,effectInfo.x,effectInfo.y,true);
                  }
               }
               else
               {
                  EffectManager.addEffect(effectInfo.id,this._view,effectInfo.time,effectInfo.x,effectInfo.y,false);
               }
            }
            entity.deleteMsg(KuPaoEntityMsgConst.ADD_EFFECT);
         }
      }
      
      private function processFilters(entity:Entity) : void
      {
         var body:Array = entity.getMsg(KuPaoEntityMsgConst.ADDFILTER);
         if(body != null)
         {
            entity.deleteMsg(KuPaoEntityMsgConst.REMOVE_EFFECT);
         }
      }
      
      public function updateView() : void
      {
         this._view.onFrame(30);
         this._view.x = KuPaoUtil.convertViewX(this._hero.moveData.xPos);
         this._view.y = KuPaoUtil.convertViewY(this._hero.moveData.yPos);
      }
      
      public function active(e:Entity) : void
      {
         KPMap.instance._view.addChild(this._view);
         this.updateView();
      }
      
      public function unActive(e:Entity) : void
      {
         KPMap.instance._view.removeChild(this._view);
      }
      
      public function changeView(state:int = -1, modelID:int = -1, way:int = -1, frameInt:int = 0, frameIndex:int = -1, horse:int = -1, wing:int = -1, weapon:int = -1, job:int = -1, sex:int = -1, scale:Number = 0.8) : void
      {
         this._view.modelId = GameUnitManager.hero.sex == 1 ? 80101 : 80102;
         this._view.way = way == -1 ? 2 : -1;
         this._view.setFrameInterval(frameInt <= 0 ? 100 : frameInt);
         this._view.updateLayer();
         this._view.state = state <= 0 ? Action.RUN : state;
         this._view.goto(frameIndex);
         this._view.invalidateView = true;
      }
   }
}

