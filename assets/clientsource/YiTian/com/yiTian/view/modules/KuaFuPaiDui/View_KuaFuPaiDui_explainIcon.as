package com.yiTian.view.modules.KuaFuPaiDui
{
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_KuaFuPaiDui_explainIcon extends Sprite
   {
      
      private static var _instance:View_KuaFuPaiDui_explainIcon;
      
      private var bg:Bitmap;
      
      private var ef:Effect;
      
      public function View_KuaFuPaiDui_explainIcon()
      {
         super();
      }
      
      public static function get instance() : View_KuaFuPaiDui_explainIcon
      {
         if(!_instance)
         {
            _instance = new View_KuaFuPaiDui_explainIcon();
            _instance.Init();
         }
         return _instance;
      }
      
      private function Init() : void
      {
         this.bg = Utils.getLoadBitmap("resource/image/KuaFuPaiDui/explain.png");
         this.buttonMode = true;
         this.addChild(this.bg);
         this.addEventListener(MouseEvent.CLICK,this.onClickHandle);
      }
      
      private function onClickHandle(e:MouseEvent = null) : void
      {
         View_KuaFuPaiDui_explainMenu.instance.visible = true;
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

