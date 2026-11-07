package com.yiTian.net.handler
{
   import com.yiTian.data.model.Model_ChongZhiPaiHang;
   import com.yiTian.view.modules.ChongZhiPaiHang.View_ChongZhiPaiHang_menu;
   
   public class ChongZhiPaiHangHandle
   {
      
      public function ChongZhiPaiHangHandle()
      {
         super();
      }
      
      public static function Update(arr:Array) : void
      {
         Model_ChongZhiPaiHang.array = arr;
         Model_ChongZhiPaiHang.totalPege = Math.ceil(arr.length / 3 / 10);
         View_ChongZhiPaiHang_menu.instance.UpdateCurrentPage();
      }
   }
}

