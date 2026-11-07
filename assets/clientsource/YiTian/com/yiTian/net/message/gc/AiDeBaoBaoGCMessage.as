package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.net.handler.AiDeBaoBaoHandle;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class AiDeBaoBaoGCMessage
   {
      
      public function AiDeBaoBaoGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_AiDeBaoBao_ICON] = this.GC_AiDeBaoBao_ICON;
         index[MessageType.GC_AiDeBaoBao_SERVER_CHOICE] = this.GC_AiDeBaoBao_SERVER_CHOICE;
         index[MessageType.GC_AiDeBaoBao_JOIN] = this.GC_AiDeBaoBao_JOIN;
         index[MessageType.GC_AiDeBaoBao_EXIT] = this.GC_AiDeBaoBao_EXIT;
         index[MessageType.GC_AiDeBaoBao_TIME] = this.GC_AiDeBaoBao_TIME;
         index[MessageType.GC_AiDeBaoBao_FRESH_LIST] = this.GC_AiDeBaoBao_FRESH_LIST;
         index[MessageType.GC_AiDeBaoBao_REQUEST] = this.GC_AiDeBaoBao_REQUEST;
         index[MessageType.GC_AiDeBaoBao_YongBao] = this.GC_AiDeBaoBao_YongBao;
         index[MessageType.GC_AiDeBaoBao_RELIEVE] = this.GC_AiDeBaoBao_RELIEVE;
         index[MessageType.GC_AiDeBaoBao_ROOM_MENU] = this.GC_AiDeBaoBao_ROOM_MENU;
         index[MessageType.GC_AiDeBaoBao_CHANGE_ROOM] = this.GC_AiDeBaoBao_CHANGE_ROOM;
         index[MessageType.GC_AiDeBaoBao_JOIN_SECOND_HALF] = this.GC_AiDeBaoBao_JOIN_SECOND_HALF;
         index[MessageType.GC_AiDeBaoBao_ARRIVE_END] = this.GC_AiDeBaoBao_ARRIVE_END;
         index[MessageType.GC_AiDeBaoBao_PaiHang] = this.GC_AiDeBaoBao_PaiHang;
         index[MessageType.GC_AiDeBaoBao_SKILL_CAST] = this.GC_AiDeBaoBao_SKILL_CAST;
         index[MessageType.GC_AiDeBaoBao_SKILL_BUFF] = this.GC_AiDeBaoBao_SKILL_BUFF;
         index[MessageType.GC_AiDeBaoBao_GUIDE] = this.GC_AiDeBaoBao_GUIDE;
         index[MessageType.GC_AiDeBaoBao_CHECK_POSITION_END] = this.GC_AiDeBaoBao_CHECK_POSITION_END;
         index[MessageType.GC_AiDeBaoBao_CHECK_POSITION_START] = this.GC_AiDeBaoBao_CHECK_POSITION_START;
      }
      
      public function GC_AiDeBaoBao_ICON(patch:IDataInput) : void
      {
         AiDeBaoBaoHandle.IconSwitch(patch.readByte());
      }
      
      public function GC_AiDeBaoBao_SERVER_CHOICE(patch:IDataInput) : void
      {
         AiDeBaoBaoHandle.GC_AiDeBaoBao_SERVER_CHOICE(patch.readByte());
      }
      
      public function GC_AiDeBaoBao_JOIN(patch:IDataInput) : void
      {
         var flag:int = patch.readByte();
         var roomId:int = patch.readInt();
         AiDeBaoBaoHandle.JoinResult(flag,roomId);
      }
      
      public function GC_AiDeBaoBao_EXIT(patch:IDataInput) : void
      {
         var flag:int = patch.readByte();
         AiDeBaoBaoHandle.ExitResult(flag);
      }
      
      public function GC_AiDeBaoBao_TIME(patch:IDataInput) : void
      {
         AiDeBaoBaoHandle.TimeCountDown(patch.readInt());
      }
      
      public function GC_AiDeBaoBao_FRESH_LIST(patch:IDataInput) : void
      {
         var round:int = 0;
         var i:int = 0;
         var obj:Object = null;
         var arr:Array = [];
         if(patch.readByte() == 1)
         {
            round = patch.readShort();
            i = 0;
            while(i < round)
            {
               obj = {};
               obj.id = LongUtil.readLong(patch);
               obj.name = patch.readUTF();
               obj.zoneId = patch.readInt();
               obj.sex = patch.readByte();
               arr.push(obj);
               i++;
            }
         }
         AiDeBaoBaoHandle.FreshList(arr);
      }
      
      public function GC_AiDeBaoBao_REQUEST(patch:IDataInput) : void
      {
         var id:Number = LongUtil.readLong(patch);
         var zoneId:int = patch.readInt();
         AiDeBaoBaoHandle.Request(id,zoneId);
      }
      
      public function GC_AiDeBaoBao_YongBao(patch:IDataInput) : void
      {
         var zoneId:int = 0;
         var flag:int = patch.readByte();
         var id:Number = 0;
         if(flag == 1 || flag == 7)
         {
            id = LongUtil.readLong(patch);
            zoneId = patch.readInt();
         }
         AiDeBaoBaoHandle.RequestResult(flag,id,zoneId);
      }
      
      public function GC_AiDeBaoBao_RELIEVE(patch:IDataInput) : void
      {
         AiDeBaoBaoHandle.RelieveResult(patch.readByte());
      }
      
      public function GC_AiDeBaoBao_ROOM_MENU(patch:IDataInput) : void
      {
         var arr:Array = null;
         var i:int = 0;
         var roomId:int = 0;
         var propleNum:int = 0;
         var roomNum:int = patch.readShort();
         if(roomNum > 0)
         {
            arr = [];
            i = 0;
            while(i < roomNum)
            {
               roomId = patch.readInt();
               propleNum = patch.readShort();
               arr.push([roomId,propleNum]);
               i++;
            }
            AiDeBaoBaoHandle.RoomMenuResult(arr);
         }
      }
      
      public function GC_AiDeBaoBao_CHANGE_ROOM(patch:IDataInput) : void
      {
         var flag:int = patch.readByte();
         var roomID:int = patch.readInt();
         AiDeBaoBaoHandle.ChangeRoomResult(flag,roomID);
      }
      
      public function GC_AiDeBaoBao_JOIN_SECOND_HALF(patch:IDataInput) : void
      {
         if(patch.readByte() == 1)
         {
            AiDeBaoBaoHandle.SecondHalf();
         }
      }
      
      public function GC_AiDeBaoBao_ARRIVE_END(patch:IDataInput) : void
      {
         var costTime:int = patch.readInt();
         var rank:int = patch.readShort();
         AiDeBaoBaoHandle.Arrive_end(costTime,rank);
      }
      
      public function GC_AiDeBaoBao_PaiHang(patch:IDataInput) : void
      {
         var nameGroup:String = null;
         var costTime:int = 0;
         var arr:Array = [];
         var times:int = patch.readByte();
         var i:int = 0;
         while(i < times)
         {
            nameGroup = patch.readUTF();
            costTime = patch.readInt();
            arr.push(nameGroup.split("&").concat(costTime));
            i++;
         }
         AiDeBaoBaoHandle.PaiHang(arr);
      }
      
      public function GC_AiDeBaoBao_SKILL_CAST(patch:IDataInput) : void
      {
         var skillId:int = patch.readByte();
         var flag:int = patch.readByte();
         var times:int = patch.readShort();
         AiDeBaoBaoHandle.SkillResult(skillId,flag,times);
      }
      
      public function GC_AiDeBaoBao_SKILL_BUFF(patch:IDataInput) : void
      {
         var skillId:int = patch.readByte();
         AiDeBaoBaoHandle.SkillBuffTime(skillId);
      }
      
      public function GC_AiDeBaoBao_GUIDE(patch:IDataInput) : void
      {
         AiDeBaoBaoHandle.Guide(1);
      }
      
      public function GC_AiDeBaoBao_CHECK_POSITION_END(patch:IDataInput) : void
      {
         AiDeBaoBaoHandle.startEndCheckPosition(2);
      }
      
      public function GC_AiDeBaoBao_CHECK_POSITION_START(patch:IDataInput) : void
      {
         AiDeBaoBaoHandle.startEndCheckPosition(1);
      }
   }
}

