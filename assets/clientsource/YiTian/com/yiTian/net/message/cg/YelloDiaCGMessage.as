package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class YelloDiaCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function YelloDiaCGMessage()
      {
         super();
      }
      
      public static function CG_YELLOWDIAMOND() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_YELLOWDIAMOND,bytebuff);
      }
      
      public static function CG_YELLOWDIAMOND_AWARD(_type:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(_type);
         SocketManager.send(MessageType.CG_YELLOWDIAMOND_AWARD,bytebuff);
      }
      
      public static function CG_OPEN_QQGIFT() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_OPEN_QQGIFT,bytebuff);
      }
      
      public static function CG_OPEN_CHITU_GIFT() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_OPEN_CHITU_GIFT,bytebuff);
      }
      
      public static function CG_GET_QQGIFT() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_GET_QQGIFT,bytebuff);
      }
      
      public static function CG_KUANGHUAN_GET_GIFT() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_KUANGHUAN_GET_GIFT,bytebuff);
      }
      
      public static function CG_OLD_PLAYERS_RETURN_GETGOODS() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_OLD_PLAYERS_RETURN_GETGOODS,bytebuff);
      }
      
      public static function CG_OPEN_SANLIU() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_OPEN_SANLIU,bytebuff);
      }
      
      public static function CG_SANLIU_AWARDS_GET() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_SANLIU_AWARDS_GET,bytebuff);
      }
      
      public static function CG_XIANSHI_GET() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_XIANSHI_GET,bytebuff);
      }
      
      public static function CG_XIANSHI_GET_3366() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_XIANSHI_GET_3366,bytebuff);
      }
      
      public static function CG_GET_AIWAN_GIFT() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_GET_AIWAN_GIFT,bytebuff);
      }
      
      public static function CG_GET_CHITU_GIFT() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_GET_CHITU_GIFT,bytebuff);
      }
      
      public static function CG_TUIJIAN_LIBAO_SEND() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_TUIJIAN_LIBAO_SEND,bytebuff);
      }
      
      public static function CG_OPEN_HONGZUAN() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_OPEN_HONGZUAN,bytebuff);
      }
      
      public static function CG_LINGQU_AWARD() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_LINGQU_AWARD,bytebuff);
      }
      
      public static function CG_GET_XINYUE_GIFT() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_GET_XINYUE_GIFT,bytebuff);
      }
      
      public static function CG_SET_XINYUE() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_SET_XINYUE,bytebuff);
      }
      
      public static function CG_ICON_HIDE_SEND() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_ICON_HIDE_SEND,bytebuff);
      }
      
      public static function CG_QQZONE_GET_GIFT() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_QQZONE_GET_GIFT,bytebuff);
      }
      
      public static function CG_APPLAY_TO_PAN() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_APPLAY_TO_PAN,bytebuff);
      }
      
      public static function CG_GET_NEWYEAR_AWARD(action:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(action);
         SocketManager.send(MessageType.CG_GET_NEWYEAR_AWARD,bytebuff);
      }
      
      public static function CG_HUANGZUAN_XF_ASK() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_HUANGZUAN_XF_ASK,bytebuff);
      }
   }
}

