package com.yiTian.data.model
{
   import com.yiTian.data.vo.Vo_worldLevRewItem;
   import com.yiTian.manager.UIManager;
   
   public class Model_worldLevel
   {
      
      private static var _worldLev:int;
      
      private static var _rewardData:Array;
      
      public function Model_worldLevel()
      {
         super();
      }
      
      public static function set worldLev(level:int) : void
      {
         _worldLev = level;
         UIManager.paiHangPanel.updateWorldLev();
         UIManager.worldLevReward.updateWorldLvBind();
      }
      
      public static function get worldLev() : int
      {
         return _worldLev;
      }
      
      public static function set rewardData(data:Array) : void
      {
         var itemData:Array = null;
         var worldRewVo:Vo_worldLevRewItem = null;
         _rewardData = [];
         var len:int = int(data.length);
         var i:int = 0;
         while(i < len)
         {
            itemData = data[i];
            worldRewVo = new Vo_worldLevRewItem();
            worldRewVo.type = itemData[0];
            worldRewVo.value = itemData[1];
            worldRewVo.status = itemData[2];
            _rewardData.push(worldRewVo);
            i++;
         }
         UIManager.worldLevReward.update(_rewardData);
      }
      
      public static function get rewardData() : Array
      {
         return _rewardData;
      }
   }
}

