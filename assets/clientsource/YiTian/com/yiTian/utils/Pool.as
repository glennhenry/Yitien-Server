package com.yiTian.utils
{
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class Pool
   {
      
      private static const pool:Dictionary = new Dictionary();
      
      public function Pool()
      {
         super();
      }
      
      public static function getObject(cla:Class) : *
      {
         var result:Object = null;
         var qName:String = getQualifiedClassName(cla);
         if(Boolean(pool[qName]) && Boolean(pool[qName].length))
         {
            result = pool[qName].pop();
         }
         else
         {
            result = new cla();
         }
         return result;
      }
      
      public static function saveObject(obj:Object) : void
      {
         var qName:String = getQualifiedClassName(obj);
         var arr:Array = pool[qName];
         if(arr == null)
         {
            arr = [];
            pool[qName] = arr;
         }
         if(arr.indexOf(obj) == -1)
         {
            arr.push(obj);
         }
      }
   }
}

