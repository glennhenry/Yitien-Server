package com.yiTian.view.modules.huangbang
{
   import com.yiTian.Global;
   import flash.display.BitmapData;
   
   public class Enum_Huangbang
   {
      
      public static var SILVER:int = 1;
      
      public static var GOLD:int = 2;
      
      public static var HUANGBANG_NUM:int = 1000000;
      
      public static var START_QUEST_ID:int = 16200;
      
      public static var MAX_QUALITY:int = 3;
      
      public static var MAX_FINISH_COUNT:int = 10;
      
      public static var SILVER_OFFSET:int = 1;
      
      public static var GOLD_OFFSET:int = 2;
      
      public static var SHAKER:String = "shaker";
      
      public static var GOBACK_START:String = "goback";
      
      public static var SHOW_ALLPOINT:String = "showAllPoint";
      
      public static var JUMP_LAST_POINT:String = "jumpLastPoint";
      
      public function Enum_Huangbang()
      {
         super();
      }
      
      public static function getShaiZiBmd(definedName:String) : BitmapData
      {
         if(!Global.HuangBang_Imgdm)
         {
            return null;
         }
         return new (Global.HuangBang_Imgdm.getDefinition(definedName) as Class)();
      }
   }
}

