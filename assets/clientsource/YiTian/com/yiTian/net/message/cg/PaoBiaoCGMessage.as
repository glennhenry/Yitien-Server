package com.yiTian.net.message.cg
{
   import com.utils.LongUtil;
   import com.yiTian.gameUnit.role.Player;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.handler.PaoBiaoHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class PaoBiaoCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function PaoBiaoCGMessage()
      {
         super();
      }
      
      public static function CG_YUNSONG(id:int, baoXian:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(id);
         bytebuff.writeByte(baoXian);
         SocketManager.send(MessageType.CG_YUNSONG,bytebuff);
      }
      
      public static function CG_JIEBIAO(id:Number) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,id);
         SocketManager.send(MessageType.CG_JIEBIAO,bytebuff);
      }
      
      public static function CG_YUNSONG_TIMES() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_YUNSONG_TIMES,bytebuff);
      }
      
      public static function CG_ZHI_BIAO(flag:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(flag);
         SocketManager.send(MessageType.CG_ZHI_BIAO,bytebuff);
      }
      
      public static function CG_JIE_BIAO_BEFORE(player:Player) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,player.id);
         SocketManager.send(MessageType.CG_JIE_BIAO_BEFORE,bytebuff);
         PaoBiaoHandler.paoBiaoPlayer = player;
      }
   }
}

