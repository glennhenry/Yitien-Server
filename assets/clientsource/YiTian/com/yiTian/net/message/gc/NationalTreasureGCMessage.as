package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.NationalTreasureHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class NationalTreasureGCMessage
   {
      
      public function NationalTreasureGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_SHOW_ICON] = this.GC_SHOW_ICON;
         index[MessageType.GC_WABAO_DATA] = this.GC_WABAO_DATA;
         index[MessageType.GC_WABAO_RESULT] = this.GC_WABAO_RESULT;
         index[MessageType.GC_GOODS_QUERY] = this.GC_GOODS_QUERY;
         index[MessageType.GC_BUY_GOODS_RESULT] = this.GC_BUY_GOODS_RESULT;
      }
      
      public function GC_SHOW_ICON(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         NationalTreasureHandler.GC_SHOW_ICON(result);
      }
      
      public function GC_WABAO_DATA(patch:IDataInput) : void
      {
         var wabaoData:String = patch.readUTF();
         var broadcastData:String = patch.readUTF();
         var jifen:int = patch.readInt();
         NationalTreasureHandler.GC_WABAO_DATA(wabaoData,broadcastData,jifen);
      }
      
      public function GC_WABAO_RESULT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         NationalTreasureHandler.GC_WABAO_RESULT(result);
      }
      
      public function GC_GOODS_QUERY(patch:IDataInput) : void
      {
         var jifen:int = patch.readInt();
         NationalTreasureHandler.GC_GOODS_QUERY(jifen);
      }
      
      public function GC_BUY_GOODS_RESULT(patch:IDataInput) : void
      {
         var jifen:int = patch.readInt();
         var result:int = patch.readByte();
         NationalTreasureHandler.GC_BUY_GOODS_RESULT(jifen,result);
      }
   }
}

