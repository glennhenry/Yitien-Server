package com.yiTian.net.message.gc
{
   import com.yiTian.data.model.Model_qq_hall_national_day;
   import com.yiTian.net.handler.QqHallNationalDayReturnHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class QqHallNationalDayGCMessage
   {
      
      public function QqHallNationalDayGCMessage(index:Array)
      {
         super();
         index[MessageType.gc_qq_hall_national_day_return] = this.gc_qq_hall_national_day_return;
         index[MessageType.gc_qq_hall_get_gift_return] = this.gc_qq_hall_get_gift_return;
      }
      
      public function gc_qq_hall_national_day_return(patch:IDataInput) : void
      {
         var value:uint = uint(patch.readByte());
         if(value == 1)
         {
            QqHallNationalDayReturnHandler.addIcon();
         }
         else
         {
            QqHallNationalDayReturnHandler.removeIcon();
         }
         value = uint(patch.readByte());
         if(value == 0)
         {
            Model_qq_hall_national_day.instace.isMonthBlueDia = false;
         }
         else if(value == 1)
         {
            Model_qq_hall_national_day.instace.isMonthBlueDia = true;
            Model_qq_hall_national_day.instace.canGetMonthGift = true;
         }
         else if(value == 2)
         {
            Model_qq_hall_national_day.instace.isMonthBlueDia = true;
            Model_qq_hall_national_day.instace.canGetMonthGift = false;
         }
         value = uint(patch.readByte());
         if(value == 0)
         {
            Model_qq_hall_national_day.instace.isYearBuleDia = false;
         }
         else if(value == 1)
         {
            Model_qq_hall_national_day.instace.isYearBuleDia = true;
            Model_qq_hall_national_day.instace.canGetYearGift = true;
         }
         else if(value == 2)
         {
            Model_qq_hall_national_day.instace.isYearBuleDia = true;
            Model_qq_hall_national_day.instace.canGetYearGift = false;
         }
         QqHallNationalDayReturnHandler.update(0);
      }
      
      public function gc_qq_hall_get_gift_return(patch:IDataInput) : void
      {
         var type:uint = 0;
         var result:uint = uint(patch.readByte());
         if(result == 1)
         {
            type = uint(patch.readByte());
            if(type == 1)
            {
               Model_qq_hall_national_day.instace.canGetMonthGift = false;
               QqHallNationalDayReturnHandler.update(1);
            }
            else if(type == 2)
            {
               Model_qq_hall_national_day.instace.canGetYearGift = false;
               QqHallNationalDayReturnHandler.update(2);
            }
         }
      }
   }
}

