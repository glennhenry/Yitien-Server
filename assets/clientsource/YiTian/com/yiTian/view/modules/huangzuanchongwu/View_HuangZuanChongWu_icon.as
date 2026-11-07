package com.yiTian.view.modules.huangzuanchongwu
{
   import com.yiTian.Global;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_HuangZuanChongWu_icon extends Sprite
   {
      
      private static var _instance:View_HuangZuanChongWu_icon;
      
      private var bg:Bitmap;
      
      private var ef:Effect;
      
      public function View_HuangZuanChongWu_icon()
      {
         super();
      }
      
      public static function get instance() : View_HuangZuanChongWu_icon
      {
         if(!_instance)
         {
            _instance = new View_HuangZuanChongWu_icon();
            _instance.Init();
         }
         return _instance;
      }
      
      private function Init() : void
      {
         this.bg = Utils.getLoadBitmap("resource/image/huangzuanchongwu/huangzuanchongwu.png");
         this.buttonMode = true;
         this.addChild(this.bg);
         this.addEventListener(MouseEvent.CLICK,this.onClickHandle);
      }
      
      public function onClickHandle(e:MouseEvent = null) : void
      {
         Global.delegate.dosomething(View_hzcwPanel.instance,function():void
         {
            View_hzcwPanel.instance.visible = !View_hzcwPanel.instance.visible;
         });
      }
   }
}

