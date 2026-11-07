package com.yiTian.view.modules.tianTi
{
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.LangConfig;
   import flash.system.ApplicationDomain;
   import flash.utils.Dictionary;
   
   public class Enum_ZhangMenRen
   {
      
      private static var _xfNms:Array;
      
      public static var srcDomain:ApplicationDomain;
      
      public static const CJX:int = 138;
      
      public static const CJY:int = 47;
      
      public static const MAXTILE:int = 5;
      
      public static const needLv:int = 25;
      
      public static const SSPEED:int = 300;
      
      public static const ASPEED:int = 5;
      
      public static const COMBOTIMES:int = 10;
      
      public static const colorArr:Array = [16776960,16711680,65535,16711935,65280];
      
      public static const transformArr:Array = ["yellow","red","blue","cyan","green"];
      
      public static const XFLV:Array = ["神·","圣·","仙·","尊·"];
      
      private static var srcDic:Dictionary = new Dictionary();
      
      public static const XINFA_LV_LOSE:int = 0;
      
      public static const XINFA_LV_SUC:int = 1;
      
      public static const XINFA_JJ_STATUS_NO:int = 0;
      
      public static const XINFA_JJ_STATUS_CAN:int = 1;
      
      public static const XINFA_JJ_STATUS_HAS:int = 2;
      
      public function Enum_ZhangMenRen()
      {
         super();
      }
      
      public static function get xinFaNames() : Array
      {
         _xfNms = [];
         var i:int = 0;
         while(i < 5)
         {
            if(Model_ZhangMenRen.isGod)
            {
               _xfNms.push("神·" + LangConfig.getWord((29050 + i).toString(),2));
            }
            else
            {
               _xfNms.push(LangConfig.getWord((29050 + i).toString(),2));
            }
            i += 1;
         }
         return _xfNms;
      }
      
      public static function get YJTIP() : String
      {
         return LangConfig.getWord("21055",2);
      }
      
      public static function findXinID(type:int, level:int) : int
      {
         if(level > 100)
         {
            level -= 100;
         }
         return int(39000 + type * 100 + level - 1);
      }
      
      public static function getCount(lv:int) : int
      {
         var key:String = null;
         var tiantiDic:Dictionary = Data_lib.tianTi;
         var tmp:int = 0;
         for(key in tiantiDic)
         {
            if(key != "len")
            {
               if(tiantiDic[key][2] <= lv)
               {
                  tmp = int(key);
               }
            }
         }
         return tmp >= 3 ? tmp : 3;
      }
      
      public static function get YJCost() : int
      {
         if(Model_ZhangMenRen.isGod)
         {
            return 5000;
         }
         return 1000;
      }
   }
}

