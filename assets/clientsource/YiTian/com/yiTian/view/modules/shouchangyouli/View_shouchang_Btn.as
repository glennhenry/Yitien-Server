package com.yiTian.view.modules.shouchangyouli
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_shouchang_Btn extends Sprite
   {
      
      private static var _instance:View_shouchang_Btn;
      
      private var _bg:Bitmap;
      
      public function View_shouchang_Btn()
      {
         super();
      }
      
      public static function get instance() : View_shouchang_Btn
      {
         if(!_instance)
         {
            _instance = new View_shouchang_Btn();
            _instance.init();
         }
         return _instance;
      }
      
      private function init() : void
      {
         this._bg = new Bitmap();
         this._bg = Utils.getLoadBitmap("resource/image/shouchang/shouchang.png",this._bg);
         buttonMode = true;
         addChild(this._bg);
         addEventListener(MouseEvent.CLICK,this.clickHandle);
      }
      
      private function clickHandle(evt:MouseEvent) : void
      {
         evt.stopPropagation();
         if(!UIManager.shouchang_panel)
         {
            UIManager.shouchang_panel = new View_shouchang_Panel();
         }
         UIManager.shouchang_panel.visible = !UIManager.shouchang_panel.visible;
      }
   }
}

