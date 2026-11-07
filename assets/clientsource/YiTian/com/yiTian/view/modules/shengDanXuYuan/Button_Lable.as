package com.yiTian.view.modules.shengDanXuYuan
{
   import com.ui.controls.Button;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import flash.utils.getTimer;
   
   public class Button_Lable
   {
      
      private static var button:Button;
      
      private static var labelValue:int;
      
      private static var labelContent:String;
      
      private static var maxNumber:int;
      
      private static var compFun:Function;
      
      private static var startTime:Number;
      
      private static var playTime:int;
      
      public function Button_Lable()
      {
         super();
      }
      
      public static function play(target:Button, value:int, fun:Function, time:int = 3000) : void
      {
         button = target;
         labelValue = value;
         labelContent = button.label;
         maxNumber = getMaxNumber(value);
         compFun = fun;
         playTime = time;
         startTime = getTimer();
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,loopFun);
      }
      
      private static function getMaxNumber(num:int) : int
      {
         var len:int = num.toString().length;
         var max:int = 1;
         var i:int = 0;
         while(i < len)
         {
            max *= 10;
            i++;
         }
         return max;
      }
      
      private static function loopFun() : void
      {
         var num:int = int(button.label);
         button.label = int(Math.random() * maxNumber) + "";
         if(getTimer() - startTime >= playTime)
         {
            complete();
         }
      }
      
      private static function complete() : void
      {
         button.label = labelValue.toString();
         compFun();
         button = null;
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,loopFun);
      }
   }
}

