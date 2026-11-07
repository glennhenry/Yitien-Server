package com.yiTian.net.message.cg
{
   import com.utils.LongUtil;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class GuaJiCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function GuaJiCGMessage()
      {
         super();
      }
      
      public static function CG_GUAJI_REQUEST() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_GUAJI_REQUEST,bytebuff);
      }
      
      public static function CG_GUAJI_CANCEL(name:String) : void
      {
         bytebuff.length = 0;
         bytebuff.writeUTF(name);
         SocketManager.send(MessageType.CG_GUAJI_CANCEL,bytebuff);
      }
      
      public static function CG_GUAJI_OTHERROLE_INFO(type:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(type);
         SocketManager.send(MessageType.CG_LQQD_ROOM_INFO,bytebuff);
      }
      
      public static function CG_LEAVE_LQROOM(lqType:int, rId:int, pId:Number) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(lqType);
         bytebuff.writeByte(rId);
         LongUtil.writeLong(bytebuff,pId);
         SocketManager.send(MessageType.CG_LEAVE_LQROOM,bytebuff);
      }
      
      public static function GC_GET_XINGXINGEXP() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_GET_XINGXINGEXP,bytebuff);
      }
      
      public static function CG_CHECK_LQINFO(lqType:int, roomId:int, roleId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(lqType);
         bytebuff.writeByte(roomId);
         bytebuff.writeInt(roleId);
         SocketManager.send(MessageType.CG_CHECK_LQINFO,bytebuff);
      }
      
      public static function CG_SNATCH_LQROOM(lqType:int, roomId:int, roleId:Number) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(lqType);
         bytebuff.writeByte(roomId);
         LongUtil.writeLong(bytebuff,roleId);
         SocketManager.send(MessageType.CG_SNATCH_LQROOM,bytebuff);
      }
      
      public static function CG_SHUANGXIU_REQUEST(id:Number) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,id);
         SocketManager.send(MessageType.CG_SHUANGXIU_REQUEST,bytebuff);
      }
      
      public static function CG_SHUANGXIU_REQUEST_CHOOSE(choose:int, id:Number) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(choose);
         LongUtil.writeLong(bytebuff,id);
         SocketManager.send(MessageType.CG_SHUANGXIU_REQUEST_CHOOSE,bytebuff);
      }
      
      public static function CG_CANCEL_SHUANGXIU(name:String) : void
      {
         bytebuff.length = 0;
         bytebuff.writeUTF(name);
         SocketManager.send(MessageType.CG_CANCEL_SHUANGXIU,bytebuff);
      }
      
      public static function CG_AUTOWAWASHUANGXIU(flag:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(flag);
         SocketManager.send(MessageType.CG_WAWASHUANGXIU,bytebuff);
      }
      
      public static function CG_CHANGEWAWASHUANGXIU(value:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(value);
         SocketManager.send(MessageType.CG_CHANGEWAWASHUANGXIU,bytebuff);
      }
   }
}

