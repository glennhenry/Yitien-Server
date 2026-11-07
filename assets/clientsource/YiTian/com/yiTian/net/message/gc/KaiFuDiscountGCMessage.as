package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.KaiFuDiscountHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class KaiFuDiscountGCMessage
   {
      
      public function KaiFuDiscountGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_KAIFU_DISCOUNT_INFO] = this.GC_KAIFU_DISCOUNT;
         index[MessageType.GC_KAIFU_GEM_INLAY] = this.GC_KAIFU_GEM;
         index[MessageType.GC_KAIFU_GIFT_INFO] = this.GC_KAIFU_GIFT;
         index[MessageType.GC_KAIFU_GEM_REST] = this.GC_KAIFU_GEM_REST;
         index[MessageType.GC_KAIFU_CARD_INFO] = this.GC_OPEN_DISCOUNT_VIEW;
      }
      
      private function GC_KAIFU_DISCOUNT(patch:IDataInput) : void
      {
         var openFlag:int = patch.readByte();
         KaiFuDiscountHandler.GC_KAIFU_DISCOUNT(openFlag);
      }
      
      private function GC_KAIFU_GEM(patch:IDataInput) : void
      {
         var count:int = 0;
         var state:int = 0;
         var counts:Array = [];
         var states:Array = [];
         var len:int = patch.readByte();
         var i:int = 0;
         while(i < len)
         {
            count = patch.readByte();
            state = patch.readByte();
            counts.push(count);
            states.push(state);
            i += 1;
         }
         KaiFuDiscountHandler.GC_KAIFU_GEM(counts,states);
      }
      
      private function GC_KAIFU_GIFT(patch:IDataInput) : void
      {
         var remain:int = 0;
         var remains:Array = [];
         var i:int = 0;
         while(i < 4)
         {
            remain = patch.readByte();
            remains.push(remain);
            i += 1;
         }
         KaiFuDiscountHandler.GC_KAIFU_GIFT(remains);
      }
      
      private function GC_KAIFU_GEM_REST(patch:IDataInput) : void
      {
         var moduleType:int = patch.readByte();
         var rest:int = patch.readByte();
         var index:int = patch.readByte();
         KaiFuDiscountHandler.GC_KAIFU_GEM_REST(moduleType,rest,index);
      }
      
      private function GC_OPEN_DISCOUNT_VIEW(patch:IDataInput) : void
      {
         var rest:int = patch.readByte();
         KaiFuDiscountHandler.GC_OPEN_DISCOUNT_VIEW(rest);
      }
   }
}

