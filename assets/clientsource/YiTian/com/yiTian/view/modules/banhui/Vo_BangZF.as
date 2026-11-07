package com.yiTian.view.modules.banhui
{
   import com.yiTian.data.Data_lib;
   
   public class Vo_BangZF
   {
      
      public static var TYPE:int = 0;
      
      public static var LEVEL:int = 1;
      
      public static var NAME:int = 2;
      
      public static var WEIZHI:int = 5;
      
      public static var IMG:int = 8;
      
      public static var BANG_BASIC_ZF_ARR:Array = [80100,80200,80300,80400,80500,80600,80700,80800,80900,81000];
      
      public var id:int;
      
      public var type:int;
      
      public var level:int;
      
      public var descript:String;
      
      public var name:String;
      
      public var weizhi:String;
      
      public var img:int;
      
      public var isLoadImg:Boolean;
      
      public function Vo_BangZF(type:int, level:int)
      {
         var lv1Id:int = 0;
         super();
         if(level <= 0)
         {
            this.id = BANG_BASIC_ZF_ARR[type - 1] + level;
            this.level = level;
            lv1Id = this.id + 1;
            type = int(Data_lib.zhenfa[lv1Id][TYPE]);
            this.name = Data_lib.zhenfa[lv1Id][NAME];
            this.weizhi = Data_lib.zhenfa[lv1Id][WEIZHI];
            this.img = Data_lib.zhenfa[lv1Id][IMG];
         }
         else
         {
            this.id = BANG_BASIC_ZF_ARR[type - 1] + level;
            this.level = level;
            type = int(Data_lib.zhenfa[this.id][TYPE]);
            this.name = Data_lib.zhenfa[this.id][NAME];
            this.weizhi = Data_lib.zhenfa[this.id][WEIZHI];
            this.img = Data_lib.zhenfa[this.id][IMG];
         }
      }
   }
}

