package com.yiTian.data.vo
{
   public class Vo_farm_farmer
   {
      
      public static const farmer_status_normal:uint = 0;
      
      public static const farmer_status_sleep:uint = 1;
      
      public var id:Number = 0;
      
      public var name:String;
      
      public var sex:uint;
      
      public var level:uint;
      
      public var profession:uint;
      
      public var status:uint;
      
      public var position:uint;
      
      public var time_left:uint;
      
      public var time_left_from_timer:uint;
      
      public var time_all:uint;
      
      public var time_pre_system:Number;
      
      public var time_pre_request_sleep:Number;
      
      public var time_buffer_left:uint;
      
      public var time_buffer_left_from_timer:uint;
      
      public var time_buffer_pre_sys:Number;
      
      public var isNeedSleep:Boolean;
      
      public function Vo_farm_farmer()
      {
         super();
      }
      
      public function clear() : void
      {
         this.id = 0;
         this.name = "";
         this.sex = 0;
         this.profession = 0;
         this.status = 0;
         this.time_left = 0;
         this.position = 0;
         this.time_all = 0;
         this.time_pre_system = 0;
         this.time_left_from_timer = 0;
         this.time_buffer_left = 0;
         this.time_buffer_left_from_timer = 0;
         this.time_buffer_pre_sys = 0;
         this.level = 0;
         this.isNeedSleep = false;
         this.time_pre_request_sleep = 0;
      }
   }
}

