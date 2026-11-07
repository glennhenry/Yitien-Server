package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.BattleManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.qingMing.Model_QingMing;
   import com.yiTian.view.modules.qingMing.View_zhuaGuiPanel;
   
   public class QingmingHandler
   {
      
      public function QingmingHandler()
      {
         super();
      }
      
      public static function GC_SHOW_ZHUAGUI_ICON(str:String) : void
      {
         Model_QingMing.tipStr = str + "，在应天府<font color=\'#ff7700\'>百鬼道人</font>处可领取<font color=\'#ff7700\'>10次抓鬼任务</font>";
      }
      
      public static function GC_QINGMING_QUALITY(currentQuality:int, count:int) : void
      {
         var zhuaGuiPnl:View_zhuaGuiPanel = Singleton.getInstance(View_zhuaGuiPanel);
         Global.delegate.dosomething(zhuaGuiPnl,zhuaGuiPnl.show);
         Model_QingMing.qualityUpdate = currentQuality;
         Model_QingMing.remainUpdate = count;
      }
      
      public static function GC_QINGMING_TASK_COUNT(count:int) : void
      {
         if(!Global.control.hasCallBack(Enum_MsgType.MSG_ASK_CHANGE_SCENE_OK,View_zhuaGuiPanel.instance.onEnterSceneOk))
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_ASK_CHANGE_SCENE_OK,View_zhuaGuiPanel.instance.onEnterSceneOk);
            Model_QingMing.needFresh = true;
         }
         Model_QingMing.remainUpdate = count;
         UIManager.questTraceView.update();
      }
      
      public static function GC_QINGMING_TASK_RESULT(result:int) : void
      {
         switch(result)
         {
            case 2:
               UIManager.centerBroadcast.addMsg("队伍有40级以下玩家");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("队伍有玩家抓鬼剩余次数为0");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("队伍有人暂离或离线，不能接受任务");
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("队伍已有人接了抓鬼任务");
               break;
            case 6:
               UIManager.centerBroadcast.addMsg("不在活动时间内");
               break;
            case 7:
               UIManager.centerBroadcast.addMsg("你处于暂离状态，不能接任务");
         }
      }
      
      public static function GC_QINGMING_TASK_DATA(id:int, monsterId:int, sceneId:int, x:int, y:int) : void
      {
         View_zhuaGuiPanel.instance.updateTargetMap(id,monsterId,sceneId,x,y);
      }
      
      public static function GC_QINGMING_CATCHGHOSE_RESULT(result:int) : void
      {
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("ok");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("队伍有非任务队员不能抓捕");
         }
      }
      
      public static function GC_QINGMING_TASK_FAIL() : void
      {
         var s:Function = null;
         if(BattleManager.isPlaying)
         {
            s = function():void
            {
               View_Alert.show("抓鬼任务的目标厉鬼已被消灭，任务失败",View_Alert.OK);
               Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_END,s);
            };
            Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_END,s);
         }
         else
         {
            View_Alert.show("抓鬼任务的目标厉鬼已被消灭，任务失败",View_Alert.OK);
         }
         View_zhuaGuiPanel.instance.removeGui();
         Model_QingMing.data = [];
      }
      
      public static function GC_QINGMING_CATCHGHOSE_OK(battleId:int, result:int, count:int) : void
      {
         Model_QingMing.battleId = battleId;
         Model_QingMing.battleResult = result;
         Model_QingMing.rewardCount = count;
         Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_END,Model_QingMing.onCatchGhostResult);
      }
      
      public static function GC_QINGMING_REFRESH_TIP(result:int) : void
      {
         Model_QingMing.qualityUpdate = result;
         if(result > 1)
         {
            UIManager.centerBroadcast.addMsg("刷新至" + Model_QingMing.ghostNameArr[result]);
         }
      }
   }
}

