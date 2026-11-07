package com.yiTian.view.modules.boatChall
{
   import com.utils.DisplayData;
   import com.utils.ResObj;
   import com.yiTian.manager.ResourceManager;
   import com.yiTian.view.modules.ship.Ship;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.utils.getTimer;
   
   public class MapShipPart extends Sprite
   {
      
      private static var pool:Array = [];
      
      public var bm:Bitmap;
      
      private var boWen:Bitmap;
      
      private var type:int = 1;
      
      private var res2:ResObj;
      
      public var url:String = "modelRes/role/ship/stand/12345.swf";
      
      private var beginTime:int;
      
      public var ship:Ship;
      
      private var bmjianTou:Bitmap;
      
      private var isAddJianTou:Boolean = false;
      
      public function MapShipPart()
      {
         super();
         this.init();
      }
      
      public static function get instance() : MapShipPart
      {
         return pool.pop() || new MapShipPart();
      }
      
      private function init() : void
      {
         this.boWen = new Bitmap();
         addChild(this.boWen);
         this.bm = new Bitmap();
         addChild(this.bm);
         this.res2 = ResourceManager.resourceIndex["modelRes/role/ship/stand/35355.swf"];
         ResourceManager.load("modelRes/role/ship/stand/35355.swf",5);
         ResourceManager.addCount("modelRes/role/ship/stand/35355.swf");
         this.beginTime = getTimer();
      }
      
      public function addType(type:int = 1) : void
      {
         this.type = type;
      }
      
      public function update(way:int, global_x:int, global_y:int) : void
      {
         var res:ResObj = null;
         var go:Function = null;
         go = function():void
         {
            var data:DisplayData = null;
            var _now2:int = 0;
            var current2:int = 0;
            var data2:DisplayData = null;
            var now:int = getTimer();
            if(now - beginTime > 450)
            {
               beginTime = now;
            }
            var rate:Number = (now - beginTime) / 450;
            var _now:int = rate * res.actionFrame;
            if(_now >= res.actionFrame)
            {
               _now = res.actionFrame - 1;
            }
            var current:int = (way < 7 ? way : 12 - way) * res.actionFrame + _now;
            data = ResourceManager.find(res,current);
            bm.bitmapData = data.p;
            bm.x = data.x;
            bm.y = data.y;
            if(way > 6)
            {
               scaleX = -1 / 8;
            }
            else
            {
               scaleX = 1 / 8;
            }
            scaleY = 1 / 8;
            resize(global_x,global_y);
            if(ship.sign < 0)
            {
               return;
            }
            if(Boolean(res2) && res2.isLoad)
            {
               _now2 = rate * res2.actionFrame;
               if(_now2 >= res2.actionFrame)
               {
                  _now2 = res2.actionFrame - 1;
               }
               current2 = (way < 7 ? way : 12 - way) * res2.actionFrame + _now2;
               data2 = ResourceManager.find(res2,current2);
               boWen.bitmapData = data2.p;
               boWen.x = data2.x;
               boWen.y = data2.y;
            }
         };
         res = ResourceManager.resourceIndex[this.url];
         if(!res || !res.isLoad)
         {
            ResourceManager.registerResource(this.url,go);
         }
         else
         {
            go();
         }
      }
      
      public function resize(global_x:int, global_y:int) : void
      {
         if(this.type == 1)
         {
            x = global_x / 10;
            y = global_y / 10;
         }
         else
         {
            x = global_x / 20.3;
            y = global_y / 22.6;
         }
      }
      
      public function addJiaoTou() : void
      {
         if(!this.isAddJianTou)
         {
            this.isAddJianTou = true;
            graphics.beginFill(16646144,0);
            graphics.lineStyle(20,16646144,1);
            graphics.drawEllipse(-275,-150,550,300);
            graphics.endFill();
         }
      }
      
      public function removeJiaoTou() : void
      {
         graphics.clear();
         this.isAddJianTou = false;
      }
      
      public function dispose() : void
      {
         if(Boolean(parent))
         {
            parent.removeChild(this);
         }
         pool.push(this);
         this.type = 1;
         this.filters = [];
         this.removeJiaoTou();
      }
   }
}

