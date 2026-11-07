package com.yiTian.view.modules.actions.beCahua
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.view.modules.actions.xsHaoli.LinkManager;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   
   public class TipBtnBeCahua
   {
      
      public function TipBtnBeCahua()
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
         LinkManager.jump("http://yi.qq.com/act/a20130702wldch/index.htm",new MainUIBtn("resource/image/beCahua/beCahua.png",{
            "x":-12,
            "y":-9
         }),true);
      }
   }
}

