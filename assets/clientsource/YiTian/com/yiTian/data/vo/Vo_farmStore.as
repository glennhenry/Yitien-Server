package com.yiTian.data.vo
{
   import com.yiTian.data.Data_lib;
   
   public class Vo_farmStore
   {
      
      public static const NAME:int = 0;
      
      public static const ORIGIN:int = 1;
      
      public static const NEED_LEVEL:int = 10;
      
      public static const SEED_TYPE:int = 2;
      
      public static const SEED_LEVEL:int = 3;
      
      public static const ORDER_NUMBER:int = 4;
      
      public static const SEED_PRICETYPE:int = 5;
      
      public static const SEED_PRICE:int = 6;
      
      public static const FRUITID:int = 7;
      
      public static const RIPE_TIME:int = 8;
      
      public static const PLANT_TOPLIMIT:int = 9;
      
      public var seed_id:int;
      
      public var seed_name:String;
      
      public var origin:int;
      
      public var seed_type:int;
      
      public var seed_level:int;
      
      public var order_number:int;
      
      public var seed_priceType:int;
      
      public var seed_price:int;
      
      public var fruitID:String;
      
      public var ripe_time:int;
      
      public var plant_toplimit:int;
      
      public var needLevel:uint;
      
      public function Vo_farmStore(id:int)
      {
         super();
         this.seed_id = id;
         this.seed_name = Data_lib.Farm_store[this.seed_id][NAME];
         this.origin = Data_lib.Farm_store[this.seed_id][ORIGIN];
         this.seed_type = Data_lib.Farm_store[this.seed_id][SEED_TYPE];
         this.seed_level = Data_lib.Farm_store[this.seed_id][SEED_LEVEL];
         this.order_number = Data_lib.Farm_store[this.seed_id][ORDER_NUMBER];
         this.seed_priceType = Data_lib.Farm_store[this.seed_id][SEED_PRICETYPE];
         this.seed_price = Data_lib.Farm_store[this.seed_id][SEED_PRICE];
         this.ripe_time = Data_lib.Farm_store[this.seed_id][RIPE_TIME];
         this.fruitID = Data_lib.Farm_store[this.seed_id][FRUITID];
         this.plant_toplimit = Data_lib.Farm_store[this.seed_id][PLANT_TOPLIMIT];
         this.needLevel = Data_lib.Farm_store[this.seed_id][NEED_LEVEL];
      }
   }
}

