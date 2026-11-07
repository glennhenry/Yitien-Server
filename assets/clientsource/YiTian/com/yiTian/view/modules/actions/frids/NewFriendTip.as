package com.yiTian.view.modules.actions.frids
{
   import com.yiTian.Global;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.net.message.cg.FruitShopCGMessage;
   import com.yiTian.net.message.cg.InviteFriendNewCGMessage;
   import com.yiTian.view.modules.actions.xsHaoli.LinkManager;
   import com.yiTian.view.modules.mainUIBtnContainer.Enum_mainUIBtn_hide;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import com.yiTian.view.modules.wuXing.WuXingMter;
   import flash.utils.setTimeout;
   
   public class NewFriendTip
   {
      
      private static var ef:Effect;
      
      public static var btn:MainUIBtn = new MainUIBtn("resource/image/inviteFriends/Icon_YQHY.png");
      
      public static const DailyReset:String = "NewFriendTip_DailyReset";
      
      private static const startDate:Number = new Date(2013,11,27,0,0,0,0).time;
      
      private static const endDate:Number = new Date(2013,11,31,0,0,0,0).time;
      
      public function NewFriendTip()
      {
         super();
      }
      
      public static function showTip() : void
      {
         LinkManager.jump(function():void
         {
            WuXingMter.getPan(NewFriends,function(pan:NewFriends):void
            {
               pan.visible = true;
               InviteFriendNewCGMessage.CG_OPEN_NEWFRIEND_PAN();
            });
         },btn,false,LinkManager.RIGHT);
         Global.control.registerCallBack(Enum_mainUIBtn_hide.NOW_TIME,gettedNowDate);
         getNowDate();
      }
      
      private static function getNowDate() : void
      {
         FruitShopCGMessage.CG_FRUIT_SHOP_SER_TIME();
      }
      
      private static function gettedNowDate(second:int) : void
      {
         var now:Number = second * 1000;
         if(now >= startDate && now < endDate)
         {
            effectBegin();
            Global.control.registerCallBack(NewFriendTip.DailyReset,getNowDate);
            setTimeout(function():void
            {
               effectEnd();
            },60000);
         }
         else
         {
            Global.control.removeCallBack(Enum_mainUIBtn_hide.NOW_TIME,gettedNowDate);
            Global.control.removeCallBack(NewFriendTip.DailyReset,getNowDate);
            effectEnd();
         }
      }
      
      private static function effectBegin() : void
      {
         if(!ef)
         {
            ef = EffectManager.addEffect("35343",btn,1000,32,29,true);
         }
      }
      
      private static function effectEnd() : void
      {
         if(Boolean(ef))
         {
            EffectManager.removeEffect(ef);
            ef = null;
         }
      }
   }
}

