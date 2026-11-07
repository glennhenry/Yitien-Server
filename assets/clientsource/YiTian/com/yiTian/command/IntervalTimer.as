package com.yiTian.command
{
   import com.yiTian.Global;
   
   public class IntervalTimer
   {
      
      protected var _interval:int;
      
      protected var _updateRecordTime:int;
      
      protected var _countTime:int;
      
      protected var _tickFun:Function;
      
      protected var _count:int;
      
      private var _isRun:Boolean = false;
      
      public function IntervalTimer()
      {
         super();
      }
      
      public function set interval(value:int) : void
      {
         this._interval = value;
      }
      
      public function get interval() : int
      {
         return this._interval;
      }
      
      public function start() : void
      {
         if(this._isRun)
         {
            return;
         }
         this._isRun = true;
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onFrame);
      }
      
      public function stop() : void
      {
         if(!this._isRun)
         {
            return;
         }
         this._isRun = false;
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onFrame);
      }
      
      public function set updateRecordTime(value:int) : void
      {
         this._updateRecordTime = value;
      }
      
      public function get updateRecordTime() : int
      {
         return this._updateRecordTime;
      }
      
      private function onFrame(time:int) : void
      {
         this._countTime += time;
         if(this._countTime >= this._interval)
         {
            this._countTime = 0;
            if(this._tickFun != null)
            {
               this._tickFun();
            }
         }
      }
      
      public function set tickFun(value:Function) : void
      {
         this._tickFun = value;
      }
      
      public function get tickFun() : Function
      {
         return this._tickFun;
      }
      
      public function dispose() : void
      {
         this._interval = 0;
         this._updateRecordTime = 0;
         this._count = 0;
         this._countTime = 0;
         this._tickFun = null;
      }
   }
}

