package com.yiTian.view.modules.blueDiamondND.xiaofeiCJ
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   
   public class XFTipBtn
   {
      
      private static var tipBtn:MainUIBtn;
      
      public function XFTipBtn()
      {
         super();
      }
      
      public static function show() : void
      {
      }
      
      public static function hide() : void
      {
         if(Boolean(tipBtn))
         {
            UIManager.mainUiBtnContainer.removeBTN(tipBtn);
         }
      }
   }
}

