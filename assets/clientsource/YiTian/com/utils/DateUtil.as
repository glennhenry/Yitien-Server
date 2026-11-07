package com.utils
{
   public class DateUtil
   {
      
      public static var dayStrings:Array = ["星期日","星期一","星期二","星期三","星期四","星期五","星期六"];
      
      public function DateUtil()
      {
         super();
      }
      
      public static function transDate(value:Number) : String
      {
         var date:Date = new Date(value * 1000);
         var hourStr:String = date.hours >= 10 ? date.hours + "" : "0" + date.hours;
         var minStr:String = date.minutes >= 10 ? date.minutes + "" : "0" + date.minutes;
         var secondsStr:String = date.seconds >= 10 ? date.seconds + "" : "0" + date.seconds;
         return hourStr + ":" + minStr + ":" + secondsStr;
      }
      
      public static function decodeInt2String($date:int) : String
      {
         var date:String = $date + "";
         var year:String = date.slice(0,4);
         var month:String = date.slice(4,6);
         var day:String = date.slice(6,8);
         var time:String = date.slice(8,10);
         return year + "-" + month + "-" + day + " " + time;
      }
      
      public static function getUTCDate(date:Date) : Date
      {
         date.minutes -= date.getTimezoneOffset();
         return date;
      }
      
      public static function addYear(date:Date, years:Number = 0) : Date
      {
         date.month += years * 12;
         return date;
      }
      
      public static function addMonth(date:Date, months:Number = 0) : Date
      {
         date.month += months;
         return date;
      }
      
      public static function addDay(date:Date, days:Number = 0) : Date
      {
         date.date += days;
         return date;
      }
      
      public static function addHours(date:Date, hours:Number = 0) : Date
      {
         date.hours += hours;
         return date;
      }
      
      public static function addMinutes(date:Date, minutes:Number = 0) : Date
      {
         date.minutes += minutes;
         return date;
      }
      
      public static function addSeconds(date:Date, seconds:Number = 0) : Date
      {
         date.seconds += seconds;
         return date;
      }
      
      public static function format(date:Date, formString:String = "YYYY-MM-DD") : String
      {
         var dateFormatter:DateFormatter = new DateFormatter();
         dateFormatter.formatString = formString;
         return dateFormatter.format(date);
      }
      
      public static function dateDiffer(startTime:Date, endTime:Date) : Number
      {
         return startTime.time - endTime.time;
      }
      
      public static function getDateBySeconds(seconds:Number) : String
      {
         return "";
      }
      
      public static function getHMSBySecond(second:Number, division:String = "时分秒") : String
      {
         var h:uint = second / 3600;
         var m:uint = second % 3600 / 60;
         var s:uint = second % 3600 % 60;
         var result:String = "";
         if(h > 0)
         {
            result = h + division.charAt(0);
         }
         if(m > 0 || h > 0)
         {
            result = result + m + division.charAt(1);
         }
         return result + s + division.charAt(2);
      }
      
      public static function getHMSBySecond2(second:Number, division:String = "::") : String
      {
         var result:String = null;
         var h:uint = second / 3600;
         var m:uint = second % 3600 / 60;
         var s:uint = second % 3600 % 60;
         result = h >= 10 ? h.toString() + division.charAt(0) : "0" + h.toString() + division.charAt(0);
         result += m >= 10 ? m.toString() + division.charAt(1) : "0" + m.toString() + division.charAt(1);
         return result + (s >= 10 ? s.toString() : "0" + s.toString());
      }
      
      public static function getMSBySecond2(second:Number, division:String = "：：") : String
      {
         var h:String = uint(second / 3600) + "";
         var m:String = uint(second % 3600 / 60) + "";
         var s:String = uint(second % 3600 % 60) + "";
         var result:String = "";
         if(int(h) > 0)
         {
            if(h.length == 1)
            {
               result = "0" + h + division.charAt(0);
            }
            else
            {
               result = h + division.charAt(0);
            }
         }
         else if(int(h) == 0)
         {
            result = "00" + division.charAt(0);
         }
         if(int(m) > 0)
         {
            if(m.length == 1)
            {
               result = result + "0" + m + division.charAt(1);
            }
            else
            {
               result = result + m + division.charAt(1);
            }
         }
         else if(int(m) == 0)
         {
            result = result + "00" + division.charAt(1);
         }
         if(s.length == 1)
         {
            result = result + "0" + s;
         }
         else
         {
            result += s;
         }
         return result;
      }
      
      public static function getMSBySecond3(second:Number, division:String = "：") : String
      {
         var m:String = uint(second % 3600 / 60) + "";
         var s:String = uint(second % 3600 % 60) + "";
         var result:String = "";
         if(int(m) > 0)
         {
            if(m.length == 1)
            {
               result = result + "0" + m + ":";
            }
            else
            {
               result = result + m + ":";
            }
         }
         else if(int(m) == 0)
         {
            result = result + "00" + ":";
         }
         if(s.length == 1)
         {
            result = result + "0" + s;
         }
         else
         {
            result += s;
         }
         return result;
      }
      
      public static function getMSBySecond4(second:Number, division:String = "天时分秒") : String
      {
         var result:String = "";
         var day:String = uint(second / (3600 * 24)) + "";
         if(int(day) >= 1)
         {
            result = day + "天";
         }
         var h:int = second % (3600 * 24);
         if(h == 0)
         {
            return result;
         }
         var hour:int = int(h / 3600);
         result = result + hour + "时";
         var min:int = int(h % 3600);
         if(min == 0)
         {
            return result;
         }
         var minu:int = int(min / 60);
         result = result + minu + "分";
         var sec:int = int(min % 60);
         if(sec == 0 || int(day) > 0)
         {
            return result;
         }
         var secon:int = sec;
         return result + secon + "秒";
      }
      
      public static function getHMBysecond(second:Number, division:String = ":") : String
      {
         var m:String = null;
         var result:String = "";
         var time:Number = int(second) * 1000;
         var date:Date = new Date(time);
         result = String(date.hoursUTC) + division;
         m = String(date.getMinutes());
         if(m.length < 2)
         {
            m = "0" + m;
         }
         return result + m;
      }
      
      public static function clone(date:Date) : Date
      {
         return new Date(date.getFullYear(),date.getMonth(),date.getDate(),date.getHours(),date.getMinutes(),date.getSeconds(),date.getMilliseconds());
      }
      
      public static function getDaysByMonth(year:Number, month:int) : int
      {
         var days:Array = new Array(31,28,31,30,31,30,31,31,30,31,30,31);
         if(year % 4 == 0 && year % 100 != 0 || year % 400 == 0)
         {
            days[1] = 29;
         }
         if(month > 11)
         {
            month = 11;
         }
         if(month < 0)
         {
            month = 0;
         }
         return days[month] as int;
      }
      
      public static function getDefaultDateString(date:Date, needTime:Boolean = true) : String
      {
         var year:String = date.fullYear + "";
         var month:String = addZero(date.month + 1 + "");
         var dayOfMonth:String = addZero(date.date + "");
         var hours:String = addZero(date.hours + "");
         var min:String = addZero(date.minutes + "");
         var sec:String = addZero(date.seconds + "");
         if(needTime)
         {
            return year + "-" + month + "-" + dayOfMonth + " " + hours + ":" + min + ":" + sec;
         }
         return year + "-" + month + "-" + dayOfMonth;
      }
      
      public static function getYearMonthDay(value:int, division:String = "--") : String
      {
         var temStr:String = null;
         var data:Date = new Date(value * 1000);
         trace("year..",data.getFullYear());
         trace(data.getMonth());
         trace(data.getDay());
         temStr = data.getDate() < 10 ? "0" + data.getDate().toString() : data.getDate().toString();
         return data.getFullYear().toString() + division.charAt(0) + (data.getMonth() + 1).toString() + division.charAt(1) + temStr + (Boolean(division.charAt(2)) ? division.charAt(2) : "");
      }
      
      public static function getYMDHM(value:int, c1:String = "-", c2:String = "-", c3:String = " ", c4:String = ":") : String
      {
         var str:String = null;
         var data:Date = new Date(value * 1000);
         str = data.getFullYear().toString();
         str += c1 + (data.getMonth() + 1 < 10 ? "0" + (data.getMonth() + 1).toString() : (data.getMonth() + 1).toString());
         str += c2 + (data.getDate() < 10 ? "0" + data.getDate().toString() : data.getDate().toString());
         str += c3 + (data.getHours() < 10 ? "0" + data.getHours().toString() : data.getHours().toString());
         return str + (c4 + (data.getMinutes() < 10 ? "0" + data.getMinutes().toString() : data.getMinutes().toString()));
      }
      
      public static function getDateFromDefaultString(str:String) : Date
      {
         if(str.length > 19)
         {
            str = str.substr(0,19);
         }
         var pattern:RegExp = /-/g;
         str = str.replace(pattern,"/");
         return new Date(Date.parse(str));
      }
      
      private static function addZero(str:String) : String
      {
         if(str.length == 1)
         {
            str = "0" + str;
         }
         return str;
      }
      
      public static function dateCompareFun(a:Date, b:Date) : int
      {
         if(a.time > b.time)
         {
            return 1;
         }
         if(a.time < b.time)
         {
            return -1;
         }
         return 0;
      }
      
      public static function dateCompareFunDesc(a:Date, b:Date) : int
      {
         if(a.time > b.time)
         {
            return -1;
         }
         if(a.time < b.time)
         {
            return 1;
         }
         return 0;
      }
      
      public static function getSubDate(a:Date, b:Date) : Number
      {
         var newA:Date = clearHourse(a);
         var newB:Date = clearHourse(b);
         return Math.abs(Math.round((newA.time - newB.time) / (24 * 3600 * 1000)));
      }
      
      public static function clearHourse(date:Date) : Date
      {
         var result:Date = new Date(date.time);
         result.hours = result.minutes = result.seconds = 0;
         return result;
      }
      
      public static function getStartEndDatesByMonth(year:Number, month:Number) : Array
      {
         var sDate:Date = new Date(year,month);
         sDate.date -= sDate.day;
         var eDate:Date = new Date(year,month,getLastDateByMonth(year,month));
         eDate.date += 6 - eDate.day;
         return [sDate,eDate];
      }
      
      private static function getLastDateByMonth(y:Number, m:Number) : int
      {
         var result:int = 31;
         switch(m)
         {
            case 0:
            case 2:
            case 4:
            case 6:
            case 7:
            case 9:
            case 11:
               result = 31;
               break;
            case 3:
            case 5:
            case 8:
            case 10:
               result = 30;
               break;
            case 1:
               if(y % 4 == 0)
               {
                  result = 29;
                  break;
               }
               result = 28;
         }
         return result;
      }
      
      public static function getStartEndDatesByWeek(year:Number, week:Number) : Array
      {
         var sDate:Date = new Date(year,0);
         sDate.date += 7 - sDate.day;
         sDate.date += 7 * (week - 1);
         var eDate:Date = new Date(sDate.time);
         eDate.date += 6;
         return [sDate,eDate];
      }
      
      public static function getWeekIndex(date:Date) : int
      {
         var sDate:Date = new Date(date.fullYear,0);
         sDate.date += 7 - sDate.day;
         return int(getSubDate(date,sDate) / 7) + 1;
      }
      
      public static function getStartEndDatesByDate(date:Date) : Array
      {
         var sDate:Date = new Date(date.time);
         sDate.date -= 1;
         var eDate:Date = new Date(date.time);
         eDate.date += 1;
         return [sDate,eDate];
      }
   }
}

class DateFormatter
{
   
   private var _formatString:String;
   
   public function DateFormatter()
   {
      super();
   }
   
   public function set formatString(value:String) : void
   {
      if(Boolean(value))
      {
         this._formatString = value;
      }
   }
   
   public function get formatString() : String
   {
      return this._formatString;
   }
   
   public function format(value:Object) : String
   {
      return null;
   }
}
