package com.yiTian.utils
{
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   
   public class ComboTweenStep
   {
      
      public var property:Object;
      
      public var tweenType:String;
      
      public var startFun:Function;
      
      public var endFun:Function;
      
      public var stepFun:Function;
      
      public var time:uint;
      
      public var next:ComboTweenStep;
      
      public function ComboTweenStep()
      {
         super();
      }
      
      public static function toBag(obj:Object, sx:Number = 0, sy:Number = 0, end:Function = null, type:String = "upToBag") : void
      {
         var startPoint:Point;
         var vo:Object = null;
         var p:Point = null;
         var dir:String = null;
         var bm:Bitmap2 = null;
         var disPoint:Point = null;
         var step1:ComboTweenStep = null;
         var step2:ComboTweenStep = null;
         var p1:Point = null;
         var ox:Number = NaN;
         var oy:Number = NaN;
         var step22:ComboTweenStep = null;
         if(obj is View_Grid)
         {
            if(!obj.vo)
            {
               return;
            }
            vo = obj.vo;
            p = obj.localToGlobal(new Point(0,0));
            dir = "resource/image/icon/" + vo.str_icon + ".png";
         }
         if(obj is Vo_item)
         {
            vo = obj as Vo_item;
            p = new Point(sx,sy);
            dir = "resource/image/icon/" + vo.str_icon + ".png";
         }
         else if(obj is Vo_equip)
         {
            p = new Point(sx,sy);
            dir = "resource/image/icon/" + (obj as Vo_equip).str_icon + ".png";
         }
         bm = new Bitmap2();
         if(obj is Bitmap)
         {
            p = obj.localToGlobal(new Point(0,0));
            bm.bitmapData = obj.bitmapData;
         }
         else
         {
            bm.load(dir);
         }
         bm.x = p.x;
         bm.y = p.y;
         GameScene.upUILayer.addChild(bm);
         startPoint = p;
         disPoint = UIManager.mainMenu.getbagPoint();
         switch(type)
         {
            case "upToBag":
               step1 = new ComboTweenStep();
               step1.property = {"y":[p.y,p.y - 100]};
               step1.time = 700;
               step1.tweenType = Tween.SIN;
               step2 = new ComboTweenStep();
               step2.property = {
                  "x":[startPoint.x,disPoint.x],
                  "y":[p.y - 100,disPoint.y]
               };
               step2.time = 1000;
               step2.tweenType = Tween.SIN;
               step1.next = step2;
               step2.endFun = function(target:Bitmap):void
               {
                  target.parent.removeChild(target);
                  target.bitmapData = null;
                  if(end != null)
                  {
                     end();
                  }
               };
               break;
            case "bsToBag":
               p1 = p.clone();
               ox = (disPoint.x - p.x) * 0.55;
               oy = (disPoint.y - p.y) * 0.35;
               p1.offset(ox,oy);
               step1 = new ComboTweenStep();
               step1.property = {
                  "x":[p.x,p1.x],
                  "y":[p.y,p1.y],
                  "scaleX":[0.5,1],
                  "scaleY":[0.5,1]
               };
               step1.time = 900;
               step1.tweenType = Tween.SIN;
               step22 = new ComboTweenStep();
               step22.property = {
                  "x":[p1.x,disPoint.x],
                  "y":[p1.y,disPoint.y],
                  "scaleX":[1,0.7],
                  "scaleY":[1,0.7]
               };
               step22.time = 650;
               step22.tweenType = Tween.SIN;
               step1.next = step22;
               step22.endFun = function(target:Bitmap2):void
               {
                  target.parent.removeChild(target);
                  target.bitmapData = null;
                  target.load("");
                  if(end != null)
                  {
                     end();
                  }
               };
         }
         Tween.playComboStep(bm,step1);
      }
      
      public static function getUpAndToBag(target:DisplayObject, time1:Number = 700, time2:Number = 1000, offsetY:Number = -100, offsetX:Number = -20) : ComboTweenStep
      {
         var startPoint:Point = target.localToGlobal(new Point(0,0));
         var disPoint:Point = UIManager.mainMenu.getbagPoint();
         var step1:ComboTweenStep = new ComboTweenStep();
         step1.property = {"y":[startPoint.y,startPoint.y + offsetY]};
         step1.time = time1;
         step1.tweenType = Tween.SIN;
         var step2:ComboTweenStep = new ComboTweenStep();
         step2.property = {
            "x":[startPoint.x + offsetX,disPoint.x],
            "y":[startPoint.y + offsetY,disPoint.y]
         };
         step2.time = time2;
         step2.tweenType = Tween.SIN;
         step1.next = step2;
         return step1;
      }
      
      public function dispose() : void
      {
         this.tweenType = null;
         this.tweenType = "";
         this.startFun = null;
         this.endFun = null;
         this.stepFun = null;
         this.time = 0;
      }
      
      public function clone() : ComboTweenStep
      {
         var ins:ComboTweenStep = new ComboTweenStep();
         ins.property = this.property;
         ins.tweenType = this.tweenType;
         ins.startFun = this.startFun;
         ins.endFun = this.endFun;
         ins.stepFun = this.stepFun;
         ins.time = this.time;
         return ins;
      }
   }
}

