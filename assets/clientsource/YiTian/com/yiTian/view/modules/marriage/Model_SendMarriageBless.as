package com.yiTian.view.modules.marriage
{
   public class Model_SendMarriageBless
   {
      
      private static var _data:Object;
      
      public static var pool:Vector.<View_SendMarriageBlessPlane> = new Vector.<View_SendMarriageBlessPlane>();
      
      public static var countList:Array = new Array();
      
      public function Model_SendMarriageBless()
      {
         super();
      }
      
      public static function get data() : Object
      {
         return _data;
      }
      
      public static function set data(value:Object) : void
      {
         var temp:View_SendMarriageBlessPlane = null;
         _data = value;
         if(pool.length > 0)
         {
            temp = pool.shift();
            temp.data = value;
            temp.restart();
         }
         else
         {
            temp = new View_SendMarriageBlessPlane();
            temp.data = value;
         }
      }
      
      public static function disposeAll() : void
      {
         var i:int = countList.length - 1;
         while(i >= 0)
         {
            countList[i].dispose();
            i--;
         }
      }
   }
}

