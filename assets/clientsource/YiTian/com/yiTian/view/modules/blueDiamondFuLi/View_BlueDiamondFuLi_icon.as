package com.yiTian.view.modules.blueDiamondFuLi
{
   import com.yiTian.Global;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_BlueDiamondFuLi_icon extends Sprite
   {
      
      private static var _instance:View_BlueDiamondFuLi_icon;
      
      private var bg:Bitmap;
      
      private var ef:Effect;
      
      public function View_BlueDiamondFuLi_icon()
      {
         super();
      }
      
      public static function get instance() : View_BlueDiamondFuLi_icon
      {
         if(!_instance)
         {
            _instance = new View_BlueDiamondFuLi_icon();
            _instance.Init();
         }
         return _instance;
      }
      
      private function Init() : void
      {
         this.bg = Utils.getLoadBitmap("resource/image/lanzuanfuli/lanzuanfuli.png");
         this.buttonMode = true;
         this.addChild(this.bg);
         this.addEventListener(MouseEvent.CLICK,this.onClickHandle);
      }
      
      public function onClickHandle(e:MouseEvent = null) : void
      {
         Global.delegate.dosomething(BlueDiamondFuLi_Panel.instance,function():void
         {
            BlueDiamondFuLi_Panel.instance.visible = !BlueDiamondFuLi_Panel.instance.visible;
         });
      }
   }
}

