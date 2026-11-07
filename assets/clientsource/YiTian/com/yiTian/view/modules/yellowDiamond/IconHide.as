package com.yiTian.view.modules.yellowDiamond
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   
   public class IconHide
   {
      
      private static var _instance:IconHide;
      
      private var hideBtn:MainUIBtn;
      
      public function IconHide()
      {
         super();
      }
      
      public static function get instance() : IconHide
      {
         if(!_instance)
         {
            _instance = new IconHide();
         }
         return _instance;
      }
      
      public function show() : void
      {
      }
      
      private function cliHd(e:MouseEvent) : void
      {
         UIManager.qplusShare.visible = true;
      }
      
      public function hide() : void
      {
      }
   }
}

