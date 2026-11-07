package com.yiTian.data.vo
{
   public class Vo_mart_buy extends Vo_Mart
   {
      
      public static var WP_TYPE:int = 8;
      
      public static var WP_ID:int = 9;
      
      public var wp_type:int;
      
      public var wp_id:int;
      
      public function Vo_mart_buy()
      {
         super();
      }
      
      override public function Init_Mart(arr:Array) : void
      {
         mart_id = arr[MARTID];
         good_num = arr[GOOD_NUM];
         left_time = arr[LEFT_TIME];
         price = arr[PRICE];
         sold_buy_host = arr[SOLD_BUY_HOST];
         price_type = arr[PRICE_TYPE];
         sold_buy_host_id = arr[SOLD_BUY_ID];
         sold_bought_num = arr[SOLD_BOUGHT_NUM];
         this.wp_type = arr[WP_TYPE];
         this.wp_id = arr[WP_ID];
      }
   }
}

