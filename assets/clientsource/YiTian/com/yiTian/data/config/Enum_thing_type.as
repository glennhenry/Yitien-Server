package com.yiTian.data.config
{
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.valuable.Enum_lib_equip;
   import com.yiTian.data.config.valuable.Enum_lib_item;
   import com.yiTian.manager.LangConfig;
   
   public class Enum_thing_type
   {
      
      public static const ITEM:int = 1;
      
      public static const EQUIP:int = 2;
      
      public static const YUAN_BAO:int = 3;
      
      public static const LING_LIANG:int = 4;
      
      public static const EXP:int = 5;
      
      public static const LI_QUAN:int = 6;
      
      public static const SHENG_WANG:int = 7;
      
      public static const BAG_FULL:int = 8;
      
      public static const YUE_LI:int = 9;
      
      public static const BANG_GONG:int = 10;
      
      public static const QIJU:int = 11;
      
      private static var discript:Object = new Object();
      
      private static var itemColor:Array = ["#000000","#ffffff","#00ffff","#33ccff","#bb00ff"];
      
      public function Enum_thing_type()
      {
         super();
      }
      
      public static function getDiscript(type:int) : String
      {
         return discript[type];
      }
      
      public static function getEquipHtmlText(equipId:int) : String
      {
         var str:String = null;
         var color:int = 0;
         color = int(Data_lib.equip[equipId][Enum_lib_equip.COLOR]);
         return "<font color = \'" + itemColor[color] + "\'>" + Data_lib.equip[equipId][Enum_lib_equip.STR_NAME] + "</font>";
      }
      
      public static function getItemHtmlText(itemId:Number) : String
      {
         var str:String = null;
         var color:int = 0;
         color = int(Data_lib.item[itemId][Enum_lib_item.COLOR]);
         return "<font color = \'" + itemColor[color] + "\'>" + Data_lib.item[itemId][Enum_lib_item.STR_NAME] + "</font>";
      }
      
      public static function init() : void
      {
         discript = {
            1:LangConfig.getWord("534",0),
            2:LangConfig.getWord("534",0),
            3:LangConfig.getWord("535",0),
            4:LangConfig.getWord("536",0),
            5:LangConfig.getWord("537",0),
            6:LangConfig.getWord("538",0),
            7:LangConfig.getWord("539",0),
            8:LangConfig.getWord("540",0),
            9:LangConfig.getWord("541",0),
            10:LangConfig.getWord("30008",3)
         };
      }
   }
}

