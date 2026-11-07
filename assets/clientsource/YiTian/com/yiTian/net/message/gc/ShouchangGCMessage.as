package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.ShouchangHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class ShouchangGCMessage
   {
      
      public function ShouchangGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_SHOW_SHOUCHANG_ICON] = this.GC_SHOW_SHOUCHANG_ICON;
         index[MessageType.GC_SHOUCHANG] = this.GC_SHOUCHANG;
      }
      
      public function GC_SHOW_SHOUCHANG_ICON(patch:IDataInput) : void
      {
         ShouchangHandler.GC_SHOW_SHOUCHANG_ICON();
      }
      
      public function GC_SHOUCHANG(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         ShouchangHandler.GC_SHOUCHANG(result);
      }
   }
}

