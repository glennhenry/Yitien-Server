package com.yiTian.view.modules.ShengDan
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Bitmap2;
   import com.yiTian.utils.Pool;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class ShengDanUtil
   {
      
      private static var _btn:Button;
      
      private static var _timer:Timer;
      
      private static var _last:int;
      
      public static var selectedDelay:int = 300;
      
      private static var _frameInterval:int = 60;
      
      private static var _enabled:Boolean = true;
      
      public function ShengDanUtil()
      {
         super();
      }
      
      private static function getBtn() : Button
      {
         if(!_btn)
         {
            _btn = ComponentUtil.getButton("关","Button_Round",UIManager.heroHead,{
               "x":2,
               "y":75,
               "callBack":btnClick
            },Global.Img_Cdm);
            TipManager.bind(_btn,"点我可开关雪花飘落");
         }
         return _btn;
      }
      
      private static function btnClick(e:MouseEvent) : void
      {
         _enabled = !_enabled;
         _btn.label = _enabled ? "关" : "开";
         checkSceneToPlay2();
      }
      
      public static function addXueHua() : void
      {
         var xueHuaBM:Bitmap2 = null;
         var centerWidth:Number = NaN;
         var centerX:Number = NaN;
         var percentNum:Number = NaN;
         xueHuaBM = Pool.getObject(Bitmap2);
         xueHuaBM.y = 0;
         xueHuaBM.rotation = Math.random() * 360;
         var url:String = Math.random() > 0.3 ? "resource/image/ShengDan/xueHua1.png" : "resource/image/ShengDan/xueHua2.png";
         xueHuaBM.load(url);
         var scale:Number = Math.random() * 0.5 + 0.2;
         centerWidth = Global.stage.stageWidth * 0.75;
         centerX = (Global.stage.stageWidth - centerWidth) / 2;
         percentNum = Math.random();
         xueHuaBM.scaleX = xueHuaBM.scaleY = scale;
         GameScene.upUILayer.addChild(xueHuaBM);
         xueHuaBM.x = percentNum * Global.stage.stageWidth;
         var time:int = Math.random() * 1000 + 5000;
         Tween2.fromTo(xueHuaBM,time,{
            "y":[xueHuaBM.y,Global.stage.stageHeight],
            "x":[xueHuaBM.x,centerX + centerWidth * percentNum]
         },onTweenComplete);
      }
      
      public static function checkSceneToPlay() : void
      {
         var tip:String = null;
         if(Global.sceneMap == 13401)
         {
            getBtn().visible = true;
            tip = _btn.enabled ? "点击头像左边的【关】按钮可以取消雪花飘落" : "点击头像左边的【开】按钮可以激活雪花飘落";
            UIManager.centerBroadcast.addMsg(tip);
            if(selectedDelay > 0 && _enabled)
            {
               play(selectedDelay);
            }
            else
            {
               stop();
            }
         }
         else
         {
            if(Boolean(_btn))
            {
               getBtn().visible = false;
            }
            stop();
         }
      }
      
      public static function checkSceneToPlay2() : void
      {
         if(Global.sceneMap != 13401 || selectedDelay < 0 || !_enabled)
         {
            stop();
         }
         else
         {
            play(selectedDelay);
         }
      }
      
      public static function play(delay:uint = 300, repeatCount:int = 0, frameInterval:int = 60) : void
      {
         if(!_timer)
         {
            _timer = new Timer(delay);
         }
         _timer.repeatCount = repeatCount;
         _timer.addEventListener(TimerEvent.TIMER,onTimerTick);
         _timer.delay = delay;
         _timer.start();
         _frameInterval = frameInterval;
         Global.stage.addEventListener(Event.ENTER_FRAME,onFrame);
      }
      
      private static function onFrame(e:Event) : void
      {
         var now:int = getTimer();
         if(now - _last < _frameInterval)
         {
            return;
         }
         _last = now;
         Tween2.step();
      }
      
      public static function stop() : void
      {
         if(Boolean(_timer))
         {
            _timer.stop();
            if(_timer.hasEventListener(TimerEvent.TIMER))
            {
               _timer.removeEventListener(TimerEvent.TIMER,onTimerTick);
            }
         }
      }
      
      private static function onTimerTick(e:TimerEvent) : void
      {
         addXueHua();
      }
      
      private static function onTweenComplete(sp:Bitmap2) : void
      {
         sp.parent.removeChild(sp);
         sp.load(null);
         Pool.saveObject(sp);
         if(Tween2.getThreadLength() <= 0)
         {
            Global.stage.removeEventListener(Event.ENTER_FRAME,onFrame);
         }
      }
   }
}

import flash.utils.getTimer;

class Tween2
{
   
   private static var threads:Array = [];
   
   public function Tween2()
   {
      super();
   }
   
   public static function getThreadLength() : int
   {
      return threads.length;
   }
   
   public static function fromTo(target:Object, duration:uint, properity:Object, complete:Function) : void
   {
      var obj:Object = {};
      obj.target = target;
      obj.duration = duration;
      obj.properity = properity;
      obj.complete = complete;
      obj.startTime = getTimer();
      threads.push(obj);
   }
   
   public static function step() : void
   {
      var thread:Object = null;
      var percent:Number = NaN;
      var key:String = null;
      var now:int = getTimer();
      var i:int = threads.length - 1;
      while(i >= 0)
      {
         thread = threads[i];
         percent = (now - thread.startTime) / thread.duration;
         if(percent > 1)
         {
            percent = 1;
         }
         for(key in thread.properity)
         {
            thread.target[key] = (thread.properity[key][1] - thread.properity[key][0]) * percent + thread.properity[key][0];
         }
         if(percent >= 1)
         {
            threads.splice(i,1);
            thread.complete(thread.target);
         }
         i -= 1;
      }
   }
}
