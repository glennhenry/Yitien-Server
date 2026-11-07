package com.yiTian.gameUnit.magic
{
   import com.utils.DisplayData;
   import com.utils.ResObj;
   import com.yiTian.gameUnit.IBattleUnit;
   import com.yiTian.manager.BattleUnitManager;
   import com.yiTian.manager.ResourceManager;
   import flash.display.Bitmap;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class BattleMagic extends IBattleUnit
   {
      
      public static var pool:Array = [];
      
      public static var list:Dictionary = new Dictionary();
      
      public var url:String;
      
      public var isLoop:Boolean;
      
      private var way:int;
      
      private var part:Bitmap = new Bitmap();
      
      private var current:int;
      
      private var totalTime:int;
      
      private var beginTime:int;
      
      private var _state:int;
      
      public function BattleMagic()
      {
         super();
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      override public function show() : void
      {
         addChild(this.part);
         list[id] = this;
      }
      
      public function init(id:int, init_x:int, init_y:int, isLoop:Boolean, sourceUrl:String, time:int) : void
      {
         this.id = id;
         this.x = init_x;
         this.y = init_y;
         this.isLoop = isLoop;
         this.url = sourceUrl;
         this.totalTime = time;
         this.beginTime = getTimer();
         ResourceManager.load(this.url);
      }
      
      public function get state() : int
      {
         return this._state;
      }
      
      public function set state(value:int) : void
      {
         this._state = value;
      }
      
      override public function update(now:int) : void
      {
         var index:int = 0;
         var data:DisplayData = null;
         var frameIndex:int = 0;
         if(now - this.beginTime >= this.totalTime)
         {
            if(!this.isLoop)
            {
               BattleUnitManager.removeUnit(this);
               return;
            }
            this.beginTime = now;
         }
         var rate:Number = (now - this.beginTime) / this.totalTime;
         var res:ResObj = ResourceManager.resourceIndex[this.url];
         var temp:int = rate * res.actionFrame;
         if(res.isLoad)
         {
            if(res.isSpecial)
            {
               frameIndex = int(res.f[temp]);
               if(frameIndex == -1)
               {
                  this.part.bitmapData = null;
                  return;
               }
               if(res.f[temp] == undefined)
               {
                  this.part.bitmapData = null;
                  return;
               }
               index = int(res.f[temp]);
            }
            else
            {
               index = temp;
            }
            if(index == this.current)
            {
               return;
            }
            this.current = index;
            data = ResourceManager.find(res,index);
            this.part.bitmapData = data.p;
            this.part.x = data.x;
            this.part.y = data.y;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.isLoop = false;
         rotation = 0;
         delete list[id];
         pool.push(this);
      }
   }
}

