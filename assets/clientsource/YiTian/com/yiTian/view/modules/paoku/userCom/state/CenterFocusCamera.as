package com.yiTian.view.modules.paoku.userCom.state
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class CenterFocusCamera extends GameCamera
   {
      
      public var viewWidth:Number = 0;
      
      public var viewHeight:Number = 0;
      
      public var limitRect:Rectangle = new Rectangle(-500,0,400000,3000);
      
      public var _focusPoint:Point;
      
      public function CenterFocusCamera()
      {
         super();
      }
      
      public function focusPoint(point:Point) : void
      {
         this._focusPoint = point;
      }
      
      override public function getViewPoint() : Point
      {
         var p:Point = new Point();
         var tempX:Number = this._focusPoint.x - this.viewWidth / 2;
         var tempY:Number = this._focusPoint.y - this.viewHeight / 2;
         p.x = -tempX;
         p.y = -tempY;
         return p;
      }
   }
}

