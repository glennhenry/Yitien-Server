package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.FangXinHuiJiaHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class FangXinHuiJiaGCMessage
   {
      
      public function FangXinHuiJiaGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_FangXinHuiJia_ICON] = this.GC_FangXinHuiJia_ICON;
         index[MessageType.GC_FangXinHuiJia_Fresh] = this.GC_FangXinHuiJia_Fresh;
         index[MessageType.GC_FangXinHuiJia_GET_PRIZE] = this.GC_FangXinHuiJia_GET_PRIZE;
      }
      
      private function GC_FangXinHuiJia_ICON(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         FangXinHuiJiaHandler.GC_FangXinHuiJia_ICON(result);
      }
      
      private function GC_FangXinHuiJia_Fresh(patch:IDataInput) : void
      {
         var show1:int = patch.readByte();
         var show2:int = patch.readByte();
         var day:int = patch.readInt();
         var btnStatus:int = patch.readByte();
         FangXinHuiJiaHandler.GC_FangXinHuiJia_Fresh(show1,show2,day,btnStatus);
      }
      
      private function GC_FangXinHuiJia_GET_PRIZE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         FangXinHuiJiaHandler.GC_FangXinHuiJia_GET_PRIZE(result);
      }
   }
}

