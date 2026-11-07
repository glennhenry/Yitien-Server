package com.utils
{
   public class ColorConstant
   {
      
      public static const WHITE:int = 1;
      
      public static const RED:int = 2;
      
      public static const ORANGE:int = 3;
      
      public static const YELLOW:int = 4;
      
      public static const GREEN:int = 5;
      
      public static const CYAN:int = 6;
      
      public static const BLUE:int = 7;
      
      public static const PURPLE:int = 8;
      
      public static const GREY:int = 9;
      
      public static const BLUE_LIGHT:int = 10;
      
      public static const YELLOW_SAND:int = 11;
      
      public static const QUEST_YIWANCHENG:int = GREEN;
      
      public static const QUEST_WEIWANCHENG:int = ORANGE;
      
      public static const QUEST_BUKEJIE:int = RED;
      
      public static const MAP_NAME:int = 12;
      
      public static const NPC_NAME:int = 13;
      
      public static const ANJIN:int = 15;
      
      public static const GOLD:int = 16;
      
      public static const ROLE_ATTR_COLOR:String = "0x11904647";
      
      public static const ITEM_YELLOW:int = YELLOW;
      
      private static const color1:String = "ffffff";
      
      private static const color2:String = "fe0000";
      
      private static const color3:String = "ff7700";
      
      private static const color4:String = "f9ff00";
      
      private static const color5:String = "04ff00";
      
      private static const color6:String = "00ffff";
      
      private static const color7:String = "33CCFF";
      
      private static const color8:String = "de45c7";
      
      private static const color9:String = "999999";
      
      private static const color10:String = "afe4e4";
      
      private static const color11:String = "f4cd31";
      
      private static const color12:String = "ffac00";
      
      private static const color13:String = "99ff00";
      
      private static const color14:String = "ff6600";
      
      private static const color15:String = "c53232";
      
      private static const color16:String = "ffd700";
      
      public function ColorConstant()
      {
         super();
      }
      
      public static function getColorInt(type:int) : int
      {
         return int("0x" + ColorConstant["color" + type]);
      }
      
      public static function getColorStr(type:int) : String
      {
         return "#" + ColorConstant["color" + type];
      }
      
      public static function getItemColorStr(itemColor:int) : String
      {
         var type:int = 0;
         switch(itemColor)
         {
            case 1:
               type = WHITE;
               break;
            case 2:
               type = GREEN;
               break;
            case 3:
               type = BLUE;
               break;
            case 4:
               type = PURPLE;
               break;
            case 5:
               type = ORANGE;
         }
         return getColorStr(type);
      }
   }
}

