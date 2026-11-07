package com.yiTian.data.model
{
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_farmStore;
   import flash.utils.Dictionary;
   
   public class Model_treasureChest
   {
      
      private static var _instance:Model_treasureChest;
      
      public static var incomeDic:Dictionary;
      
      public static var dic1:Dictionary;
      
      public static var pos:int;
      
      public static var storeSeedList:Array = new Array();
      
      public static var buySeedArr:Array = new Array();
      
      public function Model_treasureChest()
      {
         var id:String = null;
         var k:int = 0;
         var index:int = 0;
         var seed_id:uint = 0;
         var vo:Vo_farmStore = null;
         var j:int = 0;
         var n:int = 0;
         var incomeArr:Array = null;
         var str:String = null;
         var arr:Array = null;
         var m:int = 0;
         var arr1:Array = null;
         super();
         dic1 = new Dictionary();
         incomeDic = new Dictionary();
         for(id in Data_lib.Farm_store)
         {
            index = 0;
            seed_id = uint(id);
            vo = new Vo_farmStore(seed_id);
            if(vo.origin != 0)
            {
               if(vo.order_number != 0)
               {
                  if(vo.order_number > storeSeedList.length)
                  {
                     index = int(storeSeedList.length);
                     j = 0;
                     while(j < vo.order_number - index)
                     {
                        storeSeedList.push(new Array());
                        j++;
                     }
                  }
                  storeSeedList[vo.order_number - 1].push(vo);
               }
            }
         }
         k = 0;
         while(k < storeSeedList.length)
         {
            n = 0;
            while(n < storeSeedList[k].length)
            {
               incomeArr = [];
               str = storeSeedList[k][n].fruitID;
               arr = str.split(",");
               m = 0;
               while(m < arr.length)
               {
                  arr1 = arr[m].split("_");
                  incomeArr.push(arr1);
                  m++;
               }
               incomeDic[storeSeedList[k][n].seed_id] = incomeArr;
               n++;
            }
            k++;
         }
         j = 0;
         while(j < storeSeedList.length)
         {
            storeSeedList[j].sortOn("seed_level",Array.NUMERIC);
            j++;
         }
      }
      
      public static function get instance() : Model_treasureChest
      {
         if(!_instance)
         {
            _instance = new Model_treasureChest();
         }
         return _instance;
      }
   }
}

