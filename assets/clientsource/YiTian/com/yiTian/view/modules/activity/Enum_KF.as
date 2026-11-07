package com.yiTian.view.modules.activity
{
   import com.yiTian.data.Data_lib;
   
   public class Enum_KF
   {
      
      public static const TYPE_ZL:int = 1;
      
      public static const TYPE_SC:int = 2;
      
      public static const ID_HORSE:int = 14;
      
      public static const ID_ZL:int = 15;
      
      public static const ID_BB:int = 16;
      
      public static const ID_FISHING:int = 44647;
      
      public static const ID_SHOUCHONGTUANGOU:int = 20;
      
      public static const ID_WUHUNTUANGOU:int = 21;
      
      public static const ID_ZUOQITUANGOU:int = 22;
      
      public static const FISHINGID:Array = [[],[20171,21101,20191,22101],[20172,21102,20192,22102]];
      
      public static const URL_IMG:Array = ["","BQ_DYT","BQ_DErT","BQ_DSanT","BQ_DSiT","BQ_DWuT","BQ_DLiuT","BQ_DQiT"];
      
      public function Enum_KF()
      {
         super();
      }
      
      public static function get wingArr() : Array
      {
         var modelId:* = undefined;
         var modelIdArray:Array = [];
         for(modelId in Data_lib.wing)
         {
            if(modelId == 1)
            {
               modelIdArray.push(modelId);
            }
            else if(Data_lib.wing[modelId][32] != Data_lib.wing[modelId - 1][32])
            {
               modelIdArray.push(modelId);
            }
         }
         return modelIdArray;
      }
      
      public static function transDate(value:Number = 1, type:int = 0) : String
      {
         var date:Date = new Date(value * 1000);
         var year:String = date.fullYear + "";
         var month:String = date.month + 1 < 10 ? "0" + (date.month + 1) : date.month + 1 + "";
         var day:String = date.dateUTC + 1 < 10 ? "0" + (date.dateUTC + 1) : date.dateUTC + 1 + "";
         var hourStr:String = date.hours >= 10 ? date.hours + "" : "0" + date.hours;
         var minStr:String = date.minutes >= 10 ? date.minutes + "" : "0" + date.minutes;
         var secondsStr:String = date.seconds >= 10 ? date.seconds + "" : "0" + date.seconds;
         if(Boolean(type))
         {
            return year + "年" + month + "月" + day + "日 ";
         }
         return year + "年" + month + "月" + day + "日 " + hourStr + ":" + minStr + ":" + secondsStr;
      }
   }
}

