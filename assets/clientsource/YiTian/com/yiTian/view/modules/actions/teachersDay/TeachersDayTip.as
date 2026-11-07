package com.yiTian.view.modules.actions.teachersDay
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class TeachersDayTip
   {
      
      private static var actBtn:MainUIBtn;
      
      public function TeachersDayTip()
      {
         super();
      }
      
      public static function showTip() : void
      {
         if(GameUnitManager.hero.level < 35)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP,showTip);
            return;
         }
         Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP,showTip);
         if(GameUnitManager.hero.level >= 35)
         {
            if(!actBtn)
            {
               actBtn = new MainUIBtn("resource/image/jiaoshijiezhufu/jiaoshijiezhufu.png",{
                  "x":-12,
                  "y":-7
               });
               UIManager.mainUiBtnContainer.addBTN(actBtn);
               actBtn.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
               {
                  UIManager.mainUiBtnContainer.removeBTN(actBtn);
                  actBtn = null;
                  navigateToURL(new URLRequest("http://yi.qq.com/act/a20130822teacher/index.shtml"),"_brank");
               });
            }
         }
      }
   }
}

