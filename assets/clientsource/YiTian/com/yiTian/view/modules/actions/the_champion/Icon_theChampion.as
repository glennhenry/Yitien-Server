package com.yiTian.view.modules.actions.the_champion
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.view.modules.actions.xsHaoli.LinkManager;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import com.yiTian.view.modules.mainUIBtnContainer.View_mainUiBtn_container;
   
   public class Icon_theChampion
   {
      
      private static var icon:MainUIBtn;
      
      public function Icon_theChampion()
      {
         super();
      }
      
      public static function show() : void
      {
         if(GameUnitManager.hero.level < 35)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP_2,show);
            return;
         }
         Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP_2,show);
         if(!icon)
         {
            icon = new MainUIBtn("resource/image/theChampion/championIcon.png",{
               "x":-12,
               "y":-9
            });
         }
         LinkManager.jump("http://bbs.open.qq.com/forum.php?mod=viewthread&tid=3145097&fromuid=65636",icon,true,LinkManager.RIGHT_UP);
      }
      
      public static function hide() : void
      {
         if(Boolean(icon) && Boolean(icon.parent) && icon.parent is View_mainUiBtn_container)
         {
            (icon.parent as View_mainUiBtn_container).removeBTN(icon);
         }
      }
   }
}

