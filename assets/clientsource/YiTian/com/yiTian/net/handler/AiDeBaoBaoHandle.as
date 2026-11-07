package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_AiDeBaoBao;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.gameUnit.GameUnit;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.AiDeBaoBaoCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.AiDeBaoBao.AiDeBaoBao_control;
   import com.yiTian.view.modules.AiDeBaoBao.AiDeBaoBao_guide;
   import com.yiTian.view.modules.AiDeBaoBao.View_AiDeBaoBao_PaiHang;
   import com.yiTian.view.modules.AiDeBaoBao.View_AiDeBaoBao_changeRoom;
   import com.yiTian.view.modules.AiDeBaoBao.View_AiDeBaoBao_findPartner;
   import com.yiTian.view.modules.AiDeBaoBao.View_AiDeBaoBao_icon;
   import com.yiTian.view.modules.AiDeBaoBao.View_AiDeBaoBao_partnerMenu;
   import com.yiTian.view.modules.AiDeBaoBao.View_AiDeBaoBao_secondHalfOKMenu;
   import com.yiTian.view.modules.AiDeBaoBao.View_AiDeBaoBao_serverMenu;
   import com.yiTian.view.modules.AiDeBaoBao.View_AiDeBaoBao_serverTips;
   import com.yiTian.view.modules.AiDeBaoBao.View_AiDeBaoBao_skillBar;
   import com.yiTian.view.modules.activity.Model_actDaily;
   import com.yiTian.view.modules.crossClanBattle.Model_CrossClanBattle;
   import flash.text.TextFormatAlign;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   
   public class AiDeBaoBaoHandle
   {
      
      public function AiDeBaoBaoHandle()
      {
         super();
      }
      
      public static function IconSwitch(flag:int = 1) : void
      {
         var startArr:Array = null;
         var i:int = 0;
         var midArr2:Array = null;
         var j:int = 0;
         var midArr1:Array = null;
         var k:int = 0;
         var endArr:Array = null;
         var l:int = 0;
         if(flag == 1)
         {
            if(GameUnitManager.hero.level < 35)
            {
               Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP_2,IconSwitch);
            }
            else
            {
               Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP_2,IconSwitch);
               UIManager.mainUiBtnContainer.addBTN(View_AiDeBaoBao_icon.instance);
               View_AiDeBaoBao_icon.instance.effectBegin();
               AiDeBaoBao_control.creatShowAndHide(true);
            }
            startArr = Data_lib.AiDeBaoBao_position[1][1].split("_");
            AiDeBaoBao_control.startPointArray = [];
            i = 0;
            while(i < startArr.length)
            {
               AiDeBaoBao_control.startPointArray.push([int(startArr[i]),int(startArr[i + 1])]);
               i += 2;
            }
            midArr2 = Data_lib.AiDeBaoBao_position[2][1].split("_");
            AiDeBaoBao_control.middlePointArray2 = [];
            j = 0;
            while(j < midArr2.length)
            {
               AiDeBaoBao_control.middlePointArray2.push([int(midArr2[j]),int(midArr2[j + 1])]);
               j += 2;
            }
            midArr1 = Data_lib.AiDeBaoBao_position[3][1].split("_");
            AiDeBaoBao_control.middlePointArray = [];
            k = 0;
            while(k < midArr1.length)
            {
               AiDeBaoBao_control.middlePointArray.push([int(midArr1[k]),int(midArr1[k + 1])]);
               k += 2;
            }
            endArr = Data_lib.AiDeBaoBao_position[4][1].split("_");
            AiDeBaoBao_control.endPointArray = [];
            l = 0;
            while(l < endArr.length)
            {
               AiDeBaoBao_control.endPointArray.push([int(endArr[l]),int(endArr[l + 1])]);
               l += 2;
            }
            Model_actDaily.getInstance().updateAct(9,true);
            UIManager.smallMap.addTip(0);
         }
         else if(flag == 2)
         {
            UIManager.mainUiBtnContainer.removeBTN(View_AiDeBaoBao_icon.instance);
            View_AiDeBaoBao_icon.instance.effectEnd();
            AiDeBaoBao_control.creatShowAndHide(false);
            UIManager.smallMap.removeTip(0);
            Model_actDaily.getInstance().updateAct(9,false);
         }
      }
      
      public static function GC_AiDeBaoBao_SERVER_CHOICE(flag:int) : void
      {
         switch(flag)
         {
            case 1:
               AiDeBaoBaoCGMessage.CG_AiDeBaoBao_JOIN();
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("不在活动时间内");
               break;
            case 3:
               View_AiDeBaoBao_serverTips.instance.show();
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("服务器真忙哦，请稍后再试！");
               View_AiDeBaoBao_serverMenu.instance.delayJoin();
         }
      }
      
      public static function JoinResult(result:int, roomId:int) : void
      {
         switch(result)
         {
            case 1:
               AiDeBaoBao_control.Enter(roomId);
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("已经在活动里面");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("间隔不足30秒，请稍后再进");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("活动还没开放");
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("等级不足");
               break;
            case 6:
               UIManager.centerBroadcast.addMsg("组队不能进入此场景");
               break;
            case 7:
               UIManager.centerBroadcast.addMsg("在副本中不能进入此场景");
         }
      }
      
      public static function ExitResult(result:int) : void
      {
         switch(result)
         {
            case 1:
               Model_CrossClanBattle.port = 0;
               SocketManager.setChangeSocketFun(false);
               SocketManager.setKuafuSocketFun(false);
               AiDeBaoBaoCGMessage.CG_AiDeBaoBao_SOCKET();
               AiDeBaoBao_control.Exit();
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("不在活动时间内");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("匹配状态不能退出");
         }
      }
      
      public static function TimeCountDown(time:int) : void
      {
         if(Boolean(Global.ADBB_Imgsdm))
         {
            View_AiDeBaoBao_findPartner.instance.UpdateTime(time);
         }
      }
      
      public static function FreshList(arr:Array) : void
      {
         View_AiDeBaoBao_partnerMenu.instance.FreshPartnerList(arr);
      }
      
      public static function Request(num:Number, zoneId:int) : void
      {
         var name:String = null;
         var time:int = 0;
         var obj:Object = null;
         var i:uint = 0;
         var unit:GameUnit = GameUnitManager.findUnit(num,UnitType.PLAYER);
         if(!unit)
         {
            AiDeBaoBaoCGMessage.CG_AiDeBaoBao_REQUEST(2,num,zoneId);
            return;
         }
         name = unit.name;
         time = 5;
         obj = {};
         View_Alert.show("<font color=\'#0099ff\'>" + Model_heFu.repNameUseSerID(name) + "</font><font color=\'#ffffff\'>想要和你组成搭档</font><br/>" + "</font><font color=\'#ffffff\'>剩余</font><font color=\'#00ff00\'>" + time + "</font><font color=\'#ffffff\'>秒</font>",2,function():void
         {
            AiDeBaoBaoCGMessage.CG_AiDeBaoBao_REQUEST(1,num,zoneId);
         },function():void
         {
            AiDeBaoBaoCGMessage.CG_AiDeBaoBao_REQUEST(2,num,zoneId);
         },obj,null,310,"同意","拒绝",TextFormatAlign.CENTER);
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
               View_Alert.text = "<font color=\'#0099ff\'>" + Model_heFu.repNameUseSerID(name) + "</font><font color=\'#ffffff\'>想要和你组成搭档</font><br/>" + "</font><font color=\'#ffffff\'>剩余</font><font color=\'#00ff00\'>" + time + "</font><font color=\'#ffffff\'>秒</font>";
            }
            else
            {
               View_Alert.instance.hide();
               AiDeBaoBaoCGMessage.CG_AiDeBaoBao_REQUEST(2,num,zoneId);
               clearInterval(i);
            }
         },1000);
      }
      
      public static function RequestResult(flag:int, id:Number, zoneId:int) : void
      {
         Utils.print("结果>id>",flag,id,zoneId);
         switch(flag)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("匹配成功");
               View_AiDeBaoBao_partnerMenu.instance.visible = false;
               View_AiDeBaoBao_findPartner.instance.partner = id;
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("邀请被拒绝");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("不在活动期间");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("只能与一个玩家拥抱");
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("该玩家已与其他玩家拥抱");
               Global.control.sendNotification(Enum_AiDeBaoBao.CLICK_YongBao_CD_COMPLETE,null);
               break;
            case 6:
               UIManager.centerBroadcast.addMsg("该玩家正在匹配中");
               Global.control.sendNotification(Enum_AiDeBaoBao.CLICK_YongBao_CD_COMPLETE,null);
               break;
            case 7:
               View_Alert.show("<font color=\'#ffffff\'>与此玩家搭档将不会获得爱心奖励！</font><br/>" + "<font color=\'#ff0000\'>(此玩家已完成过一次比赛。)</font><br/>" + "<font color=\'#ffffff\'>是否继续与此玩家搭档？</font>",2,function():void
               {
                  AiDeBaoBaoCGMessage.CG_AiDeBaoBao_REQUEST_2(id,zoneId);
               },null,null,null,310,"同意","拒绝",TextFormatAlign.CENTER);
               break;
            case 8:
               UIManager.centerBroadcast.addMsg("该玩家已下线");
               Global.control.sendNotification(Enum_AiDeBaoBao.CLICK_YongBao_CD_COMPLETE,null);
         }
      }
      
      public static function RelieveResult(flag:int) : void
      {
         if(flag == 1)
         {
            UIManager.centerBroadcast.addMsg("解除匹配成功");
            View_AiDeBaoBao_findPartner.instance.partner = 0;
         }
      }
      
      public static function RoomMenuResult(arr:Array) : void
      {
         View_AiDeBaoBao_changeRoom.instance.Update(arr);
      }
      
      public static function ChangeRoomResult(flag:int, roomId:int) : void
      {
         switch(flag)
         {
            case 1:
               AiDeBaoBao_control.roomId = roomId;
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("非活动时间");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("已经在此房间");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("请先解除拥抱");
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("此房间已满人");
               break;
            case 6:
               UIManager.centerBroadcast.addMsg("未知错误，请尝试切换其他房间");
         }
      }
      
      public static function SecondHalf() : void
      {
         Global.control.sendNotification(Enum_AiDeBaoBao.RESET_MAP_END,false);
         Global.control.sendNotification(Enum_AiDeBaoBao.RESET_MAP_MIDDLE,false);
         Global.control.sendNotification(Enum_AiDeBaoBao.RESET_MAP_MIDDLE_2,true);
         View_AiDeBaoBao_secondHalfOKMenu.instance.visible = true;
         AiDeBaoBao_control.AddEndPoint();
         if(GameUnitManager.hero.status == Status.AiDeBaoBao_Bao)
         {
            Global.control.sendNotification(Enum_AiDeBaoBao.GUIDE_ARROW_POINT_TO_SKILL,1);
         }
      }
      
      public static function Arrive_end(costTime:int, rank:int) : void
      {
         AiDeBaoBao_control.checkTimer.reset();
         AiDeBaoBao_control.Arrive_end(costTime,rank);
      }
      
      public static function PaiHang(arr:Array) : void
      {
         View_AiDeBaoBao_PaiHang.instance.setRank(arr);
      }
      
      public static function SkillResult(skillId:int, flag:int, times:int) : void
      {
         switch(flag)
         {
            case 1:
               View_AiDeBaoBao_skillBar.instance.setSkillCD(skillId);
               View_AiDeBaoBao_skillBar.instance.setSkillTimes(skillId,times);
               UIManager.centerBroadcast.addMsg("下次使用该技能需花费<font color=\'#ffff00\'>20元宝</font>",1);
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("冷却时间未结束");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("眩晕状态不能使用技能");
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("元宝不足");
               break;
            case 6:
               UIManager.centerBroadcast.addMsg("目标免疫了你的技能");
               View_AiDeBaoBao_skillBar.instance.setSkillCD(skillId);
               View_AiDeBaoBao_skillBar.instance.setSkillTimes(skillId,times);
               UIManager.centerBroadcast.addMsg("下次使用该技能需花费<font color=\'#ffff00\'>20元宝</font>",1);
               break;
            case 7:
               UIManager.centerBroadcast.addMsg("不能对自己使用技能");
               break;
            case 8:
               UIManager.centerBroadcast.addMsg("不能对他人使用技能");
               break;
            case 9:
               UIManager.centerBroadcast.addMsg("此技能要拥抱者才能使用");
               break;
            case 10:
               UIManager.centerBroadcast.addMsg("此技能要被拥抱者才能使用");
               break;
            case 11:
               UIManager.centerBroadcast.addMsg("不能对准备状态的目标施放技能");
         }
      }
      
      public static function SkillBuffTime(skillId:int) : void
      {
         AiDeBaoBao_control.SkillBuffStart(skillId);
      }
      
      public static function Guide(flag:int) : void
      {
         if(flag == 1)
         {
            AiDeBaoBao_guide.instance;
         }
      }
      
      public static function startEndCheckPosition(flag:int) : void
      {
         if(flag == 1)
         {
            AiDeBaoBao_control.checkTimer.start();
         }
         else if(flag == 2)
         {
            AiDeBaoBao_control.checkTimer.reset();
         }
      }
   }
}

