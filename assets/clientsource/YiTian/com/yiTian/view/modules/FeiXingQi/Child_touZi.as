package com.yiTian.view.modules.FeiXingQi
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.utils.getTimer;
   
   public class Child_touZi extends Sprite
   {
      
      private var _num:int = 0;
      
      public var vx:Number;
      
      public var vy:Number;
      
      private var bm:Bitmap;
      
      private var _result:int;
      
      private var last:int;
      
      public var stepInterval:int = 50;
      
      public function Child_touZi()
      {
         super();
         this.bm = new Bitmap();
         this.bm.x = -20;
         this.bm.y = -20;
         addChild(this.bm);
      }
      
      public function set bmd(value:BitmapData) : void
      {
         this.bm.x = -value.width / 2;
         this.bm.y = -value.height / 2;
         this.bm.bitmapData = value;
      }
      
      public function roll(result:int) : void
      {
         this._result = result;
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.playStep);
      }
      
      public function endRoll() : void
      {
         this.bm.bitmapData = Enum_FeiXingQi.getTouZiBmd("S0" + this._result.toString());
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.playStep);
      }
      
      public function playStep() : void
      {
         var rnd:int = 0;
         var defineName:String = null;
         var now:int = getTimer();
         if(now - this.last > this.stepInterval)
         {
            rnd = Math.random() * 6 + 1;
            defineName = "X" + rnd.toString();
            this.bmd = Enum_FeiXingQi.getTouZiBmd(defineName);
            this.last = now;
         }
      }
   }
}

