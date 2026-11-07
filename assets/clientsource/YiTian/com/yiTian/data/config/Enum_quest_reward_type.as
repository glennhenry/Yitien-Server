package com.yiTian.data.config
{
   import com.yiTian.manager.LangConfig;
   
   public class Enum_quest_reward_type
   {
      
      public static const ITEM:int = 1;
      
      public static const EQUIP:int = 2;
      
      public static const YUAN_BAO:int = 16;
      
      public static const LI_QUAN:int = 17;
      
      public static const LING_LIANG:int = 18;
      
      public static const EXP:int = 20;
      
      public static const SHENG_WANG:int = 21;
      
      public static const BANG_GONG:int = 27;
      
      private static var data:Array = new Array();
      
      public function Enum_quest_reward_type()
      {
         super();
      }
      
      public static function getTypeName(type:int) : String
      {
         return data[type];
      }
      
      public static function init() : void
      {
         data[ITEM] = LangConfig.getWord("515",0);
         data[EQUIP] = LangConfig.getWord("516",0);
         data[YUAN_BAO] = LangConfig.getWord("25",0);
         data[LI_QUAN] = LangConfig.getWord("517",0);
         data[LING_LIANG] = LangConfig.getWord("518",0);
         data[EXP] = LangConfig.getWord("519",0);
         data[SHENG_WANG] = LangConfig.getWord("466",0);
         data[BANG_GONG] = LangConfig.getWord("30007",3);
      }
   }
}

