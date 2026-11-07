package com.yiTian.gameUnit.config
{
   public class Status
   {
      
      public static const NOMAL:int = 1;
      
      public static const SIT:int = 2;
      
      public static const FISH:int = 3;
      
      public static const KUN_LUN:int = 4;
      
      public static const COLLECT:int = 5;
      
      public static const PA_TA:int = 6;
      
      public static const WU_LING:int = 7;
      
      public static const BANG_PAI:int = 8;
      
      public static const BZ_COLLECT:int = 9;
      
      public static const WANANSI:int = 10;
      
      public static const KEJU:int = 11;
      
      public static const QJ:int = 12;
      
      public static const GMD:int = 13;
      
      public static const AiDeBaoBao:int = 14;
      
      public static const AiDeBaoBao_Bao:int = 15;
      
      public static const AiDeBaoBao_BeiBao:int = 16;
      
      public static const KuaFuPaiDui_HIDE:int = 17;
      
      public static const KuaFuPaiDui_18:int = 18;
      
      public static const KuaFuPaiDui_19:int = 19;
      
      public static const KuaFuPaiDui_20:int = 20;
      
      public static const KuaFuPaiDui_21:int = 21;
      
      public static const KuaFuPaiDui_22:int = 22;
      
      public static const KuaFuPaiDui_23:int = 23;
      
      public static const KuaFuPaiDui_24:int = 24;
      
      public static const KuaFuPaiDui_25:int = 25;
      
      public static const KFPAOBIAO_26:int = 26;
      
      private static const STR:Object = {
         1:"正常",
         2:"挂机",
         3:"钓鱼",
         4:"昆仑山",
         5:"采集",
         6:"爬塔",
         7:"武林大会",
         8:"帮派战",
         9:"帮战采集"
      };
      
      public function Status()
      {
         super();
      }
      
      public static function getStatusString(value:int) : String
      {
         return STR[value];
      }
   }
}

