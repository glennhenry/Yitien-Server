package com.yiTian.data.vo
{
   public class Vo_jingJiChang
   {
      
      public static var ROLE_ID:int = 0;
      
      public static var ROLE_NAME:int = 1;
      
      public static var PAIMING:int = 2;
      
      public static var LEVEL:int = 3;
      
      public static var JOB:int = 4;
      
      public static var SEX:int = 5;
      
      public static var PET_ID:int = 6;
      
      public static var HERO_POSITION:int = 7;
      
      public static var PET_POSITION:int = 8;
      
      public static var PET_ICON:int = 9;
      
      public static var ROLE_ZHANLI:int = 10;
      
      public var roldId:Number = 0;
      
      public var role_name:String;
      
      public var pai_ming:int;
      
      public var level:int;
      
      public var job:int;
      
      public var sex:int;
      
      public var pet_id:int;
      
      public var hero_position:int;
      
      public var pet_position:int;
      
      public var pet_icon:int;
      
      public var role_zhanLi:int;
      
      public function Vo_jingJiChang()
      {
         super();
      }
      
      public function init(arr:Array) : void
      {
         this.roldId = arr[ROLE_ID];
         this.role_name = arr[ROLE_NAME];
         this.pai_ming = arr[PAIMING];
         this.level = arr[LEVEL];
         this.job = arr[JOB];
         this.sex = arr[SEX];
         this.pet_id = arr[PET_ID];
         this.hero_position = arr[HERO_POSITION];
         this.pet_position = arr[PET_POSITION];
         this.pet_icon = arr[PET_ICON];
         this.role_zhanLi = arr[ROLE_ZHANLI];
      }
   }
}

