package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.ModelManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.panel.Model_target;
   
   public class Little_system_Handler
   {
      
      public function Little_system_Handler()
      {
         super();
      }
      
      public static function GC_CHIP_GIFT(result:int, id_chip:int, jieMiflag:int) : void
      {
         if(result == 1)
         {
            Model_target.taskCompleteMap[id_chip] = 1;
            Global.control.sendNotification(Model_target.TARGET_GET_CHIP_SUCCESS,id_chip);
            if(Model_target.jieMiFlag == -1 || Model_target.getChipCanGetting() != -1)
            {
               UIManager.smallMap.addTip(5);
            }
            else
            {
               UIManager.smallMap.removeTip(5);
            }
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("639",0));
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("640",0));
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("641",0));
         }
         else
         {
            Utils.print("服务器领取碎片奖励失败");
         }
         Global.control.sendNotification(Model_target.TARGET_DATA_UPDATE,null);
         Model_target.jieMiFlag = jieMiflag;
         if(jieMiflag == -1)
         {
            Global.control.sendNotification(Model_target.TARGET_POPUP_JIEMI,null);
         }
      }
      
      public static function GC_CHIP_TASK_INIT(vec_task:Vector.<int>, vec_gift:Vector.<int>) : void
      {
         var i:int = 0;
         if(vec_task.length <= 34)
         {
            Model_target.type = 1;
         }
         else
         {
            Model_target.type = 2;
         }
         i = 0;
         while(i < vec_task.length)
         {
            Model_target.taskStateMap.put(String(vec_task[i]),vec_task[i + 1]);
            i += 2;
         }
         i = 0;
         while(i < vec_gift.length)
         {
            Model_target.taskCompleteMap.put(String(i + 1),vec_gift[i]);
            i += 1;
         }
         if(Model_target.jieMiFlag == -1 || Model_target.getChipCanGetting() != -1)
         {
            UIManager.smallMap.addTip(5);
         }
         else
         {
            UIManager.smallMap.removeTip(5);
         }
         Global.control.sendNotification(Model_target.TARGET_DATA_UPDATE,null);
      }
      
      public static function GC_CHIP_TASK_UPDATE(id_task:int, state:int) : void
      {
         Model_target.taskStateMap.put(String(id_task),state);
         if(Model_target.getChipCanGetting() != -1)
         {
            UIManager.smallMap.addTip(5);
         }
         else
         {
            UIManager.smallMap.removeTip(5);
         }
         Global.control.sendNotification(Model_target.TARGET_DATA_UPDATE,null);
      }
      
      public static function GC_CHIP_TASK_TYPE() : void
      {
         Model_target.jieMiFlag = -1;
         Global.control.sendNotification(Model_target.TARGET_POPUP_JIEMI,null);
         UIManager.smallMap.addTip(5);
      }
      
      public static function GC_SERVER_TIME(time:int) : void
      {
         ModelManager.little_system.Init_serverTime(time);
         Utils.print("服务器时间初始化");
      }
   }
}

