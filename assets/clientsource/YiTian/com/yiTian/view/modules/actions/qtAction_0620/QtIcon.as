package com.yiTian.view.modules.actions.qtAction_0620
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.view.modules.actions.xsHaoli.LinkManager;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   
   public class QtIcon
   {
      
      public static var sign:Boolean = false;
      
      public function QtIcon()
      {
         super();
      }
      
      public static function showTip() : void
      {
         if(GameUnitManager.hero.level < 30)
         {
            if(sign)
            {
               return;
            }
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP,showTip);
            sign = true;
            return;
         }
         if(sign)
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP,showTip);
         }
         LinkManager.jump("http://yi.qq.com/webplat/info/news_version3/4814/5561/5562/m4016/201306/211839.shtml",new MainUIBtn("resource/image/linkActionIcon/qtIcon.png",{
            "x":-12,
            "y":-8
         }),false,LinkManager.RIGHT_UP);
      }
   }
}

