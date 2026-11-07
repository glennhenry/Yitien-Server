package com.yiTian.view.modules.actions.xsHaoli
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   
   public class XSHaoLiTip
   {
      
      public function XSHaoLiTip()
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
         LinkManager.jump("http://qqgame.qq.com/act/a20130521gift/index.html",new MainUIBtn("resource/image/xianshiHaoli/xsHaoli.png",{
            "x":-12,
            "y":-9
         }),true,LinkManager.RIGHT_UP);
      }
   }
}

