package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.net.handler.LFlowerHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class LFlowerGCMessage
   {
      
      public function LFlowerGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_IFLOWER_OPEN] = this.GC_IFLOWER_OPEN;
         index[MessageType.GC_IFLOWER_WY] = this.GC_IFLOWER_WY;
         index[MessageType.GC_IFLOWER_BROCAST] = this.GC_IFLOWER_BROCAST;
         index[MessageType.GC_IFLOWER_INVITE] = this.GC_IFLOWER_INVITE;
         index[MessageType.GC_IFLOWER_INVITE_N] = this.GC_IFLOWER_INVITE_N;
      }
      
      private function GC_IFLOWER_OPEN(patch:IDataInput) : void
      {
         var currentCZ:int = patch.readInt();
         var nextCZ:int = patch.readInt();
         var cd:int = patch.readInt();
         LFlowerHandler.GC_IFLOWER_OPEN(currentCZ,nextCZ,cd);
      }
      
      private function GC_IFLOWER_WY(patch:IDataInput) : void
      {
         var relute:int = patch.readByte();
         LFlowerHandler.GC_IFLOWER_WY(relute);
      }
      
      private function GC_IFLOWER_BROCAST(patch:IDataInput) : void
      {
         var id_1:Number = LongUtil.readLong(patch);
         var rn_1:String = patch.readUTF();
         var id_2:Number = LongUtil.readLong(patch);
         var rn_2:String = patch.readUTF();
         LFlowerHandler.GC_IFLOWER_BROCAST(id_1,rn_1,id_2,rn_2);
      }
      
      private function GC_IFLOWER_INVITE(patch:IDataInput) : void
      {
         LFlowerHandler.GC_IFLOWER_INVITE();
      }
      
      private function GC_IFLOWER_INVITE_N(patch:IDataInput) : void
      {
         LFlowerHandler.GC_IFLOWER_INVITE_N();
      }
   }
}

