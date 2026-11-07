package com.yiTian.gameUnit.magic
{
   import com.utils.DisplayData;
   import com.utils.ResObj;
   import com.utils.Util;
   import com.yiTian.data.config.Enum_magic_step;
   import com.yiTian.gameUnit.GameUnit;
   import com.yiTian.gameUnit.config.State;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.role.Door;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.ResourceManager;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.utils.Tween;
   import flash.display.Bitmap;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   
   public class Magic extends GameUnit
   {
      
      public static const PLAYWORD:int = 0;
      
      public static const PLAYTIME:int = 1;
      
      public static const ROTATION:int = 2;
      
      public static var pool:Array = [];
      
      public static var list:Dictionary = new Dictionary();
      
      private static var url_pool:Array = [];
      
      private static var magic_pool:Array = [];
      
      public var url:String;
      
      public var isLoop:Boolean;
      
      public var speed:int;
      
      private var init_x:int;
      
      private var init_y:int;
      
      private var _way:int;
      
      private var part:Bitmap = new Bitmap();
      
      private var current:int;
      
      private var totalTime:int;
      
      private var beginTime:int;
      
      private var playWord:String;
      
      private var _curFlag:Number = -1;
      
      private var steps:Array = [];
      
      private const reg:RegExp = /\((\w).*\)/gi;
      
      public function Magic()
      {
         super();
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      public static function clear_url_init() : void
      {
         var url_item:uint = 0;
         var i:int = 0;
         for each(url_item in url_pool)
         {
            clearTimeout(url_item);
         }
         url_pool.length = 0;
         i = magic_pool.length - 1;
         while(i >= 0)
         {
            (magic_pool[i] as Magic).dispose();
            i--;
         }
      }
      
      override public function show() : void
      {
         super.show();
         state = State.LIFE;
         addChild(this.part);
         list[id] = this;
      }
      
      public function init(id:Number, global_x:int, global_y:int, speed:int, isLoop:Boolean, sourceID:int, time:int) : void
      {
         this.id = id;
         this.global_x = global_x;
         this.global_y = global_y;
         this.speed = speed;
         this.isLoop = isLoop;
         this.url = "modelRes/magic/" + sourceID + ".swf";
         this.totalTime = time;
         this.beginTime = getTimer();
         ResourceManager.load(this.url);
      }
      
      public function set way(value:int) : void
      {
         this._way = value;
         this.part.scaleX = value < 2 ? 1 : -1;
      }
      
      public function get way() : int
      {
         return this._way;
      }
      
      public function url_init(id:Number, global_x:int, global_y:int, isLoop:Boolean, url:String, time:int, delay:Boolean = true, playWord:String = "") : void
      {
         this.id = id;
         this.playWord = playWord;
         this.global_x = global_x;
         this.global_y = global_y;
         this.init_x = global_x;
         this.init_y = global_y;
         this.isLoop = isLoop;
         this.url = "modelRes/magic/" + url + ".swf";
         this.totalTime = time;
         this.beginTime = getTimer();
         if(delay)
         {
            magic_pool.push(this);
            url_pool.push(setTimeout(function(param:Magic):void
            {
               ResourceManager.load(param.url,MassLoader.LEVEL7);
               GameUnitManager.addUnit(param);
               if(param.playWord != "")
               {
                  explainWord(param.playWord);
               }
            },Util.rnd(2000,5000),this));
         }
         else if(!GameUnitManager.findUnit(id,UnitType.MAGIC))
         {
            ResourceManager.load(this.url,MassLoader.LEVEL4);
            GameUnitManager.addUnit(this);
            if(playWord != "")
            {
               this.explainWord(playWord);
            }
         }
      }
      
      private function explainWord(word:String) : void
      {
         var arr:Array = word.split(";");
         var len:int = int(arr.length);
         var i:int = 0;
         while(i < len)
         {
            if(Boolean(arr[i]))
            {
               this.steps.push(arr[i]);
            }
            i++;
         }
         this._curFlag = -1;
         this.play();
      }
      
      private function play() : void
      {
         ++this._curFlag;
         if(this._curFlag >= this.steps.length)
         {
            this._curFlag = 0;
         }
         this.doStep(this.steps[this._curFlag]);
      }
      
      private function doStep(stepStr:String) : void
      {
         var stepData:Array = null;
         var way:int = 0;
         var k:int = 0;
         var r:int = 0;
         var x1:int = 0;
         var x2:int = 0;
         var tar_x:int = 0;
         var tar_y:int = 0;
         var tempStr:String = stepStr.match(this.reg)[0];
         var stepTime:int = int(tempStr.substring(1,tempStr.length - 1));
         var step:String = stepStr.replace(this.reg,"");
         var stepArr:Array = step.split(",");
         var len:int = int(stepArr.length);
         var stepObj:Object = {};
         var i:int = 0;
         for(; i < len; i++)
         {
            if(!Boolean(stepArr[i]))
            {
               continue;
            }
            stepData = (stepArr[i] as String).split(":");
            switch(stepData[0])
            {
               case Enum_magic_step.ALPHA:
                  stepObj.alpha = [alpha,stepData[1]];
                  break;
               case Enum_magic_step.XMOVE:
                  stepObj.x = [x,x + int(stepData[1])];
                  break;
               case Enum_magic_step.YMOVE:
                  stepObj.y = [y,y + int(stepData[1])];
                  break;
               case Enum_magic_step.RANDOM:
                  way = Util.rnd(0,3);
                  this.way = way;
                  r = int(stepData[1]);
                  if(way == 0 || way == 2)
                  {
                     k = 1;
                  }
                  else
                  {
                     k = -1;
                  }
                  x1 = (this.init_x + x + k * (y - this.init_y) - r) / 2;
                  x2 = (this.init_x + x + k * (y - this.init_y) + r) / 2;
                  if(way >= 0 && way <= 1)
                  {
                     tar_x = Util.rnd(x,Math.max(x1,x2));
                  }
                  else
                  {
                     tar_x = Util.rnd(Math.min(x1,x2),x);
                  }
                  tar_y = y - k * (tar_x - x);
                  stepTime = Math.sqrt(Util.dist(tar_x,tar_y,x,y)) / stepTime * 1000;
                  stepObj.x = [x,tar_x];
                  stepObj.y = [y,tar_y];
                  break;
               case Enum_magic_step.DELAY:
            }
         }
         if(stepTime > 500)
         {
            Tween.to(this,stepTime,stepObj,this.play);
         }
         else
         {
            this.play();
         }
      }
      
      override public function update(nowTime:int) : void
      {
         var now:int = 0;
         var index:int = 0;
         var data:DisplayData = null;
         var frameIndex:int = 0;
         if(nowTime - this.beginTime >= this.totalTime)
         {
            if(!this.isLoop)
            {
               GameUnitManager.removeUnit(this);
               return;
            }
            this.beginTime = nowTime;
         }
         var rate:Number = (nowTime - this.beginTime) / this.totalTime;
         var res:ResObj = ResourceManager.resourceIndex[this.url];
         if(Boolean(res) && res.isLoad)
         {
            now = rate * res.actionFrame;
            if(now >= res.actionFrame)
            {
               now = res.actionFrame - 1;
            }
            if(now == this.current && Boolean(this.part.bitmapData))
            {
               return;
            }
            this.current = now;
            if(res.way == 5)
            {
               index = (this.way < 5 ? this.way : 8 - this.way) * res.actionFrame + this.current;
            }
            else if(res.way == 2)
            {
               if(res.isSpecial)
               {
                  frameIndex = int(res.f[this.current]);
                  if(frameIndex == -1)
                  {
                     this.part.bitmapData = null;
                     return;
                  }
                  if(res.f[this.current] == undefined)
                  {
                     this.part.bitmapData = null;
                     return;
                  }
                  index = res.rect.length / res.way * (this.way < 2 ? this.way : 3 - this.way) + res.f[this.current];
               }
               else
               {
                  index = (this.way < 2 ? this.way : 3 - this.way) * res.actionFrame + this.current;
               }
            }
            else if(res.way == 1)
            {
               if(res.isSpecial)
               {
                  frameIndex = int(res.f[this.current]);
                  if(frameIndex == -1)
                  {
                     this.part.bitmapData = null;
                     return;
                  }
                  if(res.f[this.current] == undefined)
                  {
                     this.part.bitmapData = null;
                     return;
                  }
                  index = int(res.f[this.current]);
               }
               else
               {
                  index = this.current;
               }
            }
            data = ResourceManager.find(res,index);
            this.part.x = data.x;
            this.part.y = data.y;
            this.part.bitmapData = data.p;
         }
      }
      
      override public function align() : void
      {
         x = global_x;
         y = global_y;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.isLoop = false;
         rotation = 0;
         this.way = 0;
         this.steps = [];
         Tween.stop(this);
         delete list[id];
         var index:int = magic_pool.indexOf(this);
         if(index != -1)
         {
            magic_pool.splice(index,1);
         }
         if(!(this is Door))
         {
            pool.push(this);
         }
      }
   }
}

