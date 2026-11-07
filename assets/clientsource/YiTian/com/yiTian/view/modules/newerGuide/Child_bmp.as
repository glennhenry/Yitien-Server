package com.yiTian.view.modules.newerGuide
{
   import com.utils.ComponentUtil;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.ResourceManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.MassLoader;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.utils.getTimer;
   
   public class Child_bmp extends Sprite
   {
      
      private static var GAP:int = 200;
      
      private var bmdVec:Vector.<BitmapData> = new Vector.<BitmapData>();
      
      private var bmp:Bitmap;
      
      private var totalWays:int;
      
      private var singWayFrame:int;
      
      private var playData:Vector.<BitmapData> = new Vector.<BitmapData>();
      
      public var _way:int = 7;
      
      private var posArr:Array = [];
      
      private var startTime:int;
      
      private var endTime:int;
      
      private var _count:int;
      
      public function Child_bmp()
      {
         super();
         this.bmp = new Bitmap();
         addChild(this.bmp);
         GameScene.mainLayer.addChild(this);
      }
      
      public function init(source:String) : void
      {
         if(!visible)
         {
            visible = true;
         }
         ResourceManager.load(source,MassLoader.LEVEL2);
         ResourceManager.addCount(source);
         MassLoader.add(source,this.comp,null,MassLoader.LEVEL2,null,Enum_resType.MODEL_URL);
      }
      
      private function comp(info:Object) : void
      {
         var c:Class = null;
         var _x:int = 0;
         var _y:int = 0;
         var bmd:BitmapData = null;
         info.content.init();
         this.totalWays = info.content.way;
         var rect:Array = info.content.rect;
         this.singWayFrame = info.content.actionFrame;
         var frameCount:int = this.totalWays * this.singWayFrame;
         var i:int = 0;
         while(i < frameCount)
         {
            c = info.applicationDomain.getDefinition("_" + i.toString());
            _x = int(rect[i][0]);
            _y = int(rect[i][1]);
            this.posArr.push([_x,_y]);
            bmd = new c();
            this.bmdVec.push(bmd);
            i++;
         }
         this.setWay(this._way);
      }
      
      public function setWay(way:int = 1) : void
      {
         var i:int = 0;
         var j:int = 0;
         if(way > 4)
         {
            scaleX = -1;
         }
         else
         {
            scaleX = 1;
         }
         way = way < 5 ? way : int(8 - way);
         var startF:int = way * this.singWayFrame;
         while(Boolean(this.playData.length))
         {
            this.playData.shift();
         }
         if(this.totalWays == 1)
         {
            i = 0;
            while(i < this.singWayFrame)
            {
               this.playData.push(this.bmdVec[i]);
               i++;
            }
         }
         else
         {
            j = startF;
            while(j < startF + this.singWayFrame)
            {
               this.playData.push(this.bmdVec[j]);
               j++;
            }
         }
      }
      
      public function addFrame() : void
      {
         this.startTime = getTimer();
         this._count = 0;
         if(!visible)
         {
            visible = true;
         }
         GameScene.instance.addFrameCallBack(this.play);
      }
      
      public function removeFrame() : void
      {
         this.pause();
         while(Boolean(this.playData.length))
         {
            this.playData.shift();
         }
         while(Boolean(this.bmdVec.length))
         {
            this.bmdVec.shift();
         }
         while(Boolean(this.posArr.length))
         {
            this.posArr.shift();
         }
         visible = false;
      }
      
      public function pause() : void
      {
         GameScene.instance.removeFrameCallBack(this.play);
         while(Boolean(this.playData.length))
         {
            this.playData.shift();
         }
         if(visible)
         {
            visible = false;
         }
      }
      
      private function play() : void
      {
         this.endTime = getTimer();
         if(this.endTime - this.startTime >= GAP)
         {
            ++this._count;
            if(this._count >= this.playData.length)
            {
               this._count = 0;
            }
            this.startTime = this.endTime;
         }
         if(Boolean(this.playData.length))
         {
            this.bmp.bitmapData = this.playData[this._count];
         }
         if(Boolean(this.posArr.length))
         {
            ComponentUtil.setPropertie(this.bmp,{
               "x":this.posArr[this._count][0],
               "y":this.posArr[this._count][1]
            });
         }
      }
      
      public function resetPos() : void
      {
         x = GameUnitManager.hero.global_x + 250;
         y = GameUnitManager.hero.global_y + 120;
      }
   }
}

