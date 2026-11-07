package com.yiTian.data.vo
{
   import com.yiTian.data.Data_lib;
   
   public class Vo_ZhenFa
   {
      
      public static var TYPE:int = 0;
      
      public static var LEVEL:int = 1;
      
      public static var NAME:int = 2;
      
      public static var MIAOSHU:int = 3;
      
      public static var MIAOSHU2:int = 4;
      
      public static var WEIZHI:int = 5;
      
      public static var PROPERYID:int = 6;
      
      public static var PROPERYVALUE:int = 7;
      
      public static var IMG:int = 8;
      
      public static var NEXTZHENFA:int = 9;
      
      public var id:int;
      
      public var type:int;
      
      public var level:int;
      
      public var name:String;
      
      public var miaoshu:String;
      
      public var miaoshu2:String;
      
      public var weizhi:String;
      
      public var properyID:int;
      
      public var properyValue:int;
      
      public var img:int;
      
      public var nextZhenfa:int;
      
      public function Vo_ZhenFa(id:int)
      {
         super();
         this.id = id;
         this.type = Data_lib.zhenfa[id][TYPE];
         this.level = Data_lib.zhenfa[id][LEVEL];
         this.name = Data_lib.zhenfa[id][NAME];
         this.miaoshu = Data_lib.zhenfa[id][MIAOSHU];
         this.miaoshu2 = Data_lib.zhenfa[id][MIAOSHU2];
         this.weizhi = Data_lib.zhenfa[id][WEIZHI];
         this.properyID = Data_lib.zhenfa[id][PROPERYID];
         this.properyValue = Data_lib.zhenfa[id][PROPERYVALUE];
         this.img = Data_lib.zhenfa[id][IMG];
         this.nextZhenfa = Data_lib.zhenfa[id][NEXTZHENFA];
      }
   }
}

