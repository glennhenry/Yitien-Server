package com.yiTian.view.modules.XiaoFeiPaiHang
{
   import com.yiTian.net.message.cg.XiaoFeiPaiHangCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.utils.call.Delegate123;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class View_XiaoFeiPaiHang_icon extends Sprite
   {
      
      private static var _instance:View_XiaoFeiPaiHang_icon;
      
      private var bg:Bitmap;
      
      private var time_1:int = -1;
      
      public function View_XiaoFeiPaiHang_icon()
      {
         super();
      }
      
      public static function get instance() : View_XiaoFeiPaiHang_icon
      {
         if(!_instance)
         {
            _instance = new View_XiaoFeiPaiHang_icon();
            _instance.Init();
         }
         return _instance;
      }
      
      private function Init() : void
      {
         this.bg = new Bitmap();
         this.bg = Utils.getLoadBitmap("resource/image/XiaoFeiPaiHang/xiaofei.png");
         this.buttonMode = true;
         this.addChild(this.bg);
         this.addEventListener(MouseEvent.CLICK,this.onClickHandle);
      }
      
      public function onClickHandle(e:MouseEvent = null) : void
      {
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(View_XiaoFeiPaiHang_menu.instance,function():void
         {
            View_XiaoFeiPaiHang_menu.instance.visible = !View_XiaoFeiPaiHang_menu.instance.visible;
            if(View_XiaoFeiPaiHang_menu.instance.visible)
            {
               if(time_1 == -1)
               {
                  XiaoFeiPaiHangCGMessage.CG_OPEN_MENU();
               }
               else if(getTimer() - time_1 > 900000)
               {
                  time_1 = getTimer();
                  XiaoFeiPaiHangCGMessage.CG_OPEN_MENU();
               }
            }
         });
      }
   }
}

