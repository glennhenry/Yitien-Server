package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.ShiZhuangSuiPianHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class ShiZhuangSuiPianGCMessage
   {
      
      public function ShiZhuangSuiPianGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_ShiZhuangSuiPian_OPEN] = this.GC_ShiZhuangSuiPian_OPEN;
         index[MessageType.GC_ShiZhuangSuiPian_BUY] = this.GC_ShiZhuangSuiPian_BUY;
      }
      
      public function GC_ShiZhuangSuiPian_OPEN(patch:IDataInput) : void
      {
         var piecesCount:int = patch.readInt();
         trace("126002>> 碎片数:",piecesCount);
         ShiZhuangSuiPianHandler.OpenMenu(piecesCount);
      }
      
      public function GC_ShiZhuangSuiPian_BUY(patch:IDataInput) : void
      {
         var id:int = patch.readInt();
         var status:int = patch.readByte();
         var piecesCount:int = patch.readInt();
         trace("126004>> 时装ID:",id,"购买状态:",status,"剩余碎片:",piecesCount);
         ShiZhuangSuiPianHandler.SetResult(id,status,piecesCount);
      }
   }
}

