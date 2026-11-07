package com.yiTian.manager
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.gameUnit.config.Status;
   import flash.utils.getTimer;
   
   public class CountStandTimeManager
   {
      
      private static var last:int;
      
      private static var count:int;
      
      public static var isNeedCount:Boolean = true;
      
      private static var rate:int = 180000;
      
      public function CountStandTimeManager()
      {
         super();
      }
      
      public static function run(now:int) : void
      {
         if(Global.isInBattle || GameUnitManager.hero.status != Status.NOMAL)
         {
            last = now;
            return;
         }
         if(GameUnitManager.hero.action != Action.STAND)
         {
            last = now;
            return;
         }
         if(now - last > rate)
         {
            if(GameUnitManager.hero.level >= 30)
            {
               if(GameUnitManager.hero.status != Status.SIT)
               {
                  Global.control.sendNotification(Enum_MsgType.MSG_GUAJIA,null);
                  last = now;
               }
            }
         }
      }
      
      public static function reset() : void
      {
         last = getTimer();
      }
   }
}

