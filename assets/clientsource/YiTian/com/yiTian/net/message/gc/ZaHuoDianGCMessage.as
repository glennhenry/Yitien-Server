package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.ZaHuoDianHandle;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class ZaHuoDianGCMessage
   {
      
      private static var i_index:int = 0;
      
      private static var ii_index:int = 0;
      
      public function ZaHuoDianGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_ZAHUODIAN_QUERY] = this.GC_ZAHUODIAN_QUERY;
         index[MessageType.GC_ZAHUODIAN_BUY] = this.GC_ZAHUODIAN_BUY;
         index[MessageType.GC_ZAHUODIAN_SELL] = this.GC_ZAHUODIAN_SELL;
      }
      
      public function GC_ZAHUODIAN_QUERY(patch:IDataInput) : void
      {
         var array_SHOPITEM:Array = null;
         var goods_len:int = patch.readShort();
         var goods:Array = [];
         i_index = 0;
         while(i_index < goods_len)
         {
            array_SHOPITEM = [];
            array_SHOPITEM.push(patch.readInt());
            array_SHOPITEM.push(patch.readInt());
            array_SHOPITEM.push(patch.readByte());
            array_SHOPITEM.push(patch.readInt());
            goods.push(array_SHOPITEM);
            ++i_index;
         }
         ZaHuoDianHandle.GC_ZAHUODIAN_QUERY(goods,goods_len);
      }
      
      public function GC_ZAHUODIAN_BUY(patch:IDataInput) : void
      {
         var resule:int = patch.readByte();
         ZaHuoDianHandle.GC_ZAHUODIAN_BUY(resule);
      }
      
      public function GC_ZAHUODIAN_SELL(patch:IDataInput) : void
      {
         var resule:int = patch.readByte();
         ZaHuoDianHandle.GC_ZAHUODIAN_SELL(resule);
      }
   }
}

