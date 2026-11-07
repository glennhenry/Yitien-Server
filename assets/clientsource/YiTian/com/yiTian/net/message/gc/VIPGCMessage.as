package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.VIPHandle;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class VIPGCMessage
   {
      
      public function VIPGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_VIP_OPEN] = this.GC_VIP_OPEN;
         index[MessageType.GC_BUY_VIP] = this.GC_BUY_VIP;
         index[MessageType.GC_GET_VIP_YIQUAN] = this.GC_GET_VIP_YIQUAN;
         index[MessageType.GC_SHOW_VIP_SERVER_ICON] = this.GC_SHOW_VIP_SERVER_ICON;
         index[MessageType.GC_SAVE_VIP_SERVER_INFO] = this.GC_SAVE_VIP_SERVER_INFO;
      }
      
      public function GC_VIP_OPEN(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var leftDays:int = patch.readShort();
         var data:Vector.<int> = new Vector.<int>(3,true);
         var i:int = 0;
         while(i < 3)
         {
            data[i] = patch.readByte();
            i++;
         }
         VIPHandle.GC_VIP_OPEN(result,leftDays,data);
      }
      
      public function GC_BUY_VIP(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         VIPHandle.GC_BUY_VIP(result);
      }
      
      public function GC_GET_VIP_YIQUAN(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         VIPHandle.GC_GET_VIP_YIQUAN(result);
      }
      
      public function GC_SHOW_VIP_SERVER_ICON(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         VIPHandle.GC_SHOW_VIP_SERVER_ICON(result);
      }
      
      public function GC_SAVE_VIP_SERVER_INFO(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         VIPHandle.GC_SAVE_VIP_SERVER_INFO(result);
      }
   }
}

