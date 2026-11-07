package com.yiTian.data.config
{
   import com.yiTian.Global;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.manager.LangConfig;
   
   public class Enum_npc_fun
   {
      
      public static const YAO_DIAN:int = 1;
      
      public static const ZA_HUO_DIAN:int = 2;
      
      public static const EQUIP_DIAN:int = 3;
      
      public static const DEPOT:int = 4;
      
      public static const BANG_PAI:int = 5;
      
      public static const COLLECT:int = 6;
      
      public static const ENTER_KUNLUN:int = 7;
      
      public static const FISH:int = 8;
      
      public static const PA_TA:int = 9;
      
      public static const GET_AWARD:int = 10;
      
      public static const ADVENTURE_PAIHANG:int = 11;
      
      public static const PLAY_INTRODUCE:int = 12;
      
      public static const QUEST_DAILY:int = 13;
      
      public static const REQUEST_BANG_BOSS:int = 15;
      
      public static const PA_TA_TEAM:int = 16;
      
      public static const YUN_SONG_BIAO_CHE:int = 17;
      
      public static const XIJIE_LIANGYUAN:int = 18;
      
      public static const TOU_FANGHONGBAO:int = 19;
      
      public static const WO_YAOLIHUN:int = 20;
      
      public static const GETQIXIREWARD:int = 21;
      
      public static const JOINKEJU:int = 22;
      
      public static const ABOUTKEJU:int = 23;
      
      public static const JOIN_XINYUE:int = 24;
      
      public static const JOIN_IN_XINYUE:int = 25;
      
      public static const christmas_big_snowman:uint = 26;
      
      public static const GET_XINYUE_GIFT:uint = 27;
      
      public static const ShiZhuangSuiPian:int = 29;
      
      public static const PA_TA2:int = 30;
      
      public static const COMMIT_MINE:int = 31;
      
      public static const AiDeBaoBao_middle:int = 32;
      
      public static const jinHuangbang:int = 33;
      
      public static const GET_QIXI_GIFT:int = 34;
      
      public static const ENTER_INNER_HOME:int = 35;
      
      public static const OPEN_HOME_MALL:int = 36;
      
      public static const LINGYANG_CHILD:int = 37;
      
      public static const TUOGUAN_CHILD:int = 38;
      
      public static const COMMIT_CRYSTAL:int = 39;
      
      public static const COMMIT_JADE_ESSENCE:int = 40;
      
      private static var data:Object = new Object();
      
      public function Enum_npc_fun()
      {
         super();
      }
      
      public static function getType(type:int) : String
      {
         return data[type];
      }
      
      public static function init() : void
      {
         if(Global.pf == Enum_SPStr.GUANWANG)
         {
            data = {
               1:LangConfig.getWord("500",0),
               2:LangConfig.getWord("501",0),
               3:LangConfig.getWord("502",0),
               4:LangConfig.getWord("503",0),
               5:LangConfig.getWord("504",0),
               6:LangConfig.getWord("505",0),
               7:LangConfig.getWord("506",0),
               8:LangConfig.getWord("507",0),
               9:LangConfig.getWord("508",0),
               10:LangConfig.getWord("509",0),
               11:LangConfig.getWord("510",0),
               12:LangConfig.getWord("511",0),
               13:LangConfig.getWord("512",0),
               15:LangConfig.getWord("138",0),
               16:LangConfig.getWord("513",0),
               17:LangConfig.getWord("514",0),
               18:LangConfig.getWord("1004",0),
               19:LangConfig.getWord("1005",0),
               20:LangConfig.getWord("1006",0),
               21:LangConfig.getWord("29274",2),
               22:LangConfig.getWord("1119",0),
               23:LangConfig.getWord("1120",0),
               24:LangConfig.getWord("1135",0),
               25:LangConfig.getWord("1136",0),
               26:LangConfig.getWord("1141",0),
               27:"领取心悦礼包",
               29:"时装兑换",
               30:"地狱模式爬塔(80级开启)",
               31:"提交资源矿",
               32:"进入下半场",
               33:"进入龙盘地图",
               34:"领取七夕礼包",
               35:LangConfig.getWord("1177",0),
               36:LangConfig.getWord("1178",0),
               37:"领养崽崽",
               38:"崽崽托管",
               39:"交付水晶",
               40:"交付玉精髓"
            };
         }
         else
         {
            data = {
               1:LangConfig.getWord("500",0),
               2:LangConfig.getWord("501",0),
               3:LangConfig.getWord("502",0),
               4:LangConfig.getWord("503",0),
               5:LangConfig.getWord("504",0),
               6:LangConfig.getWord("505",0),
               7:LangConfig.getWord("506",0),
               8:LangConfig.getWord("507",0),
               9:LangConfig.getWord("508",0),
               10:LangConfig.getWord("509",0),
               11:LangConfig.getWord("510",0),
               12:LangConfig.getWord("511",0),
               13:LangConfig.getWord("512",0),
               15:LangConfig.getWord("138",0),
               16:LangConfig.getWord("513",0),
               17:LangConfig.getWord("514",0),
               18:LangConfig.getWord("1004",0),
               19:LangConfig.getWord("1005",0),
               20:LangConfig.getWord("1006",0),
               21:LangConfig.getWord("29274",2),
               22:LangConfig.getWord("1119",0),
               23:LangConfig.getWord("1120",0),
               24:LangConfig.getWord("1135",0),
               25:LangConfig.getWord("1136",0),
               26:LangConfig.getWord("1141",0),
               29:"时装兑换",
               30:"地狱模式爬塔(80级开启)",
               31:"提交资源矿",
               32:"进入下半场",
               33:"进入龙盘地图",
               34:"领取七夕礼包",
               35:LangConfig.getWord("1177",0),
               36:LangConfig.getWord("1178",0),
               37:"领养崽崽",
               38:"崽崽托管",
               39:"交付水晶",
               40:"交付玉精髓"
            };
         }
      }
   }
}

