package com.yiTian.net.message.cg
{
   import com.utils.LongUtil;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.huaShanLunJian.util.Child_HuaShanZhenXingRole;
   import flash.utils.ByteArray;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class HuaShanCGMessage
   {
      
      private static var lastTimeOutIndex:int;
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function HuaShanCGMessage()
      {
         super();
      }
      
      public static function CG_HS_INFO() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_HS_INFO,bytebuff);
      }
      
      public static function CG_HS_COMMIT() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_HS_COMMIT,bytebuff);
      }
      
      public static function CG_HS_GET_RANKS_INFO(bangType:int, pageIndex:int, type:int = 1) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(bangType);
         bytebuff.writeByte(pageIndex);
         bytebuff.writeByte(type);
         SocketManager.send(MessageType.CG_HS_GET_RANKS_INFO,bytebuff);
      }
      
      public static function CG_HS_TEAM(teamInfoArr:Array) : void
      {
         var role:Child_HuaShanZhenXingRole = null;
         var __x:int = 0;
         var __y:int = 0;
         var posIndex:int = 0;
         bytebuff.length = 0;
         var len:int = int(teamInfoArr.length);
         bytebuff.writeByte(len);
         var i:int = 0;
         while(i < len)
         {
            role = teamInfoArr[i];
            __x = role.xIndex + 1;
            __y = role.yIndex + 1;
            posIndex = __x + __y * 10;
            bytebuff.writeByte(role.type);
            LongUtil.writeLong(bytebuff,role.TID);
            bytebuff.writeByte(posIndex);
            i += 1;
         }
         SocketManager.send(MessageType.CG_HS_TEAM,bytebuff);
      }
      
      public static function CG_HS_TEAMREQ() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_HS_TEAMREQ,bytebuff);
      }
      
      public static function CG_XUANBAMATCHINFO(jie:int, bangType:int) : void
      {
         if(lastTimeOutIndex != 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("29374",2));
            return;
         }
         lastTimeOutIndex = setTimeout(function():void
         {
            clearTimeout(lastTimeOutIndex);
            lastTimeOutIndex = 0;
         },1800);
         bytebuff.length = 0;
         bytebuff.writeShort(jie);
         bytebuff.writeByte(bangType);
         SocketManager.send(MessageType.CG_XUANBAMATCHINFO,bytebuff);
      }
      
      public static function CG_XUANBABET(jie:int, bang:int, lun:int, roleId:Number, roleName:String, itemType:int, value:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeShort(jie);
         bytebuff.writeByte(bang);
         bytebuff.writeByte(lun);
         LongUtil.writeLong(bytebuff,roleId);
         bytebuff.writeUTF(roleName);
         bytebuff.writeByte(itemType);
         bytebuff.writeByte(value);
         SocketManager.send(MessageType.CG_XUANBABET,bytebuff);
      }
      
      public static function CG_HS_WATCHBATTLE1(id1:Number, id2:Number, battleTime:int) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,id1);
         LongUtil.writeLong(bytebuff,id2);
         bytebuff.writeInt(battleTime);
         SocketManager.send(MessageType.CG_HS_WATCHBATTLE1,bytebuff);
      }
      
      public static function CG_SHENJIABANG(jie:int, bangType:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeShort(jie);
         bytebuff.writeByte(bangType);
         SocketManager.send(MessageType.CG_SHENJIABANG,bytebuff);
      }
      
      public static function CG_MYXUANBABET(jie:int, bangType2:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeShort(jie);
         bytebuff.writeByte(bangType2);
         SocketManager.send(MessageType.CG_MYXUANBABET,bytebuff);
      }
      
      public static function CG_HS_OPEN_BLESSUI(jie:int, bangType2:int, lun:int, chang:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeShort(jie);
         bytebuff.writeByte(bangType2);
         bytebuff.writeByte(lun);
         bytebuff.writeByte(chang);
         SocketManager.send(MessageType.CG_HS_OPEN_BLESSUI,bytebuff);
      }
      
      public static function CG_BLESS_ROLE(jie:int, bang:int, lun:int, roleID:Number, chooseIndex:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeShort(jie);
         bytebuff.writeByte(bang);
         bytebuff.writeByte(lun);
         LongUtil.writeLong(bytebuff,roleID);
         bytebuff.writeByte(chooseIndex);
         SocketManager.send(MessageType.CG_BLESS_ROLE,bytebuff);
      }
      
      public static function CG_HS_BLESS_RANK(jie:int, bang:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeShort(jie);
         bytebuff.writeByte(bang);
         SocketManager.send(MessageType.CG_HS_BLESS_RANK,bytebuff);
      }
      
      public static function CG_HS_MY_BLESSING(jie:int, bang:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeShort(jie);
         bytebuff.writeByte(bang);
         SocketManager.send(MessageType.CG_HS_MY_BLESSING,bytebuff);
      }
   }
}

