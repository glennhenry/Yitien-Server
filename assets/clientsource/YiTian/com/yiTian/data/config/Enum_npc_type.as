package com.yiTian.data.config
{
   public class Enum_npc_type
   {
      
      public static const QUEST_NPC:int = 1;
      
      public static const FUN_NPC:int = 2;
      
      public static const COLLECT_NPC:int = 3;
      
      public static const COMMON_MONSTER:int = 4;
      
      public static const ELITE_MONSTER:int = 5;
      
      public static const BOSS:int = 6;
      
      public static const PATA_MONSTER:int = 7;
      
      public static const KUNLUN_MONSTER:int = 8;
      
      public static const PATA_DIAOXIANG:int = 9;
      
      public static const WULIN_ITEM:int = 10;
      
      public static const WUHUN:int = 11;
      
      public static const BANG_MONSTER:int = 12;
      
      public static const BANGCOLLECT:int = 13;
      
      public static const BANG_DEFENDER:int = 14;
      
      public static const BAO_XIANG:int = 15;
      
      public static const BANGPLANT:int = 16;
      
      public static const WANANSI:int = 17;
      
      public static const KEY:int = 20;
      
      public static const SHEN_SHOU:int = 21;
      
      public static const SHEN_SHOU_NPC:int = 19;
      
      public static const QIJU_QIZI:int = 22;
      
      public static const QIJU_BOSS:int = 23;
      
      public static const QIJU_CHEST:int = 24;
      
      public static const QIJU_UNBOSS:int = 25;
      
      public static const christmas_snowman:uint = 27;
      
      public static const SNOWMAN:int = 26;
      
      public static const XINYUE:int = 27;
      
      public static const GHOST:int = 28;
      
      public static const GMD:int = 29;
      
      public static const WORLDBOSS:int = 30;
      
      public static const WORLDBOSS_BAOXIANG:int = 31;
      
      public static const CROSS_MONSTER:int = 32;
      
      public static const HuaDeng:int = 33;
      
      public static const HOMENPCSYSID:int = 52679;
      
      public function Enum_npc_type()
      {
         super();
      }
      
      public static function canBattle(type:int) : Boolean
      {
         switch(type)
         {
            case COMMON_MONSTER:
            case ELITE_MONSTER:
            case BOSS:
            case PATA_MONSTER:
            case KUNLUN_MONSTER:
            case WUHUN:
            case BANG_MONSTER:
            case BANG_DEFENDER:
            case WANANSI:
            case QIJU_QIZI:
            case QIJU_BOSS:
            case QIJU_UNBOSS:
            case SNOWMAN:
            case GHOST:
            case GMD:
            case WORLDBOSS:
               return true;
            default:
               return false;
         }
      }
      
      public static function needShake(type:int) : Boolean
      {
         switch(type)
         {
            case COMMON_MONSTER:
            case ELITE_MONSTER:
            case BOSS:
            case PATA_MONSTER:
            case BANG_MONSTER:
            case WANANSI:
            case WORLDBOSS:
               return true;
            default:
               return false;
         }
      }
      
      public static function canDialog(type:int) : Boolean
      {
         switch(type)
         {
            case QUEST_NPC:
            case FUN_NPC:
               return true;
            default:
               return false;
         }
      }
      
      public static function canCaiji(type:int) : Boolean
      {
         switch(type)
         {
            case COLLECT_NPC:
            case BANGCOLLECT:
            case BAO_XIANG:
            case WORLDBOSS_BAOXIANG:
               return true;
            default:
               return false;
         }
      }
   }
}

