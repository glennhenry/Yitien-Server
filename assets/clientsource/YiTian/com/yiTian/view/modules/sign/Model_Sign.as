package com.yiTian.view.modules.sign
{
   import com.yiTian.data.Data_lib;
   
   public class Model_Sign
   {
      
      public static var holidayStatus:int;
      
      public static var nextHolidayDay:int;
      
      public static var holidayName:String;
      
      public static var index:int;
      
      public static var rewardEffType:int;
      
      public static var rewardIconIndex:int;
      
      public static var signRewardData:Array = [];
      
      public static var signRewardStatusData:Array = [];
      
      public static var signHolidayRewardData:Array = [];
      
      public static var signStatusData:Array = [];
      
      public static var yearAndMontyData:Array = [];
      
      public static var sysDate:int = 50500101;
      
      public function Model_Sign()
      {
         super();
      }
      
      public static function setSignRewardData() : void
      {
         var arr:Array = null;
         var i:String = null;
         for(i in Data_lib.signReward)
         {
            arr = new Array();
            arr.push(i);
            arr.push(Data_lib.signReward[i][0]);
            arr.push(Data_lib.signReward[i][1]);
            arr.push(Data_lib.signReward[i][2]);
            signRewardData.push(arr);
         }
      }
      
      public static function setSignHolidayRewardData() : void
      {
         var arr:Array = null;
         var i:String = null;
         for(i in Data_lib.signHolidayReward)
         {
            arr = Data_lib.signHolidayReward[i][0].toString().split(",");
         }
         signHolidayRewardData = arr;
      }
      
      public static function setSignStatusData() : void
      {
         var status:int = 0;
         var day:int = 0;
         var len:int = 2 * Enum_Sign.ITEM_MAX_NUM;
         var monty:int = 5;
         var i:int = 0;
         while(i < len)
         {
            if(i < 7)
            {
               monty = 3;
               day = 25 + i;
            }
            else if(i >= 7 && i < 42)
            {
               monty = 4;
               day = i - 6;
            }
            else
            {
               monty = 5;
               day = i - 41;
            }
            status = Math.random() * 2;
            signStatusData["" + 2013 + (monty < 10 ? "0" + monty : monty) + (day < 10 ? "0" + day : day)] = status;
            i++;
         }
      }
   }
}

