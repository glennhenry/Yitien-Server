package com.yiTian.command
{
   import flash.utils.Dictionary;
   
   public class Control
   {
      
      private var _vecDic:Dictionary;
      
      public function Control()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         this._vecDic = new Dictionary();
      }
      
      public function registerCallBack(type:String, callBack:Function, duplicate:Boolean = false) : void
      {
         if(this._vecDic[type] == null)
         {
            this._vecDic[type] = new List1();
         }
         var vec:List1 = this._vecDic[type];
         if(duplicate)
         {
            vec.add(callBack);
         }
         else if(vec.indexOf(callBack) == -1)
         {
            vec.add(callBack);
         }
      }
      
      public function hasCallBack(type:String, callBack:Function) : Boolean
      {
         var vec:List1 = null;
         if(Boolean(this._vecDic[type]))
         {
            vec = this._vecDic[type];
            return vec.indexOf(callBack) != -1;
         }
         return false;
      }
      
      public function removeCallBack(type:String, callBack:Function) : void
      {
         var vec:List1 = this._vecDic[type];
         if(vec != null)
         {
            vec.remove(callBack);
         }
      }
      
      public function sendNotification(type:String, body:Object) : void
      {
         var arr:Array = null;
         var len:int = 0;
         var i:int = 0;
         var func:Function = null;
         var vec:List1 = this._vecDic[type];
         if(vec != null)
         {
            arr = vec.array;
            len = int(arr.length);
            i = 0;
            while(i < len)
            {
               func = arr[i];
               if(func != null)
               {
                  if(Boolean(func.length))
                  {
                     func(body);
                  }
                  else
                  {
                     func();
                  }
               }
               i += 1;
            }
         }
      }
   }
}

