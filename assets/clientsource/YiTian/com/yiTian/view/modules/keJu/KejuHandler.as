package com.yiTian.view.modules.keJu
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import flash.utils.getTimer;
   
   public class KejuHandler
   {
      
      private static var startTime:Number;
      
      public static var canColl:Boolean = true;
      
      public function KejuHandler()
      {
         super();
      }
      
      public static function changColl() : void
      {
         startTime = getTimer();
         canColl = false;
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,changCollFun);
      }
      
      private static function changCollFun() : void
      {
         if(getTimer() - startTime > 200)
         {
            canColl = true;
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,changCollFun);
         }
      }
   }
}

