package com.yiTian.view.modules.XianGou
{
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.net.message.cg.XianGouCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.utils.call.Delegate123;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_XianGou_icon extends Sprite
   {
      
      private static var _instance:View_XianGou_icon;
      
      private var bg:Bitmap;
      
      private var ef:Effect;
      
      public var firstInit:Boolean;
      
      public function View_XianGou_icon()
      {
         super();
         this.firstInit = true;
      }
      
      public static function get instance() : View_XianGou_icon
      {
         if(!_instance)
         {
            _instance = new View_XianGou_icon();
            _instance.Init();
         }
         return _instance;
      }
      
      private function Init() : void
      {
         this.bg = new Bitmap();
         this.bg = Utils.getLoadBitmap("resource/image/XianGou/XianGou.png",this.bg);
         this.buttonMode = true;
         this.addChild(this.bg);
         this.addEventListener(MouseEvent.CLICK,this.onClickHandle);
      }
      
      public function onClickHandle(e:MouseEvent = null) : void
      {
         if(Boolean(e))
         {
            e.stopPropagation();
         }
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(View_XianGou_menu.instance,function():void
         {
            View_XianGou_menu.instance.visible = !View_XianGou_menu.instance.visible;
            if(View_XianGou_menu.instance.visible)
            {
               XianGouCGMessage.CG_OPEN_MENU();
            }
            effectEnd();
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

