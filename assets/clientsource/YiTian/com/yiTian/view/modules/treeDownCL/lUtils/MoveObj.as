package com.yiTian.view.modules.treeDownCL.lUtils
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.scene.GameScene;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Shape;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class MoveObj
   {
      
      public static var LEFT:String = "left";
      
      public static var RIGHT:String = "right";
      
      private static var dataDic:Dictionary = new Dictionary();
      
      private static var pool:Array = [];
      
      private static var arr:Array = [];
      
      private static var isMoving:Boolean = false;
      
      public function MoveObj()
      {
         super();
      }
      
      public static function addMoveTf(disObj:DisplayObject, wid:int, hei:int, leftOrRight:String = "left", isLoop:Boolean = true) : void
      {
         var _disObj:DisplayObject = null;
         var tfWid:int = 0;
         var _x:int = 0;
         var _y:int = 0;
         var tf:MyTextField = null;
         for each(_disObj in arr)
         {
            if(_disObj == disObj)
            {
               return;
            }
         }
         arr.push(disObj);
         if(DisplayObject is MyTextField)
         {
            tf = disObj as MyTextField;
            tfWid = tf.width;
            _x = tf.x + tf.textWidth / 2 - wid / 2;
            _y = tf.y + tf.textHeight / 2 - hei / 2;
         }
         else
         {
            tfWid = disObj.width;
            _x = disObj.x + disObj.width / 2 - wid / 2;
            _y = disObj.y + disObj.height / 2 - hei / 2;
         }
         var dicItem:DicItem = Boolean(pool.length) ? pool.pop() : new DicItem();
         dicItem.remainPos = new Point(disObj.x,disObj.y);
         dicItem.maxMinObj = {
            "minX":_x - tfWid,
            "maxX":_x + wid
         };
         dicItem.moveStype = leftOrRight;
         var _paren:DisplayObjectContainer = disObj.parent;
         var sp:Shape = new Shape();
         sp.graphics.beginFill(0,0);
         sp.graphics.drawRect(0,0,wid,hei);
         sp.graphics.endFill();
         ComponentUtil.setPropertie(sp,{
            "x":_x,
            "y":_y
         });
         disObj.mask = sp;
         _paren.addChild(sp);
         dicItem.maskSp = sp;
         dataDic[disObj] = dicItem;
         if(!isMoving)
         {
            isMoving = true;
            GameScene.instance.addFrameCallBack(move);
         }
      }
      
      public static function stop(disObj:DisplayObject) : void
      {
         if(!disObj || arr.indexOf(disObj) == -1)
         {
            return;
         }
         arr.splice(arr.indexOf(disObj),1);
         if(Boolean(disObj))
         {
            disObj.mask = null;
         }
         var dItem:DicItem = dataDic[disObj];
         var point:Point = dItem.remainPos;
         ComponentUtil.setPropertie(disObj,{
            "x":point.x,
            "y":point.y
         });
         var sp:DisplayObject = dItem.maskSp;
         sp.parent.removeChild(sp);
         sp = null;
         delete dataDic[disObj];
         pool.push(dItem);
      }
      
      private static function move() : void
      {
         var disObj:DisplayObject = null;
         var dI:DicItem = null;
         var moveS:String = null;
         var obj:Object = null;
         if(arr.length == 0)
         {
            GameScene.instance.removeFrameCallBack(move);
            isMoving = false;
         }
         for each(disObj in arr)
         {
            dI = dataDic[disObj];
            moveS = dI.moveStype;
            obj = dI.maxMinObj;
            if(moveS == LEFT)
            {
               if(disObj.x <= obj.minX)
               {
                  disObj.x = obj.maxX;
               }
               disObj.x -= 2;
            }
            else if(moveS == RIGHT)
            {
               if(disObj.x >= obj.maxX)
               {
                  disObj.x = obj.minX;
               }
               disObj.x += 2;
            }
         }
      }
   }
}

import flash.display.DisplayObject;
import flash.geom.Point;

class DicItem
{
   
   public var remainPos:Point;
   
   public var maskSp:DisplayObject;
   
   public var maxMinObj:Object;
   
   public var moveStype:String;
   
   public function DicItem()
   {
      super();
   }
}
