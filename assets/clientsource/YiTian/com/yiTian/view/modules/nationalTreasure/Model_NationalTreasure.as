package com.yiTian.view.modules.nationalTreasure
{
   import com.yiTian.data.Data_lib;
   
   public class Model_NationalTreasure
   {
      
      public static var currentGridIndex:int;
      
      public static var currentArea:int;
      
      public static var shopJifen:int;
      
      public static var wabaoJifen:int;
      
      public static var integrationShopData:Array = [];
      
      public static var gridData:Array = [];
      
      public static var itemOrdinaryShowData:Array = [];
      
      public static var itemAdvancedShowData:Array = [];
      
      public static var broadcastData:Array = [["gffgf",2,46158,1,5],["gffgf",1,44533,1,15],["gffgf",1,46255,1,50]];
      
      public static var AreaData:Array = ["普通","高级"];
      
      public static var AreaIngots:Array = [20,88];
      
      public function Model_NationalTreasure()
      {
         super();
      }
      
      public static function setShopJifen(jifen:int) : void
      {
         shopJifen = jifen;
         View_IntegrationShopPanel.instance.setJifen(shopJifen);
      }
      
      public static function setWabaoJifen(jifen:int) : void
      {
         wabaoJifen = jifen;
         View_NationalTreasurePanel.instance.setJifen(wabaoJifen);
      }
      
      public static function setIntegrationShopData() : void
      {
         var i:String = null;
         for(i in Data_lib.wabaoShop)
         {
            integrationShopData.push([Data_lib.wabaoShop[i][0],Data_lib.wabaoShop[i][1],i]);
         }
      }
      
      public static function setItemOrdinaryShowData() : void
      {
         var i:String = null;
         for(i in Data_lib.ordinaryReward)
         {
            if(Data_lib.ordinaryReward[i][3] == Enum_NationalTreasure.CAN_SHOW)
            {
               itemOrdinaryShowData.push(Data_lib.ordinaryReward[i][0]);
            }
         }
      }
      
      public static function setItemAdvancedShowData() : void
      {
         var i:String = null;
         for(i in Data_lib.advancedReward)
         {
            if(Data_lib.advancedReward[i][3] == Enum_NationalTreasure.CAN_SHOW)
            {
               itemAdvancedShowData.push(Data_lib.advancedReward[i][0]);
            }
         }
      }
      
      public static function setGridData(str:String) : void
      {
         var arr:Array = str.split(",");
         gridData = arr;
         if(View_NationalTreasurePanel.instance.visible == true)
         {
            View_NationalTreasurePanel.instance.showGridList(gridData);
            setGridVisible();
         }
      }
      
      public static function setBroadcastData(str:String) : void
      {
         var arr:Array = str.split(",");
         arr.reverse();
         broadcastData = arr;
         if(View_NationalTreasurePanel.instance.visible == true)
         {
            View_NationalTreasurePanel.instance.showBroadcastList(broadcastData);
         }
      }
      
      public static function setGridVisible() : void
      {
         var i:int = 0;
         var arr:Array = null;
         var len:int = int(gridData.length);
         i = 0;
         while(i < len)
         {
            arr = gridData[i].toString().split("_");
            if(arr[4] == Enum_NationalTreasure.NOT_DIG)
            {
               View_NationalTreasurePanel.instance.setGridVisible(false,i);
            }
            else
            {
               View_NationalTreasurePanel.instance.setGridVisible(true,i);
            }
            i++;
         }
      }
      
      public static function needfresh() : Boolean
      {
         var i:int = 0;
         var arr:Array = null;
         var len:int = int(gridData.length);
         i = 0;
         while(i < len)
         {
            arr = gridData[i].toString().split("_");
            if(arr[4] == Enum_NationalTreasure.NOT_DIG)
            {
               return false;
            }
            i++;
         }
         return true;
      }
   }
}

