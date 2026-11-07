package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_KuaFuPaiDui;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.KuaFuPaiDuiCGMessage;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.KuaFuPaiDui.Control_KuaFuPaiDui;
   import com.yiTian.view.modules.KuaFuPaiDui.Enum_KuaFuPaiDui;
   import com.yiTian.view.modules.KuaFuPaiDui.View_KuaFuPaiDui_icon;
   import com.yiTian.view.modules.KuaFuPaiDui.View_KuaFuPaiDui_serverChoiceMenu;
   import com.yiTian.view.modules.activity.Model_actDaily;
   import com.yiTian.view.modules.crossClanBattle.Model_CrossClanBattle;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   
   public class KuaFuPaiDuiHandle
   {
      
      public function KuaFuPaiDuiHandle()
      {
         super();
      }
      
      public static function GC_KuaFuPaiDui_icon(flag:int) : void
      {
         if(Boolean(flag))
         {
            UIManager.smallMap.addTip(0);
            Model_actDaily.getInstance().updateAct(11,true);
            Control_KuaFuPaiDui.getInstance();
            UIManager.mainUiBtnContainer.addBTN(View_KuaFuPaiDui_icon.instance);
            View_KuaFuPaiDui_icon.instance.effectBegin();
         }
         else
         {
            Model_actDaily.getInstance().updateAct(11,false);
            UIManager.mainUiBtnContainer.removeBTN(View_KuaFuPaiDui_icon.instance);
            View_KuaFuPaiDui_icon.instance.effectEnd();
         }
      }
      
      public static function GC_KuaFuPaiDui_SERVER_CHOICE(flag:int) : void
      {
         switch(flag)
         {
            case 1:
               KuaFuPaiDuiCGMessage.CG_KuaFuPaiDui_ENTER();
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("不在活动时间");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("服务器爆满");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("您进入房间太频繁了,请稍等1分钟");
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("服务器未开启");
               break;
            case 6:
               UIManager.centerBroadcast.addMsg("服务器真忙哦，请稍后再试！");
               View_KuaFuPaiDui_serverChoiceMenu.instance.delayJoin();
         }
      }
      
      public static function GC_KuaFuPaiDui_ENTER_EXIT(flag:int, id:int, serverId:int) : void
      {
         if(flag == 1)
         {
            Model_KuaFuPaiDui.myRoomId = id;
            Model_KuaFuPaiDui.myServerId = serverId;
            Global.control.sendNotification(Enum_KuaFuPaiDui.ENTER,null);
         }
         else
         {
            Model_CrossClanBattle.port = 0;
            SocketManager.setChangeSocketFun(false);
            SocketManager.setKuafuSocketFun(false);
            KuaFuPaiDuiCGMessage.CG_KuaFuPaiDui_CHANGE_SOCKET();
            Model_KuaFuPaiDui.inTeam = false;
            Global.control.sendNotification(Enum_KuaFuPaiDui.SCORE_LIST,[]);
            Global.control.sendNotification(Enum_KuaFuPaiDui.SET_MY_RANK,[]);
            Global.control.sendNotification(Enum_KuaFuPaiDui.EXIT,null);
         }
      }
      
      public static function GC_KuaFuPaiDui_COUNT_DOWN(flag:int, time:int) : void
      {
         Global.control.sendNotification(Enum_KuaFuPaiDui.COUNT_DOWN,[flag,time]);
      }
      
      public static function GC_KuaFuPaiDui_ROUND_START(round:int) : void
      {
         Model_KuaFuPaiDui.roundTime = round;
         Global.control.sendNotification(Enum_KuaFuPaiDui.ROUND_START,null);
      }
      
      public static function GC_KuaFuPaiDui_REST() : void
      {
         Global.control.sendNotification(Enum_KuaFuPaiDui.REST,null);
      }
      
      public static function GC_KuaFuPaiDui_SCORE_LIST(arr:Array) : void
      {
         Global.control.sendNotification(Enum_KuaFuPaiDui.SCORE_LIST,arr);
      }
      
      public static function GC_KuaFuPaiDui_SCORE_ADD(score:int, totalScore:int) : void
      {
         Model_KuaFuPaiDui.totalScore = totalScore;
         Global.control.sendNotification(Enum_KuaFuPaiDui.SCORE_ADD,score);
      }
      
      public static function GC_KuaFuPaiDui_CHANGE_ROOM(flag:int, roomId:int, serverId:int) : void
      {
         switch(flag)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("更换房间成功");
               Model_KuaFuPaiDui.myRoomId = roomId;
               Model_KuaFuPaiDui.myServerId = serverId;
               Global.control.sendNotification(Enum_KuaFuPaiDui.SCORE_LIST,[]);
               Global.control.sendNotification(Enum_KuaFuPaiDui.SET_MY_RANK,[]);
               Global.control.sendNotification(Enum_KuaFuPaiDui.CHANGE_ROOM,null);
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("更换房间冷却中");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("房间人数已满");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("已经在此房间内");
         }
      }
      
      public static function GC_KuaFuPaiDui_FRESH_ROOM(arr:Array) : void
      {
         Model_KuaFuPaiDui.roomList = arr;
         Global.control.sendNotification(Enum_KuaFuPaiDui.FRESH_ROOM,null);
      }
      
      public static function GC_KuaFuPaiDui_FRESH_PARTNER(arr:Array) : void
      {
         Model_KuaFuPaiDui.partnerList = arr;
         Global.control.sendNotification(Enum_KuaFuPaiDui.FRESH_PARTNER,null);
      }
      
      public static function GC_KuaFuPaiDui_BE_INVITED(playerId:Number, zoneId:int, name:String) : void
      {
         var obj:Object = null;
         var time:int = 0;
         var i:uint = 0;
         obj = {};
         time = 5;
         View_Alert.show("<font color=\'#00ff00\'>" + Model_heFu.repNameUseSerID(name + ".S" + zoneId) + "</font>" + "邀请你一起狂欢，愿意和他/她一起狂欢吗？<br/>" + "剩余<font color=\'#00ff00\'>" + time + "</font>秒",2,function():void
         {
            KuaFuPaiDuiCGMessage.CG_KuaFuPaiDui_REPLY_INVITE(playerId,1,zoneId);
         },function():void
         {
            KuaFuPaiDuiCGMessage.CG_KuaFuPaiDui_REPLY_INVITE(playerId,2,zoneId);
         },obj,null,310,null,null,"center",false,1);
         i = setInterval(function():void
         {
            --time;
            if(View_Alert.instance.data != obj)
            {
               clearInterval(i);
               return;
            }
            if(time > 0)
            {
               View_Alert.text = "<font color=\'#00ff00\'>" + Model_heFu.repNameUseSerID(name + ".S" + zoneId) + "</font>" + "邀请你一起狂欢，愿意和他/她一起狂欢吗？<br/>" + "剩余<font color=\'#00ff00\'>" + time + "</font>秒";
            }
            else
            {
               View_Alert.instance.hide();
               clearInterval(i);
            }
         },1000);
      }
      
      public static function GC_KuaFuPaiDui_INVITE_RESULT1(flag:int, playerId:Number, name:String, zoneId:int) : void
      {
         switch(flag)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("发送邀请成功");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("邀请成功");
               Model_KuaFuPaiDui.lastPartner = [playerId,zoneId];
               Model_KuaFuPaiDui.inTeam = true;
               Global.control.sendNotification(Enum_KuaFuPaiDui.INVITE_SUCCEED,1);
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("已经发送过邀请了");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("邀请被拒绝");
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("对方在匹配中");
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("舞伴不在房间内");
         }
      }
      
      public static function GC_KuaFuPaiDui_INVITE_RESULT2(flag:int, playerId:Number, name:String, zoneId:int) : void
      {
         switch(flag)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("接受邀请成功");
               Model_KuaFuPaiDui.lastPartner = [playerId,zoneId];
               Model_KuaFuPaiDui.inTeam = true;
               Global.control.sendNotification(Enum_KuaFuPaiDui.INVITE_SUCCEED,2);
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("接受邀请失败");
         }
      }
      
      public static function GC_KuaFuPaiDui_BREAK_UP(flag:int, tips:int) : void
      {
         var str:String = null;
         switch(flag)
         {
            case 1:
               Model_KuaFuPaiDui.inTeam = false;
               str = "解散成功";
               if(tips == 2)
               {
                  str = "对方与你解除舞伴关系";
               }
               UIManager.centerBroadcast.addMsg(str);
               Global.control.sendNotification(Enum_KuaFuPaiDui.BREAK_UP,null);
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("解散失败");
         }
      }
      
      public static function GC_KuaFuPaiDui_GET_EXP(exp:int) : void
      {
         View_Alert.show("<font color=\'#ffffff\'>恭喜你在跨服派对中共计获得了<font color=\'#9900ff\'>" + exp + "经验值</font>。</font>",1,null,null,null,null,310,"","","center");
      }
      
      public static function GC_KuaFuPaiDui_MY_RANK(arr:Array) : void
      {
         Global.control.sendNotification(Enum_KuaFuPaiDui.SET_MY_RANK,arr);
      }
   }
}

