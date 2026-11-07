package com.yiTian.view.modules.worldLevel
{
   import com.yiTian.Global;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.mainUIBtnContainer.Enum_mainUIBtn_hide;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_wlRewardBtn extends Sprite
   {
      
      private static var _instance:View_wlRewardBtn;
      
      private var _bg:Bitmap;
      
      public function View_wlRewardBtn()
      {
         super();
      }
      
      public static function get instance() : View_wlRewardBtn
      {
         if(!_instance)
         {
            _instance = new View_wlRewardBtn();
            _instance.init();
         }
         return _instance;
      }
      
      private function init() : void
      {
         this._bg = new Bitmap();
         this._bg = Utils.getLoadBitmap("resource/image/worldLevel/worldbtn.png",this._bg);
         buttonMode = true;
         addChild(this._bg);
         addEventListener(MouseEvent.CLICK,this.clickHandle);
         Global.control.registerCallBack(Enum_mainUIBtn_hide.MOVE_TO_HIDE,this.onHide);
      }
      
      private function onHide() : void
      {
         UIManager.mainUiBtnContainer.partPauseRemove(this,1);
      }
      
      private function clickHandle(evt:MouseEvent) : void
      {
         evt.stopPropagation();
         UIManager.worldLevReward.visible = !UIManager.worldLevReward.visible;
      }
   }
}

