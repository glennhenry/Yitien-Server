package com.yiTian.data.vo
{
   public class Vo_trans
   {
      
      public static var TRANS_ID:int = 0;
      
      public static var ROLE_ID:int = 1;
      
      public static var TRANS_NAME:int = 2;
      
      public static var TRANS_STATUS:int = 3;
      
      public static var RECEIVE_STATUS:int = 4;
      
      public static var TRANS_TITLE:int = 5;
      
      public static var TRANS_TIME:int = 6;
      
      public var trans_id:Number;
      
      public var role_id:int;
      
      public var trans_name:String;
      
      public var trans_status:int;
      
      public var receive_status:int;
      
      public var trans_title:String;
      
      public var trans_time:String;
      
      public function Vo_trans()
      {
         super();
      }
      
      public function init(arr:Array) : void
      {
         this.trans_id = arr[TRANS_ID];
         this.role_id = arr[ROLE_ID];
         this.trans_name = arr[TRANS_NAME];
         this.trans_status = arr[TRANS_STATUS];
         this.receive_status = arr[RECEIVE_STATUS];
         this.trans_title = arr[TRANS_TITLE];
         this.trans_time = arr[TRANS_TIME];
      }
   }
}

