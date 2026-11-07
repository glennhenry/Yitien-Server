package com.yiTian.net.message.cg
{
   import com.utils.LongUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_CrossType;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.utils.Utils;
   import flash.utils.ByteArray;
   
   public class AiDeBaoBaoCGMessage
   {
      
      private static var bytebuff:ByteArray = new ByteArray();
      
      public function AiDeBaoBaoCGMessage()
      {
         super();
      }
      
      public static function CG_AiDeBaoBao_choiceServer(id:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(id);
         SocketManager.send(MessageType.CG_AiDeBaoBao_SERVER_CHOICE,bytebuff);
      }
      
      public static function CG_AiDeBaoBao_JOIN() : void
      {
         Global.crossType = Enum_CrossType.CROSS_AiDeBaoBao;
         CrossClanBattleCGMessage.CG_ENTER_BATTLE_SCENE(Global.crossType,"");
      }
      
      public static function CG_AiDeBaoBao_FRESH_LIST() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_AiDeBaoBao_FRESH_LIST,bytebuff);
      }
      
      public static function CG_AiDeBaoBao_YongBao(id:Number, zoneId:int) : void
      {
         bytebuff.length = 0;
         Utils.print("A申请抱B,B>",id);
         LongUtil.writeLong(bytebuff,id);
         bytebuff.writeInt(zoneId);
         SocketManager.send(MessageType.CG_AiDeBaoBao_YongBao,bytebuff);
      }
      
      public static function CG_AiDeBaoBao_REQUEST(flag:int, id:Number, zoneId:int) : void
      {
         bytebuff.length = 0;
         Utils.print("B接受不>A>",flag,id);
         bytebuff.writeByte(flag);
         LongUtil.writeLong(bytebuff,id);
         bytebuff.writeInt(zoneId);
         SocketManager.send(MessageType.CG_AiDeBaoBao_REQUEST,bytebuff);
      }
      
      public static function CG_AiDeBaoBao_REQUEST_2(id:Number, zoneId:int) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,id);
         bytebuff.writeInt(zoneId);
         SocketManager.send(MessageType.CG_AiDeBaoBao_REQUEST_2,bytebuff);
      }
      
      public static function CG_AiDeBaoBao_RELIEVE() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_AiDeBaoBao_RELIEVE,bytebuff);
      }
      
      public static function CG_AiDeBaoBao_EXIT() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_AiDeBaoBao_EXIT,bytebuff);
      }
      
      public static function CG_AiDeBaoBao_ROOM_MENU() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_AiDeBaoBao_ROOM_MENU,bytebuff);
      }
      
      public static function CG_AiDeBaoBao_CHANGE_ROOM(id:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(id);
         SocketManager.send(MessageType.CG_AiDeBaoBao_CHANGE_ROOM,bytebuff);
      }
      
      public static function CG_AiDeBaoBao_JOIN_SECOND_HALF() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_AiDeBaoBao_JOIN_SECOND_HALF,bytebuff);
      }
      
      public static function CG_AiDeBaoBao_ARRIVE_END() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_AiDeBaoBao_ARRIVE_END,bytebuff);
      }
      
      public static function CG_AiDeBaoBao_SKILL_BUFF(skillId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(skillId);
         SocketManager.send(MessageType.CG_AiDeBaoBao_SKILL_BUFF,bytebuff);
      }
      
      public static function CG_AiDeBaoBao_SKILL_CAST(targetId:Number, skillId:int, zoneId:int) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,targetId);
         bytebuff.writeByte(skillId);
         bytebuff.writeInt(zoneId);
         SocketManager.send(MessageType.CG_AiDeBaoBao_SKILL_CAST,bytebuff);
      }
      
      public static function CG_AiDeBaoBao_RETURN_TO_BEGIN() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_AiDeBaoBao_RETURN_TO_BEGIN,bytebuff);
      }
      
      public static function CG_AiDeBaoBao_GUIDE() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_AiDeBaoBao_GUIDE,bytebuff);
      }
      
      public static function CG_AiDeBaoBao_SOCKET() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_AiDeBaoBao_SOCKET,bytebuff);
      }
      
      public static function CG_AiDeBaoBao_CHECK_POSITION(x:int, y:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeShort(x);
         bytebuff.writeShort(y);
         SocketManager.send(MessageType.CG_AiDeBaoBao_CHECK_POSITION,bytebuff);
      }
   }
}

