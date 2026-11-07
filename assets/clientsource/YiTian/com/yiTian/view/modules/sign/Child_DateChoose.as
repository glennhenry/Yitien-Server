package com.yiTian.view.modules.sign
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class Child_DateChoose extends Sprite
   {
      
      private var headtxt:MyTextField;
      
      private var itemList:Vector.<Child_CalendarItem> = new Vector.<Child_CalendarItem>(Enum_Sign.ITEM_MAX_NUM,true);
      
      private var item:Child_CalendarItem;
      
      private var xqArr:Array = new Array("日","一","二","三","四","五","六");
      
      private var MonthArr:Array = new Array(31,28,31,30,31,30,31,31,30,31,30,31);
      
      private var isToday:int;
      
      private var xm:int;
      
      private var ym:int;
      
      private var startday:int;
      
      private var date:Date;
      
      private var panelwidth:int = 322;
      
      private var panelheight:int = 400;
      
      private var nowMonth:int;
      
      private var nowYear:int;
      
      private var currentMonth:int;
      
      private var currentYear:int;
      
      private var dateIndex:int;
      
      public function Child_DateChoose()
      {
         super();
         this.date = new Date();
         this.nowMonth = this.date.getMonth();
         this.nowYear = this.date.getFullYear();
         this.currentMonth = this.date.getMonth();
         this.addPanel(this.date.getFullYear(),this.date.getMonth());
         this.addDate(this.date.getFullYear(),this.date.getMonth(),1);
      }
      
      public function updateDate(date:Date) : void
      {
         this.date = date;
         this.nowMonth = date.getMonth();
         this.nowYear = date.getFullYear();
         if(Model_Sign.index == Enum_Sign.MIN_INDEX)
         {
            this.addDate(date.getFullYear(),date.getMonth() - 1,date.getDate());
            this.currentMonth = date.getMonth() - 1;
         }
         else if(Model_Sign.index == Enum_Sign.MAX_INDEX)
         {
            this.addDate(date.getFullYear(),date.getMonth() + 1,date.getDate());
            this.currentMonth = date.getMonth() + 1;
         }
         else
         {
            this.addDate(date.getFullYear(),date.getMonth(),date.getDate());
            this.currentMonth = date.getMonth();
         }
      }
      
      private function addPanel(year:Number, month:Number) : void
      {
         ComponentUtil.getBitmap("Back_DayList",this,{
            "x":0,
            "y":0
         },Global.ZaiXian_Imgsdm);
         ComponentUtil.getTextField("周日",this,{
            "x":9,
            "y":5,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("周一",this,{
            "x":55,
            "y":5,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("周二",this,{
            "x":101,
            "y":5,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("周三",this,{
            "x":147,
            "y":5,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("周四",this,{
            "x":193,
            "y":5,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("周五",this,{
            "x":239,
            "y":5,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("周六",this,{
            "x":285,
            "y":5,
            "color":16764206,
            "size":12,
            "leading":0
         });
         var premonth:Button = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":116,
            "y":-23,
            "textColor":16184781,
            "callBack":this.premonthHandler
         },Global.Img_Cdm);
         this.headtxt = ComponentUtil.getTextField("",this,{
            "x":premonth.x + premonth.width + 3,
            "y":-24,
            "width":28,
            "height":20,
            "color":16184781,
            "size":16,
            "leading":0
         });
         var nextmonth:Button = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":179,
            "y":-23,
            "textColor":16184781,
            "callBack":this.nextmonthHandler
         },Global.Img_Cdm);
      }
      
      private function addDate(year:int, month:int, day:int) : void
      {
         var lastMonthDays:int = 0;
         var i:int = 0;
         var index:Object = null;
         this.headtxt.htmlText = (month + 1).toString() + "月";
         this.currentYear = year;
         var nowdate:Date = new Date(year,month,1);
         this.startday = nowdate.getDay();
         var startDayNum:int = this.startday;
         lastMonthDays = int(this.MonthArr[(month - 1 + 12) % 12]);
         var nextMonthDays:int = int(this.MonthArr[(month + 1 + 12) % 12]);
         var days:int = int(this.MonthArr[month]);
         this.xm = this.panelwidth / 7;
         this.ym = 32;
         if(Model_Sign.index == Enum_Sign.MAX_INDEX)
         {
            this.dateIndex = 2 * Enum_Sign.ITEM_MAX_NUM;
         }
         else if(Model_Sign.index == Enum_Sign.MIN_INDEX)
         {
            this.dateIndex = 0;
         }
         else
         {
            this.dateIndex = Enum_Sign.ITEM_MAX_NUM;
         }
         i = 0;
         while(i < this.itemList.length)
         {
            if(!this.itemList[i])
            {
               this.item = new Child_CalendarItem();
               this.itemList[i] = this.item;
               addChild(this.item);
            }
            i++;
         }
         if(int(year.toString().substr(2,3)) % 4 == 0)
         {
            if(month == Enum_Sign.FEBRUARY)
            {
               days = 29;
            }
         }
         var nextMoneyStartDay:int = Enum_Sign.ITEM_MAX_NUM - days - startDayNum;
         var yearAndMontyData:Object = Model_Sign.yearAndMontyData;
         i = 0;
         while(i < startDayNum)
         {
            if(Boolean(this.itemList[i]))
            {
               this.itemList[i].x = this.xm * (startDayNum - i - 1);
               this.itemList[i].y = this.ym;
               index = int(Model_Sign.yearAndMontyData["" + year + (month < 10 ? "0" + month : month) + (lastMonthDays - i)]);
               this.itemList[i].update(int(Model_Sign.yearAndMontyData["" + year + (month < 10 ? "0" + month : month) + (lastMonthDays - i)]),lastMonthDays - i,Model_Sign.signStatusData["" + year + (month < 10 ? "0" + month : month) + (lastMonthDays - i)],Enum_Sign.NOT_TODAY,false,false);
               ++this.dateIndex;
            }
            i++;
         }
         i = 0;
         while(i < days)
         {
            if(i == this.date.getDate() - 1 && this.nowMonth == month && this.nowYear == year)
            {
               this.isToday = Enum_Sign.TODAY;
            }
            else
            {
               this.isToday = Enum_Sign.NOT_TODAY;
            }
            if(i > this.date.getDate() - 1 && this.nowMonth == month && this.nowYear == year)
            {
               this.dealDate(i,i + startDayNum,year,month + 1,false,true);
            }
            else
            {
               this.dealDate(i,i + startDayNum,year,month + 1,true,true);
            }
            i++;
         }
         i = 0;
         while(i < nextMoneyStartDay)
         {
            this.isToday = Enum_Sign.NOT_TODAY;
            this.dealDate(i,i + startDayNum + days,year,month + 2,false,false);
            i++;
         }
      }
      
      private function dealDate(i:int, startIndex:int, year:int, month:int, value:Boolean, nowMonth:Boolean) : void
      {
         var index:Object = null;
         var index2:Object = null;
         var modelArr:Array = Model_Sign.yearAndMontyData;
         if(Boolean(this.itemList[startIndex]))
         {
            this.itemList[startIndex].x = this.xm * this.startday;
            this.itemList[startIndex].y = this.ym;
            index = "" + year + (month < 10 ? "0" + month : month) + (i + 1 < 10 ? "0" + (i + 1) : i + 1);
            index2 = "" + year + (month < 10 ? "0" + month : month) + (i + 1 < 10 ? "0" + (i + 1) : i + 1);
            if(this.dateIndex >= 2 * Enum_Sign.ITEM_MAX_NUM)
            {
               this.itemList[startIndex].update(int(Model_Sign.yearAndMontyData["" + year + (month < 10 ? "0" + month : month) + (i + 1 < 10 ? "0" + (i + 1) : i + 1)]),i + 1,Model_Sign.signStatusData["" + year + (month < 10 ? "0" + month : month) + (i + 1 < 10 ? "0" + (i + 1) : i + 1)],this.isToday,false,nowMonth);
            }
            else
            {
               this.itemList[startIndex].update(int(Model_Sign.yearAndMontyData["" + year + (month < 10 ? "0" + month : month) + (i + 1 < 10 ? "0" + (i + 1) : i + 1)]),i + 1,Model_Sign.signStatusData["" + year + (month < 10 ? "0" + month : month) + (i + 1 < 10 ? "0" + (i + 1) : i + 1)],this.isToday,value,nowMonth);
            }
            ++this.dateIndex;
         }
         if(this.startday >= 6)
         {
            this.xm = this.panelwidth / 7;
            this.ym += 30;
            this.startday = -1;
         }
         ++this.startday;
      }
      
      private function nextmonthHandler(evt:MouseEvent) : void
      {
         SignUtil.removeSingleTips();
         if(Model_Sign.index == Enum_Sign.MAX_INDEX)
         {
            return;
         }
         if(this.currentMonth < Enum_Sign.MAX_MONTH)
         {
            this.currentMonth += 1;
         }
         else
         {
            this.currentMonth = Enum_Sign.MIN_MONTH;
            this.currentYear += 1;
         }
         ++Model_Sign.index;
         this.headtxt.htmlText = (this.currentMonth + 1).toString() + "月";
         this.addDate(this.currentYear,this.currentMonth,1);
      }
      
      private function premonthHandler(evt:MouseEvent) : void
      {
         SignUtil.removeSingleTips();
         if(Model_Sign.index == Enum_Sign.MIN_INDEX)
         {
            return;
         }
         if(this.currentMonth > Enum_Sign.MIN_MONTH)
         {
            this.currentMonth -= 1;
         }
         else
         {
            this.currentMonth = Enum_Sign.MAX_MONTH;
            this.currentYear -= 1;
         }
         --Model_Sign.index;
         this.headtxt.htmlText = (this.currentMonth + 1).toString() + "月";
         this.addDate(this.currentYear,this.currentMonth,1);
      }
   }
}

