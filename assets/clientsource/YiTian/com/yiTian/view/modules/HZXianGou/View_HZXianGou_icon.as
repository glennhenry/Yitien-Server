package com.yiTian.view.modules.HZXianGou
{
   import com.yiTian.Global;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_HZXianGou_icon extends Sprite
   {
      
      private static var _instance:View_HZXianGou_icon;
      
      private var bg:Bitmap;
      
      private var ef:Effect;
      
      public function View_HZXianGou_icon()
      {
         super();
      }
      
      public static function get instance() : View_HZXianGou_icon
      {
         if(!_instance)
         {
            _instance = new View_HZXianGou_icon();
            _instance.Init();
         }
         return _instance;
      }
      
      private function Init() : void
      {
         this.bg = Utils.getLoadBitmap("resource/image/huangzuanxiangou/Icon_HZXG.png");
         this.buttonMode = true;
         this.addChild(this.bg);
         this.addEventListener(MouseEvent.CLICK,this.onClickHandle);
      }
      
      public function onClickHandle(e:MouseEvent = null) : void
      {
         Global.delegate.dosomething(View_HZXianGou_Panel.instance,function():void
         {
            View_HZXianGou_Panel.instance.visible = !View_HZXianGou_Panel.instance.visible;
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

