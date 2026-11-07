package com.yiTian.view.modules.actions.yaAn
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import com.yiTian.view.modules.wuXing.WuXingMter;
   import flash.events.MouseEvent;
   
   public class YaAnTip
   {
      
      private static var tipBtn:MainUIBtn;
      
      public function YaAnTip()
      {
         super();
      }
      
      public static function show(result:int) : void
      {
         if(result == 1)
         {
            if(!tipBtn)
            {
               tipBtn = new MainUIBtn("resource/image/xinXiYaAn/yaAn.png");
               tipBtn.addEventListener(MouseEvent.CLICK,function():void
               {
                  WuXingMter.getPan(YaAnShaking,function(pan:YaAnShaking):void
                  {
                     pan.visible = true;
                  });
               });
            }
            if(!UIManager.mainUiBtnContainer.hasBTN(tipBtn))
            {
               UIManager.mainUiBtnContainer.addBTN(tipBtn);
            }
         }
         else
         {
            removeTip();
         }
      }
      
      public static function removeTip() : void
      {
         if(!UIManager.mainUiBtnContainer.hasBTN(tipBtn))
         {
            UIManager.mainUiBtnContainer.removeBTN(tipBtn);
         }
      }
   }
}

