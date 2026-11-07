package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.ShouChongTiaoZhengHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class ShouChongTiaoZhengGCMessage
   {
      
      public function ShouChongTiaoZhengGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_ShouChongTiaoZheng_ICON] = this.GC_ShouChongTiaoZheng_ICON;
         index[MessageType.GC_ShouChongTiaoZheng_GET_PRIZE] = this.GC_ShouChongTiaoZheng_GET_PRIZE;
         index[MessageType.GC_ShouChongTiaoZheng_LINK] = this.GC_ShouChongTiaoZheng_LINK;
      }
      
      public function GC_ShouChongTiaoZheng_ICON(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var time:int = patch.readInt();
         var tableId:int = patch.readInt();
         var day:int = patch.readInt();
         ShouChongTiaoZhengHandler.GC_ShouChongTiaoZheng_ICON(result,tableId,time,day);
      }
      
      public function GC_ShouChongTiaoZheng_GET_PRIZE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         ShouChongTiaoZhengHandler.GC_ShouChongTiaoZheng_GET_PRIZE(result);
      }
      
      public function GC_ShouChongTiaoZheng_LINK(patch:IDataInput) : void
      {
         var tableId:int = patch.readInt();
         var time:int = patch.readInt();
         ShouChongTiaoZhengHandler.GC_ShouChongTiaoZheng_LINK(tableId,time);
      }
   }
}

