package com.yiTian.view.modules.touzijijin
{
   import com.yiTian.Global;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_TouZiJiJin_Icon extends Sprite
   {
      
      private static var _instance:View_TouZiJiJin_Icon;
      
      private var bg:Bitmap;
      
      private var ef:Effect;
      
      public function View_TouZiJiJin_Icon()
      {
         super();
      }
      
      public static function get instance() : View_TouZiJiJin_Icon
      {
         if(!_instance)
         {
            _instance = new View_TouZiJiJin_Icon();
            _instance.Init();
         }
         return _instance;
      }
      
      private function Init() : void
      {
         this.bg = Utils.getLoadBitmap("resource/image/touzijijin/touzijijin.png");
         this.buttonMode = true;
         this.addChild(this.bg);
         this.addEventListener(MouseEvent.CLICK,this.onClickHandle);
      }
      
      protected function onClickHandle(event:MouseEvent) : void
      {
         Global.delegate.dosomething(View_TZJJPanel.instance,function():void
         {
            View_TZJJPanel.instance.visible = !View_TZJJPanel.instance.visible;
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

