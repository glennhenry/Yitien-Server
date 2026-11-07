package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_QiJu;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.config.Enum_npc_type;
   import com.yiTian.data.model.Model_QiJu;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.QiJuCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.battle.SiWangFuHuoPanel;
   import com.yiTian.view.modules.broadcast.View_FuBenBroadcast;
   import com.yiTian.view.modules.mainUIBtnContainer.View_mainUiBtn_container;
   import com.yiTian.view.modules.qiJu.QiJuGameMessage;
   import com.yiTian.view.modules.qiJu.TeamVo;
   import com.yiTian.view.modules.qiJu.View_JoinQiJu;
   import flash.display.Bitmap;
   import flash.events.TextEvent;
   
   public class QiJuHandler
   {
      
      public function QiJuHandler()
      {
         super();
      }
      
      public static function linkHandler(event:TextEvent) : void
      {
         var roleId:Number = Number(event.text.split("_")[1]);
         if(Boolean(roleId) && roleId != GameUnitManager.hero.id)
         {
            Global.control.sendNotification(Enum_MsgType.MSG_CHECKOTHERROLE,roleId);
         }
      }
      
      public static function disposeGame() : void
      {
         Model_QiJu.inQijuGame = false;
         QiJuGameMessage.instance.visible = false;
         UIManager.questTraceView.visible = true;
         Model_QiJu.game_type = -1;
         Model_QiJu.skip_time = 0;
      }
      
      public static function checkCreatTeam() : Boolean
      {
         if(View_JoinQiJu.instance.visible)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("80150",8));
            return false;
         }
         return true;
      }
      
      public static function joinQijuTeam(teamId:int, teamType:int) : void
      {
         var tip:String = null;
         if(UIManager.mainUiBtnContainer.curFuBenType == View_mainUiBtn_container.QIJU)
         {
            return;
         }
         if(Model_team.hasTeam())
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("80151",8));
         }
         else if(GameUnitManager.hero.level < Enum_QiJu.type_level[teamType])
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("80152",8));
         }
         else if(UIManager.mainUiBtnContainer.curFuBenType != 0 || Global.sceneID == 12304)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("80175",8));
         }
         else if(GameUnitManager.hero.paoBiao != 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("80176",8));
         }
         else if(Model_QiJu.team_id != 0)
         {
            tip = LangConfig.getWord("80153",8,Enum_QiJu.qiju_type[teamType]);
            View_Alert.show(tip,View_Alert.OK_CANCAL,function():void
            {
               QiJuCGMessage.CG_JOIN_QIJU_TEAM(teamId);
            });
         }
         else
         {
            QiJuCGMessage.CG_JOIN_QIJU_TEAM(teamId);
         }
      }
      
      public static function isQiju_Npc(npcType:int) : Boolean
      {
         return npcType == Enum_npc_type.QIJU_QIZI || npcType == Enum_npc_type.QIJU_BOSS || npcType == Enum_npc_type.QIJU_UNBOSS;
      }
      
      public static function isQiju_Boss(npcType:int) : Boolean
      {
         return npcType == Enum_npc_type.QIJU_BOSS;
      }
      
      public static function isQiju_Chest(npcType:int) : Boolean
      {
         return npcType == Enum_npc_type.QIJU_CHEST;
      }
      
      public static function addQiJuEvent(id:int) : void
      {
         var str:String = null;
         var name:String = null;
         var type:int = int(Data_lib.zlevent[id][0]);
         if(type == 2)
         {
            addEff(2);
         }
         else
         {
            str = Data_lib.zlevent[id][1];
            if(id == 2)
            {
               UIManager.siWangFuHuoPanel.show(SiWangFuHuoPanel.QIJU);
               UIManager.centerBroadcast.addMsg(str);
            }
            else if(id == 16)
            {
               name = Enum_QiJu.qiju_type[Model_QiJu.game_type];
               UIManager.centerBroadcast.addMsg(LangConfig.reTxt(str,name));
            }
            else
            {
               UIManager.centerBroadcast.addMsg(str);
            }
         }
      }
      
      public static function addEff(type:int) : void
      {
         var bitmap:Bitmap = null;
         var url:String = "resource/image/qiJu/eff_" + type + ".png";
         bitmap = new Bitmap();
         Utils.getLoadBitmap(url,bitmap,null,function():void
         {
            View_FuBenBroadcast.instance.addEff(bitmap);
         });
      }
      
      public static function addBossEff() : void
      {
         addEff(1);
         Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_END,QiJuHandler.addBossEff);
      }
      
      public static function isQiJuNpc(sysId:int, souce:Vector.<int>) : Boolean
      {
         var len:int = int(souce.length);
         var i:int = 0;
         while(i < len)
         {
            if(souce[i] <= sysId && sysId <= souce[i + 1])
            {
               return true;
            }
            i += 2;
         }
         return false;
      }
      
      public static function dispose() : void
      {
         Model_QiJu.isCaptain = false;
         Model_QiJu.myTeamVo.length = 0;
         Model_QiJu.team_captain_id = 0;
         Model_QiJu.team_id = 0;
         Model_QiJu.team_Type = -1;
         Model_QiJu.leftTime = 0;
      }
      
      public static function getListSource(type:int) : Array
      {
         var vo:TeamVo = null;
         var arr:Array = [];
         for each(vo in Model_QiJu.listVo)
         {
            if(vo.team_type == type)
            {
               arr.push(vo);
            }
         }
         return arr.sort(sortFun);
      }
      
      public static function getHeatUrl(sex:int, job:int) : String
      {
         var icon_num:int = 23000 + Enum_job.getBaseJob(job) * 100 + 30 + sex;
         return "resource/image/icon/" + icon_num.toString() + ".jpg";
      }
      
      public static function delItem(id:int) : void
      {
         var sourceVo:TeamVo = null;
         var len:int = int(Model_QiJu.listVo.length);
         var i:int = 0;
         while(i < len)
         {
            sourceVo = Model_QiJu.listVo[i];
            if(sourceVo.team_id == id)
            {
               Model_QiJu.listVo.splice(i,1);
               break;
            }
            i++;
         }
         upDataList();
      }
      
      public static function editItem(vo:TeamVo) : void
      {
         var sourceVo:TeamVo = null;
         var id:int = vo.team_id;
         var len:int = int(Model_QiJu.listVo.length);
         var i:int = 0;
         while(i < len)
         {
            sourceVo = Model_QiJu.listVo[i];
            if(sourceVo.team_id == id)
            {
               Model_QiJu.listVo[i] = vo;
               break;
            }
            i++;
         }
         upDataList();
      }
      
      public static function addItem(vo:TeamVo) : void
      {
         Model_QiJu.listVo.push(vo);
         upDataList();
      }
      
      public static function upDataList() : void
      {
         Model_QiJu.listVo.sortOn(["status","team_type"],[Array.NUMERIC,Array.NUMERIC]);
         View_JoinQiJu.instance.upTeamList();
      }
      
      private static function sortFun(vo1:TeamVo, vo2:TeamVo) : int
      {
         if(vo1.status == 1)
         {
            return -1;
         }
         if(vo2.status == 1)
         {
            return 1;
         }
         return vo1.status - vo2.status;
      }
   }
}

