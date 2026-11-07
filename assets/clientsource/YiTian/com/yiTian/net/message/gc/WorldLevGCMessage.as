package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.WorldLevHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class WorldLevGCMessage
   {
      
      public function WorldLevGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_WORLD_LEVEL] = this.GC_WORLD_LEVEL;
         index[MessageType.GC_WL_REWARD] = this.GC_WL_REWARD;
         index[MessageType.GC_WL_REWARD_FAILURE] = this.GC_WL_REWARD_FAILURE;
      }
      
      public function GC_WORLD_LEVEL(patch:IDataInput) : void
      {
         var level:int = patch.readShort();
         WorldLevHandler.GC_WORLD_LEVEL(level);
      }
      
      public function GC_WL_REWARD(patch:IDataInput) : void
      {
         var item:Array = null;
         var len:int = patch.readByte();
         var rewardData:Array = [];
         var i:int = 0;
         while(i < len)
         {
            item = [];
            item.push(patch.readByte());
            item.push(patch.readInt());
            item.push(patch.readByte());
            rewardData.push(item);
            i++;
         }
         WorldLevHandler.GC_WL_REWARD(rewardData);
      }
      
      public function GC_WL_REWARD_FAILURE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         WorldLevHandler.GC_WL_REWARD_FAILURE(result);
      }
   }
}

