package com.yiTian.net.message.cg
{
   import com.utils.LongUtil;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class PetCGMessage
   {
      
      public static var byteBuff:ByteArray = new ByteArray();
      
      public function PetCGMessage()
      {
         super();
      }
      
      public static function CG_PET_RENAMED(newName:String) : void
      {
         byteBuff.length = 0;
         byteBuff.writeUTF(newName);
         SocketManager.send(MessageType.CG_PET_RENAMED,byteBuff);
      }
      
      public static function CG_PET_ADD_QIXUE() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_PET_ADD_QIXUE,byteBuff);
      }
      
      public static function CG_PET_NEIDAN(type:int, id:int = 0) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(type);
         byteBuff.writeInt(id);
         SocketManager.send(MessageType.CG_PET_NEIDAN,byteBuff);
      }
      
      public static function CG_PET_XIZI(gridId:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(gridId);
         SocketManager.send(MessageType.CG_PET_XIZI,byteBuff);
      }
      
      public static function CG_PET_LIANHUA(gridId:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(gridId);
         SocketManager.send(MessageType.CG_PET_LIANHUA,byteBuff);
      }
      
      public static function CG_PET_OTHER_INFO(petId:Number) : void
      {
         byteBuff.length = 0;
         LongUtil.writeLong(byteBuff,petId);
         SocketManager.send(MessageType.CG_PET_OTHER_INFO,byteBuff);
      }
      
      public static function CG_PET_XILIAN(index:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(index);
         SocketManager.send(MessageType.CG_PET_XILIAN,byteBuff);
      }
      
      public static function CG_PET_JINGNENG_XILIAN(times:int, index:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(times);
         byteBuff.writeByte(index);
         SocketManager.send(MessageType.CG_PET_JINGNENG_XILIAN,byteBuff);
      }
      
      public static function CG_PET_JINGNENG_CHANGE(gridPosition:int, jiNengId:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(gridPosition);
         byteBuff.writeInt(jiNengId);
         SocketManager.send(MessageType.CG_PET_JINGNENG_CHANGE,byteBuff);
      }
      
      public static function CG_PET_BIANSHENGKA(toolId:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(toolId);
         SocketManager.send(MessageType.CG_PET_BIANSHENGKA,byteBuff);
      }
      
      public static function CG_PET_YELLOWDIAMOND_AWARD() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_PET_YELLOWDIAMOND_AWARD,byteBuff);
      }
      
      public static function CG_PET_SHOW_FASHION(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_PET_SHOW_FASHION,byteBuff);
      }
      
      public static function CG_PET_YUANXING() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_PET_YUANXING,byteBuff);
      }
      
      public static function CG_OPEN_JINGXIU() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_OPEN_JINGXIU,byteBuff);
      }
      
      public static function CG_BT_JINGXIU(type:int, index:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(type);
         byteBuff.writeInt(index);
         SocketManager.send(MessageType.CG_BT_JINGXIU,byteBuff);
      }
      
      public static function CG_BT_HUAXING() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_BT_HUAXING,byteBuff);
      }
      
      public static function CG_PET_QIANGHUA(type:int, yuanbao:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         byteBuff.writeByte(yuanbao);
         SocketManager.send(MessageType.CG_PET_QIANGHUA,byteBuff);
      }
      
      public static function CG_PET_SHENGJIE(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_PET_SHENGJIE,byteBuff);
      }
      
      public static function CG_PET_TYPE_SEND(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_PET_TYPE_SEND,byteBuff);
      }
      
      public static function CG_PET_TUPO() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_PET_TUPO,byteBuff);
      }
      
      public static function CG_PET_DANQI_ICON() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_PET_DANQI_ICON,byteBuff);
      }
      
      public static function CG_PET_SURE_NEIDAN_JINJIE(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_PET_SURE_NEIDAN_JINJIE,byteBuff);
      }
   }
}

