package com.yiTian.view.modules.tianTi
{
   import com.yiTian.net.message.cg.TianTiCGMessage;
   import flash.system.ApplicationDomain;
   import flash.utils.setTimeout;
   
   public class TianTiManager
   {
      
      public static var player:Child_tianTiUnit;
      
      public static var data:Array;
      
      public static var bInfo:Array;
      
      public static var floodDomain:ApplicationDomain;
      
      public static var refreshTimes:int = -1;
      
      public static var maxLv:int = 20;
      
      public static var curLv:int = -1;
      
      public static var recordLv:int = 0;
      
      public static var refreshCGFlag:Boolean = false;
      
      public static var xfLoad:Boolean = false;
      
      private static var lastTimeOutIndex:int = 0;
      
      public function TianTiManager()
      {
         super();
      }
      
      public static function reqReward() : void
      {
         if(lastTimeOutIndex != 0)
         {
            return;
         }
         TianTiCGMessage.CG_TIANTIREWARDS();
         lastTimeOutIndex = setTimeout(function():void
         {
            lastTimeOutIndex = 0;
         },3000);
      }
   }
}

