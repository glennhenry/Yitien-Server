package com.yiTian.view.modules.yellowDiamond.yellowDiaShengYan
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class YellowDiaShengYanBtn
   {
      
      public static var tipBtn:MainUIBtn;
      
      public function YellowDiaShengYanBtn()
      {
         super();
      }
      
      public static function show() : void
      {
         if(GameUnitManager.hero.level < 50)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP_2,show);
            return;
         }
         Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP_2,show);
         if(!tipBtn)
         {
            tipBtn = new MainUIBtn("resource/image/hzsy/ht_shengYan.png",{
               "x":-12,
               "y":-8
            });
            UIManager.mainUiBtnContainer.addBTN(tipBtn);
            tipBtn.addEventListener(MouseEvent.CLICK,handle);
         }
      }
      
      private static function handle(e:MouseEvent) : void
      {
         hide();
         navigateToURL(new URLRequest("http://qzs.qq.com/qzone/mall/app/meteor/act/index.html?rid=340"));
      }
      
      private static function hide() : void
      {
         if(Boolean(tipBtn))
         {
            UIManager.mainUiBtnContainer.removeBTN(tipBtn);
            tipBtn = null;
         }
      }
   }
}

