package com.yiTian.view.modules.actions.DLxiaxin
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.view.modules.actions.xsHaoli.LinkManager;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   
   public class TipbtnXiaxin
   {
      
      public function TipbtnXiaxin()
      {
         super();
      }
      
      public static function show() : void
      {
         if(GameUnitManager.hero.level < 35)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP,show);
            return;
         }
         Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP,show);
         LinkManager.jump("http://yi.qq.com/act/a20130704dltb/index.htm",new MainUIBtn("resource/image/DLXiaxin/dlXX.png",{
            "x":-12,
            "y":-9
         }),true);
      }
   }
}

