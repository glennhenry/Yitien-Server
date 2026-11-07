package com.yiTian.net.message.gc
{
   import com.yiTian.Global;
   import com.yiTian.net.handler.FruitShopHandler;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.mainUIBtnContainer.Enum_mainUIBtn_hide;
   import flash.utils.IDataInput;
   
   public class FruitShopGCMessage
   {
      
      public function FruitShopGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_FRUIT_SHOP_DATA] = this.GC_FRUIT_SHOP_DATA;
         index[MessageType.GC_FRUIT_SHOP_BUY] = this.GC_FRUIT_SHOP_BUY;
         index[MessageType.GC_FRUIT_SHOP_SER_TIME] = this.GC_FRUIT_SHOP_SER_TIME;
      }
      
      public function GC_FRUIT_SHOP_DATA(patch:IDataInput) : void
      {
         var len:int = 0;
         var vo:Object = null;
         var i:int = 0;
         var num:int = 0;
         len = patch.readByte();
         FruitShopHandler.list = [];
         if(len > 0)
         {
            i = 0;
            while(i < len)
            {
               vo = new Object();
               vo.index = patch.readInt();
               num = int(vo.buyTimes = patch.readInt());
               FruitShopHandler.list.push(vo);
               i++;
            }
         }
         FruitShopHandler.GC_FRUIT_SHOP_DATA(FruitShopHandler.list);
      }
      
      public function GC_FRUIT_SHOP_BUY(patch:IDataInput) : void
      {
         var tipFlag:int = patch.readByte();
         FruitShopHandler.GC_FRUIT_SHOP_BUY(tipFlag);
      }
      
      public function GC_FRUIT_SHOP_SER_TIME(patch:IDataInput) : void
      {
         var serTime:int = patch.readInt();
         FruitShopHandler.GC_FRUIT_SHOP_SER_TIME(serTime);
         Global.control.sendNotification(Enum_mainUIBtn_hide.NOW_TIME,serTime);
      }
   }
}

