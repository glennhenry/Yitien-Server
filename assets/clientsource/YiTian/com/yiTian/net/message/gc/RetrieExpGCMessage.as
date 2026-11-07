package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.RetrieExpHandle;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class RetrieExpGCMessage
   {
      
      public function RetrieExpGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_RETRIEEXP_INFO] = this.GC_RETRIEEXP_INFO;
         index[MessageType.GC_RETRIEEXP1] = this.GC_RETRIEEXP1;
         index[MessageType.GC_RETRIEEXP2] = this.GC_RETRIEEXP2;
      }
      
      public function GC_RETRIEEXP_INFO(patch:IDataInput) : void
      {
         var obj1:Object = null;
         var result:int = patch.readByte();
         var dailyActLeng:int = patch.readByte();
         var array:Array = new Array();
         var index:int = 0;
         while(index < dailyActLeng)
         {
            obj1 = new Object();
            obj1.type = patch.readByte();
            obj1.date = patch.readInt();
            obj1.level = patch.readShort();
            obj1.exp = patch.readInt();
            obj1.moneyCost = patch.readInt();
            obj1.silverCost = patch.readInt();
            array.push(obj1);
            index++;
         }
         var obj2:Object = new Object();
         obj2.type = patch.readByte();
         obj2.overflow = patch.readInt();
         obj2.exp = patch.readInt();
         obj2.moneyCost = patch.readInt();
         obj2.silverCost = patch.readInt();
         RetrieExpHandle.GC_RETRIEEXP_INFO(array,obj2);
      }
      
      public function GC_RETRIEEXP1(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         RetrieExpHandle.GC_RETRIEEXP1(result);
      }
      
      public function GC_RETRIEEXP2(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         RetrieExpHandle.GC_RETRIEEXP2(result);
      }
   }
}

