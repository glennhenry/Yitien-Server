package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.OnlineAwardHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class OnLineAwardGCMessage
   {
      
      public function OnLineAwardGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_PCU_START] = this.GC_PCU_START;
         index[MessageType.GC_PCU_UPDATE_STATUS] = this.GC_PCU_UPDATE_STATUS;
         index[MessageType.GC_PCU_SHOW_ICON] = this.GC_PCU_SHOW_ICON;
      }
      
      public function GC_PCU_START(patch:IDataInput) : void
      {
         trace("****@@@@****");
         var status0:int = patch.readByte();
         var status1:int = patch.readByte();
         var status2:int = patch.readByte();
         var status3:int = patch.readByte();
         var status4:int = patch.readByte();
         var status5:int = patch.readByte();
         var status6:int = patch.readByte();
         var status7:int = patch.readByte();
         var status8:int = patch.readByte();
         var status9:int = patch.readByte();
         trace(status0,status1,status2,status3,status4,status5,status6,status7,status8,status9);
         OnlineAwardHandler.GC_PCU_START(status0,status1,status2,status3,status4,status5,status6,status7,status8,status9);
      }
      
      public function GC_PCU_UPDATE_STATUS(patch:IDataInput) : void
      {
         var id:int = patch.readByte();
         var status:int = patch.readByte();
         OnlineAwardHandler.GC_PCU_UPDATE_STATUS(id,status);
      }
      
      public function GC_PCU_SHOW_ICON(patch:IDataInput) : void
      {
         var status:int = patch.readByte();
         OnlineAwardHandler.GC_PCU_SHOW_ICON(status);
      }
   }
}

