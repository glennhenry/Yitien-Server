package com.yiTian.view.modules.actions.weiXin
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.view.modules.actions.xsHaoli.LinkManager;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   
   public class weiXTip
   {
      
      public function weiXTip()
      {
         super();
      }
      
      public static function showTip() : void
      {
         if(GameUnitManager.hero.level < 30)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP_2,showTip);
            return;
         }
         Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP_2,showTip);
         LinkManager.jump("http://yi.qq.com/act/a20130527yit61/index.htm",new MainUIBtn("resource/image/weixin/weixin.png",{
            "x":-12,
            "y":-9
         }),true,LinkManager.RIGHT_UP);
      }
   }
}

