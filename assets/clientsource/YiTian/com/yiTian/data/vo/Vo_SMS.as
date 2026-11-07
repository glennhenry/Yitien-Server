package com.yiTian.data.vo
{
   public class Vo_SMS
   {
      
      public static var GOODS_ID:int = 0;
      
      public static var GRID_ID:int = 1;
      
      public static var WP_ID:int = 2;
      
      public static var TYPE:int = 3;
      
      public static var NUMS:int = 4;
      
      public static var MONEY_TYPE:int = 5;
      
      public static var PRICE:int = 6;
      
      public static var IS_EXPEN_WP:int = 7;
      
      public static var IS_BAOWU:int = 8;
      
      public static var DESCRIP:int = 9;
      
      public var goods_id:int;
      
      public var grid_id:int;
      
      public var wp_id:int;
      
      public var type:int;
      
      public var nums:int;
      
      public var money_type:int;
      
      public var price:int;
      
      public var is_expen_wp:int;
      
      public var is_baowu:int;
      
      public var descrip:String;
      
      public function Vo_SMS()
      {
         super();
      }
      
      public function init_on_sells(arr:Array) : void
      {
         this.goods_id = arr[GOODS_ID];
         this.grid_id = arr[GRID_ID];
         this.wp_id = arr[WP_ID];
         this.type = arr[TYPE];
         this.nums = arr[NUMS];
         this.money_type = arr[MONEY_TYPE];
         this.price = arr[PRICE];
         this.is_expen_wp = arr[IS_EXPEN_WP];
         this.is_baowu = arr[IS_BAOWU];
         this.descrip = arr[DESCRIP];
      }
   }
}

