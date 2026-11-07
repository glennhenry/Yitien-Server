package com.yiTian.view.modules.huangbang
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.view.modules.FeiXingQi.TouZiEvent;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class Child_ShaiziContainer extends Sprite
   {
      
      private var w:Number = 145;
      
      private var h:Number = 70;
      
      private var touzi:Child_Shaizi;
      
      private var eff:Effect;
      
      private var _mask:Shape;
      
      private var isHuangbang:Boolean;
      
      private var _result:int;
      
      private var result:int;
      
      private var dx:Number;
      
      private var dy:Number;
      
      public function Child_ShaiziContainer()
      {
         super();
         this._mask = new Shape();
         this._mask.graphics.beginFill(26316,0.2);
         this._mask.graphics.drawRect(-23,-47,150,151);
         this._mask.graphics.endFill();
         addChild(this._mask);
         mask = this._mask;
      }
      
      public function init() : void
      {
         this.touzi = new Child_Shaizi();
         var rnd:int = int(Math.random() * 6) + 1;
         this.touzi.bmd = Enum_Huangbang.getShaiZiBmd("X" + rnd.toString());
         this.touzi.x = this.w / 2;
         this.touzi.y = this.h / 2;
         addChild(this.touzi);
      }
      
      public function roll(value:int) : void
      {
         this.result = value;
         var dir:Number = Math.random() * Math.PI * 2;
         this.touzi.vx = 30 * Math.cos(dir);
         this.touzi.vy = 30 * Math.sin(dir);
         this.dx = this.touzi.vx * 0.01;
         this.dy = this.touzi.vy * 0.01;
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onFrame);
         this.touzi.roll(value);
      }
      
      private function onFrame(interval:int) : void
      {
         var nvx:Number = NaN;
         var nvy:Number = NaN;
         if(Math.abs(this.touzi.vx) < 0.3)
         {
            this.touzi.vx = 0;
         }
         if(Math.abs(this.touzi.vy) < 0.3)
         {
            this.touzi.vy = 0;
         }
         if(this.touzi.vx == 0 && this.touzi.vy == 0)
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onFrame);
            this.touzi.endRoll();
            dispatchEvent(new TouZiEvent(TouZiEvent.COMPLETE,this.result));
            return;
         }
         var nx:Number = this.touzi.x + this.touzi.vx;
         var ny:Number = this.touzi.y + this.touzi.vy;
         if(nx < 0)
         {
            nx = 0;
            this.touzi.vx = -this.touzi.vx;
            this.touzi.vx *= 0.95;
            this.touzi.vy *= 0.95;
         }
         else if(nx > this.w)
         {
            nx = this.w;
            this.touzi.vx = -this.touzi.vx;
            this.touzi.vx *= 0.95;
            this.touzi.vy *= 0.95;
         }
         if(ny < 0)
         {
            ny = 0;
            this.touzi.vy = -this.touzi.vy;
            this.touzi.vx *= 0.95;
            this.touzi.vy *= 0.95;
         }
         else if(ny > this.h)
         {
            ny = this.h;
            this.touzi.vy = -this.touzi.vy;
            this.touzi.vx *= 0.95;
            this.touzi.vy *= 0.95;
         }
         this.touzi.vx = this.touzi.vx * this.dx > 0 ? this.touzi.vx - this.dx : this.touzi.vx + this.dx;
         this.touzi.vy = this.touzi.vy * this.dy > 0 ? this.touzi.vy - this.dy : this.touzi.vy + this.dy;
         this.touzi.stepInterval = 900 / Math.sqrt(this.touzi.vx * this.touzi.vx + this.touzi.vy * this.touzi.vy);
         this.touzi.y = ny - 5 < -10 ? -10 : ny - 5;
         this.touzi.x = nx > 100 ? 100 : nx;
      }
   }
}

