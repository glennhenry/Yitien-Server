package com.yiTian.view.modules.qingMing
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   
   public class QingMIconTip
   {
      
      private static var eff:Effect;
      
      private static var tipBtn:MainUIBtn;
      
      public function QingMIconTip()
      {
         super();
      }
      
      public static function showTip() : void
      {
         if(Global.iconCtrlUnknown)
         {
            if(GameUnitManager.hero.level < 30)
            {
               Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP,realShowTip);
            }
            else
            {
               realShowTip();
            }
         }
      }
      
      public static function realShowTip() : void
      {
      }
   }
}

