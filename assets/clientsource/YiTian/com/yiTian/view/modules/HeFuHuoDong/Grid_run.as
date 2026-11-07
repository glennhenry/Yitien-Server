package com.yiTian.view.modules.HeFuHuoDong
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_HeFuHuoDong;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class Grid_run extends Sprite
   {
      
      private var id:int;
      
      private var firstItem:Array;
      
      private var vo_0:Vo_item;
      
      private var vo_1:Vo_item;
      
      private var grid_0:View_Grid;
      
      private var grid_1:View_Grid;
      
      private var totalItemID:Vector.<int>;
      
      private var totalItemIDCount:Vector.<int>;
      
      private const runSpeed:int = 10;
      
      public var curSpeed:int;
      
      private var endItem:Array;
      
      private var endGrid:View_Grid;
      
      private var otherGrid:View_Grid;
      
      private var isRunEnd:Boolean;
      
      public var running:Boolean;
      
      private var _curGrid:View_Grid;
      
      public function Grid_run(ID:int, itemArr:Array, item:String = null)
      {
         var i:* = undefined;
         super();
         if(item != null)
         {
            this.firstItem = item.split("_");
            if(this.firstItem[0] != 1)
            {
               throw new Error("Grid_run:item is not item!");
            }
            this.Init2();
         }
         else
         {
            this.Init();
         }
         if(Boolean(itemArr.length))
         {
            this.totalItemID = new Vector.<int>();
            this.totalItemIDCount = new Vector.<int>();
            for(i in itemArr)
            {
               this.totalItemID.push(Number(itemArr[i].split("_")[1]));
               this.totalItemIDCount.push(Number(itemArr[i].split("_")[2]));
            }
            var mask:Shape = ComponentUtil.getShape(40,40,0,1);
            addChild(mask);
            this.mask = mask;
            this.id = ID;
            return;
         }
         throw new Error("Grid_run:itemArr is empty!");
      }
      
      private function Init() : void
      {
         this.grid_0 = new View_Grid();
         this.grid_0.set_bmp_bg("resource/image/HeFuHuoDong/46395.png");
         this.grid_0.set_bmp_over(true,null);
         this.grid_0.set_tf_count();
         this.vo_0 = new Vo_item();
         addChild(this.grid_0);
         this._curGrid = this.grid_0;
         this.grid_1 = new View_Grid();
         this.grid_1.set_bmp_bg();
         this.grid_1.set_bmp_over(true,null);
         this.grid_1.set_tf_count();
         this.vo_1 = new Vo_item();
         this.grid_1.y = 40;
         addChild(this.grid_1);
      }
      
      private function Init2() : void
      {
         this.grid_0 = new View_Grid();
         this.grid_0.set_bmp_bg();
         this.grid_0.set_bmp_over(true,null);
         this.grid_0.set_tf_count();
         this.grid_0.count = this.firstItem[2];
         this.vo_0 = new Vo_item();
         this.vo_0.id = this.firstItem[1];
         this.vo_0.Init_lib();
         this.grid_0.vo = this.vo_0;
         addChild(this.grid_0);
         this._curGrid = this.grid_0;
         this.grid_1 = new View_Grid();
         this.grid_1.set_bmp_bg();
         this.grid_1.set_bmp_over(true,null);
         this.grid_1.set_tf_count();
         this.vo_1 = new Vo_item();
         this.grid_1.y = 40;
         addChild(this.grid_1);
      }
      
      public function setYaoJiang(flag:int) : void
      {
         if(Boolean(flag))
         {
            if(this.grid_0.y == 0)
            {
               this.grid_0.vo = null;
               this.grid_0.set_bmp_bg("resource/image/HeFuHuoDong/46393.png");
            }
            else if(this.grid_1.y == 0)
            {
               this.grid_1.vo = null;
               this.grid_1.set_bmp_bg("resource/image/HeFuHuoDong/46393.png");
            }
         }
         else if(this.grid_0.y == 0)
         {
            this.grid_0.vo = null;
            this.grid_0.set_bmp_bg("resource/image/HeFuHuoDong/46395.png");
         }
         else if(this.grid_1.y == 0)
         {
            this.grid_1.vo = null;
            this.grid_1.set_bmp_bg("resource/image/HeFuHuoDong/46395.png");
         }
      }
      
      public function setItem(itemStr:String) : void
      {
         if(this.running)
         {
            return;
         }
         var arr:Array = itemStr.split("_");
         if(this.grid_0.y == 0)
         {
            this.vo_0.id = arr[1];
            this.vo_0.Init_lib();
            this.grid_0.set_bmp_bg();
            this.grid_0.vo = this.vo_0;
            this.grid_0.count = arr[2];
         }
         else if(this.grid_1.y == 0)
         {
            this.vo_1.id = arr[1];
            this.vo_1.Init_lib();
            this.grid_1.set_bmp_bg();
            this.grid_1.vo = this.vo_1;
            this.grid_1.count = arr[2];
         }
      }
      
      public function Run(endItemStr:String) : void
      {
         if(this.running)
         {
            return;
         }
         this.running = true;
         this.endItem = endItemStr.split("_");
         this.curSpeed = this.runSpeed;
         this.addEventListener(Event.ENTER_FRAME,this.onFrame);
         Tween.to(this,2000,{"curSpeed":[0,10]},this.onComplete,null,Tween.EASYINOUT);
      }
      
      private function onComplete() : void
      {
         Tween.to(this,1000,{"curSpeed":[10,5]},this.onComplete2,null,Tween.EASYINOUT);
      }
      
      private function onComplete2() : void
      {
         this.isRunEnd = true;
         Tween.to(this,1000,{"curSpeed":[5,1]},null,null,Tween.EASYINOUT);
      }
      
      private function onFrame(e:Event) : void
      {
         var ranId:int = 0;
         var ranId_1:int = 0;
         this.grid_0.y += this.curSpeed;
         this.grid_1.y += this.curSpeed;
         if(this.grid_0.y > 40)
         {
            this.grid_0.set_bmp_bg();
            if(this.isRunEnd)
            {
               this.isRunEnd = false;
               this.vo_0.id = this.endItem[1];
               this.vo_0.Init_lib();
               this.grid_0.count = this.endItem[2];
               this.endGrid = this.grid_0;
               this.otherGrid = this.grid_1;
            }
            else
            {
               ranId = this.randomID();
               this.vo_0.id = this.totalItemID[ranId];
               this.vo_0.Init_lib();
               this.grid_0.count = this.totalItemIDCount[ranId];
            }
            this.grid_0.vo = this.vo_0;
            this.grid_0.y = this.grid_1.y - 40;
         }
         if(this.grid_1.y > 40)
         {
            this.grid_1.set_bmp_bg();
            if(this.isRunEnd)
            {
               this.isRunEnd = false;
               this.vo_1.id = this.endItem[1];
               this.vo_1.Init_lib();
               this.grid_1.count = this.endItem[2];
               this.endGrid = this.grid_1;
               this.otherGrid = this.grid_0;
            }
            else
            {
               ranId_1 = this.randomID();
               this.vo_1.id = this.totalItemID[ranId_1];
               this.vo_1.Init_lib();
               this.grid_1.count = this.totalItemIDCount[ranId_1];
            }
            this.grid_1.vo = this.vo_1;
            this.grid_1.y = this.grid_0.y - 40;
         }
         if(Boolean(this.endGrid))
         {
            if(this.endGrid.y > 0)
            {
               Tween.stop(this);
               this.endGrid.y = 0;
               this.otherGrid.y = 40;
               this._curGrid = this.endGrid;
               this.endGrid = null;
               this.otherGrid = null;
               this.removeEventListener(Event.ENTER_FRAME,this.onFrame);
               this.running = false;
               Global.control.sendNotification(Enum_HeFuHuoDong.GRID_RUN_COMPLETE,this.id);
            }
         }
      }
      
      private function randomID() : int
      {
         return Math.floor(Math.random() * this.totalItemID.length);
      }
      
      public function get curGrid() : View_Grid
      {
         if(Boolean(this._curGrid.vo) && Boolean(this._curGrid.vo.str_name))
         {
            return this._curGrid;
         }
         return null;
      }
   }
}

