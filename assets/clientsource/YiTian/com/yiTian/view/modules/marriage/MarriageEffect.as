package com.yiTian.view.modules.marriage
{
   import com.yiTian.Global;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class MarriageEffect
   {
      
      public static var bm:Bitmap;
      
      public static const WIDTH:int = 386;
      
      public static const HEIGHT:int = 384;
      
      private static const DELAY:int = 3000;
      
      private static var dir:int = 1;
      
      private static var isRun:Boolean = false;
      
      public function MarriageEffect()
      {
         super();
      }
      
      public static function runEffect() : void
      {
         var path:String = null;
         if(!MarriageConfig.startUsing)
         {
            return;
         }
         if(!bm)
         {
            path = "resource/image/marriage/End.png";
            bm = Utils.getLoadBitmap(path,null,null,run);
         }
         else
         {
            run();
         }
      }
      
      public static function run() : void
      {
         if(!isRun)
         {
            bm.alpha = 0;
            bm.x = Global.stage.stageWidth / 2 - WIDTH / 2;
            bm.y = Global.stage.stageHeight / 2 - HEIGHT / 2;
            GameScene.downUIDisabledLayer.addChild(bm);
            isRun = true;
            if(!bm.hasEventListener(Event.ENTER_FRAME))
            {
               bm.addEventListener(Event.ENTER_FRAME,onEnter);
            }
         }
      }
      
      private static function onEnter(evt:Event) : void
      {
         var timer:Timer = null;
         bm.alpha += 0.05 * dir;
         if(bm.alpha >= 1 && dir == 1)
         {
            timer = new Timer(DELAY,1);
            timer.addEventListener(TimerEvent.TIMER_COMPLETE,onTimerComplete);
            timer.start();
            bm.removeEventListener(Event.ENTER_FRAME,onEnter);
         }
         if(bm.alpha <= 0 && dir == -1)
         {
            end();
         }
      }
      
      private static function onTimerComplete(evt:TimerEvent) : void
      {
         dir = -dir;
         bm.addEventListener(Event.ENTER_FRAME,onEnter);
      }
      
      private static function end() : void
      {
         bm.removeEventListener(Event.ENTER_FRAME,onEnter);
         dir = 1;
         GameScene.downUIDisabledLayer.removeChild(bm);
         isRun = false;
      }
   }
}

