package com.yiTian.view.modules.KuaFuPaiDui
{
   import com.yiTian.Global;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_KuaFuPaiDui_icon extends Sprite
   {
      
      private static var _instance:View_KuaFuPaiDui_icon;
      
      private var bg:Bitmap;
      
      private var ef:Effect;
      
      public function View_KuaFuPaiDui_icon()
      {
         super();
      }
      
      public static function get instance() : View_KuaFuPaiDui_icon
      {
         if(!_instance)
         {
            _instance = new View_KuaFuPaiDui_icon();
            _instance.Init();
         }
         return _instance;
      }
      
      private function Init() : void
      {
         this.bg = Utils.getLoadBitmap("resource/image/KuaFuPaiDui/icon.png");
         this.buttonMode = true;
         this.addChild(this.bg);
         this.addEventListener(MouseEvent.CLICK,this.onClickHandle);
      }
      
      public function onClickHandle(e:MouseEvent = null) : void
      {
         Global.delegate.dosomething(View_KuaFuPaiDui_rank.instance,function():void
         {
            View_KuaFuPaiDui_serverChoiceMenu.instance.visible = true;
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

