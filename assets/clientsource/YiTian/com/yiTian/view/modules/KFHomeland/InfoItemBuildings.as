package com.yiTian.view.modules.KFHomeland
{
   import com.yiTian.data.Data_lib;
   
   public class InfoItemBuildings
   {
      
      public var id:int;
      
      public var num:int;
      
      public var leftTime:int;
      
      public var localDataArr:Array;
      
      public function InfoItemBuildings()
      {
         super();
      }
      
      public function initListInfo() : void
      {
         this.localDataArr = Data_lib.kfjyjzflb[this.id];
      }
   }
}

