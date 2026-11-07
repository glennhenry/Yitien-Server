package com.yiTian.view.modules.broadcast
{
   import com.yiTian.Global;
   import com.yiTian.command.Control;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.effects.Effect_attribute;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.view.UIBase;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class View_heroBroadcast extends UIBase
   {
      
      private static const maxV:Number = 70;
      
      private static const g:Number = 300;
      
      private static const sv:Number = -230;
      
      private var viewerVec:Vector.<item>;
      
      private var _lastTime:int = -1;
      
      private var _queue:Array;
      
      private var _queueV:Vector.<Number>;
      
      private var _queueFun:Vector.<Function>;
      
      private const INTERVAL:int = 400;
      
      private var _parent:Sprite;
      
      private const MAXNUM:int = 20;
      
      private const FONTSIZE:int = 22;
      
      private var flag:Boolean = true;
      
      private var f:Boolean = false;
      
      private var _isRun:Boolean = false;
      
      private var _runTime:int = 0;
      
      public function View_heroBroadcast()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         this.setParent(GameUnitManager.hero,0,-70);
      }
      
      public function setParent(viewer:Sprite, offsetX:Number, offsetY:Number) : void
      {
         x = offsetX;
         y = offsetY;
         viewer.addChild(this);
         this._parent = viewer;
         bindParent = viewer;
      }
      
      override protected function initDynamicView() : void
      {
         this.viewerVec = new Vector.<item>();
         this._queue = [];
         this._queueV = new Vector.<Number>();
         this._queueFun = new Vector.<Function>();
         var c:Control = Global.control;
         c.registerCallBack(Enum_MsgType.MSG_ENTER_SCENE,this.setStop);
         c.registerCallBack(Enum_MsgType.MSG_ENTER_FUBEN,this.setStop);
         c.registerCallBack(Enum_MsgType.BATTLE_PLAY_START,this.setStop);
         c.registerCallBack(Enum_MsgType.MSG_ASK_CHANGE_SCENE_OK,this.setRun);
         c.registerCallBack(Enum_MsgType.MSG_ENTER_FUBEN_OK,this.setRun);
         c.registerCallBack(Enum_MsgType.BATTLE_PLAY_END,this.setRun);
         this.resetPosition();
      }
      
      protected function setStop(obj:Object) : void
      {
         if(this.f)
         {
            this.flag = false;
         }
         else
         {
            this.f = true;
         }
      }
      
      protected function setRun(obj:Object) : void
      {
         this.flag = true;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
      }
      
      override public function resetPosition() : void
      {
         y = -130;
      }
      
      public function get isRun() : Boolean
      {
         return this._isRun;
      }
      
      public function start() : void
      {
         this.visible = true;
         this._isRun = true;
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.step);
      }
      
      public function stop() : void
      {
         this.visible = false;
         this._isRun = false;
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.step);
      }
      
      public function addItem(arr:Array, vx:Number = 0, fun:Function = null) : void
      {
         if(this._queue.length > this.MAXNUM)
         {
            this._queue.shift();
            this._queueV.shift();
         }
         this._queue.push(arr);
         this._queueV.push(vx);
         this._queueFun.push(fun);
         if(!this.isRun)
         {
            this.start();
         }
      }
      
      public function addObj(obj:DisplayObject, vx:Number = 0, fun:Function = null) : void
      {
         if(this._queue.length > this.MAXNUM)
         {
            this._queue.shift();
            this._queueV.shift();
         }
         this._queue.push(obj);
         this._queueV.push(vx);
         this._queueFun.push(fun);
         if(!this.isRun)
         {
            this.start();
         }
      }
      
      private function step(interval:int) : void
      {
         var obj:Object = null;
         var pow:DisplayObject = null;
         var o:item = null;
         var it:item = null;
         var pow2:DisplayObject = null;
         var t:Number = NaN;
         if(!this.flag)
         {
            return;
         }
         this._runTime += interval;
         if(this._queue.length == 0 && this.viewerVec.length == 0)
         {
            this.stop();
         }
         if(this._queue.length > 0 && (this._lastTime <= 0 || this._runTime - this._lastTime > this.INTERVAL))
         {
            obj = this._queue.shift();
            if(obj is Array)
            {
               pow = Effect_attribute.pop(obj[0],obj[1]);
            }
            else
            {
               pow = obj as DisplayObject;
            }
            this._lastTime = this._runTime;
            o = new item();
            o.dObj = pow;
            pow.x = -pow.width / 2;
            o.vx = this._queueV.shift();
            o.vy = sv;
            o.onComplete = this._queueFun.shift();
            this.viewerVec.push(o);
            addChild(o.dObj);
         }
         var i:int = this.viewerVec.length - 1;
         while(i >= 0)
         {
            it = this.viewerVec[i];
            if(it.vy > maxV)
            {
               if(it.dObj is Effect_attribute)
               {
                  pow2 = it.dObj as Effect_attribute;
                  removeChild(pow2);
                  (pow2 as Effect_attribute).dispose();
                  this.viewerVec.splice(i,1);
                  it.dispose();
               }
               else
               {
                  pow2 = it.dObj;
                  if(it.onComplete != null)
                  {
                     if(Boolean(it.onComplete.length))
                     {
                        it.onComplete(it.dObj);
                     }
                     else
                     {
                        it.onComplete();
                     }
                  }
                  removeChild(pow2);
                  this.viewerVec.splice(i,1);
                  it.dispose();
               }
            }
            else
            {
               t = it.life / 1000;
               it.life += interval;
               it.vy = sv + g * t;
               it.dObj.y = sv * t + g * Math.pow(t,2) / 2;
               it.dObj.x += it.vx * t;
            }
            i--;
         }
      }
   }
}

import flash.display.DisplayObject;

class item
{
   
   public var vy:Number;
   
   public var vx:Number;
   
   public var dObj:DisplayObject;
   
   public var life:int;
   
   public var onComplete:Function;
   
   public function item()
   {
      super();
   }
   
   public function dispose() : void
   {
      this.vy = 0;
      this.vx = 0;
      this.life = 0;
      this.dObj = null;
   }
}
