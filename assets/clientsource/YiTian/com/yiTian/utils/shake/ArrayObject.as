package com.yiTian.utils.shake
{
   public class ArrayObject
   {
      
      public function ArrayObject()
      {
         super();
      }
      
      public static function isIndex(array:Array, value:*, ... rest) : int
      {
         var select:Array = null;
         var memory:* = undefined;
         var index:Number = NaN;
         var indexSeach:Number = NaN;
         var result:int = -1;
         var seach:Array = rest;
         index = 0;
         while(index < array.length)
         {
            select = array[index];
            indexSeach = 0;
            while(indexSeach < seach.length)
            {
               if(seach.length != indexSeach + 1)
               {
                  select = select[seach[indexSeach]];
               }
               else
               {
                  memory = select[seach[indexSeach]];
               }
               indexSeach++;
            }
            switch(true)
            {
               case value is Array:
                  if(value.toString() == memory.toString())
                  {
                     result = index;
                  }
                  break;
               default:
                  if(value == memory)
                  {
                     result = index;
                  }
            }
            if(-1 != result)
            {
               break;
            }
            index++;
         }
         return result;
      }
   }
}

