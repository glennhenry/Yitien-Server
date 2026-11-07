package com.yiTian.net.handler
{
   import com.yiTian.net.message.cg.MarriageCGMessage;
   
   public class MarriageHandler
   {
      
      public function MarriageHandler()
      {
         super();
      }
      
      public static function CG_MARRIAGE_INITIATE(type:int) : void
      {
         MarriageCGMessage.CG_MARRIAGE_INITIATE(type);
      }
      
      public static function CG_MARRIAGE_ADDCASHGIFT(type:int) : void
      {
         MarriageCGMessage.CG_MARRIAGE_ADDCASHGIFT(type);
      }
      
      public static function CG_MARRIAGE_COLLECT_BEGIN(type:int, npcID:int) : void
      {
         MarriageCGMessage.CG_MARRIAGE_COLLECT_BEGIN(type,npcID);
      }
      
      public static function CG_MARRIAGE_BREAK() : void
      {
         MarriageCGMessage.CG_MARRIAGE_BREAK();
      }
      
      public static function CG_MARRIAGE_BLESS_SEND(maleID:Number = 0, femaleID:Number = 0, type:int = 3) : void
      {
         MarriageCGMessage.CG_MARRIAGE_BLESS_SEND(maleID,femaleID,type);
      }
      
      public static function CG_MARRIAGE_BLESS_OPEN() : void
      {
         MarriageCGMessage.CG_MARRIAGE_BLESS_OPEN();
      }
      
      public static function CG_MARRIAGE_BLESS_RESEND(id:Number, type:int, targetType:int, index:int) : void
      {
         MarriageCGMessage.CG_MARRIAGE_BLESS_RESEND(id,type,targetType,index);
      }
   }
}

