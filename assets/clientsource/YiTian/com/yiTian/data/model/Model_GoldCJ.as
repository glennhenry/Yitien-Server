package com.yiTian.data.model
{
   import com.yiTian.data.Data_lib;
   
   public class Model_GoldCJ
   {
      
      public static var curCJType:int;
      
      public static var canLockTimes:int;
      
      public static var totalCJTimes:int;
      
      public static var moreCJDelay:int;
      
      public static var SOURCE_URL:String = "lang/ch/YuanBaoCJ_Imgs.swf";
      
      public static var STATE_LOCK:int = 1;
      
      public static var STATE_UNLOCK:int = 2;
      
      public static var STATE_CANNOT_LOCK:int = 3;
      
      public static var LOTTERY_TYPE_1:int = 1;
      
      public static var LOTTERY_TYPE_2:int = 10;
      
      public static var LOTTERY_TYPE_3:int = 50;
      
      public static var MAX_CJ_TIMES:int = 100;
      
      public static var timesArr:Array = [20,50,100];
      
      public static var REWARD_NUM:int = 10;
      
      public static var INFO_NUM:int = 8;
      
      public static var voArr:Array = new Array();
      
      public static var showInfoList:Array = new Array();
      
      public static var rewardList:Array = new Array();
      
      public static var lockStr:String = "";
      
      public static var dateStr:String = "";
      
      public static var isRunning:Boolean = false;
      
      public static var posArr1:Array = [{
         "x":164,
         "y":28
      },{
         "x":250,
         "y":51
      },{
         "x":306,
         "y":121
      },{
         "x":310,
         "y":209
      },{
         "x":262,
         "y":282
      },{
         "x":178,
         "y":314
      },{
         "x":93,
         "y":291
      },{
         "x":37,
         "y":210 + 15
      },{
         "x":33,
         "y":134
      },{
         "x":81,
         "y":60
      }];
      
      public static var posArr2:Array = [{
         "x":130,
         "y":51
      },{
         "x":206,
         "y":51
      },{
         "x":268,
         "y":97
      },{
         "x":291,
         "y":168
      },{
         "x":268,
         "y":239
      },{
         "x":206,
         "y":285
      },{
         "x":130,
         "y":285
      },{
         "x":68,
         "y":239
      },{
         "x":45,
         "y":168
      },{
         "x":68,
         "y":96
      }];
      
      public function Model_GoldCJ()
      {
         super();
      }
      
      public static function getArrByPos(pos:int) : Array
      {
         var index:String = null;
         for(index in Data_lib.goldCJ)
         {
            if(Data_lib.goldCJ[index][2] == pos)
            {
               return Data_lib.goldCJ[index];
            }
         }
         return Data_lib.goldCJ[0];
      }
   }
}

