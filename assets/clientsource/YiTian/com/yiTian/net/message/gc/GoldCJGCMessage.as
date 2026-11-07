package com.yiTian.net.message.gc
{
   import com.yiTian.data.model.Model_GoldCJ;
   import com.yiTian.net.handler.GoldCJHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class GoldCJGCMessage
   {
      
      public function GoldCJGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_GOLD_CJ_LOG] = this.GC_GLOD_CJ_LOG;
         index[MessageType.GC_GOLD_CJ_START_LOTTERY] = this.GC_GLOD_CJ_START_LOTTERY;
         index[MessageType.GC_GOLD_CJ_TOTAL_LTRS] = this.GC_GLOD_CJ_TOTAL_LTRS;
         index[MessageType.GC_GOLD_CJ_LOCK_GRID] = this.GC_GLOD_CJ_LOCK_GRID;
         index[MessageType.GC_GOLD_CJ_SHOW_BTN] = this.GC_GLOD_CJ_SHOW_BTN;
      }
      
      public function GC_GLOD_CJ_LOG(patch:IDataInput) : void
      {
         var obj:Object = null;
         var num:int = patch.readByte();
         Model_GoldCJ.showInfoList = [];
         var i:int = 0;
         while(i < num)
         {
            obj = new Object();
            obj.name = patch.readUTF();
            obj.pos = patch.readByte();
            Model_GoldCJ.showInfoList.push(obj);
            i++;
         }
         GoldCJHandler.GC_GLOD_CJ_LOG(num,Model_GoldCJ.showInfoList);
      }
      
      public function GC_GLOD_CJ_START_LOTTERY(patch:IDataInput) : void
      {
         var obj:Object = null;
         var num:int = patch.readByte();
         Model_GoldCJ.rewardList = [];
         var i:int = 0;
         while(i < num)
         {
            obj = new Object();
            obj.index = patch.readByte();
            Model_GoldCJ.rewardList.push(obj);
            i++;
         }
         GoldCJHandler.GC_GLOD_CJ_START_LOTTERY(num,Model_GoldCJ.rewardList);
      }
      
      public function GC_GLOD_CJ_TOTAL_LTRS(patch:IDataInput) : void
      {
         var times:int = patch.readInt();
         var dateStr:String = patch.readUTF();
         var lockIdxS:String = patch.readUTF();
         GoldCJHandler.GC_GLOD_CJ_TOTAL_LTRS(times,dateStr,lockIdxS);
      }
      
      public function GC_GLOD_CJ_LOCK_GRID(patch:IDataInput) : void
      {
         var state:int = patch.readByte();
         var index:int = patch.readByte();
         GoldCJHandler.GC_GLOD_CJ_LOCK_GRID(state,index);
      }
      
      public function GC_GLOD_CJ_SHOW_BTN(patch:IDataInput) : void
      {
         var isShow:int = patch.readByte();
         GoldCJHandler.GC_GLOD_CJ_SHOW_BTN(isShow);
      }
   }
}

