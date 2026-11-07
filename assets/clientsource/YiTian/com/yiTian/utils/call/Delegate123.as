package com.yiTian.utils.call
{
   import com.yiTian.utils.Pool;
   import flash.utils.Dictionary;
   
   public class Delegate123
   {
      
      protected var preMap:Dictionary;
      
      public function Delegate123()
      {
         super();
         this.preMap = new Dictionary();
      }
      
      public function dosomething(target:IDelegate123Obj, clouse:Function) : void
      {
         var clouserArr:Array = null;
         if(target.isReady)
         {
            clouse();
         }
         else
         {
            target.addEventListener(DelegateEvent.T_T_COMPLETE,this.complete);
            clouserArr = this.preMap[target];
            if(!clouserArr)
            {
               clouserArr = Pool.getObject(Array);
               this.preMap[target] = clouserArr;
               target.preFun();
            }
            clouserArr.push(clouse);
         }
      }
      
      protected function complete(event:DelegateEvent) : void
      {
         var len:int = 0;
         var i:int = 0;
         var clouse:Function = null;
         var target:IDelegate123Obj = event.target as IDelegate123Obj;
         target.removeEventListener(DelegateEvent.T_T_COMPLETE,this.complete);
         var clouserArr:Array = this.preMap[target];
         if(Boolean(clouserArr))
         {
            len = int(clouserArr.length);
            i = 0;
            while(i < len)
            {
               clouse = clouserArr[i];
               if(Boolean(clouse.length))
               {
                  clouse(event);
               }
               else
               {
                  clouse();
               }
               i += 1;
            }
            clouserArr.splice(0);
            Pool.saveObject(clouserArr);
         }
         delete this.preMap[target];
      }
   }
}

