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
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class Tween
   {
      
      private static var _isRuning:Boolean;
      
      public static const BEE_LINE:String = "bee_line";
      
      public static const SIN:String = "sin";
      
      public static const SIN06:String = "sin06";
      
      public static const EASYINOUT:String = "easyinout";
      
      public static const TURBOSIN:String = "turboSin";
      
      public static const DAO:String = "dao";
      
      public static const SIN010:String = "sin010";
      
      private static var tweenTypeDic:Dictionary = getTweenTypeDic();
      
      private static var pool:Array = [];
      
      private static var list:Array = [];
      
      private static var threadMap:Dictionary = new Dictionary();
      
      public static var power:int = 3;
      
      public static var sinTimes:int = 3;
      
      public function Tween()
      {
         super();
      }
      
      private static function getTweenTypeDic() : Dictionary
      {
         var dic:Dictionary = new Dictionary();
         dic[BEE_LINE] = bee_line;
         dic[SIN] = sin;
         dic[SIN06] = sin06;
         dic[EASYINOUT] = easyInOut;
         dic[TURBOSIN] = turboSin;
         dic[DAO] = dao;
         dic[SIN010] = sin010;
         return dic;
      }
      
      public static function to(target:Object, time:int, propertie:Object, complete:Function = null, fun:Function = null, easingObj:* = "bee_line") : void
      {
         var thread:Thread = null;
         var key:String = null;
         if(Boolean(threadMap[target]))
         {
            thread = threadMap[target];
         }
         else
         {
            thread = pool.length > 0 ? pool.pop() : new Thread();
            thread.target = target;
            list.push(thread);
            threadMap[target] = thread;
         }
         thread.beginTime = getTimer();
         thread.totleTime = time;
         thread.propertie = [];
         if(easingObj is String)
         {
            thread.easing = tweenTypeDic[easingObj];
         }
         else
         {
            thread.easing = easingObj;
         }
         for(key in propertie)
         {
            thread.propertie.push([key,propertie[key][0],propertie[key][1] - propertie[key][0]]);
         }
         thread.complete = complete;
         thread.fun = fun;
         start();
      }
      
      public static function curTo(target:Object, time:int, propertie:Object, complete:Function = null, fun:Function = null, easingObj:* = "bee_line") : void
      {
         var key:String = null;
         var propertie2:Object = {};
         for(key in propertie)
         {
            propertie2[key] = [target[key],propertie[key]];
         }
         Tween.to(target,time,propertie2,complete,fun,easingObj);
      }
      
      public static function stop(target:Object) : void
      {
         var i:int = list.length - 1;
         while(i >= 0)
         {
            if(list[i].target == target)
            {
               delete threadMap[list[i].target];
               pool.push(list[i]);
               list.splice(i,1);
            }
            i--;
         }
      }
      
      public static function endLastTween(target:Object) : void
      {
         _isRuning = false;
         stop(target);
      }
      
      private static function start() : void
      {
         if(!_isRuning)
         {
            GameScene.instance.addFrameCallBack(run);
            _isRuning = true;
         }
      }
      
      protected static function bee_line(rate:Number) : Number
      {
         return rate;
      }
      
      protected static function sin(rate:Number) : Number
      {
         return Math.sin(rate * Math.PI / 2);
      }
      
      protected static function sin06(rate:Number) : Number
      {
         return Math.sin(rate * Math.PI * 0.7);
      }
      
      protected static function sin010(rate:Number) : Number
      {
         if(rate <= 0.8)
         {
            return Math.sin(rate * Math.PI / 2 * 1.25) * 1.5;
         }
         return 1.5 - Math.sin((rate - 0.8) * Math.PI / 2 * 5 / 3);
      }
      
      protected static function easyInOut(rate:Number) : Number
      {
         var result:Number = NaN;
         var rate2:Number = rate * 2;
         if(rate < 0.5)
         {
            result = Math.pow(rate2,power) / 2;
         }
         else
         {
            result = 1 - Math.abs(Math.pow(rate2 - 2,power)) / 2;
         }
         return result;
      }
      
      protected static function turboSin(rate:Number) : Number
      {
         return Math.sin(2 * Math.PI * rate * sinTimes);
      }
      
      public static function dao(rate:Number) : Number
      {
         return 1 - sin(rate);
      }
      
      private static function run() : void
      {
         var thread:Thread = null;
         var percent:Number = NaN;
         var rate:Number = NaN;
         var j:int = 0;
         var value:Number = NaN;
         if(!list.length)
         {
            GameScene.instance.removeFrameCallBack(run);
            _isRuning = false;
         }
         var now:int = getTimer();
         var i:int = list.length - 1;
         while(i >= 0)
         {
            thread = list[i];
            percent = (now - thread.beginTime) / thread.totleTime;
            percent = percent > 1 ? 1 : percent;
            rate = thread.easing(percent);
            j = 0;
            while(j < thread.propertie.length)
            {
               value = thread.propertie[j][1] + rate * thread.propertie[j][2];
               thread.target[thread.propertie[j][0]] = value;
               if(thread.fun != null)
               {
                  if(Boolean(thread.fun.length))
                  {
                     thread.fun(thread);
                  }
                  else
                  {
                     thread.fun();
                  }
               }
               j++;
            }
            if(now - thread.beginTime > thread.totleTime)
            {
               list.splice(i,1);
               delete threadMap[thread.target];
               pool.push(thread);
               if(thread.complete != null)
               {
                  if(Boolean(thread.complete.length))
                  {
                     thread.complete(thread.target);
                  }
                  else
                  {
                     thread.complete();
                  }
               }
            }
            i--;
         }
      }
      
      public static function playComboStep(target:DisplayObject, curStep:ComboTweenStep) : void
      {
         if(curStep.startFun != null)
         {
            curStep.startFun();
         }
         Tween.to(target,curStep.time,curStep.property,function():void
         {
            var endFun:Function = curStep.endFun;
            if(endFun != null)
            {
               if(Boolean(endFun.length))
               {
                  endFun(target);
               }
               else
               {
                  endFun();
               }
            }
            if(Boolean(curStep.next))
            {
               playComboStep(target,curStep.next);
            }
         },curStep.stepFun,curStep.tweenType);
      }
      
      public static function gridToBagBezierFuncDef(obj:Object, totalTime:int = -1, sx:Number = 0, sy:Number = 0) : void
      {
         var vo:Object = null;
         var p:Point = null;
         var dir:String = null;
         var bm:Bitmap = null;
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
         else if(obj is String)
         {
            p = new Point(sx,sy);
            dir = "resource/image/icon/" + obj.toString() + ".png";
         }
         bm = new Bitmap();
         bm = Utils.getLoadBitmap(dir,bm);
         bm.x = p.x;
         bm.y = p.y;
         var aimPoint:Point = UIManager.mainMenu.getItemGlobalPosC("bagBtn");
         if(totalTime <= 0)
         {
            totalTime = Math.pow(Math.pow(aimPoint.y - p.y,2) + Math.pow(aimPoint.x - p.x,2),0.5) * 3.5;
         }
         var py:Number = p.y + Math.abs(p.y - aimPoint.y) / 5;
         var point1:Point = new Point(aimPoint.x,py);
         Bezier.getInstance().addTarget(bm,aimPoint,totalTime,GameScene.popupLayer,-1,[point1],CFUN);
      }
      
      public static function CFUN(o:DisplayObject) : void
      {
         if(GameScene.popupLayer.contains(o))
         {
            GameScene.popupLayer.removeChild(o);
         }
         (o as Bitmap).bitmapData = null;
      }
   }
}

class Thread
{
   
   public var easing:Function;
   
   public var target:Object;
   
   public var beginTime:int;
   
   public var totleTime:int;
   
   public var propertie:Array;
   
   public var complete:Function;
   
   public var fun:Function;
   
   public function Thread()
   {
      super();
   }
}
