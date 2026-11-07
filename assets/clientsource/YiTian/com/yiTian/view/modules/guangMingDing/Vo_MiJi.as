package com.yiTian.view.modules.guangMingDing
{
   import com.yiTian.data.Data_lib;
   
   public class Vo_MiJi
   {
      
      public var id:int = 0;
      
      public var freeCount:int;
      
      public var size:int = 34;
      
      public var isEffecting:Boolean = false;
      
      public var extraType:int;
      
      public function Vo_MiJi()
      {
         super();
      }
      
      public function getIconUrl() : String
      {
         return "resource/image/miji/" + this.id.toString() + "_" + this.size.toString() + ".png";
      }
      
      public function getMaxFreeTimes() : int
      {
         return Data_lib.Gmd_mj[this.id][Enum_guangMingDing.LIB_MJ_FREETIMES];
      }
   }
}

