package com.yiTian.net.message.cg
{
   import com.utils.LongUtil;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.marriage.MarriageConfig;
   import flash.utils.ByteArray;
   
   public class MarriageCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function MarriageCGMessage()
      {
         super();
      }
      
      public static function CG_MARRIAGE_INITIATE(ringID:int) : void
      {
         if(!MarriageConfig.startUsing)
         {
            return;
         }
         bytebuff.length = 0;
         bytebuff.writeInt(ringID);
         SocketManager.send(MessageType.CG_MARRIAGE_INITIATE,bytebuff);
      }
      
      public static function CG_MARRIAGE_BREAK() : void
      {
         if(!MarriageConfig.startUsing)
         {
            return;
         }
         bytebuff.length = 0;
         bytebuff.writeInt(GameUnitManager.hero.id);
         SocketManager.send(MessageType.CG_MARRIAGE_BREAK,bytebuff);
      }
      
      public static function CG_MARRIAGE_BLESS_SEND(maleID:Number = 0, femaleID:Number = 0, type:int = 3) : void
      {
         if(!MarriageConfig.startUsing)
         {
            return;
         }
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,maleID);
         LongUtil.writeLong(bytebuff,femaleID);
         bytebuff.writeInt(type);
         SocketManager.send(MessageType.CG_MARRIAGE_BLESS_SEND,bytebuff);
      }
      
      public static function CG_MARRIAGE_BLESS_OPEN() : void
      {
         if(!MarriageConfig.startUsing)
         {
            return;
         }
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,GameUnitManager.hero.id);
         SocketManager.send(MessageType.CG_MARRIAGE_BLESS_OPEN,bytebuff);
      }
      
      public static function CG_MARRIAGE_BLESS_RESEND(id:Number, type:int, targetType:int, index:int) : void
      {
         if(!MarriageConfig.startUsing)
         {
            return;
         }
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,id);
         bytebuff.writeInt(type);
         bytebuff.writeInt(targetType);
         bytebuff.writeInt(index);
         SocketManager.send(MessageType.CG_MARRIAGE_BLESS_RESEND,bytebuff);
         CG_MARRIAGE_BLESS_OPEN();
      }
      
      public static function CG_MARRIAGE_COLLECT_BEGIN(type:int, npcID:int) : void
      {
         if(!MarriageConfig.startUsing)
         {
            return;
         }
         bytebuff.length = 0;
         bytebuff.writeInt(type);
         bytebuff.writeInt(npcID);
         SocketManager.send(MessageType.CG_MARRIAGE_COLLECT_BEGIN,bytebuff);
      }
      
      public static function CG_MARRIAGE_ADDCASHGIFT(type:int) : void
      {
         if(!MarriageConfig.startUsing)
         {
            return;
         }
         bytebuff.length = 0;
         bytebuff.writeInt(type);
         SocketManager.send(MessageType.CG_MARRIAGE_ADDCASHGIFT,bytebuff);
      }
      
      public static function CG_GETQIXIREWARD() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_GETQIXIREWARD,bytebuff);
      }
      
      public static function CG_GETLITANGREWARD() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_GETLITANGREWARD,bytebuff);
      }
      
      public static function CG_MARRIAGE_ADD() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_MARRIAGE_ADD,bytebuff);
      }
      
      public static function CG_GET_QIXI_GIFT() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_GET_QIXI_GIFT,bytebuff);
      }
   }
}

