package com.yiTian.view.modules.wuXing
{
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.WuxingCGMessage;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   
   public class WuxingIconTip
   {
      
      public static var tipBtn:MainUIBtn;
      
      public function WuxingIconTip()
      {
         super();
      }
      
      public static function show() : void
      {
         if(GameUnitManager.hero.level < 50)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP,showTip);
         }
         else
         {
            showTip();
         }
      }
      
      private static function showTip() : void
      {
         if(GameUnitManager.hero.level >= 50)
         {
            if(!tipBtn)
            {
               tipBtn = new MainUIBtn("resource/image/wuXing/wuXingIcon.png");
               tipBtn.y = -20;
               tipBtn.addEventListener(MouseEvent.CLICK,cliHd);
               tipBtn.addEventListener(MouseEvent.ROLL_OVER,onRollOver);
               tipBtn.addEventListener(MouseEvent.ROLL_OUT,onRollOut);
               UIManager.special_btn.appendItem(tipBtn);
            }
            Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP,showTip);
         }
      }
      
      private static function onRollOver(e:MouseEvent) : void
      {
         tipBtn.filters = Util.glowBigFFff00;
      }
      
      private static function onRollOut(e:MouseEvent) : void
      {
         tipBtn.filters = null;
      }
      
      public static function cliHd(e:MouseEvent = null) : void
      {
         if(GameUnitManager.hero.level < 50)
         {
            UIManager.centerBroadcast.addMsg("等级不够");
            return;
         }
         WuXingMter.getPan(WuxingPan,function(pan:WuxingPan):void
         {
            pan.visible = !pan.visible;
            if(pan.visible)
            {
               WuxingCGMessage.CG_OPEN_WUXINGPAN();
            }
         });
      }
   }
}

