package com.yiTian.view.modules.Kunlun
{
   import com.yiTian.manager.LangConfig;
   
   public class Enum_kunLun
   {
      
      private static var _awardArr:Array;
      
      public static var RenWu1:Array = [0,1];
      
      public static var RenWu2:Array = [1,5];
      
      public static var RenWu3:Array = [2,5];
      
      public static const NUM_MAX_PLAYER:int = 30;
      
      public static const killAim:Array = [[1,1],[1,3],[1,6],[2,1],[2,2],[2,4]];
      
      public function Enum_kunLun()
      {
         super();
      }
      
      public static function get awardArr() : Array
      {
         if(!_awardArr)
         {
            _awardArr = [];
            _awardArr.push(LangConfig.getWord("22351",2),LangConfig.getWord("22352",2));
         }
         return _awardArr;
      }
   }
}

