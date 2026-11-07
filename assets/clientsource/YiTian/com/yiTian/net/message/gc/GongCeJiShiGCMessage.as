package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.GongCeJiShiHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class GongCeJiShiGCMessage
   {
      
      public function GongCeJiShiGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_GCJS_SHOWPANEL] = this.GC_GCJS_SHOWPANEL;
         index[MessageType.GC_GCJS_AWARD] = this.GC_GCJS_AWARD;
      }
      
      private function GC_GCJS_SHOWPANEL(patch:IDataInput) : void
      {
         var id:int = 0;
         var curTimes:int = 0;
         var len:int = patch.readInt();
         var arr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            id = patch.readInt();
            curTimes = patch.readInt();
            arr.push(curTimes);
            i++;
         }
         GongCeJiShiHandler.GC_GCJS_SHOWPANEL(arr);
      }
      
      private function GC_GCJS_AWARD(patch:IDataInput) : void
      {
         var flag:int = patch.readInt();
         var curTimes:int = patch.readInt();
         GongCeJiShiHandler.GC_GCJS_AWARD(flag,curTimes);
      }
   }
}

