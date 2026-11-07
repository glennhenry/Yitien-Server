package com.yiTian.view.modules.farm
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.ui.Mouse;
   import flash.utils.Timer;
   
   public class View_farm_tool extends Sprite
   {
      
      public static const type_pick:uint = 1;
      
      public static const type_water:uint = 2;
      
      public static const type_sleep:uint = 3;
      
      private static const rotationAngle:Array = [[0,0],[0,0],[0,-60],[0,-60]];
      
      private static const speed:Number = 10;
      
      private var bitmap:Bitmap;
      
      private var timer:Timer;
      
      private var _type:uint;
      
      private var playing:Boolean;
      
      private var startAngle:Number;
      
      private var endAngle:Number;
      
      private var dir:int = 0;
      
      public function View_farm_tool()
      {
         super();
         this.bitmap = new Bitmap();
         this.addChild(this.bitmap);
         this.mouseEnabled = false;
         this.mouseChildren = false;
      }
      
      public function get type() : uint
      {
         return this._type;
      }
      
      public function set type(value:uint) : void
      {
         this._type = value;
      }
      
      public function setBitmapData(bd:BitmapData) : void
      {
         this.bitmap.bitmapData = bd;
         this.bitmap.x = -this.bitmap.width / 2;
         this.bitmap.y = -this.bitmap.height / 2;
      }
      
      public function play() : void
      {
         this.rotation = rotationAngle[this.type][1];
      }
      
      public function stop() : void
      {
         this.rotation = rotationAngle[this.type][0];
      }
      
      public function play0() : void
      {
         if(!this.timer)
         {
            this.timer = new Timer(100);
            this.timer.addEventListener(TimerEvent.TIMER,this.onTimer);
            this.timer.stop();
         }
         this.startAngle = rotationAngle[this.type][0];
         this.endAngle = rotationAngle[this.type][1];
         this.dir = this.startAngle - this.endAngle > 0 ? -1 : 1;
         this.timer.start();
         this.playing = true;
      }
      
      private function onTimer(evt:Event) : void
      {
         if(this.dir == 1)
         {
            this.startAngle += View_farm_tool.speed;
            this.rotation += View_farm_tool.speed;
         }
         else if(this.dir == -1)
         {
            this.endAngle -= View_farm_tool.speed;
            this.rotation -= View_farm_tool.speed;
         }
         else
         {
            this.playing = false;
            this.timer.stop();
            this.rotation = 0;
         }
         if(Math.abs(this.startAngle - this.endAngle) <= 50)
         {
            this.playing = false;
            this.timer.stop();
            this.rotation = 0;
            this.startAngle = 0;
            this.endAngle = 0;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            Mouse.hide();
         }
         else
         {
            Mouse.show();
         }
      }
   }
}

