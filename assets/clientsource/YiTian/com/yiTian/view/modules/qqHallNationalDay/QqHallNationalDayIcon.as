package com.yiTian.view.modules.qqHallNationalDay
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class QqHallNationalDayIcon extends Sprite
   {
      
      private static var _instance:QqHallNationalDayIcon;
      
      private var _bg:Bitmap;
      
      public function QqHallNationalDayIcon()
      {
         super();
         this.init();
      }
      
      public static function get instance() : QqHallNationalDayIcon
      {
         if(!_instance)
         {
            _instance = new QqHallNationalDayIcon();
         }
         return _instance;
      }
      
      private function init() : void
      {
         this._bg = new Bitmap();
         this._bg = Utils.getLoadBitmap("resource/image/myPath/" + "qqHallNationalDay.png",this._bg);
         buttonMode = true;
         addChild(this._bg);
         addEventListener(MouseEvent.CLICK,this.clickHandle);
      }
      
      private function clickHandle(evt:MouseEvent) : void
      {
         UIManager.qqHallNationalDay.visible = !UIManager.qqHallNationalDay.visible;
      }
   }
}

