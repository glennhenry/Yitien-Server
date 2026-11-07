package com.yiTian.data.model
{
   import com.yiTian.data.vo.Vo_battle_lib_data;
   
   public class Model_Battle
   {
      
      public static var last_battle_vo:Vo_battle_lib_data;
      
      public static var last_battle_rewards:Array;
      
      public static var battleVideoList:Vector.<Vo_battle_lib_data>;
      
      public static var specId:int = -1;
      
      public function Model_Battle()
      {
         super();
      }
      
      public static function getBattleVideoData(bid:uint) : Vo_battle_lib_data
      {
         var vo:Vo_battle_lib_data = null;
         for each(vo in Model_Battle.battleVideoList)
         {
            if(vo.battleId == bid)
            {
               return vo;
            }
         }
         return null;
      }
      
      public static function addBattleVideoData(vo:Vo_battle_lib_data) : void
      {
         if(!Model_Battle.battleVideoList)
         {
            Model_Battle.battleVideoList = new Vector.<Vo_battle_lib_data>();
         }
         Model_Battle.battleVideoList.push(vo);
         if(Model_Battle.battleVideoList.length > 20)
         {
            Model_Battle.battleVideoList.shift();
         }
      }
   }
}

