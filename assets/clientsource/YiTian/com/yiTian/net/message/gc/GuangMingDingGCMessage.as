package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.GuangMingDingHandle;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class GuangMingDingGCMessage
   {
      
      public function GuangMingDingGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_GMD_TIP] = this.GC_GMD_TIP;
         index[MessageType.GC_GMD_MYINFO] = this.GC_GMD_MYINFO;
         index[MessageType.GC_GMD_ROOM_INFO] = this.GC_GMD_ROOM_INFO;
         index[MessageType.GC_GMD_CREATE_ROOM] = this.GC_GMD_CREATE_ROOM;
         index[MessageType.GC_GMD_SEARCH_ROOM] = this.GC_GMD_SEARCH_ROOM;
         index[MessageType.GC_GMD_FAST_JOIN] = this.GC_GMD_FAST_JOIN;
         index[MessageType.GC_GMD_INVITE_INFO] = this.GC_GMD_INVITE_INFO;
         index[MessageType.GC_GMD_INVITE_PLAYER] = this.GC_GMD_INVITE_PLAYER;
         index[MessageType.GC_GMD_INVITE_QUICKLY] = this.GC_GMD_INVITE_QUICKLY;
         index[MessageType.GC_GMD_TEAMLEADER_RESPON] = this.GC_GMD_TEAMLEADER_RESPON;
         index[MessageType.GC_GMD_LEAVE_TEAM] = this.GC_GMD_LEAVE_TEAM;
         index[MessageType.GC_GMD_KICK_TEAMMEMBER] = this.GC_GMD_KICK_TEAMMEMBER;
         index[MessageType.GC_GMD_MEMBER_READY] = this.GC_GMD_MEMBER_READY;
         index[MessageType.GC_GMD_BEGIN_CHALLENGE] = this.GC_GMD_BEGIN_CHALLENGE;
         index[MessageType.GC_GMD_TEAM_INFO] = this.GC_GMD_TEAM_INFO;
         index[MessageType.GC_GMD_PASSWORD] = this.GC_GMD_PASSWORD;
         index[MessageType.GC_GMD_ENTERINFO] = this.GC_GMD_ENTERINFO;
         index[MessageType.GC_GMD_USE_MJ] = this.GC_GMD_USE_MJ;
         index[MessageType.GC_GMD_REWARD_LEVEL] = this.GC_GMD_REWARD_LEVEL;
         index[MessageType.GC_GMD_MIJI_USEING] = this.GC_GMD_MIJI_USEING;
         index[MessageType.GC_GMD_ROOM_HASPASSWORD] = this.GC_GMD_ROOM_HASPASSWORD;
         index[MessageType.GC_GMD_REVIVE] = this.GC_GMD_REVIVE;
         index[MessageType.GC_GMD_JUMP_BATTLE] = this.GC_GMD_JUMP_BATTLE;
         index[MessageType.GC_GMD_JUMP_BATTLE_TIMES] = this.GC_GMD_JUMP_BATTLE_TIMES;
         index[MessageType.GC_GMD_BATTLE_CLASH] = this.GC_GMD_BATTLE_CLASH;
      }
      
      public function GC_GMD_TIP(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         GuangMingDingHandle.GC_GMD_TIP(type);
      }
      
      public function GC_GMD_ROOM_INFO(patch:IDataInput) : void
      {
         var teamId:int = 0;
         var passWord:String = null;
         var numPlayer:int = 0;
         var maxPlayer:int = 0;
         var roleName:String = null;
         var curPage:int = patch.readInt();
         var maxPage:int = patch.readInt();
         var len:int = patch.readByte();
         var teams:Array = [];
         var i:int = 0;
         while(i < len)
         {
            teamId = patch.readInt();
            passWord = patch.readUTF();
            numPlayer = patch.readByte();
            maxPlayer = patch.readByte();
            roleName = Model_heFu.repNameStr(patch.readUTF());
            teams.push([teamId,passWord,numPlayer,maxPlayer,roleName]);
            i += 1;
         }
         GuangMingDingHandle.GC_GMD_ROOM_INFO(curPage,maxPage,teams);
      }
      
      public function GC_GMD_CREATE_ROOM(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         GuangMingDingHandle.GC_GMD_CREATE_ROOM(type);
      }
      
      public function GC_GMD_MYINFO(patch:IDataInput) : void
      {
         var remain:int = patch.readByte();
         var record:int = patch.readShort();
         GuangMingDingHandle.GC_GMD_MYINFO(remain,record);
      }
      
      public function GC_GMD_TEAM_INFO(patch:IDataInput) : void
      {
         var sex:int = 0;
         var roleName:String = null;
         var job:int = 0;
         var level:int = 0;
         var petID:Number = NaN;
         var fashion:int = 0;
         var weapon:int = 0;
         var roleID:Number = NaN;
         var isReady:int = 0;
         var position:int = 0;
         var wing:int = 0;
         var teamID:int = patch.readInt();
         var passWord:String = patch.readUTF();
         var numMembers:int = patch.readByte();
         var members:Array = [];
         var i:int = 0;
         while(i < numMembers)
         {
            sex = patch.readInt();
            roleName = Model_heFu.repNameStr(patch.readUTF());
            job = patch.readInt();
            level = patch.readShort();
            petID = LongUtil.readLong(patch);
            fashion = patch.readInt();
            weapon = patch.readInt();
            roleID = LongUtil.readLong(patch);
            isReady = patch.readByte();
            position = i;
            wing = patch.readInt();
            members.push([sex,roleName,job,level,petID,fashion,weapon,roleID,isReady,position,wing]);
            i += 1;
         }
         GuangMingDingHandle.GC_GMD_TEAM_INFO(teamID,passWord,members);
      }
      
      public function GC_GMD_SEARCH_ROOM(patch:IDataInput) : void
      {
         var targetID:int = patch.readInt();
         GuangMingDingHandle.GC_GMD_SEARCH_ROOM(targetID);
      }
      
      public function GC_GMD_FAST_JOIN(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         GuangMingDingHandle.GC_GMD_FAST_JOIN(result);
      }
      
      public function GC_GMD_INVITE_INFO(patch:IDataInput) : void
      {
         var roleID:Number = NaN;
         var roleName:String = null;
         var roleJob:int = 0;
         var roleLv:int = 0;
         var roleInfos:Array = [];
         var numRole:int = patch.readShort();
         var i:int = 0;
         while(i < numRole)
         {
            roleID = LongUtil.readLong(patch);
            roleName = Model_heFu.repNameStr(patch.readUTF());
            roleJob = patch.readByte();
            roleLv = patch.readShort();
            roleInfos.push([roleID,roleName,roleJob,roleLv]);
            i += 1;
         }
         GuangMingDingHandle.GC_GMD_INVITE_INFO(2,roleInfos);
      }
      
      public function GC_GMD_INVITE_PLAYER(patch:IDataInput) : void
      {
         var cID:Number = LongUtil.readLong(patch);
         var cName:String = patch.readUTF();
         var targetRoom:int = patch.readInt();
         GuangMingDingHandle.GC_GMD_INVITE_PLAYER(cID,cName,targetRoom);
      }
      
      public function GC_GMD_INVITE_QUICKLY(patch:IDataInput) : void
      {
         var roleID:Number = LongUtil.readLong(patch);
         var roleName:String = patch.readUTF();
         var teamID:int = patch.readInt();
         var pw:String = patch.readUTF();
         GuangMingDingHandle.GC_GMD_INVITE_QUICKLY(roleID,roleName,teamID,pw);
      }
      
      public function GC_GMD_LEAVE_TEAM(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         GuangMingDingHandle.GC_GMD_LEAVE_TEAM(result);
      }
      
      public function GC_GMD_KICK_TEAMMEMBER(patch:IDataInput) : void
      {
         GuangMingDingHandle.GC_GMD_KICK_TEAMMEMBER();
      }
      
      public function GC_GMD_MEMBER_READY(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         GuangMingDingHandle.GC_GMD_MEMBER_READY(result);
      }
      
      public function GC_GMD_BEGIN_CHALLENGE(patch:IDataInput) : void
      {
         var roleID:Number = NaN;
         var len2:int = 0;
         var mjInfo:Array = null;
         var j:int = 0;
         var mjID:int = 0;
         var battleID:int = patch.readInt();
         var result:int = patch.readByte();
         var floor:int = patch.readShort();
         var len1:int = patch.readByte();
         var map:Object = len1 != 0 ? {} : null;
         var i:int = 0;
         while(i < len1)
         {
            roleID = LongUtil.readLong(patch);
            len2 = patch.readByte();
            mjInfo = [];
            j = 0;
            while(j < len2)
            {
               mjID = patch.readInt();
               if(mjID != 101)
               {
                  mjInfo.push(mjID);
               }
               j += 1;
            }
            map[roleID] = mjInfo;
            i += 1;
         }
         var jumpFlag:int = patch.readByte();
         GuangMingDingHandle.GC_GMD_BEGIN_CHALLENGE(battleID,result,floor,map,jumpFlag);
      }
      
      public function GC_GMD_TEAMLEADER_RESPON(patch:IDataInput) : void
      {
         var teamID:int = patch.readInt();
         var memberID:Number = LongUtil.readLong(patch);
         var memberName:String = patch.readUTF();
         GuangMingDingHandle.GC_GMD_TEAMLEADER_RESPON(memberID,memberName);
      }
      
      public function GC_GMD_PASSWORD(patch:IDataInput) : void
      {
         var pw:String = patch.readUTF();
         GuangMingDingHandle.GC_GMD_PASSWORD(pw);
      }
      
      public function GC_GMD_ENTERINFO(patch:IDataInput) : void
      {
         var mjID:int = 0;
         var freeRemain:int = 0;
         var costRemain:int = 0;
         var useingID:int = 0;
         var floor:int = patch.readShort();
         var disFloor:int = patch.readShort();
         var mjLen:int = patch.readByte();
         var mjRemainMap:Object = {};
         var i:int = 0;
         while(i < mjLen)
         {
            mjID = patch.readInt();
            freeRemain = patch.readByte();
            costRemain = patch.readByte();
            mjRemainMap[mjID.toString()] = [freeRemain,costRemain];
            i += 1;
         }
         var useLen:int = patch.readByte();
         var useingInfo:Object = {};
         var j:int = 0;
         while(j < useLen)
         {
            useingID = patch.readInt();
            useingInfo[useingID] = true;
            j += 1;
         }
         var leaderID:Number = LongUtil.readLong(patch);
         GuangMingDingHandle.GC_GMD_ENTERINFO(floor,disFloor,mjRemainMap,useingInfo,leaderID);
      }
      
      public function GC_GMD_USE_MJ(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var mjID:int = patch.readInt();
         var freeRemain:int = patch.readByte();
         var costRemain:int = patch.readByte();
         GuangMingDingHandle.GC_GMD_USE_MJ(result,mjID,freeRemain,costRemain);
      }
      
      public function GC_GMD_REWARD_LEVEL(patch:IDataInput) : void
      {
         var level:int = patch.readShort();
         GuangMingDingHandle.GC_GMD_REWARD_LEVEL(level);
      }
      
      public function GC_GMD_MIJI_USEING(patch:IDataInput) : void
      {
         var id:int = 0;
         var len:int = patch.readByte();
         var map:Object = {};
         var i:int = 0;
         while(i < len)
         {
            id = patch.readInt();
            map[id] = true;
            i += 1;
         }
         GuangMingDingHandle.GC_GMD_MIJI_USEING(map);
      }
      
      public function GC_GMD_ROOM_HASPASSWORD(patch:IDataInput) : void
      {
         var roomID:Number = patch.readInt();
         GuangMingDingHandle.GC_GMD_ROOM_HASPASSWORD(roomID);
      }
      
      public function GC_GMD_REVIVE(patch:IDataInput) : void
      {
         var bID:int = patch.readInt();
         var type:int = patch.readByte();
         var remain:int = patch.readShort();
         GuangMingDingHandle.GC_GMD_REVIVE(bID,type,remain);
      }
      
      public function GC_GMD_BATTLE_CLASH(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == 2)
         {
            UIManager.centerBroadcast.addMsg("在副本中不能抢夺农夫");
         }
      }
      
      public function GC_GMD_JUMP_BATTLE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var times:int = patch.readByte();
         GuangMingDingHandle.GC_GMD_JUMP_BATTLE(result,times);
      }
      
      public function GC_GMD_JUMP_BATTLE_TIMES(patch:IDataInput) : void
      {
         var times:int = patch.readByte();
         GuangMingDingHandle.GC_GMD_JUMP_BATTLE(0,times);
      }
   }
}

