package com.yiTian.view.modules.WuLinMiXin
{
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.net.message.cg.WulinmixinCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.utils.call.Delegate123;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_WuLinMiXin_MainButton extends Sprite
   {
      
      private static var _instance:View_WuLinMiXin_MainButton;
      
      private var _bg:Bitmap;
      
      private var ef:Effect;
      
      public function View_WuLinMiXin_MainButton()
      {
         super();
      }
      
      public static function get instance() : View_WuLinMiXin_MainButton
      {
         if(!_instance)
         {
            _instance = new View_WuLinMiXin_MainButton();
            _instance.init();
         }
         return _instance;
      }
      
      private function init() : void
      {
         this._bg = new Bitmap();
         this._bg = Utils.getLoadBitmap("resource/image/WuLinMiXin/WuLinMiXin.png",this._bg);
         this.buttonMode = true;
         this.addChild(this._bg);
         this.addEventListener(MouseEvent.CLICK,this.onClickHandle);
      }
      
      public function onClickHandle(e:MouseEvent = null) : void
      {
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(View_WuLinMiXin_MainMenu.instance,function():void
         {
            View_WuLinMiXin_MainMenu.instance.visible = !View_WuLinMiXin_MainMenu.instance.visible;
            WulinmixinCGMessage.CG_OPEN_MENU();
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

