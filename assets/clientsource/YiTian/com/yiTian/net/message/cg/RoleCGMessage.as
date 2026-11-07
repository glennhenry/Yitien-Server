package com.yiTian.net.message.cg
{
   import com.utils.LongUtil;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.newRolePan.ComparePan;
   import com.yiTian.view.modules.wuXing.WuXingMter;
   import flash.utils.ByteArray;
   
   public class RoleCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public static const BAG_ROLE:int = 1;
      
      public static const ROLE_BAG:int = 2;
      
      public static const KEY_RIDE:int = 3;
      
      public function RoleCGMessage()
      {
         super();
      }
      
      public static function CG_ROLE_SWAP(label:int, gridId:int, role_gridId:int = 0) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(label);
         bytebuff.writeShort(gridId);
         bytebuff.writeByte(role_gridId);
         SocketManager.send(MessageType.CG_ROLE_SWAP,bytebuff);
      }
      
      public static function CG_MERIDIAN_UP(type:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(type);
         SocketManager.send(MessageType.CG_MERIDIAN_UP,bytebuff);
      }
      
      public static function CG_MERIDIAN_INIT() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_MERIDIAN_INIT,bytebuff);
      }
      
      public static function CG_MERIDIAN_PILL(gridId:int, isYB:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeShort(gridId);
         bytebuff.writeByte(isYB);
         SocketManager.send(MessageType.CG_MERIDIAN_PILL,bytebuff);
      }
      
      public static function CG_CHECK_OTHERROLE(roleId:Number) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,roleId);
         WuXingMter.getPan(ComparePan,function(pan:ComparePan):void
         {
            pan.showTitle(-1);
         });
         bytebuff.writeInt(roleId);
         SocketManager.send(MessageType.CG_CHECK_OTHERROLE,bytebuff);
      }
      
      public static function CG_HERO_TITLE() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_HERO_TITLE,bytebuff);
      }
      
      public static function CG_BUTTON_CBBS(name:String, type:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeUTF(name);
         bytebuff.writeByte(type);
         SocketManager.send(MessageType.CG_BUTTON_CBBS,bytebuff);
      }
      
      public static function GC_DIAOXIANG_CLICK(id:Number) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,id);
         SocketManager.send(MessageType.GC_DIAOXIANG_CLICK,bytebuff);
      }
      
      public static function CG_PAIHANG_CLICK(name:String, type:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeUTF(name);
         bytebuff.writeByte(type);
         SocketManager.send(MessageType.CG_PAIHANG_CLICK,bytebuff);
      }
      
      public static function CG_NAME_CLICK(name:String) : void
      {
         bytebuff.length = 0;
         bytebuff.writeUTF(name);
         SocketManager.send(MessageType.CG_NAME_CLICK,bytebuff);
      }
      
      public static function CG_ROLE_FASHION() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_ROLE_FASHION,bytebuff);
      }
      
      public static function CG_LIGHT_FASHION(type:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(type);
         SocketManager.send(MessageType.CG_LIGHT_FASHION,bytebuff);
      }
      
      public static function CG_DRESS_FASHION(type:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(type);
         SocketManager.send(MessageType.CG_DRESS_FASHION,bytebuff);
      }
      
      public static function CG_CHECK_OTHER_NEW(roleId:Number) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,roleId);
         SocketManager.send(MessageType.CG_CHECK_OTHER_NEW,bytebuff);
      }
   }
}

