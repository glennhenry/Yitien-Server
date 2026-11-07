package com.yiTian.view.modules.WulinDaHui
{
   import com.utils.Util;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.WulinPartyCGMessage;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   public class CountdownTips extends Sprite
   {
      
      private static var frameType:int;
      
      private static var MAX_COUNT:int;
      
      private static var last:int;
      
      private static var now:int;
      
      public function CountdownTips()
      {
         super();
      }
      
      public function isBattleHandle() : void
      {
         frameType = 1;
         MAX_COUNT = 50;
         if(hasEventListener(Event.ENTER_FRAME))
         {
            removeEventListener(Event.ENTER_FRAME,this.frameHandle);
         }
         addEventListener(Event.ENTER_FRAME,this.frameHandle);
      }
      
      public function deadTimeHandle() : void
      {
         frameType = 2;
         MAX_COUNT = 10;
         if(hasEventListener(Event.ENTER_FRAME))
         {
            removeEventListener(Event.ENTER_FRAME,this.frameHandle);
         }
         addEventListener(Event.ENTER_FRAME,this.frameHandle);
      }
      
      private function frameHandle(e:Event) : void
      {
         now = getTimer();
         if(now - last >= 1000)
         {
            --MAX_COUNT;
            if(MAX_COUNT < 0)
            {
               MAX_COUNT = 0;
            }
            if(frameType == 2)
            {
               GameUnitManager.hero.filters = Util.disabled;
               UIManager.deadthCountPan.visible = true;
               UIManager.deadthCountPan.getTxt(MAX_COUNT);
            }
            else if(frameType == 1)
            {
               UIManager.wulin_record.upTxt(MAX_COUNT);
            }
            last = now;
         }
         if(MAX_COUNT <= 0)
         {
            this.removeFrame();
            if(frameType == 1)
            {
               WulinPartyCGMessage.CG_TIMEUP();
            }
            else if(frameType == 2)
            {
               WulinPartyCGMessage.CG_DEADCOUNT(UIManager.deadthCountPan.getType());
               UIManager.deadthCountPan.visible = false;
            }
         }
      }
      
      public function removeFrame() : void
      {
         if(frameType == 1)
         {
            UIManager.wulin_record.upTxt(MAX_COUNT);
         }
         removeEventListener(Event.ENTER_FRAME,this.frameHandle);
      }
   }
}

