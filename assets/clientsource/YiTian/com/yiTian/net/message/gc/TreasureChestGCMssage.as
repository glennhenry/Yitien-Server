package com.yiTian.net.message.gc
{
   import com.yiTian.data.model.Model_farm;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class TreasureChestGCMssage
   {
      
      public function TreasureChestGCMssage(index:Array)
      {
         super();
         index[MessageType.gc_buySeed_data_basic] = this.gc_buySeed_data_basic;
      }
      
      private function gc_fruit_exchange_resource(patch:IDataInput) : void
      {
         var resourceNum:int = 0;
         if(!UIManager.farm)
         {
            return;
         }
         var value:uint = uint(patch.readByte());
         if(value == 1)
         {
            resourceNum = int(patch.readUTF());
            UIManager.farm.updateFarmMaster(Model_farm.currentFarmId);
            if(Boolean(UIManager.treasureChest))
            {
               UIManager.treasureChest.update();
            }
         }
      }
      
      private function gc_buySeed_data_basic(patch:IDataInput) : void
      {
         var silver:String = null;
         var value:int = patch.readByte();
         if(value == 1)
         {
            silver = patch.readUTF();
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("151",9));
            if(Boolean(UIManager.treasureChest))
            {
               UIManager.treasureChest.update();
            }
            UIManager.treasureChest.flyCartoon();
            UIManager.farm.updateFarmMaster(Model_farm.currentFarmId);
         }
         else if(value == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("71",9));
         }
         else if(value == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("70",9));
         }
         else if(value == 4)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("163",9));
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("98",9));
         }
      }
   }
}

