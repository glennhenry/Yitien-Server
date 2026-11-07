package manager
{
   import flash.events.Event;
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
      
      private static function start() : void
      {
         if(!_isRuning)
         {
            Global.stage.addEventListener(Event.ENTER_FRAME,run);
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
      
      private static function run(e:Event) : void
      {
         var thread:Thread = null;
         var percent:Number = NaN;
         var rate:Number = NaN;
         var j:int = 0;
         var value:Number = NaN;
         if(!list.length)
         {
            Global.stage.removeEventListener(Event.ENTER_FRAME,run);
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
