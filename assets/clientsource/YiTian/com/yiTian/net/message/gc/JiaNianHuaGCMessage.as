package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.JiaNianHuaHandle;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class JiaNianHuaGCMessage
   {
      
      public function JiaNianHuaGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_JiaNianHua_ICON] = this.GC_JiaNianHua_ICON;
         index[MessageType.GC_JiaNianHua_OPEN] = this.GC_JiaNianHua_OPEN;
         index[MessageType.GC_JiaNianHua_GET] = this.GC_JiaNianHua_GET;
         index[MessageType.GC_JiaNianHua_ICON_2] = this.GC_JiaNianHua_ICON_2;
         index[MessageType.GC_JiaNianHua_OPEN_2] = this.GC_JiaNianHua_OPEN_2;
         index[MessageType.GC_JiaNianHua_GET_2] = this.GC_JiaNianHua_GET_2;
      }
      
      public function GC_JiaNianHua_ICON(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var time:int = 0;
         if(Boolean(patch.bytesAvailable))
         {
            time = patch.readInt();
         }
         JiaNianHuaHandle.GC_JiaNianHua_ICON(result,time);
      }
      
      public function GC_JiaNianHua_OPEN(patch:IDataInput) : void
      {
         var money:int = patch.readInt();
         var btnStatus:int = patch.readByte();
         JiaNianHuaHandle.GC_JiaNianHua_OPEN(money,btnStatus);
      }
      
      public function GC_JiaNianHua_GET(patch:IDataInput) : void
      {
         JiaNianHuaHandle.GC_JiaNianHua_GET(patch.readByte());
      }
      
      public function GC_JiaNianHua_ICON_2(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var time:int = 0;
         if(Boolean(patch.bytesAvailable))
         {
            time = patch.readInt();
         }
         JiaNianHuaHandle.GC_JiaNianHua_ICON_2(result,time);
      }
      
      public function GC_JiaNianHua_OPEN_2(patch:IDataInput) : void
      {
         var money:int = patch.readInt();
         var btnStatus:int = patch.readByte();
         JiaNianHuaHandle.GC_JiaNianHua_OPEN_2(money,btnStatus);
      }
      
      public function GC_JiaNianHua_GET_2(patch:IDataInput) : void
      {
         JiaNianHuaHandle.GC_JiaNianHua_GET_2(patch.readByte());
      }
   }
}

