package com.yiTian.data.config
{
   import com.yiTian.data.Data_lib;
   import flash.utils.Dictionary;
   
   public class Enum_QiJu
   {
      
      private static var _qiju_type:Array;
      
      private static var _type_level:Array;
      
      private static var _reward:Array;
      
      public static const BOSS_ID_VEC:Vector.<int> = new <int>[56315,56324,56350,56359,56385,56394,56420,56429,56455,56464];
      
      public static const CHEST_ID_VEC:Vector.<int> = new <int>[56326,56335,56361,56370,56396,56405,56431,56440,56466,56475];
      
      public static const CAN_FIGHT_NPC:Vector.<int> = new <int>[56301,56325,56336,56360,56371,56395,56406,56430,56441,56465];
      
      private static const TYPE_COUNT:int = 5;
      
      public static const QIJUSOURCE:String = "lang/ch/ZLQiJun.swf";
      
      public static const MAX_TIME:uint = 4;
      
      public function Enum_QiJu()
      {
         super();
      }
      
      public static function get qiju_type() : Array
      {
         var i:int = 0;
         var dic:Dictionary = Data_lib.zlchess;
         if(!_qiju_type)
         {
            _qiju_type = [];
            i = 1;
            while(i <= TYPE_COUNT)
            {
               _qiju_type.push(Data_lib.zlchess[i][0]);
               i++;
            }
         }
         return _qiju_type;
      }
      
      public static function get type_level() : Array
      {
         var i:int = 0;
         if(!_type_level)
         {
            _type_level = [];
            i = 1;
            while(i <= TYPE_COUNT)
            {
               _type_level.push(Data_lib.zlchess[i][1]);
               i++;
            }
         }
         return _type_level;
      }
      
      public static function get reward() : Array
      {
         var i:int = 0;
         if(!_reward)
         {
            _reward = [];
            i = 1;
            while(i <= TYPE_COUNT)
            {
               _reward.push(Data_lib.zlchess[i][3].toString().split("_"));
               i++;
            }
         }
         return _reward;
      }
   }
}

