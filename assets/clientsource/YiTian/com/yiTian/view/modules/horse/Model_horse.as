package com.yiTian.view.modules.horse
{
   import com.yiTian.Global;
   
   public class Model_horse
   {
      
      public static var partInfos:Array;
      
      public static var extraMoveSpeed:int;
      
      public static var baseMoveSpeed:int;
      
      public static var qiangHuaLucky:int;
      
      public static var qiangHuaHorseId:int;
      
      public static var libInfos:Object;
      
      public static var myRidder:int;
      
      public static var curJinJieId:int;
      
      public static var starSignHorseLv:int = 1;
      
      public static const HORSEPNL_VIS_CHANGE:String = "HorsPnleVisChange";
      
      public static const STARHORSE_LV_CHANGE:String = "STARHORSE_LV_CHANGE";
      
      public static var qiangHuaStar:int = -1;
      
      public static var neverNote:Array = [];
      
      public function Model_horse()
      {
         super();
      }
      
      public static function getSSLevel() : int
      {
         var min:int = 150;
         if(!partInfos)
         {
            return 0;
         }
         var len:int = int(partInfos.length);
         var i:int = 0;
         while(i < len)
         {
            if(partInfos[i] < min)
            {
               min = int(partInfos[i]);
            }
            i += 2;
         }
         return min;
      }
      
      public static function updateStarsignHorse(lv:int) : void
      {
         starSignHorseLv = lv;
         Global.control.sendNotification(STARHORSE_LV_CHANGE,lv);
      }
   }
}

