package com.yiTian.net.handler
{
   import com.yiTian.data.model.Model_GoldCJ;
   import com.yiTian.manager.UIManager;
   
   public class GoldCJHandler
   {
      
      public function GoldCJHandler()
      {
         super();
      }
      
      public static function GC_GLOD_CJ_LOG(num:int, list:Array) : void
      {
         if(UIManager.goldCJ.visible)
         {
            UIManager.goldCJ.updateInfo(num,list);
         }
      }
      
      public static function GC_GLOD_CJ_START_LOTTERY(num:int, rewardList:Array) : void
      {
         Model_GoldCJ.isRunning = true;
         if(num == Model_GoldCJ.LOTTERY_TYPE_1)
         {
            UIManager.goldCJ.wheel.forTimes = 3;
            UIManager.goldCJ.wheel.start(rewardList[0].index);
         }
         else if(num == Model_GoldCJ.LOTTERY_TYPE_2)
         {
            UIManager.goldCJ.grids.stepByStepHandler(0);
            UIManager.goldCJ.wheel.forTimes = 1;
            UIManager.goldCJ.wheel.start(rewardList[rewardList.length - 1].index);
         }
         else if(num == Model_GoldCJ.LOTTERY_TYPE_3)
         {
            UIManager.goldCJ.grids.stepByStepHandler(0);
            UIManager.goldCJ.wheel.forTimes = 7;
            UIManager.goldCJ.wheel.start(rewardList[rewardList.length - 1].index);
         }
         Model_GoldCJ.totalCJTimes += num;
         if(UIManager.goldCJ.visible)
         {
            UIManager.goldCJ.updateTimes(Model_GoldCJ.totalCJTimes);
            UIManager.goldCJ.setBtnEnable();
         }
      }
      
      public static function GC_GLOD_CJ_LOCK_GRID(state:int, index:int) : void
      {
         var a:Array = null;
         var i:int = 0;
         var str:String = "";
         if(state == Model_GoldCJ.STATE_LOCK)
         {
            str = Model_GoldCJ.lockStr == "" ? "" + index : "_" + index;
            Model_GoldCJ.lockStr += str;
         }
         else
         {
            a = Model_GoldCJ.lockStr.split("_");
            i = 0;
            while(i < a.length)
            {
               if(a[i] == index)
               {
                  a.splice(i,1);
               }
               i++;
            }
            str = a.join("_");
            Model_GoldCJ.lockStr = "";
            Model_GoldCJ.lockStr = str;
         }
         if(UIManager.goldCJ.visible)
         {
            UIManager.goldCJ.grids.updateLock(state,index);
            UIManager.goldCJ.updateLockState();
            UIManager.goldCJ.setBtnEnable();
         }
      }
      
      public static function GC_GLOD_CJ_SHOW_BTN(isShow:int) : void
      {
         UIManager.goldCJ.removeGoldCJMainBtn();
      }
      
      public static function GC_GLOD_CJ_TOTAL_LTRS(times:int, dateStr:String, lockIdxS:String) : void
      {
         Model_GoldCJ.totalCJTimes = times;
         Model_GoldCJ.dateStr = dateStr;
         Model_GoldCJ.lockStr = "";
         Model_GoldCJ.lockStr = lockIdxS;
         if(UIManager.goldCJ.visible)
         {
            UIManager.goldCJ.updateDate(dateStr);
            UIManager.goldCJ.updateTimes(times);
            UIManager.goldCJ.updateLockState();
         }
      }
   }
}

