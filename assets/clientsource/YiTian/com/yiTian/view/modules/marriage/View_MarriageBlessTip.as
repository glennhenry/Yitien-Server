package com.yiTian.view.modules.marriage
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.MarriageHandler;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_MarriageBlessTip extends Sprite
   {
      
      private static var _instance:View_MarriageBlessTip;
      
      private var _bg:Bitmap;
      
      public function View_MarriageBlessTip()
      {
         super();
         if(Boolean(_instance))
         {
            throw new Error("singlton error");
         }
         this.init();
         _instance = this;
      }
      
      public static function get instance() : View_MarriageBlessTip
      {
         if(_instance)
         {
         }
         return _instance;
      }
      
      private function init() : void
      {
         this._bg = new Bitmap();
         this._bg = Utils.getLoadBitmap("resource/image/marriage/Quickicon.png",this._bg);
         buttonMode = true;
         addChild(this._bg);
         addEventListener(MouseEvent.CLICK,this.clickHandle);
      }
      
      private function clickHandle(evt:MouseEvent) : void
      {
         evt.stopPropagation();
         if(!UIManager.getMarriageBlessPlane.visible)
         {
            MarriageHandler.CG_MARRIAGE_BLESS_OPEN();
         }
         else
         {
            UIManager.getMarriageBlessPlane.visible = false;
         }
      }
   }
}

