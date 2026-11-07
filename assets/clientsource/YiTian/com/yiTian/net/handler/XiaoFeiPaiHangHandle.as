package com.yiTian.net.handler
{
   import com.yiTian.data.model.Model_XiaoFeiPaiHang;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.XiaoFeiPaiHang.View_XiaoFeiPaiHang_icon;
   import com.yiTian.view.modules.XiaoFeiPaiHang.View_XiaoFeiPaiHang_menu;
   
   public class XiaoFeiPaiHangHandle
   {
      
      public function XiaoFeiPaiHangHandle()
      {
         super();
      }
      
      public static function IconHandle(flag:int) : void
      {
         if(Boolean(flag))
         {
            UIManager.mainUiBtnContainer.addBTN(View_XiaoFeiPaiHang_icon.instance);
         }
         else
         {
            UIManager.mainUiBtnContainer.removeBTN(View_XiaoFeiPaiHang_icon.instance);
         }
      }
      
      public static function Update(arr:Array) : void
      {
         Model_XiaoFeiPaiHang.array = arr;
         Model_XiaoFeiPaiHang.totalPege = Math.ceil(arr.length / 3 / 10);
         View_XiaoFeiPaiHang_menu.instance.UpdateCurrentPage();
      }
   }
}

