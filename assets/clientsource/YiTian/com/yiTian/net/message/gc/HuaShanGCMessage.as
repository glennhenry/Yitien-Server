package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.net.handler.HuaShanHandle;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.utils.PatchReader;
   import flash.utils.IDataInput;
   
   public class HuaShanGCMessage
   {
      
      public function HuaShanGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_HS_TIPBTNSHOW] = this.GC_HS_TIPBTNSHOW;
         index[MessageType.GC_HS_INFO] = this.GC_HS_INFO;
         index[MessageType.GC_HS_RANKS] = this.GC_HS_RANKS;
         index[MessageType.GC_HS_MATCH_INFO] = this.GC_HS_MATCH_INFO;
         index[MessageType.GC_HS_UPDATE_TIP] = this.GC_HS_UPDATE_TIP;
         index[MessageType.GC_HS_TEAM] = this.GC_HS_TEAM;
         index[MessageType.GC_XUANBAMATCHINFO] = this.GC_XUANBAMATCHINFO;
         index[MessageType.GC_NXTMATCHINFO] = this.GC_NXTMATCHINFO;
         index[MessageType.GC_SHENJIABANG] = this.GC_SHENJIABANG;
         index[MessageType.GC_XUANBABET] = this.GC_XUANBABET;
         index[MessageType.GC_MYXUANBABET] = this.GC_MYXUANBABET;
         index[MessageType.GC_BLESS_ROLE] = this.GC_BLESS_ROLE;
         index[MessageType.GC_HS_BLESS_RANK] = this.GC_HS_BLESS_RANK;
         index[MessageType.GC_HS_MY_BLESSING] = this.GC_HS_MY_BLESSING;
         index[MessageType.GC_HS_BROADCAST] = this.GC_HS_BROADCAST;
         index[MessageType.GC_HS_CHAMPION] = this.GC_HS_CHAMPION;
         index[MessageType.GC_CENTERSERVADDRESS] = this.GC_CENTERSERVADDRESS;
      }
      
      private function GC_HS_TIPBTNSHOW(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         HuaShanHandle.GC_HS_TIPBTNSHOW(type);
      }
      
      private function GC_HS_INFO(patch:IDataInput) : void
      {
         var myState:int = patch.readByte();
         HuaShanHandle.GC_HS_INFO(myState);
      }
      
      private function GC_HS_TEAM(patch:IDataInput) : void
      {
         var pos:int = 0;
         var roleType:int = 0;
         var roleID:Number = NaN;
         var roleName:String = null;
         var roleModelID:int = 0;
         var len:int = patch.readByte();
         var teamInfo:Array = [];
         var i:int = 0;
         while(i < len)
         {
            pos = patch.readByte();
            roleType = patch.readByte();
            roleID = LongUtil.readLong(patch);
            roleName = patch.readUTF();
            roleModelID = patch.readInt();
            teamInfo.push([pos,roleType,roleID,roleName,roleModelID]);
            i += 1;
         }
         HuaShanHandle.GC_HS_TEAM(teamInfo);
      }
      
      private function GC_HS_RANKS(patch:IDataInput) : void
      {
         var roleID:Number = NaN;
         var roleName:String = null;
         var roleArea:String = null;
         var score:int = 0;
         var bangType:int = patch.readByte();
         var curPageIndex:int = patch.readShort();
         var numMaxPage:int = patch.readShort();
         var len:int = patch.readShort();
         var arr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            roleID = LongUtil.readLong(patch);
            roleName = patch.readUTF();
            roleArea = patch.readUTF();
            score = patch.readInt();
            arr.push([roleID,roleName,roleArea,score]);
            i += 1;
         }
         HuaShanHandle.GC_HS_RANKS(bangType,curPageIndex,numMaxPage,arr);
      }
      
      private function GC_HS_MATCH_INFO(patch:IDataInput) : void
      {
         var result:int = 0;
         var roleID1:Number = NaN;
         var roleName1:String = null;
         var roleID2:Number = NaN;
         var roleName2:String = null;
         var battleTime:int = 0;
         var result2:int = 0;
         var roleID21:Number = NaN;
         var roleName21:String = null;
         var roleID22:Number = NaN;
         var roleName22:String = null;
         var battleTime2:int = 0;
         var areaType:int = patch.readByte();
         var bangType:int = patch.readByte();
         var isOverMatch:int = patch.readByte();
         var myBangType:int = patch.readByte();
         var myScore:int = patch.readInt();
         var remainLife:int = patch.readByte();
         var myRank:int = patch.readInt();
         var otherInfo:Array = [];
         var len1:int = patch.readShort();
         var i:int = 0;
         while(i < len1)
         {
            result = patch.readByte();
            roleID1 = LongUtil.readLong(patch);
            roleName1 = Model_heFu.repsServName2(patch.readUTF());
            roleID2 = LongUtil.readLong(patch);
            roleName2 = Model_heFu.repsServName2(patch.readUTF());
            battleTime = patch.readInt();
            otherInfo.push([result,roleID1,roleName1,roleID2,roleName2,battleTime]);
            i += 1;
         }
         var myInfo:Array = [];
         var len2:int = patch.readShort();
         var i2:int = 0;
         while(i2 < len2)
         {
            result2 = patch.readByte();
            roleID21 = LongUtil.readLong(patch);
            roleName21 = Model_heFu.repsServName2(patch.readUTF());
            roleID22 = LongUtil.readLong(patch);
            roleName22 = Model_heFu.repsServName2(patch.readUTF());
            battleTime2 = patch.readInt();
            myInfo.push([result2,roleID21,roleName21,roleID22,roleName22,battleTime2]);
            i2 += 1;
         }
         HuaShanHandle.GC_HS_MATCH_INFO(areaType,bangType,isOverMatch,myBangType,myScore,remainLife,myRank,otherInfo,myInfo);
      }
      
      private function GC_HS_UPDATE_TIP(patch:IDataInput) : void
      {
         var sai:int = patch.readByte();
         var bangType:int = patch.readByte();
         HuaShanHandle.GC_HS_UPDATE_TIP(sai,bangType);
      }
      
      private function GC_XUANBAMATCHINFO(patch:IDataInput) : void
      {
         var roleID:Number = NaN;
         var roleName:String = null;
         var sex:int = 0;
         var job:int = 0;
         var shenjia:int = 0;
         var servName:String = null;
         var roleLv:int = 0;
         var roleStrength:int = 0;
         var roleBlessLv:int = 0;
         var roleBlessStar:int = 0;
         var roleBlessExp:int = 0;
         var len2:int = 0;
         var tmp:Array = null;
         var jj:int = 0;
         var id1:Number = NaN;
         var id2:Number = NaN;
         var bInfo:int = 0;
         var state:int = 0;
         var result:int = 0;
         var jie:int = patch.readShort();
         var bangType:int = patch.readByte();
         var len:int = patch.readShort();
         var playerInfoArr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            roleID = LongUtil.readLong(patch);
            roleName = patch.readUTF();
            sex = patch.readByte();
            job = patch.readByte();
            shenjia = patch.readInt();
            servName = patch.readUTF();
            roleLv = patch.readShort();
            roleStrength = patch.readInt();
            roleBlessLv = patch.readByte();
            roleBlessStar = patch.readByte();
            roleBlessExp = patch.readInt();
            playerInfoArr.push([roleID,roleName,sex,job,shenjia,servName,roleLv,roleStrength,roleBlessLv,roleBlessStar,roleBlessExp]);
            i += 1;
         }
         var matchInfoArr:Array = [];
         var j:int = 0;
         while(j < 5)
         {
            len2 = patch.readShort();
            tmp = [];
            jj = 0;
            while(jj < len2)
            {
               id1 = LongUtil.readLong(patch);
               id2 = LongUtil.readLong(patch);
               bInfo = patch.readInt();
               state = patch.readByte();
               result = patch.readByte();
               tmp.push([id1,id2,bInfo,state]);
               jj += 1;
            }
            matchInfoArr.push(tmp);
            j += 1;
         }
         HuaShanHandle.GC_XUANBAMATCHINFO(jie,bangType,playerInfoArr,matchInfoArr);
      }
      
      private function GC_MYXUANBABET(patch:IDataInput) : void
      {
         var types:Array = ["s","b",["s","b","l","u","b","i","b","b","i","i"]];
         var infos:Array = PatchReader.instance.readPatch(types,patch);
         HuaShanHandle.GC_MYXUANBABET(infos[0],infos[1],infos[2]);
      }
      
      private function GC_SHENJIABANG(patch:IDataInput) : void
      {
         var roleID:Number = NaN;
         var shenjia:int = 0;
         var jie:int = patch.readShort();
         var bangType:int = patch.readByte();
         var infos:Array = [];
         var len:int = patch.readShort();
         var i:int = 0;
         while(i < len)
         {
            roleID = LongUtil.readLong(patch);
            shenjia = patch.readInt();
            infos.push([roleID,shenjia]);
            i += 1;
         }
         HuaShanHandle.GC_SHENJIABANG(jie,bangType,infos);
      }
      
      private function GC_XUANBABET(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         HuaShanHandle.GC_XUANBABET(result);
      }
      
      private function GC_CENTERSERVADDRESS(patch:IDataInput) : void
      {
         var url:String = patch.readUTF();
         HuaShanHandle.GC_CENTERSERVADDRESS(url);
      }
      
      private function GC_NXTMATCHINFO(patch:IDataInput) : void
      {
         var nxtTime:int = patch.readInt();
         var nxtLun:int = patch.readByte();
         var nxtChang:int = patch.readByte();
         HuaShanHandle.GC_NXTMATCHINFO(nxtTime,nxtLun,nxtChang);
      }
      
      private function GC_HS_OPEN_BLESSUI(patch:IDataInput) : void
      {
         var types:Array = ["b","b","b","b","i","b","b","b","i","b","b","b"];
         var infos:Array = PatchReader.instance.readPatch(types,patch);
         HuaShanHandle.GC_HS_OPEN_BLESSUI(infos);
      }
      
      private function GC_BLESS_ROLE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var roleID:Number = LongUtil.readLong(patch);
         var blessLV:int = patch.readByte();
         var blessStar:int = patch.readByte();
         var blessExp:int = patch.readInt();
         HuaShanHandle.GC_BLESS_ROLE(result,roleID,blessLV,blessStar,blessExp);
      }
      
      private function GC_HS_BLESS_RANK(patch:IDataInput) : void
      {
         var roleID:Number = NaN;
         var srcStrength:int = 0;
         var addStrength:int = 0;
         var blessLV:int = 0;
         var blessStar:int = 0;
         var blessExp:int = 0;
         var jie:int = patch.readShort();
         var bangType:int = patch.readByte();
         var infos:Array = [];
         var len:int = patch.readShort();
         var i:int = 0;
         while(i < len)
         {
            roleID = LongUtil.readLong(patch);
            srcStrength = patch.readInt();
            addStrength = patch.readInt();
            blessLV = patch.readByte();
            blessStar = patch.readByte();
            blessExp = patch.readInt();
            infos.push([roleID,srcStrength,addStrength,blessLV,blessStar,blessExp]);
            i += 1;
         }
         HuaShanHandle.GC_HS_BLESS_RANK(jie,bangType,infos);
      }
      
      private function GC_HS_MY_BLESSING(patch:IDataInput) : void
      {
         var types:Array = ["s",["s","b","b","l","u","b","b"]];
         var infos:Array = PatchReader.instance.readPatch(types,patch);
         HuaShanHandle.GC_HS_MY_BLESSING(infos[0],infos[1]);
      }
      
      public function GC_HS_BROADCAST(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         HuaShanHandle.GC_HS_BROADCAST(type);
      }
      
      public function GC_HS_CHAMPION(patch:IDataInput) : void
      {
         var bangType:int = 0;
         var rank:int = 0;
         var areaIndex:String = null;
         var roleName:String = null;
         var infos:Array = [];
         var len:int = patch.readShort();
         var i:int = 0;
         while(i < len)
         {
            bangType = patch.readByte();
            rank = patch.readByte();
            areaIndex = patch.readUTF();
            roleName = patch.readUTF();
            infos.push([bangType,rank,areaIndex,roleName]);
            i += 1;
         }
         HuaShanHandle.GC_HS_CHAMPION(infos);
      }
   }
}

