package com.yiTian.view.modules.farm
{
   import com.yiTian.Global;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.mainUIBtnContainer.Enum_mainUIBtn_hide;
   import com.yiTian.view.modules.mainUIBtnContainer.IMainUiBtn;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class ViewFarmIcon extends IMainUiBtn
   {
      
      private static var _instance:ViewFarmIcon;
      
      public static var isCLick:Boolean = true;
      
      private var _bg:Bitmap;
      
      private var effect:Effect;
      
      public function ViewFarmIcon()
      {
         super();
         if(Boolean(_instance))
         {
            throw new Error("singlton error");
         }
         this.init();
         _instance = this;
      }
      
      public static function get instance() : ViewFarmIcon
      {
         if(_instance)
         {
         }
         return _instance;
      }
      
      private function init() : void
      {
         this._bg = new Bitmap();
         bmUrl = "resource/image/myPath/farm.png";
         this._bg = Utils.getLoadBitmap(bmUrl,this._bg);
         buttonMode = true;
         addChild(this._bg);
         addEventListener(MouseEvent.CLICK,this.clickHandle);
         Global.control.registerCallBack(Enum_mainUIBtn_hide.MOVE_TO_HIDE,this.onHide);
      }
      
      public function clickHandle(evt:MouseEvent = null) : void
      {
         if(GameUnitManager.hero.status == Status.WU_LING || SceneConfig.getSceneType() == SceneConfig.KUNLUN || SceneConfig.getSceneType() == SceneConfig.BZ_BATTLE || SceneConfig.getSceneType() == SceneConfig.BZ_READY)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("182",9));
            return;
         }
         if(!UIManager.farm)
         {
            UIManager.farm = new View_farm();
            UIManager.farm.init();
         }
         UIManager.farm.visible = !UIManager.farm.visible;
      }
      
      public function addEffect() : void
      {
         if(!this.effect)
         {
            this.effect = EffectManager.addEffect("35343",this,1000,32,29,true);
         }
      }
      
      public function removeEffect() : void
      {
         if(Boolean(this.effect))
         {
            EffectManager.removeEffect(this.effect);
            this.effect = null;
         }
      }
      
      private function onHide() : void
      {
         UIManager.mainUiBtnContainer.partPauseRemove(this,1);
      }
   }
}

