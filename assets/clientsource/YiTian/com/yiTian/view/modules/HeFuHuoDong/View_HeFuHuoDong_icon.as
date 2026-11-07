package com.yiTian.view.modules.HeFuHuoDong
{
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.utils.call.Delegate123;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_HeFuHuoDong_icon extends Sprite
   {
      
      private static var _instance:View_HeFuHuoDong_icon;
      
      private var bg:Bitmap;
      
      private var ef:Effect;
      
      public function View_HeFuHuoDong_icon()
      {
         super();
      }
      
      public static function get instance() : View_HeFuHuoDong_icon
      {
         if(!_instance)
         {
            _instance = new View_HeFuHuoDong_icon();
            _instance.Init();
         }
         return _instance;
      }
      
      private function Init() : void
      {
         this.bg = Utils.getLoadBitmap("resource/image/HeFuHuoDong/hefu.png");
         this.buttonMode = true;
         this.addChild(this.bg);
         this.addEventListener(MouseEvent.CLICK,this.onClickHandle);
      }
      
      public function onClickHandle(e:MouseEvent = null) : void
      {
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(View_HeFuHuoDong_menu.instance,function():void
         {
            View_HeFuHuoDong_menu.instance.visible = !View_HeFuHuoDong_menu.instance.visible;
         });
      }
      
      public function effectBegin() : void
      {
         if(!this.ef)
         {
            this.ef = EffectManager.addEffect("35343",this,1000,32,29,true);
         }
      }
      
      public function effectEnd() : void
      {
         if(Boolean(this.ef))
         {
            EffectManager.removeEffect(this.ef);
            this.ef = null;
         }
      }
   }
}

