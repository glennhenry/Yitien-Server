package com.yiTian.view.modules.huaShanLunJian.util
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.modules.huaShanLunJian.model.Model_HuaShan;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class Child_HuaShanZhenXing extends Sprite
   {
      
      protected var bm_zhenFaBG:Bitmap;
      
      protected var _data:Object;
      
      protected var _roleArr:Array = [];
      
      protected var zfType:int;
      
      private var gridContainer:Sprite;
      
      private var roleLayer:Sprite;
      
      private var pool:Array = [];
      
      protected var dragRect:Rectangle;
      
      private var posTranMatrix:Matrix;
      
      private var antiPosTranMatrix:Matrix;
      
      private var gridArr:Array = [];
      
      private var _lastGrid:roleGrid;
      
      private var _isDraging:Boolean = false;
      
      private var _tweenCounter:uint;
      
      private var _counter1:int;
      
      private var last:int;
      
      private var playSpeed:int = 30;
      
      public function Child_HuaShanZhenXing()
      {
         super();
         this.init();
      }
      
      protected function init() : void
      {
         var gridStateArr:Array = null;
         var i:int = 0;
         var grid:roleGrid = null;
         var point:Point = null;
         var rPoint:Point = null;
         addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHd);
         this.gridContainer = new Sprite();
         addChild(this.gridContainer);
         this.roleLayer = new Sprite();
         addChild(this.roleLayer);
         this.dragRect = new Rectangle(0,0,400,300);
         this.posTranMatrix = new Matrix();
         this.posTranMatrix.a = HuaShanUtil.TEAMROLEVOFFSET;
         this.posTranMatrix.d = HuaShanUtil.TEAMROLEHOFFSET;
         this.posTranMatrix.rotate(-Math.PI * HuaShanUtil.TEAMROLEROTATE);
         var offsetMartix:Matrix = new Matrix();
         offsetMartix.scale(-1,74 / 135);
         this.posTranMatrix.concat(offsetMartix);
         this.antiPosTranMatrix = this.posTranMatrix.clone();
         this.antiPosTranMatrix.invert();
         gridStateArr = [2,2,2,2,2,2];
         i = 0;
         while(i < 6)
         {
            grid = new roleGrid();
            point = new Point(i % HuaShanUtil.TEAMVNUM,int(i / HuaShanUtil.TEAMVNUM));
            rPoint = this.posTranMatrix.transformPoint(point);
            grid.x = rPoint.x;
            grid.y = rPoint.y;
            grid.state = gridStateArr[i];
            this.gridArr.push(grid);
            this.gridContainer.addChild(grid);
            i += 1;
         }
      }
      
      public function set data(d:Array) : void
      {
         this._data = d;
      }
      
      public function refresh() : void
      {
         var tArr:Array = null;
         var intPos:int = 0;
         var type:int = 0;
         var xIndex:int = 0;
         var yIndex:int = 0;
         var role:Child_HuaShanZhenXingRole = null;
         var arr:Array = this._data as Array;
         this.removeAll();
         var i:int = 0;
         while(i < arr.length)
         {
            tArr = arr[i];
            intPos = tArr[Enum_HuaShan.ZX_POS] - 1;
            type = int(tArr[Enum_HuaShan.ZX_UNITTYPE]);
            xIndex = intPos % 10;
            yIndex = int(intPos / 10) - 1;
            role = Boolean(this.pool.length) ? this.pool.pop() : new Child_HuaShanZhenXingRole();
            role.TID = tArr[Enum_HuaShan.ZX_ROLEID];
            role.setModelID(tArr[Enum_HuaShan.ZX_ROLEMODELID]);
            role.xIndex = xIndex;
            role.yIndex = yIndex;
            role.way = 7;
            role.roleName = tArr[Enum_HuaShan.ZX_ROLENAME];
            role.type = tArr[Enum_HuaShan.ZX_UNITTYPE];
            this._roleArr.push(role);
            this.roleLayer.addChild(role);
            i += 1;
         }
         this.align();
      }
      
      public function removeAll() : void
      {
         var role:Child_HuaShanZhenXingRole = null;
         for each(role in this._roleArr)
         {
            Tween.stop(role);
            this.roleLayer.removeChild(role);
            this.pool.push(role);
         }
         this._roleArr.splice(0);
      }
      
      private function dragEnterFrame(event:Event) : void
      {
         var model:Model_HuaShan = null;
         var tarterGrid:roleGrid = null;
         model = Singleton.getInstance(Model_HuaShan) as Model_HuaShan;
         var __x:Number = mouseX;
         var __y:Number = mouseY;
         var point:Point = this.antiPosTranMatrix.transformPoint(new Point(__x,__y));
         var xIndex:int = Math.round(point.x);
         var yIndex:int = Math.round(point.y);
         if(this._isDraging && (yIndex < 0 || yIndex >= HuaShanUtil.TEAMHNUM || xIndex < 0 || xIndex >= HuaShanUtil.TEAMVNUM))
         {
            if(!model.currentDragRole)
            {
               removeEventListener(Event.ENTER_FRAME,this.dragEnterFrame);
               this.align(true);
               return;
            }
            tarterGrid = this.gridArr[model.currentDragRole.yIndex * HuaShanUtil.TEAMVNUM + model.currentDragRole.xIndex];
         }
         else
         {
            tarterGrid = this.gridArr[yIndex * HuaShanUtil.TEAMVNUM + xIndex];
         }
         if(Boolean(this._lastGrid))
         {
            this._lastGrid.rollOutHd(null);
         }
         if(Boolean(tarterGrid) && this._isDraging)
         {
            tarterGrid.rollOverHd(null);
            this._lastGrid = tarterGrid;
         }
         if(!model.currentDragRole)
         {
            model.freeDragRole();
            this.align(true);
            removeEventListener(Event.ENTER_FRAME,this.dragEnterFrame);
            return;
         }
         model.currentDragRole.x = mouseX;
         model.currentDragRole.y = mouseY;
      }
      
      protected function mouseDownHd(event:MouseEvent) : void
      {
         var target:Child_HuaShanZhenXingRole = null;
         var model:Model_HuaShan = null;
         this._isDraging = true;
         if(event.target is Child_HuaShanZhenXingRole)
         {
            target = event.target as Child_HuaShanZhenXingRole;
            model = Singleton.getInstance(Model_HuaShan) as Model_HuaShan;
            model.dragRole = target;
            addEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandle);
            addEventListener(Event.ENTER_FRAME,this.dragEnterFrame);
         }
      }
      
      protected function stageFocusOutHandle(event:FocusEvent) : void
      {
         var model:Model_HuaShan = Singleton.getInstance(Model_HuaShan) as Model_HuaShan;
         model.freeDragRole();
         this.align(true);
      }
      
      protected function mouseUpHandle(event:MouseEvent) : void
      {
         var __x:Number = NaN;
         var __y:Number = NaN;
         var point:Point = null;
         removeEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandle);
         removeEventListener(Event.ENTER_FRAME,this.dragEnterFrame);
         var model:Model_HuaShan = Singleton.getInstance(Model_HuaShan) as Model_HuaShan;
         if(this._isDraging)
         {
            __x = model.currentDragRole.x;
            __y = model.currentDragRole.y;
            point = this.antiPosTranMatrix.transformPoint(new Point(__x,__y));
            this.tranPosTo(model.currentDragRole,Math.round(point.x),Math.round(point.y));
            model.freeDragRole();
            this.align(true);
         }
         else
         {
            model.freeDragRole();
         }
         if(Boolean(this._lastGrid))
         {
            this._lastGrid.rollOutHd(null);
            this._lastGrid = null;
         }
         this._isDraging = false;
      }
      
      private function tranPosTo(role:Child_HuaShanZhenXingRole, xIndex:int, yIndex:int) : void
      {
         var dis:Child_HuaShanZhenXingRole = null;
         var arole:Child_HuaShanZhenXingRole = null;
         if(xIndex > HuaShanUtil.TEAMVNUM - 1 || xIndex < 0 || yIndex > HuaShanUtil.TEAMHNUM - 1 || yIndex < 0)
         {
            return;
         }
         for each(arole in this._roleArr)
         {
            if(arole.xIndex == xIndex && arole.yIndex == yIndex && arole != role)
            {
               dis = arole;
               break;
            }
         }
         if(Boolean(dis))
         {
            dis.xIndex = role.xIndex;
            dis.yIndex = role.yIndex;
         }
         role.xIndex = xIndex;
         role.yIndex = yIndex;
      }
      
      public function align(isTween:Boolean = false) : void
      {
         var role:Child_HuaShanZhenXingRole = null;
         var src_point:Point = null;
         var result_point:Point = null;
         this._tweenCounter = 0;
         for each(role in this._roleArr)
         {
            src_point = new Point(role.xIndex,role.yIndex);
            result_point = this.posTranMatrix.transformPoint(src_point);
            if(!isTween)
            {
               role.x = result_point.x;
               role.y = result_point.y;
            }
            else if(role.x != result_point.x || role.y != result_point.y)
            {
               this._tweenCounter += 1;
               Tween.to(role,400,{
                  "x":[role.x,result_point.x],
                  "y":[role.y,result_point.y]
               },this.comp,null,Tween.SIN);
            }
         }
         if(!isTween)
         {
            this.sort();
         }
      }
      
      private function comp() : void
      {
         var role:Child_HuaShanZhenXingRole = null;
         this._counter1 += 1;
         if(this._counter1 >= this._tweenCounter)
         {
            this.sort();
            for each(role in this._roleArr)
            {
               role.setAtt();
            }
            this._counter1 = this._tweenCounter = 0;
         }
      }
      
      private function sortCompareFun(a:DisplayObject, b:DisplayObject) : int
      {
         if(a.y > b.y)
         {
            return 1;
         }
         return -1;
      }
      
      private function sort() : void
      {
         var role:Child_HuaShanZhenXingRole = null;
         this._roleArr.sort(this.sortCompareFun);
         var i:int = 0;
         while(i < this._roleArr.length)
         {
            role = this._roleArr[i];
            if(this.roleLayer.getChildIndex(role) != i)
            {
               this.roleLayer.setChildIndex(role,i);
            }
            i += 1;
         }
      }
      
      public function run() : void
      {
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.frameHd);
      }
      
      public function stop() : void
      {
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.frameHd);
      }
      
      private function frameHd() : void
      {
         var role:Child_HuaShanZhenXingRole = null;
         var now:int = getTimer();
         if(now - this.last > this.playSpeed)
         {
            this.last = now;
            for each(role in this._roleArr)
            {
               role.update();
            }
         }
      }
      
      public function getTeamArr() : Array
      {
         return this._roleArr;
      }
   }
}

import com.utils.ComponentUtil;
import com.utils.Util;
import com.yiTian.Global;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.MouseEvent;

class roleGrid extends Sprite
{
   
   private static var bmd1:BitmapData;
   
   private static var bmd2:BitmapData;
   
   private var bm_bg:Bitmap;
   
   private var regPoint:Shape;
   
   private var _state:int;
   
   public function roleGrid()
   {
      super();
      this.regPoint = new Shape();
      addChild(this.regPoint);
      this.bm_bg = new Bitmap();
      this.bm_bg.x = -67.5;
      this.bm_bg.y = -36;
      addChild(this.bm_bg);
   }
   
   public function rollOverHd(event:MouseEvent) : void
   {
      transform.colorTransform = Util.colorWhite2;
   }
   
   public function rollOutHd(event:MouseEvent) : void
   {
      transform.colorTransform = Util.colorNomal;
   }
   
   private function getBMD1() : BitmapData
   {
      if(!bmd1)
      {
         bmd1 = ComponentUtil.getBitmapData("GridEmpty",Global.kuafuzhan_Imgsdm);
      }
      return bmd1;
   }
   
   private function getBMD2() : BitmapData
   {
      if(!bmd2)
      {
         bmd2 = ComponentUtil.getBitmapData("GridStand",Global.kuafuzhan_Imgsdm);
      }
      return bmd2;
   }
   
   public function set state(value:int) : void
   {
      this._state = value;
      switch(value)
      {
         case 1:
            this.bm_bg.bitmapData = this.getBMD1();
            break;
         case 2:
            this.bm_bg.bitmapData = this.getBMD2();
      }
   }
   
   public function get state() : int
   {
      return this._state;
   }
}
