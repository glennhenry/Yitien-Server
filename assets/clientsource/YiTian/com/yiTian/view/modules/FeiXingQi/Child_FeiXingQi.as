package com.yiTian.view.modules.FeiXingQi
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.net.message.cg.FeiXingQiCGMessage;
   import com.yiTian.utils.Tween;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class Child_FeiXingQi extends Sprite
   {
      
      private var _mask:Shape;
      
      private var contaner:Sprite;
      
      private var mapBG:Bitmap;
      
      private var lastX:Number;
      
      private var lastY:Number;
      
      private const DELAY:int = 500;
      
      private var counter:int = 0;
      
      public function Child_FeiXingQi()
      {
         super();
         this.contaner = new Sprite();
         addChild(this.contaner);
         this.mapBG = new Bitmap();
         this.mapBG.x = -Enum_FeiXingQi.FXQMASKMENDX;
         this.mapBG.y = -Enum_FeiXingQi.FXQMASKMENDY;
         this.contaner.addChild(this.mapBG);
         this._mask = ComponentUtil.getShape(Enum_FeiXingQi.FXQMASKW,Enum_FeiXingQi.FXQMASKH,16711935,0.3);
         addChild(this._mask);
         mask = this._mask;
         Global.control.registerCallBack(Enum_MsgType.FXQ_FRAME,this.onFrame);
         addEventListener(MouseEvent.MOUSE_DOWN,this.mDownHd);
         addEventListener(MouseEvent.MOUSE_UP,this.mUpHd);
         addEventListener(MouseEvent.ROLL_OUT,this.rollOutHd);
      }
      
      private function createTile(dic:Dictionary) : void
      {
         var tileArr:Array = null;
         var i:int = 0;
         var o:DisplayObject = null;
         var dicArr:Array = null;
         var tileY:int = 0;
         var tileX:int = 0;
         var tile:Child_FeiXingQiTile = null;
         var pos:Point = null;
         var tId:int = 0;
         var bm:Bitmap = null;
         var LEN:int = Enum_FeiXingQi.NUMTILE;
         var TILEW:int = Enum_FeiXingQi.TILEW;
         var TILEH:int = Enum_FeiXingQi.TILEH;
         tileArr = Model_FeiXingQi.tileArr;
         i = 0;
         while(i <= LEN)
         {
            dicArr = Data_lib.fxqMap[i];
            if(!dicArr)
            {
               break;
            }
            tileY = int(dicArr[0]);
            tileX = int(dicArr[1]);
            tile = new Child_FeiXingQiTile();
            pos = Enum_FeiXingQi.getPoint(tileY,tileX);
            tile.y = Enum_FeiXingQi.getTileYOffset(i);
            tile.x = Enum_FeiXingQi.getTileXOffset(i);
            tId = 1 + Math.random() * 7;
            bm = new Bitmap();
            tile.addChild(bm);
            this.contaner.addChild(tile);
            tileArr.push(tile);
            i += 1;
         }
         var arr:Array = Enum_FeiXingQi.depthSort(tileArr);
         for each(o in arr)
         {
            this.contaner.addChild(o);
         }
      }
      
      private function mDownHd(evt:MouseEvent) : void
      {
         this.lastX = mouseX;
         this.lastY = mouseY;
         addEventListener(MouseEvent.MOUSE_MOVE,this.mMoveHd);
         Tween.stop(this.contaner);
      }
      
      private function mUpHd(evt:MouseEvent) : void
      {
         removeEventListener(MouseEvent.MOUSE_MOVE,this.mMoveHd);
         this.toRect();
      }
      
      private function rollOutHd(evt:MouseEvent) : void
      {
         removeEventListener(MouseEvent.MOUSE_MOVE,this.mMoveHd);
         this.toRect();
      }
      
      private function toRect() : void
      {
         var px:Number = this.contaner.x;
         var py:Number = this.contaner.y;
         var mW:Number = Enum_FeiXingQi.FXQMASKW - Enum_FeiXingQi.FXQWIDTH;
         var mH:Number = Enum_FeiXingQi.FXQMASKH - Enum_FeiXingQi.FXQHEIGHT;
         var dx:Number = this.contaner.x;
         var dy:Number = this.contaner.y;
         if(px > 0)
         {
            dx = 0;
         }
         else if(px < mW)
         {
            dx = mW;
         }
         if(py > 0)
         {
            dy = 0;
         }
         else if(py < mH)
         {
            dy = mH;
         }
         Tween.to(this.contaner,300,{
            "x":[this.contaner.x,dx],
            "y":[this.contaner.y,dy]
         },null,null,Tween.SIN);
      }
      
      private function mMoveHd(evt:MouseEvent) : void
      {
         var nxtY:Number = NaN;
         var nxtX:Number = this.contaner.x + mouseX - this.lastX;
         nxtY = this.contaner.y + mouseY - this.lastY;
         var mW:Number = Enum_FeiXingQi.FXQMASKW - Enum_FeiXingQi.FXQWIDTH - Enum_FeiXingQi.FXQMASKMENDX;
         var mH:Number = Enum_FeiXingQi.FXQMASKH - Enum_FeiXingQi.FXQHEIGHT - Enum_FeiXingQi.FXQMASKMENDY;
         if(nxtX > Enum_FeiXingQi.FXQMASKMENDX)
         {
            nxtX = Enum_FeiXingQi.FXQMASKMENDX;
         }
         else if(nxtX < mW)
         {
            nxtX = mW;
         }
         if(nxtY > Enum_FeiXingQi.FXQMASKMENDY)
         {
            nxtY = Enum_FeiXingQi.FXQMASKMENDY;
         }
         else if(nxtY < mH)
         {
            nxtY = mH;
         }
         this.contaner.x = nxtX;
         this.contaner.y = nxtY;
         this.lastX = mouseX;
         this.lastY = mouseY;
      }
      
      private function onFrame(interval:int) : void
      {
         this.counter += interval;
         if(this.counter > this.DELAY)
         {
            this.counter = 0;
            this.depthSort();
         }
      }
      
      private function onToNxtC(unit:Child_FeiXingQiUnit) : void
      {
         unit.tileIndex += 1;
         unit.way = Enum_FeiXingQi.getUnitWay(unit.tileIndex);
         unit.updateAniIm();
         if(unit.stepRemain > 0)
         {
            this.unitTweenToNxt(unit);
         }
         else if(unit.tileIndex != unit.targetIndex)
         {
            this.flyFromTo(unit,unit.tileIndex,unit.targetIndex);
         }
         else
         {
            if(unit.id == GameUnitManager.hero.id)
            {
               FeiXingQiCGMessage.CG_FXQTODISCOMPLETE(Model_FeiXingQi.version);
               Model_FeiXingQi.isTween = false;
            }
            unit.state = Action.STAND;
         }
      }
      
      private function flyFromTo(unit:Child_FeiXingQiUnit, sIndex:int, eIndex:int) : void
      {
         var way:int = Enum_FeiXingQi.getUnitWayFromTo(sIndex,eIndex);
         unit.aniTime = Enum_FeiXingQi.FLAYANITIME;
         unit.way = way;
         unit.updateAniIm();
         var map:Dictionary = Data_lib.fxqMap;
         var arr2:Array = map[eIndex];
         var p2:Point = new Point(Enum_FeiXingQi.getTileXOffset(eIndex),Enum_FeiXingQi.getTileYOffset(eIndex));
         var dx:Number = Enum_FeiXingQi.getTileXOffset(eIndex);
         var dy:Number = Enum_FeiXingQi.getTileYOffset(eIndex);
         Tween.to(unit,2000,{
            "x":[unit.x,dx],
            "y":[unit.y,dy]
         },this.flyC,null,Tween.EASYINOUT);
      }
      
      private function flyC(unit:Child_FeiXingQiUnit) : void
      {
         unit.state = Action.STAND;
         unit.aniTime = Enum_FeiXingQi.PLAYERANITIME;
         if(unit.id == GameUnitManager.hero.id)
         {
            FeiXingQiCGMessage.CG_FXQTODISCOMPLETE(Model_FeiXingQi.version);
            Model_FeiXingQi.isTween = false;
         }
      }
      
      public function align() : void
      {
         var u:Child_FeiXingQiUnit = null;
         var i:int = 0;
         var tmp:Array = [];
         for each(u in Model_FeiXingQi.unitArr)
         {
            if(u.tileIndex == 0)
            {
               tmp.push(u);
            }
         }
         i = 0;
         while(i < tmp.length)
         {
            tmp[i].x = Enum_FeiXingQi.getTileXOffset(0) - (tmp.length - 1) * 7 + i * 14;
            tmp[i].y = Enum_FeiXingQi.getTileYOffset(0) - (tmp.length - 1) * 4 + i * 8;
            i += 1;
         }
      }
      
      public function loadBg() : void
      {
         this.mapBG.bitmapData = Enum_FeiXingQi.getTouZiBmd("Back_Image");
      }
      
      public function depthSort() : void
      {
         var arr:Array = Enum_FeiXingQi.depthSort(Model_FeiXingQi.unitArr,Model_FeiXingQi.embellishs);
         var i:int = 0;
         while(i < arr.length)
         {
            this.contaner.addChild(arr[i]);
            i += 1;
         }
      }
      
      public function watch(px:Number, py:Number) : void
      {
         var left:Number = px - Enum_FeiXingQi.FXQMASKW / 2;
         var right:Number = px + Enum_FeiXingQi.FXQMASKW / 2;
         var top:Number = px - Enum_FeiXingQi.FXQMASKH / 2;
         var bottom:Number = px - Enum_FeiXingQi.FXQMASKH / 2;
         if(left < 0)
         {
            this.contaner.x = 0;
         }
         else if(right > Enum_FeiXingQi.FXQHEIGHT)
         {
            this.contaner.x = Enum_FeiXingQi.FXQHEIGHT - Enum_FeiXingQi.FXQMASKW;
         }
         if(top < 0)
         {
            this.contaner.y = 0;
         }
         else if(bottom > Enum_FeiXingQi.FXQMASKH)
         {
            this.contaner.y = Enum_FeiXingQi.FXQWIDTH - Enum_FeiXingQi.FXQMASKH;
         }
      }
      
      public function init() : void
      {
         this.createTile(Data_lib.fxqMap);
      }
      
      private function bDownHd(evt:MouseEvent) : void
      {
         evt.stopPropagation();
         evt.target.startDrag();
      }
      
      private function bUpHd(evt:MouseEvent) : void
      {
         evt.stopPropagation();
         evt.target.stopDrag();
      }
      
      public function addUnitAtIndex(unit:Child_FeiXingQiUnit, index:int) : void
      {
         Tween.stop(unit);
         unit.x = Enum_FeiXingQi.getTileXOffset(index);
         unit.y = Enum_FeiXingQi.getTileYOffset(index);
         unit.tileIndex = index;
         unit.way = Enum_FeiXingQi.getUnitWay(index);
         if(Model_FeiXingQi.unitArr.indexOf(unit) == -1)
         {
            Model_FeiXingQi.unitArr.push(unit);
            this.contaner.addChild(unit);
         }
      }
      
      public function removeUnit(unit:Child_FeiXingQiUnit) : void
      {
         if(this.contaner.contains(unit))
         {
            this.contaner.removeChild(unit);
         }
      }
      
      public function unitTween(unit:Child_FeiXingQiUnit, step:int) : void
      {
         unit.stepRemain = step;
         if(step > 0)
         {
            this.unitTweenToNxt(unit);
         }
      }
      
      public function unitTweenToNxt(unit:Child_FeiXingQiUnit) : void
      {
         var curTile:Child_FeiXingQiTile = null;
         unit.stepRemain -= 1;
         var curIndex:int = unit.tileIndex;
         var nxtIndex:int = unit.tileIndex + 1;
         var nxtTile:Child_FeiXingQiTile = Enum_FeiXingQi.getTile(nxtIndex);
         if(Boolean(nxtTile))
         {
            curTile = Enum_FeiXingQi.getTile(curIndex);
            if(unit.state != Action.RUN)
            {
               unit.state = Action.RUN;
               unit.resetAni();
            }
            Tween.to(unit,500,{
               "x":[Enum_FeiXingQi.getTileXOffset(curIndex),Enum_FeiXingQi.getTileXOffset(nxtIndex)],
               "y":[Enum_FeiXingQi.getTileYOffset(curIndex),Enum_FeiXingQi.getTileYOffset(nxtIndex)]
            },this.onToNxtC,null,Tween.SIN);
         }
         else
         {
            this.addUnitAtIndex(unit,0);
            unit.state = Action.STAND;
            unit.resetAni();
         }
      }
      
      public function refreshIm() : void
      {
         var u:Child_FeiXingQiUnit = null;
         for each(u in Model_FeiXingQi.unitArr)
         {
            this.contaner.removeChild(u);
            u.dispose();
         }
         Model_FeiXingQi.unitArr.splice(0);
         Model_FeiXingQi.myUnit = null;
         Model_FeiXingQi.isTween = false;
      }
      
      public function get mapLayer() : Sprite
      {
         return this.contaner;
      }
   }
}

