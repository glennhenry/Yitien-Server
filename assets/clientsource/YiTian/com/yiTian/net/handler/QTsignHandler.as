package com.yiTian.net.handler
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.QT.Model_qtSign;
   import com.yiTian.view.modules.QT.View_qtPanel;
   import com.yiTian.view.modules.sign.SignUtil;
   
   public class QTsignHandler
   {
      
      public function QTsignHandler()
      {
         super();
      }
      
      public static function GC_QTSign_OPEN(recordDays:String, count:int, reward:String, nowTime:int) : void
      {
         var data:Array = null;
         var str:String = null;
         var daysArr:Array = null;
         var index:int = 0;
         var len:int = 0;
         var j:int = 0;
         SignUtil.removeSingleTips();
         var date:Date = new Date(nowTime * 1000);
         var dayArr:Array = recordDays.split("|");
         Model_qtSign.signStatusData = [];
         Model_qtSign.signRewardStatusData = [];
         var i:int = 0;
         while(i < dayArr.length)
         {
            daysArr = dayArr[i].toString().split("#");
            data = daysArr[2].toString().split(",");
            daysArr[1] = daysArr[1] < 10 ? "0" + daysArr[1] : daysArr[1];
            index = 0;
            len = int(data.length);
            j = 1;
            while(j < 32)
            {
               str = "" + daysArr[0] + daysArr[1] + (j < 10 ? "0" + j : j);
               if(index < len && j == data[index])
               {
                  Model_qtSign.signStatusData[str] = "1";
                  index++;
               }
               else
               {
                  Model_qtSign.signStatusData[str] = "0";
               }
               Model_qtSign.yearAndMontyData[str] = "" + daysArr[0] + daysArr[1];
               j++;
            }
            i++;
         }
         var rewardStatusArr:Array = reward.split(",");
         Model_qtSign.signRewardStatusData = rewardStatusArr;
         View_qtPanel.instance.update(count,date);
      }
      
      public static function GC_QTSign_SIGN(result:int) : void
      {
         if(result == 0)
         {
            UIManager.centerBroadcast.addMsg("签到成功");
            View_qtPanel.instance.signed();
         }
         else if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("您登陆QT语音在线未满5分钟，不可签到");
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg("您当天已经签到完，不可重复签到");
         }
      }
      
      public static function GC_QTSign_AWARD(result:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("领取成功");
            View_qtPanel.instance.getSignedAward();
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg("已经领取过该礼包，不能再重复领取");
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg("背包格子已满，请清理");
         }
      }
   }
}

