package com.yiTian.view.modules.worldBoss
{
   public class Config_WorldBoss
   {
      
      public static const CG_MONEY_COST:int = 10;
      
      public static const CG_LIQUAN_COST:int = 20;
      
      public static const MAX_CHUANGONGTIMES:int = 10;
      
      public static const REVIVE_YUANBAOCOST:int = 20;
      
      public static const SRCURL:String = "lang/ch/WuHun_Imgs.swf";
      
      public function Config_WorldBoss()
      {
         super();
      }
      
      public static function getReviveCountTime(opt:* = null) : Number
      {
         return 18;
      }
   }
}

