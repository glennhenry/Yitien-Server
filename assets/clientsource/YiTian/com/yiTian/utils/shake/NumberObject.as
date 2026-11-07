package com.yiTian.utils.shake
{
   public class NumberObject
   {
      
      public function NumberObject()
      {
         super();
      }
      
      public static function random(... rest) : Number
      {
         return rest[Math.floor(Math.random() * rest.length)];
      }
   }
}

