package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.WanJiaZhaoHuiHandle;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class WanJiaZhaoHuiGCMessage
   {
      
      public function WanJiaZhaoHuiGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_WJZH_SHOWPANEL] = this.GC_WJZH_SHOWPANEL;
         index[MessageType.GC_WJZH_AWARD] = this.GC_WJZH_AWARD;
      }
      
      private function GC_WJZH_SHOWPANEL(patch:IDataInput) : void
      {
         var statusArr:Array = [];
         var i:int = 0;
         while(i < 5)
         {
            statusArr.push(patch.readByte());
            i++;
         }
         var num:int = patch.readInt();
         WanJiaZhaoHuiHandle.GC_WJZH_SHOWPANEL(statusArr,num);
      }
      
      private function GC_WJZH_AWARD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         WanJiaZhaoHuiHandle.GC_WJZH_AWARD(result);
      }
   }
}

