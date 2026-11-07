package com.yiTian.net.message.cg
{
   import com.utils.LongUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_map_lib;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.QiJuHandler;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.guangMingDing.GuangMingDingConfig;
   import com.yiTian.view.modules.wulinduobao.BaoXiang;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TeamCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function TeamCGMessage()
      {
         super();
      }
      
      public static function CG_TEAM(currentPage:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(currentPage);
         SocketManager.send(MessageType.CG_TEAM,bytebuff);
      }
      
      public static function CG_CREATE_TEAM() : void
      {
         if(Boolean(GameUnitManager.hero.paoBiao))
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10208",1));
            return;
         }
         if(!QiJuHandler.checkCreatTeam())
         {
            return;
         }
         if(GuangMingDingConfig.cantCreateTeam())
         {
            return;
         }
         if(Data_lib.map[Global.sceneMap][Enum_map_lib.TYPE] == 3 || Data_lib.map[Global.sceneMap][Enum_map_lib.TYPE] == 5 || SceneConfig.getSceneType() == SceneConfig.HUNLI || SceneConfig.getSceneType() == 7 || SceneConfig.getSceneType() == SceneConfig.KFBZ_BATTLE || SceneConfig.getSceneType() == SceneConfig.CROSS_CAMP_BATTLE)
         {
            if(BaoXiang.isCollect)
            {
               BaoXiang.reqHideCB(false);
            }
            bytebuff.length = 0;
            SocketManager.send(MessageType.CG_CREATE_TEAM,bytebuff);
         }
         else if(Global.isInHome)
         {
            bytebuff.length = 0;
            SocketManager.send(MessageType.CG_CREATE_TEAM,bytebuff);
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10193",1));
         }
      }
      
      public static function CG_QUIT_TEAM(type:int) : void
      {
         if(SceneConfig.getSceneType() == SceneConfig.CROSS_CAMP_BATTLE)
         {
            if(GameUnitManager.hero.crossCampBattleBuff == 4)
            {
               View_Alert.show("如果退出队伍，将会失去战车",View_Alert.OK_CANCAL,function(evt:MouseEvent = null):void
               {
                  bytebuff.length = 0;
                  bytebuff.writeByte(type);
                  SocketManager.send(MessageType.CG_QUIT_TEAM,bytebuff);
               });
               return;
            }
         }
         if(SceneConfig.getInstance().getRestrict(Global.sceneMap,"NTD") == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10209",1));
            return;
         }
         bytebuff.length = 0;
         bytebuff.writeByte(type);
         SocketManager.send(MessageType.CG_QUIT_TEAM,bytebuff);
      }
      
      public static function CG_TEAM_INVITE(inviteName:String) : void
      {
         if(SceneConfig.getInstance().getRestrict(Global.sceneMap,"NZD") == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10193",1));
            return;
         }
         if(!QiJuHandler.checkCreatTeam())
         {
            return;
         }
         if(GuangMingDingConfig.cantCreateTeam())
         {
            return;
         }
         bytebuff.length = 0;
         bytebuff.writeUTF(inviteName);
         SocketManager.send(MessageType.CG_TEAM_INVITE,bytebuff);
      }
      
      public static function CG_TEAM_RECEPT(succesed:int, teamId:int) : void
      {
         if(Boolean(GameUnitManager.hero.paoBiao))
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10208",1));
            return;
         }
         if(!QiJuHandler.checkCreatTeam())
         {
            return;
         }
         if(GuangMingDingConfig.cantCreateTeam())
         {
            return;
         }
         if(SceneConfig.getInstance().getRestrict(Global.sceneMap,"NZD") == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10193",1));
            return;
         }
         bytebuff.length = 0;
         bytebuff.writeInt(succesed);
         bytebuff.writeInt(teamId);
         SocketManager.send(MessageType.CG_TEAM_RECEPT,bytebuff);
      }
      
      public static function CG_APPLY_TEAM(teamId:int) : void
      {
         if(Boolean(GameUnitManager.hero.paoBiao))
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10208",1));
            return;
         }
         if(!QiJuHandler.checkCreatTeam())
         {
            return;
         }
         if(GuangMingDingConfig.cantCreateTeam())
         {
            return;
         }
         if(SceneConfig.getInstance().getRestrict(Global.sceneMap,"NZD") == 1 && SceneConfig.getSceneType() != SceneConfig.KFBZ_BATTLE && SceneConfig.getSceneType() != SceneConfig.CROSS_CAMP_BATTLE)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10193",1));
            return;
         }
         bytebuff.length = 0;
         bytebuff.writeInt(teamId);
         SocketManager.send(MessageType.CG_APPLY_TEAM,bytebuff);
      }
      
      public static function CG_KICK_OUT(OtherRoleId:Number) : void
      {
         if(SceneConfig.getInstance().getRestrict(Global.sceneMap,"NTD") == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10210",1));
            return;
         }
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,OtherRoleId);
         SocketManager.send(MessageType.CG_KICK_OUT,bytebuff);
      }
      
      public static function CG_CHECK_TEAM(teamId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(teamId);
         SocketManager.send(MessageType.CG_CHECK_TEAM,bytebuff);
      }
      
      public static function CG_CHANGE_CAP(otherRoleId:Number) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,otherRoleId);
         SocketManager.send(MessageType.CG_CHANGE_CAP,bytebuff);
      }
      
      public static function CG_APPLY_CAP(teamId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(teamId);
         SocketManager.send(MessageType.CG_APPLY_CAP,bytebuff);
      }
      
      public static function CG_CAP_RETURN(isRecept:int, otherRoleId:Number) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(isRecept);
         LongUtil.writeLong(bytebuff,otherRoleId);
         SocketManager.send(MessageType.CG_CAP_RETURN,bytebuff);
      }
      
      public static function CG_CHANGE_LEVEL(leastLevel:int, biggestLevel:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(leastLevel);
         bytebuff.writeInt(biggestLevel);
         SocketManager.send(MessageType.CG_CHANGE_LEVEL,bytebuff);
      }
      
      public static function CG_LEAVE_TEAM(status:int) : void
      {
         if(SceneConfig.getInstance().getRestrict(Global.sceneMap,"NZL") == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10211",1));
            return;
         }
         bytebuff.length = 0;
         bytebuff.writeInt(status);
         SocketManager.send(MessageType.CG_LEAVE_TEAM,bytebuff);
      }
      
      public static function CG_CAP_FOLLOW(otherRoleId:Number) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,otherRoleId);
         SocketManager.send(MessageType.CG_CAP_FOLLOW,bytebuff);
      }
      
      public static function CG_CHANGE_ZHENFA(zhenfaType:int, temStr:String) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(zhenfaType);
         trace("..",temStr);
         bytebuff.writeUTF(temStr);
         SocketManager.send(MessageType.CG_CHANGE_ZHENFA,bytebuff);
      }
      
      public static function CG_FOLLOW_CAP(follow:int, teamId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(follow);
         bytebuff.writeInt(teamId);
         SocketManager.send(MessageType.CG_FOLLOW_CAP,bytebuff);
      }
      
      public static function CG_DIRECT_TEAM_STATE(type:int, otherRoleId:String, zone:int = 0) : void
      {
         if(SceneConfig.getInstance().getRestrict(Global.sceneMap,"NTD") == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10210",1));
            return;
         }
         if(Boolean(GameUnitManager.hero.paoBiao))
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10208",1));
            return;
         }
         bytebuff.length = 0;
         bytebuff.writeInt(type);
         bytebuff.writeUTF(otherRoleId);
         if(Global.isInHome)
         {
            bytebuff.writeInt(zone);
         }
         SocketManager.send(MessageType.CG_DIRECT_TEAM_STATE,bytebuff);
      }
      
      public static function CG_DIRECT_TEAM(otherRoleId:Number, operat:int, zone:int = 0) : void
      {
         if(Boolean(GameUnitManager.hero.paoBiao))
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10208",1));
            return;
         }
         if(!QiJuHandler.checkCreatTeam())
         {
            return;
         }
         if(GuangMingDingConfig.cantCreateTeam())
         {
            return;
         }
         if(SceneConfig.getInstance().getRestrict(Global.sceneMap,"NTD") == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10210",1));
            return;
         }
         if(Data_lib.map[Global.sceneMap][Enum_map_lib.TYPE] == 7 || Data_lib.map[Global.sceneMap][Enum_map_lib.TYPE] == 3 || Data_lib.map[Global.sceneMap][Enum_map_lib.TYPE] == 5 || SceneConfig.getSceneType() == SceneConfig.HUNLI)
         {
            if(BaoXiang.isCollect)
            {
               BaoXiang.reqHideCB(false);
            }
            bytebuff.length = 0;
            LongUtil.writeLong(bytebuff,otherRoleId);
            bytebuff.writeInt(operat);
            if(Global.isInHome)
            {
               bytebuff.writeInt(zone);
            }
            SocketManager.send(MessageType.CG_DIRECT_TEAM,bytebuff);
         }
         else if(Global.isInHome)
         {
            bytebuff.length = 0;
            LongUtil.writeLong(bytebuff,otherRoleId);
            bytebuff.writeInt(operat);
            bytebuff.writeInt(zone);
            SocketManager.send(MessageType.CG_DIRECT_TEAM,bytebuff);
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10210",1));
         }
      }
      
      public static function CG_REGISTRATION_TEAM(isRegister:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(isRegister);
         SocketManager.send(MessageType.CG_REGISTRATION_TEAM,bytebuff);
      }
      
      public static function CG_TEAM_PATA() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_TEAM_PATA,bytebuff);
      }
   }
}

