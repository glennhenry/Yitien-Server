package com.yiTian.net.handler
{
   import com.yiTian.data.config.Enum_vipBGift;
   import com.yiTian.data.model.Model_vipBGift;
   import com.yiTian.net.message.cg.VipBGiftCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.vipBGift.MainIcon_VBG;
   import com.yiTian.view.modules.vipBGift.View_vipBGift;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class VipBGiftHandler
   {
      
      public function VipBGiftHandler()
      {
         super();
      }
      
      public static function GC_VIPBG_OPENWIN(arr:Array, arr1:Array, date:int) : void
      {
         var str:String;
         var flag:int = 0;
         Model_vipBGift.data_Gift = arr;
         str = "";
         Model_vipBGift.data_GiftNum = arr1;
         Model_vipBGift.curDate = date;
         if(View_vipBGift.getInstance().isReady)
         {
            View_vipBGift.getInstance().setData();
         }
         else
         {
            flag = int(setTimeout(function():void
            {
               View_vipBGift.getInstance().setData();
               clearTimeout(flag);
            },1000));
         }
      }
      
      public static function GC_VIPBG_GETGIFT() : void
      {
         if(View_vipBGift.getInstance().visible)
         {
            View_vipBGift.getInstance().toolFly(1);
         }
         VipBGiftCGMessage.CG_VIPBG_OPENWIN();
      }
      
      public static function GC_VIPBG_BUYGIFT() : void
      {
         if(View_vipBGift.getInstance().visible)
         {
            View_vipBGift.getInstance().toolFly(0);
         }
         VipBGiftCGMessage.CG_VIPBG_OPENWIN();
      }
      
      public static function GC_VIPBG_ADDICON(state:int) : void
      {
         Utils.print("102050 VIP回流协议++++++状态1为开启：",state);
         if(state == Enum_vipBGift.SHOW_ICON)
         {
            MainIcon_VBG.getInstance().init();
         }
         else
         {
            MainIcon_VBG.getInstance().dispose();
         }
      }
   }
}

