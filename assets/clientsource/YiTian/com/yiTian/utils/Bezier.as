package com.yiTian.utils
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.geom.Point;
   
   public class Bezier
   {
      
      private static var instance:Bezier;
      
      public static const RIGHT1:int = 2;
      
      public static const LEFT1:int = 1;
      
      private var itemVec:Vector.<VecItem>;
      
      public function Bezier()
      {
         super();
         if(Boolean(instance))
         {
            throw new Error("singlon error");
         }
         this.init();
         instance = this;
      }
      
      public static function getInstance() : Bezier
      {
         if(instance)
         {
         }
         return instance;
      }
      
      private function init() : void
      {
         this.itemVec = new Vector.<VecItem>();
      }
      
      public function addTarget(target:DisplayObject, aimPoint:Point, countTime:int, $parent:Sprite, moveType:int = 2, points:Array = null, completeFunc:Function = null, frameFunc:Function = null, startFunc:Function = null) : void
      {
         var pt:Point = null;
         $parent.addChild(target);
         if(countTime <= 0)
         {
            throw new Error("总帧数不得小于1");
         }
         var item:VecItem = new VecItem();
         item.countTime = countTime;
         item.frameFunc = frameFunc;
         item.target = target;
         item.completeFunc = completeFunc;
         this.itemVec.push(item);
         if(startFunc != null)
         {
            startFunc();
         }
         var patchArr:Array = new Array();
         patchArr.push(new Point(target.x,target.y));
         var stage:Stage = Global.stage;
         var w:Number = stage.stageWidth;
         var h:Number = stage.stageHeight;
         switch(moveType)
         {
            case LEFT1:
               patchArr.push(new Point(0,0),new Point(0,h));
               break;
            case RIGHT1:
               patchArr.push(new Point(w,0),new Point(w,h));
               break;
            case -1:
               if(points.length < 1)
               {
                  throw new Error("路径数组长度必须大于1");
               }
               for each(pt in points)
               {
                  patchArr.push(pt);
               }
               break;
            default:
               throw new Error("错误的参数");
         }
         patchArr.push(aimPoint);
         item.points = patchArr;
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.frameHandle);
      }
      
      private function frameHandle(interval:int) : void
      {
         var item:VecItem = null;
         var t:Number = NaN;
         var p:Point = null;
         for each(item in this.itemVec)
         {
            item.runTime += interval;
            t = item.runTime / item.countTime;
            p = BezierPoint.getPoint(t,item.points);
            item.target.x = p.x;
            item.target.y = p.y;
            if(item.frameFunc != null)
            {
               item.frameFunc(item.target);
            }
            if(t >= 1)
            {
               if(item.completeFunc != null)
               {
                  item.completeFunc(item.target);
               }
               this.itemVec.splice(this.itemVec.indexOf(item),1);
               item.dispose();
            }
         }
         if(this.itemVec.length == 0)
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.frameHandle);
         }
      }
   }
}

import flash.display.DisplayObject;
import flash.geom.Point;

class VecItem
{
   
   public var target:DisplayObject;
   
   public var points:Array;
   
   public var countTime:int;
   
   public var runTime:int;
   
   public var completeFunc:Function;
   
   public var frameFunc:Function;
   
   public function VecItem()
   {
      super();
   }
   
   public function dispose() : void
   {
      this.target = null;
      this.points = null;
      this.countTime = 0;
      this.runTime = 0;
      this.completeFunc = null;
      this.frameFunc = null;
   }
}

class BezierPoint
{
   
   public function BezierPoint()
   {
      super();
   }
   
   public static function getPoint(t:Number, points:Array) : Point
   {
      var b:Number = NaN;
      var k:Number = NaN;
      var _x:Number = 0;
      var _y:Number = 0;
      var n:uint = points.length - 1;
      var factn:Number = Number(factoral(n));
      var i:uint = 0;
      while(i <= n)
      {
         b = factn / (factoral(i) * factoral(n - i));
         k = Math.pow(1 - t,n - i) * Math.pow(t,i);
         _x += b * k * points[i].x;
         _y += b * k * points[i].y;
         i++;
      }
      return new Point(_x,_y);
   }
   
   private static function factoral(value:uint) : Number
   {
      if(value == 0)
      {
         return 1;
      }
      var total:Number = value;
      while(--value > 1)
      {
         total *= value;
      }
      return total;
   }
}
