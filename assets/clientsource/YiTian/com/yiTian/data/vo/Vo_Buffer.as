package com.yiTian.data.vo
{
   import com.yiTian.data.Data_lib;
   
   public class Vo_Buffer
   {
      
      public static const NAME:int = 0;
      
      public static const TYPE:int = 1;
      
      public static const CATEGORIES:int = 2;
      
      public static const EFF1:int = 3;
      
      public static const VALUE1:int = 4;
      
      public static const EFF2:int = 5;
      
      public static const VALUE2:int = 6;
      
      public static const EFF3:int = 7;
      
      public static const VALUE3:int = 8;
      
      public static const LAST_TIME:int = 9;
      
      public static const LAST_TYPE:int = 10;
      
      public static const ICON:int = 11;
      
      public static const SWF_URL:int = 12;
      
      public static const DISCRIPT:int = 13;
      
      public static const PROPSID:int = 14;
      
      public static const BUF_LAYER:int = 15;
      
      public static const BATTLE_ICON:int = 16;
      
      public static const BATTLE_TIP:int = 17;
      
      public var id:Number;
      
      public var name:String;
      
      public var type:int;
      
      public var categories:int;
      
      public var eff1:int;
      
      public var value1:String;
      
      public var eff2:int;
      
      public var value2:String;
      
      public var eff3:int;
      
      public var value3:int;
      
      public var last_time:int;
      
      public var last_type:int;
      
      public var icon:int;
      
      public var swf_url:int;
      
      public var discript:String;
      
      public var propsId:int;
      
      public var updateTime:int;
      
      public var remainValue:int;
      
      public var Requested:Boolean;
      
      public function Vo_Buffer(id:Number)
      {
         super();
         this.id = id;
         this.name = Data_lib.buffer[id][NAME];
         this.type = Data_lib.buffer[id][TYPE];
         this.categories = Data_lib.buffer[id][CATEGORIES];
         this.eff1 = Data_lib.buffer[id][EFF1];
         this.value1 = Data_lib.buffer[id][VALUE1];
         this.eff2 = Data_lib.buffer[id][EFF2];
         this.value2 = Data_lib.buffer[id][VALUE2];
         this.eff3 = Data_lib.buffer[id][EFF3];
         this.value3 = Data_lib.buffer[id][VALUE3];
         this.last_time = Data_lib.buffer[id][LAST_TIME];
         this.last_type = Data_lib.buffer[id][LAST_TYPE];
         this.icon = Data_lib.buffer[id][ICON];
         this.swf_url = Data_lib.buffer[id][SWF_URL];
         this.discript = Data_lib.buffer[id][DISCRIPT];
         this.propsId = Data_lib.buffer[id][PROPSID];
      }
   }
}

