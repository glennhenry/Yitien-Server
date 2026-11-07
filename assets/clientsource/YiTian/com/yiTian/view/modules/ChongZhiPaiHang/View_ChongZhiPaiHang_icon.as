package com.yiTian.view.modules.ChongZhiPaiHang
{
   import com.yiTian.net.message.cg.ChongZhiPaiHangCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_ChongZhiPaiHang_icon extends Sprite
   {
      
      private static var _instance:View_ChongZhiPaiHang_icon;
      
      public function View_ChongZhiPaiHang_icon()
      {
         super();
      }
      
      public static function get instance() : View_ChongZhiPaiHang_icon
      {
         if(!_instance)
         {
            _instance = new View_ChongZhiPaiHang_icon();
            _instance.Init();
         }
         return _instance;
      }
      
      private function Init() : void
      {
      }
      
      public function onClickHandle(e:MouseEvent = null) : void
      {
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(View_ChongZhiPaiHang_menu.instance,function():void
         {
            View_ChongZhiPaiHang_menu.instance.visible = !View_ChongZhiPaiHang_menu.instance.visible;
            if(View_ChongZhiPaiHang_menu.instance.visible)
            {
               ChongZhiPaiHangCGMessage.CG_OPEN_MENU();
            }
         });
      }
   }
}

