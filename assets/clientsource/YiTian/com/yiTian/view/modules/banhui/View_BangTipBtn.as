package com.yiTian.view.modules.banhui
{
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_bang;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BangBattleCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.mainUIBtnContainer.Enum_mainUIBtn_hide;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_BangTipBtn extends Sprite
   {
      
      private static var _instance:View_BangTipBtn;
      
      private var _bm:Bitmap;
      
      private var effect:Effect;
      
      public function View_BangTipBtn()
      {
         super();
         if(Boolean(_instance))
         {
            throw new Error("singlon error");
         }
         this.init();
         _instance = this;
      }
      
      public static function isInstance() : Boolean
      {
         return _instance != null;
      }
      
      public static function get instance() : View_BangTipBtn
      {
         if(_instance)
         {
         }
         return _instance;
      }
      
      private function init() : void
      {
         this._bm = new Bitmap();
         this._bm = Utils.getLoadBitmap("resource/image/extralPng/bz.png",this._bm);
         addChild(this._bm);
         this.effect = EffectManager.addEffect("35343",this,1000,32,29,true);
         buttonMode = true;
         addEventListener(MouseEvent.CLICK,this.clickHandle);
         Global.control.registerCallBack(Enum_mainUIBtn_hide.MOVE_TO_HIDE,this.onHide);
      }
      
      private function clickHandle(evt:MouseEvent = null) : void
      {
         View_Alert.show(LangConfig.getWord("22521",2),View_Alert.OK_CANCAL,this.alertCallBack);
      }
      
      private function alertCallBack(evt:MouseEvent) : void
      {
         if(GameUnitManager.hero.level < 35)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("22522",2));
            return;
         }
         if(Model_bang.partyType == 1)
         {
            UIManager.centerBroadcast.addMsg("公共帮会不能参与帮会战");
            return;
         }
         if(GameUnitManager.hero.partyId == 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("22523",2));
            return;
         }
         if(Model_team.teamMumberInfo_data_save.length > 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("22524",2));
            return;
         }
         if(SceneConfig.getSceneType() != SceneConfig.COMMON)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("22525",2));
            return;
         }
         BangBattleCGMessage.CG_ENTER_BANG_BATTLE();
      }
      
      public function dispose() : void
      {
         removeEventListener(MouseEvent.CLICK,this.clickHandle);
         EffectManager.removeEffect(this.effect);
         this.effect = null;
         this._bm.bitmapData = null;
         this._bm = null;
         _instance = null;
      }
      
      private function onHide() : void
      {
         UIManager.mainUiBtnContainer.partPauseRemove(this,1);
      }
   }
}

