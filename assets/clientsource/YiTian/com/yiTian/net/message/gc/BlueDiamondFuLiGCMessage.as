package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.BlueDiamondFuliHandle;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class BlueDiamondFuLiGCMessage
   {
      
      public function BlueDiamondFuLiGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_BLUEDIAMOND_OPEN] = GC_BLUEDIAMOND_OPEN;
         index[MessageType.GC_BLUEDIAMOND_GETAWARD] = GC_BLUEDIAMOND_GETAWARD;
      }
      
      public static function GC_BLUEDIAMOND_OPEN(patch:IDataInput = null) : void
      {
         var time:int = patch.readInt();
         var len:int = patch.readByte();
         var statusArr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            statusArr.push(patch.readInt());
            i++;
         }
         BlueDiamondFuliHandle.GC_BLUEDIAMOND_OPEN(time,statusArr);
      }
      
      public static function GC_BLUEDIAMOND_GETAWARD(patch:IDataInput = null) : void
      {
         var result:int = patch.readByte();
         BlueDiamondFuliHandle.GC_BLUEDIAMOND_GETAWARD(result);
      }
   }
}

