package com.yiTian.net.message.gc
{
   import com.yiTian.data.vo.Vo_store;
   import com.yiTian.net.handler.StoreHandle;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class StoreGCMessage
   {
      
      public function StoreGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_PLAZA] = this.GC_PLAZA;
         index[MessageType.GC_BUY_GOODS] = this.GC_BUY_GOODS;
      }
      
      public function GC_PLAZA(patch:IDataInput) : void
      {
         var temArr:Array = null;
         var vo_store:Vo_store = null;
         var len:int = patch.readShort();
         if(len == 0)
         {
            return;
         }
         var storeArr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            temArr = [];
            vo_store = new Vo_store();
            vo_store.sign = patch.readByte();
            vo_store.position = patch.readInt();
            vo_store.wpid = patch.readInt();
            vo_store.type = patch.readByte();
            vo_store.sold_num = patch.readInt();
            vo_store.pre_price = patch.readInt();
            vo_store.now_price = patch.readInt();
            vo_store.price_type = patch.readInt();
            vo_store.job = patch.readByte();
            vo_store.left_time = patch.readInt();
            vo_store.isHot = patch.readByte();
            vo_store.init_store();
            storeArr.push(vo_store);
            i++;
         }
         storeArr.sortOn("position",Array.NUMERIC);
         StoreHandle.GC_PLAZA(storeArr);
      }
      
      public function GC_BUY_GOODS(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         StoreHandle.GC_BUY_GOODS(result);
      }
   }
}

