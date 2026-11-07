package com.yiTian.view.modules.team
{
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.view.comp.View_Grid;
   
   public class ZhenFaViewGrid extends View_Grid
   {
      
      public var gridPostion:int;
      
      public function ZhenFaViewGrid($bBigIcon:Boolean = false, str_extend_name:String = ".png")
      {
         super($bBigIcon,str_extend_name);
         super.type = Enum_type_grid.ZHENXING;
      }
   }
}

