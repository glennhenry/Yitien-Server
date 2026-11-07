package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.ShouChongHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class ShouChongGCMessage
   {
      
      public function ShouChongGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_SHOUCHONG] = GC_SHOUCHONG;
         index[MessageType.GC_SHOUCHONG_AWARD] = GC_SHOUCHONG_AWARD;
         index[MessageType.GC_HAS_SHOUCHONG] = GC_HAS_SHOUCHONG;
      }
      
      public static function GC_SHOUCHONG(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var state:int = patch.readByte();
         ShouChongHandler.GC_SHOUCHONG(result,state);
      }
      
      public static function GC_SHOUCHONG_AWARD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         ShouChongHandler.GC_SHOUCHONG_AWARD(result);
      }
      
      public static function GC_HAS_SHOUCHONG(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var result2:int = Boolean(patch.bytesAvailable) ? patch.readByte() : 0;
         ShouChongHandler.GC_HAS_SHOUCHONG(result,result2);
      }
   }
}

