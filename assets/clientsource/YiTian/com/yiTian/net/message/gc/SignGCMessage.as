package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.SignHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class SignGCMessage
   {
      
      public function SignGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_SIGN_INFO] = GC_SIGN_INFO;
         index[MessageType.GC_HOLIDAY_REWARD] = GC_HOLIDAY_REWARD;
         index[MessageType.GC_SIGN] = GC_SIGN;
         index[MessageType.GC_REWARD] = GC_REWARD;
         index[MessageType.GC_WEEK_WAGE] = GC_WEEK_WAGE;
         index[MessageType.GC_SIGN_HIGHTLIGHT] = GC_SIGN_HIGHTLIGHT;
      }
      
      public static function GC_SIGN_INFO(patch:IDataInput) : void
      {
         var holidayStatus:int = patch.readByte();
         var nextHolidayDay:int = patch.readShort();
         var holidayName:String = patch.readUTF();
         var kaifuDay:int = patch.readInt();
         var onlineHour:String = patch.readUTF();
         var nowWeekWage:int = patch.readInt();
         var lastWeekWage:int = patch.readInt();
         var wageStatus:int = patch.readInt();
         var days:String = patch.readUTF();
         var count:int = patch.readInt();
         var effType:int = patch.readInt();
         var rewardStatuss:String = patch.readUTF();
         var nowTime:int = patch.readInt();
         var kaifuDate:int = patch.readInt();
         SignHandler.GC_SIGN_INFO(holidayStatus,nextHolidayDay,holidayName,kaifuDay,onlineHour,nowWeekWage,lastWeekWage,wageStatus,days,count,effType,rewardStatuss,nowTime,kaifuDate);
      }
      
      public static function GC_HOLIDAY_REWARD(patch:IDataInput) : void
      {
         var result:int = patch.readInt();
         SignHandler.GC_HOLIDAY_REWARD(result);
      }
      
      public static function GC_SIGN(patch:IDataInput) : void
      {
         var result:int = patch.readInt();
         SignHandler.GC_SIGN(result);
      }
      
      public static function GC_REWARD(patch:IDataInput) : void
      {
         var result:int = patch.readInt();
         SignHandler.GC_REWARD(result);
      }
      
      public static function GC_WEEK_WAGE(patch:IDataInput) : void
      {
         var result:int = patch.readInt();
         SignHandler.GC_WEEK_WAGE(result);
      }
      
      public static function GC_SIGN_HIGHTLIGHT(patch:IDataInput) : void
      {
         var result:int = patch.readInt();
         SignHandler.GC_SIGN_HIGHTLIGHT(result);
      }
   }
}

