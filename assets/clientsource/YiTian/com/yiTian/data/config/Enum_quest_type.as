package com.yiTian.data.config
{
   import com.yiTian.manager.LangConfig;
   
   public class Enum_quest_type
   {
      
      public static const MAIN:int = 1;
      
      public static const BRANCH:int = 2;
      
      public static const DAILY:int = 3;
      
      public static const BANG_HUI:int = 4;
      
      public static const CYCLE:int = 5;
      
      public static const SPECIAL:int = 6;
      
      public static const PAOBIAO:int = 7;
      
      public static const ZHUOGUI:int = 8;
      
      public static const HUANGBANG:int = 9;
      
      public static const PETEQUIP:int = 10;
      
      public static const DAILY_GUIDE:int = 11;
      
      private static var data:Array = new Array();
      
      private static var minidata:Array = new Array();
      
      public function Enum_quest_type()
      {
         super();
      }
      
      public static function getTypeName(type:int) : String
      {
         return data[type];
      }
      
      public static function getTypeMiniName(type:int) : String
      {
         return minidata[type];
      }
      
      public static function init() : void
      {
         data = [null,LangConfig.getWord("520",0),LangConfig.getWord("521",0),LangConfig.getWord("522",0),LangConfig.getWord("523",0),LangConfig.getWord("524",0),LangConfig.getWord("525",0),LangConfig.getWord("526",0),"捉鬼","周任务","宠物装备","每日引导"];
         minidata = [null,LangConfig.getWord("527",0),LangConfig.getWord("528",0),LangConfig.getWord("529",0),LangConfig.getWord("530",0),LangConfig.getWord("531",0),LangConfig.getWord("532",0),LangConfig.getWord("533",0),"鬼","周","宠","导"];
      }
   }
}

