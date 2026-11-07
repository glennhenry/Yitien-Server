package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.sign.Model_Sign;
   import com.yiTian.view.modules.sign.SignUtil;
   import com.yiTian.view.modules.sign.View_SignPanel;
   
   public class SignHandler
   {
      
      public function SignHandler()
      {
         super();
      }
      
      public static function GC_SIGN_INFO(holidayStatus:int, nextHolidayDay:int, holidayName:String, kaifuDay:int, onlineHour:String, nowWeekWage:int, lastWeekWage:int, wageStatus:int, days:String, count:int, effType:int, rewardStatuss:String, nowTime:int, sysDate:int) : void
      {
         var dayArr:Array;
         var i:int;
         var rewardStatusArr:Array;
         var arr:Array = null;
         var data:Array = null;
         var str:String = null;
         var date:Date = null;
         var hasReward:Boolean = false;
         var j:int = 0;
         SignUtil.removeSingleTips();
         dayArr = days.split("#");
         Model_Sign.signStatusData = [];
         i = 0;
         while(i < dayArr.length)
         {
            data = dayArr[i].toString().split(",");
            j = 1;
            while(j < data.length)
            {
               str = "" + data[0] + (j < 10 ? "0" + j : j);
               Model_Sign.signStatusData[str] = data[j];
               Model_Sign.yearAndMontyData[str] = data[0];
               j++;
            }
            i++;
         }
         Model_Sign.holidayStatus = holidayStatus;
         Model_Sign.nextHolidayDay = nextHolidayDay;
         Model_Sign.holidayName = holidayName;
         Model_Sign.sysDate = sysDate;
         Model_Sign.rewardEffType = effType;
         rewardStatusArr = rewardStatuss.split(",");
         Model_Sign.signRewardStatusData = rewardStatusArr;
         date = new Date(nowTime * 1000);
         Global.delegate.dosomething(View_SignPanel.instance,function():void
         {
            View_SignPanel.instance.update(count,kaifuDay,nowWeekWage,lastWeekWage,onlineHour,wageStatus,date);
         });
         i = 0;
         while(i < rewardStatusArr.length)
         {
            if(rewardStatusArr[i] == 1)
            {
               hasReward = true;
               break;
            }
            hasReward = false;
            i++;
         }
      }
      
      public static function GC_HOLIDAY_REWARD(result:int) : void
      {
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("领取成功");
               View_SignPanel.instance.flyHolidayIcon();
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("你已经领取过该奖励");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("背包空间不足");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("未达到对应累计签到次数");
         }
      }
      
      public static function GC_SIGN(result:int) : void
      {
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("签到成功");
               UIManager.smallMap.removeTip(4);
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("礼券补签成功");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("元宝补签成功");
               break;
            case 4:
               if(int(Model_Sign.signRewardStatusData[4]) == 1)
               {
                  UIManager.centerBroadcast.addMsg("请领取礼包后再进行操作！");
                  break;
               }
               UIManager.centerBroadcast.addMsg("请刷新页面后再进行操作！");
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("元宝不足");
         }
      }
      
      public static function GC_REWARD(result:int) : void
      {
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("领取成功");
               View_SignPanel.instance.flyRewardIcon(Model_Sign.rewardIconIndex);
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("你已经领取过该奖励");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("背包空间不足");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("未达到对应累计签到次数");
         }
      }
      
      public static function GC_WEEK_WAGE(result:int) : void
      {
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("领取成功");
         }
      }
      
      public static function GC_SIGN_HIGHTLIGHT(result:int) : void
      {
         switch(result)
         {
            case 0:
               UIManager.smallMap.addTip(4);
               break;
            case 1:
               UIManager.smallMap.removeTip(4);
         }
      }
   }
}

