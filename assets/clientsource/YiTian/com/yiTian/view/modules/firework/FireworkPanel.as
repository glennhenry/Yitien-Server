package com.yiTian.view.modules.firework
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.view.Panel123;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class FireworkPanel extends Panel123
   {
      
      private static var _instance:FireworkPanel;
      
      private static var NUM:int = 10;
      
      private var _effArr:Array = [];
      
      private var time:Timer;
      
      private var lastTime:uint;
      
      private var typeArr:Array = ["firework","firework1","firework2"];
      
      private var len:int = 0;
      
      private var _isrunning:Boolean = false;
      
      private var playCount:int = 0;
      
      public function FireworkPanel()
      {
         super();
         if(Boolean(_instance))
         {
            return;
         }
         init();
      }
      
      public static function get instance() : FireworkPanel
      {
         if(!_instance)
         {
            _instance = new FireworkPanel();
         }
         return _instance;
      }
      
      override protected function initDynamicView() : void
      {
         bindParent = GameScene.upUILayer;
         mouseEnabled = false;
         mouseChildren = false;
         this.time = new Timer(125);
         this.time.addEventListener(TimerEvent.TIMER,this.onTimer);
         this.len = this.typeArr.length;
      }
      
      private function onCalTime(interval:int) : void
      {
         var now:uint = uint(getTimer());
         if(now - this.lastTime > 10000)
         {
            if(Boolean(this.time))
            {
               this.time.stop();
               this.time.removeEventListener(TimerEvent.TIMER,this.onTimer);
               Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onCalTime);
            }
         }
      }
      
      protected function onTimer(event:TimerEvent) : void
      {
         var eff:Effect = null;
         var p:Point = this.effPos();
         var totalTime:int = 2000 + Math.random() * 1000;
         var index:int = int(this.len * Math.random());
         var effectName:String = this.typeArr[index];
         eff = EffectManager.addEffect(effectName,this,totalTime,p.x,p.y,false,3,function():void
         {
            EffectManager.removeEffect(eff);
            eff = null;
         });
         eff.scaleX = 2;
         eff.scaleY = eff.scaleX;
      }
      
      private function effPos() : Point
      {
         var p:Point = new Point(0,0);
         p.x = Global.stage.stageWidth * Math.random();
         p.y = Global.stage.stageHeight * Math.random();
         return p;
      }
      
      public function show(useName:String = "") : void
      {
         if(GameUnitManager.hero.level < 35)
         {
            return;
         }
         if(Boolean(useName.length) && useName != GameUnitManager.hero.name)
         {
            ++this.playCount;
         }
         if(this.playCount > 5 && useName != GameUnitManager.hero.name)
         {
            return;
         }
         visible = true;
         if(this._isrunning)
         {
            if(Boolean(this.time))
            {
               this.time.stop();
            }
            if(Global.control.hasCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onCalTime))
            {
               Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onCalTime);
            }
            this._isrunning = false;
         }
         if(Boolean(this.time))
         {
            this.time.addEventListener(TimerEvent.TIMER,this.onTimer);
            this.time.reset();
            this.time.start();
         }
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onCalTime);
         this.lastTime = getTimer();
         this._isrunning = true;
      }
      
      override public function resetPosition() : void
      {
         x = 0;
         y = 0;
      }
   }
}

