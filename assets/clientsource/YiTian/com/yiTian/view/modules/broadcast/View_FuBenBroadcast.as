package com.yiTian.view.modules.broadcast
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.UIBase;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.utils.getTimer;
   
   public class View_FuBenBroadcast extends UIBase
   {
      
      private static var _instance:View_FuBenBroadcast;
      
      private var OFFSETY:Number = 230;
      
      private var OFFSETX:Number = 600;
      
      private var START_Y:Number = 120;
      
      private var END_Y:Number = -80;
      
      private var TIME:Number = 1000;
      
      private var nowEff:DisplayObject;
      
      private var time:Number;
      
      public function View_FuBenBroadcast()
      {
         super();
         bindParent = GameScene.upUILayer;
         init();
      }
      
      public static function get instance() : View_FuBenBroadcast
      {
         if(!_instance)
         {
            _instance = new View_FuBenBroadcast();
         }
         return _instance;
      }
      
      override protected function initStaticView() : void
      {
         this.resetPosition();
      }
      
      override protected function initDynamicView() : void
      {
      }
      
      public function addEff(eff:DisplayObject) : void
      {
         this.visible = true;
         this.check();
         this.nowEff = eff;
         eff.y = 0;
         eff.alpha = 0;
         this.addChild(eff);
         if(eff.width != 0)
         {
            eff.x = -eff.width / 2;
         }
         Tween.to(eff,800,{"alpha":[0,1]},this.stop,null,Tween.EASYINOUT);
      }
      
      private function check() : void
      {
         if(Boolean(this.nowEff))
         {
            Tween.to(this.nowEff,500,{"alpha":[this.nowEff.alpha,0]},this.clear,null,Tween.EASYINOUT);
         }
      }
      
      private function stop() : void
      {
         this.time = getTimer();
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.getTime);
      }
      
      private function getTime() : void
      {
         if(getTimer() - this.time > 3000)
         {
            Tween.to(this.nowEff,800,{"alpha":[this.nowEff.alpha,0]},this.clear,null,Tween.EASYINOUT);
            this.nowEff = null;
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.getTime);
         }
      }
      
      private function clear(eff:DisplayObject) : void
      {
         if(eff is Effect)
         {
            (eff as Effect).dispose();
         }
         else if(eff is Bitmap)
         {
            (eff as Bitmap).bitmapData = null;
         }
         eff = null;
         if(!this.nowEff)
         {
            this.visible = false;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
      }
      
      override public function resetPosition() : void
      {
         y = Global.stage.stageHeight - this.OFFSETY;
         x = Global.stage.stageWidth - this.OFFSETX;
      }
   }
}

