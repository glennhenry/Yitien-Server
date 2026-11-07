package com.yiTian.view.modules.chargeGuide
{
   import com.yiTian.utils.Tween;
   import com.yiTian.view.MainUIBase;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   
   public class View_newContainer extends MainUIBase
   {
      
      public static var isAutoMove:Boolean = false;
      
      private var arr:Array = [];
      
      public function View_newContainer()
      {
         super();
      }
      
      public function addBTN(btn:DisplayObject) : void
      {
         addChild(btn);
         this.arr.push(btn);
         if(isAutoMove)
         {
            btn.x = 310;
            btn.y = 120;
         }
         else
         {
            Tween.to(btn,1000,{
               "x":[310,310],
               "y":[0,120]
            },this.cmp);
         }
      }
      
      private function cmp() : void
      {
         this.resize();
      }
      
      public function getT(_target:DisplayObject) : Point
      {
         var obj:Object = null;
         for each(obj in this.arr)
         {
            if(obj == _target)
            {
               return localToGlobal(new Point(obj.x,obj.y));
            }
         }
         return null;
      }
      
      public function removeBTN(btn:DisplayObject) : void
      {
         if(Boolean(btn))
         {
            removeChild(btn);
         }
         this.arr.splice(this.arr.indexOf(btn),1);
         this.resize();
      }
      
      public function resize() : void
      {
         var stx1:int = 0;
         var stx2:int = 0;
         if(this.arr.length > 1)
         {
            stx1 = 281;
            stx2 = 339;
            this.arr[0].y = 120;
            this.arr[1].y = 120;
            Tween.to(this.arr[0],300,{"x":[this.arr[0].x,stx1]});
            Tween.to(this.arr[1],300,{"x":[this.arr[1].x,stx2]});
         }
         else if(this.arr.length == 1)
         {
            this.arr[0].y = 120;
            Tween.to(this.arr[0],300,{"x":[this.arr[0].x,310]});
         }
      }
   }
}

