package com.yiTian.net.message.cg
{
   import com.utils.LongUtil;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class BabyCGMessage
   {
      
      private static var bytebuff:ByteArray = new ByteArray();
      
      public function BabyCGMessage()
      {
         super();
      }
      
      public static function CG_START_TO_LY(type:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(type);
         SocketManager.send(MessageType.CG_START_TO_LY,bytebuff);
      }
      
      public static function CG_CLICK_TO_TUOGUAN() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_CLICK_TO_TUOGUAN,bytebuff);
      }
      
      public static function CG_PANGHANG_BABY() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_PANGHANG_BABY,bytebuff);
      }
      
      public static function CG_OPEN_BABY_PAN() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_OPEN_BABY_PAN,bytebuff);
      }
      
      public static function CG_USE_MEILI_BOTTLE() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_USE_MEILI_BOTTLE,bytebuff);
      }
      
      public static function CG_BABY_PEIYANG_ISFIRST(type:uint) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(type);
         SocketManager.send(MessageType.CG_BABY_PEIYANG_ISFIRST,bytebuff);
      }
      
      public static function CG_PEIYANGBABY(type:uint, lvl:uint) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(type);
         bytebuff.writeByte(lvl);
         SocketManager.send(MessageType.CG_PEIYANGBABY,bytebuff);
      }
      
      public static function CG_BRING_BABY_OUT(id:Number) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,id);
         SocketManager.send(MessageType.CG_BRING_BABY_OUT,bytebuff);
      }
      
      public static function CG_ISFUMO(_type:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(_type);
         SocketManager.send(MessageType.CG_ISFUMO,bytebuff);
      }
      
      public static function CG_RENAME_BABY(name:String) : void
      {
         bytebuff.length = 0;
         bytebuff.writeUTF(name);
         SocketManager.send(MessageType.CG_RENAME_BABY,bytebuff);
         UIManager.centerBroadcast.addMsg("修改成功",1);
      }
      
      public static function CG_BABY_ADD_WUGONG(skillId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(skillId);
         SocketManager.send(MessageType.CG_BABY_ADD_WUGONG,bytebuff);
      }
      
      public static function CG_UPLOAD_WUGONG(skillId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(skillId);
         SocketManager.send(MessageType.CG_UPLOAD_WUGONG,bytebuff);
      }
   }
}

