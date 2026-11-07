package com.yiTian.view.modules.actions.guoqingkuanghuan
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class GuoqingkuanghuanTip
   {
      
      private static var actBtn:MainUIBtn;
      
      public function GuoqingkuanghuanTip()
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
               actBtn = new MainUIBtn("resource/image/guoqingkuanghuan/guoqingkuanghuan.png",{
                  "x":-12,
                  "y":-7
               });
               UIManager.mainUiBtnContainer.addBTN(actBtn);
               actBtn.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
               {
                  UIManager.mainUiBtnContainer.removeBTN(actBtn);
                  actBtn = null;
                  navigateToURL(new URLRequest("http://yi.qq.com/act/a20130913nationalday/index.htm"),"_brank");
               });
            }
         }
      }
   }
}

