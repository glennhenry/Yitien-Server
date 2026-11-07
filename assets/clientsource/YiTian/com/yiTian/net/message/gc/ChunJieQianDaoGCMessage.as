package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.ChunJieQianDaoHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class ChunJieQianDaoGCMessage
   {
      
      public function ChunJieQianDaoGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_ChunJieQianDao_ICON] = this.GC_ChunJieQianDao_ICON;
         index[MessageType.GC_ChunJieQianDao_Fresh] = this.GC_ChunJieQianDao_Fresh;
         index[MessageType.GC_ChunJieQianDao_SIGN] = this.GC_ChunJieQianDao_SIGN;
         index[MessageType.GC_ChunJieQianDao_GET_PRIZE] = this.GC_ChunJieQianDao_GET_PRIZE;
      }
      
      private function GC_ChunJieQianDao_ICON(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         ChunJieQianDaoHandler.GC_ChunJieQianDao_ICON(result);
      }
      
      private function GC_ChunJieQianDao_Fresh(patch:IDataInput) : void
      {
         var len:int = patch.readByte();
         var signArr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            signArr.push(patch.readByte());
            i++;
         }
         var today:int = patch.readByte();
         var count:int = patch.readByte();
         var btnStatus:int = patch.readByte();
         ChunJieQianDaoHandler.GC_ChunJieQianDao_Fresh(signArr,today,count,btnStatus);
      }
      
      private function GC_ChunJieQianDao_SIGN(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         ChunJieQianDaoHandler.GC_ChunJieQianDao_SIGN(result);
      }
      
      private function GC_ChunJieQianDao_GET_PRIZE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         ChunJieQianDaoHandler.GC_ChunJieQianDao_GET_PRIZE(result);
      }
   }
}

