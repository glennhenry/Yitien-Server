package com.yiTian.view.modules.WuLinMiXin
{
   import com.yiTian.data.Data_lib;
   
   public class Vo_wlMx
   {
      
      public var id:int;
      
      public var str:String;
      
      public function Vo_wlMx()
      {
         super();
      }
      
      public function init() : void
      {
         this.str = String(Data_lib.wulinmixin_talk[this.id][0]);
      }
   }
}

