package com.yiTian.view
{
   import flash.utils.Dictionary;
   
   public class Enum_explor
   {
      
      public static var BTN_ROLE:String = "role";
      
      public static var BTN_BAG:String = "bag";
      
      public static var BTN_SKILL:String = "skill";
      
      public static var BTN_NEIGONG:String = "neigong";
      
      public static var BTN_PET:String = "pet";
      
      public static var BTN_PARTY:String = "party";
      
      public static var BTN_TEAM:String = "team";
      
      public static var BTN_FRIEND:String = "friend";
      
      public static var BTN_ZHENFA:String = "zhenfa";
      
      public static var BTN_HUODONG:String = "huodong";
      
      public static var BTN_FU:String = "fu";
      
      public static var BTN_JIAOYI:String = "jiaoyi";
      
      public static var BTN_FINDEXP:String = "find_exp";
      
      public static var BTN_POINT:String = "point";
      
      public static var BTN_LETTER:String = "letter";
      
      public static var BTN_MAP:String = "map";
      
      public static var BTN_MART:String = "mart";
      
      public static var BTN_BANG:String = "bang";
      
      public static var BTN_Bi:String = "pingbi";
      
      public static var Button_Zi:String = "zi";
      
      public static var BTN_CHONGZHI:String = "chongzhi";
      
      public static var BTN_VIP:String = "VIP";
      
      public static var BTN_BLUEDiamondND:String = "BLUE";
      
      public static var BTN_CROSS_CLAN_HELP:String = "crossClanBattle";
      
      public static var BTN_HUANGBANG_HELP:String = "huangbangHelp";
      
      public static var BTN_CROSS_CAMP_HELP:String = "crossCampBattleHelp";
      
      public static var bindDic:Dictionary = new Dictionary();
      
      public function Enum_explor()
      {
         super();
      }
      
      public static function bind(bindTarget:String) : Object
      {
         return bindDic[bindTarget];
      }
   }
}

