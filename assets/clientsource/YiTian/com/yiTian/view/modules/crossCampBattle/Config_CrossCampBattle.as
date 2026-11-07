package com.yiTian.view.modules.crossCampBattle
{
   import com.yiTian.data.Data_lib;
   
   public class Config_CrossCampBattle
   {
      
      public static var pointsData:Array = [];
      
      public function Config_CrossCampBattle()
      {
         super();
      }
      
      public static function setPointsData() : void
      {
         var i:String = null;
         var arr:Array = null;
         var pointArr:Array = null;
         var lvArr:Array = null;
         if(pointsData.length > 0)
         {
            return;
         }
         for(i in Data_lib.campPointsReward)
         {
            arr = new Array();
            pointArr = Data_lib.campPointsReward[i][1].toString().split("_");
            lvArr = Data_lib.campPointsReward[i][2].toString().split("_");
            arr = [pointArr[0],pointArr[1],lvArr[0],lvArr[1],Data_lib.campPointsReward[i][0]];
            pointsData.push(arr);
         }
      }
   }
}

