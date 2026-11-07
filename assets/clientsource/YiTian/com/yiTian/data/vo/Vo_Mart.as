package com.yiTian.data.vo
{
   public class Vo_Mart
   {
      
      public static var MARTID:int = 0;
      
      public static var GOOD_NUM:int = 1;
      
      public static var LEFT_TIME:int = 2;
      
      public static var PRICE:int = 3;
      
      public static var PRICE_TYPE:int = 4;
      
      public static var SOLD_BUY_HOST:int = 5;
      
      public static var SOLD_BUY_ID:int = 6;
      
      public static var SOLD_BOUGHT_NUM:int = 7;
      
      public var mart_id:Number = 0;
      
      public var good_num:int;
      
      public var left_time:int;
      
      public var sold_buy_host:String;
      
      public var price:int;
      
      public var price_type:int;
      
      public var sold_bought_num:int;
      
      public var sold_buy_host_id:Number = 0;
      
      public function Vo_Mart()
      {
         super();
      }
      
      public function Init_Mart(arr:Array) : void
      {
         this.mart_id = arr[MARTID];
         this.good_num = arr[GOOD_NUM];
         this.left_time = arr[LEFT_TIME];
         this.price = arr[PRICE];
         this.sold_buy_host = arr[SOLD_BUY_HOST];
         this.price_type = arr[PRICE_TYPE];
         this.sold_buy_host_id = arr[SOLD_BUY_ID];
         this.sold_bought_num = arr[SOLD_BOUGHT_NUM];
      }
   }
}

