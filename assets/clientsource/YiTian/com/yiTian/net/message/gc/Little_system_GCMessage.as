package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.Little_system_Handler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class Little_system_GCMessage
   {
      
      public function Little_system_GCMessage(index:Array)
      {
         super();
         index[MessageType.GC_CHIP_GIFT] = this.GC_CHIP_GIFT;
         index[MessageType.GC_CHIP_TASK_INIT] = this.GC_CHIP_TASK_INIT;
         index[MessageType.GC_CHIP_TASK_UPDATE] = this.GC_CHIP_TASK_UPDATE;
         index[MessageType.GC_SERVER_TIME] = this.GC_SERVER_TIME;
         index[MessageType.GC_CHIP_TASK_TYPE] = this.GC_CHIP_TASK_TYPE;
      }
      
      public function GC_SERVER_TIME(patch:IDataInput) : void
      {
         var time:int = patch.readInt();
         Little_system_Handler.GC_SERVER_TIME(time);
      }
      
      public function GC_CHIP_GIFT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var id_chip:int = patch.readByte();
         var jieMiflag:int = patch.readByte();
         Little_system_Handler.GC_CHIP_GIFT(result,id_chip,jieMiflag);
      }
      
      public function GC_CHIP_TASK_INIT(patch:IDataInput) : void
      {
         var i:int = 0;
         var len:int = patch.readByte();
         var vec_task:Vector.<int> = new Vector.<int>();
         i = 0;
         while(i < len)
         {
            vec_task.push(patch.readShort());
            vec_task.push(patch.readShort());
            i++;
         }
         var len2:int = patch.readByte();
         var vec_gift:Vector.<int> = new Vector.<int>();
         var i2:int = 0;
         while(i2 < len2)
         {
            vec_gift.push(patch.readByte());
            i2++;
         }
         Little_system_Handler.GC_CHIP_TASK_INIT(vec_task,vec_gift);
      }
      
      public function GC_CHIP_TASK_UPDATE(patch:IDataInput) : void
      {
         var id_task:int = patch.readShort();
         var state:int = patch.readShort();
         Little_system_Handler.GC_CHIP_TASK_UPDATE(id_task,state);
      }
      
      public function GC_CHIP_TASK_TYPE(patch:IDataInput) : void
      {
         Little_system_Handler.GC_CHIP_TASK_TYPE();
      }
   }
}

