package com.yiTian.view.modules.christmas
{
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ViewChristmasIcon extends Sprite
   {
      
      private static var _instance:ViewChristmasIcon;
      
      public static var isCLick:Boolean = true;
      
      private var _bg:Bitmap;
      
      private var effect:Effect;
      
      public function ViewChristmasIcon()
      {
         super();
         if(Boolean(_instance))
         {
            throw new Error("singlton error");
         }
         this.init();
         _instance = this;
      }
      
      public static function get instance() : ViewChristmasIcon
      {
         if(_instance)
         {
         }
         return _instance;
      }
      
      private function init() : void
      {
         this._bg = new Bitmap();
         this._bg = Utils.getLoadBitmap("resource/image/myPath/" + "christmas" + ".png",this._bg);
         buttonMode = true;
         addChild(this._bg);
         addEventListener(MouseEvent.CLICK,this.clickHandle);
      }
      
      public function clickHandle(evt:MouseEvent = null) : void
      {
         if(!UIManager.christmasView)
         {
            UIManager.christmasView = new ViewChristMas();
            UIManager.christmasView.init();
         }
         UIManager.christmasView.visible = !UIManager.christmasView.visible;
      }
   }
}

