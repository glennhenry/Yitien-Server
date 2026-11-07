package com.yiTian.data.vo
{
   public class Vo_farm_land
   {
      
      public static var land_status_none:uint = 0;
      
      public static var land_status_have_fruit:uint = 1;
      
      public static var land_status_need_water:uint = 2;
      
      public static var land_status_mature:uint = 3;
      
      public var roleid:Number;
      
      public var position:uint;
      
      public var level:uint;
      
      public var status:uint;
      
      public var fruit_id:uint;
      
      public var output_left:uint;
      
      public var output_max:uint;
      
      public var time_left_from_timer:uint;
      
      public var time_left:uint;
      
      public var time_mature:uint;
      
      public var time_pre_system:Number;
      
      public var time_pre_request_water:Number;
      
      public var isNeedCheckWater:Boolean;
      
      public var canSteal:Boolean;
      
      public var refreshTime:uint;
      
      public var isMine:Boolean;
      
      public function Vo_farm_land()
      {
         super();
      }
      
      public function clear() : void
      {
         this.status = land_status_none;
         this.fruit_id = 0;
         this.output_left = 0;
         this.output_max = 0;
         this.time_left_from_timer = 0;
         this.time_left = 0;
         this.time_mature = 0;
         this.time_pre_system = 0;
         this.isNeedCheckWater = false;
         this.canSteal = false;
         this.time_pre_request_water = 0;
         this.refreshTime = 0;
      }
   }
}

