package com.yiTian.net.handler
{
   import com.yiTian.data.model.Model_ShiZhuangSuiPian;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.ShiZhuangSuiPian.View_ShiZhuangSuiPian_buyMenu;
   import com.yiTian.view.modules.ShiZhuangSuiPian.View_ShiZhuangSuiPian_menu;
   
   public class ShiZhuangSuiPianHandler
   {
      
      public function ShiZhuangSuiPianHandler()
      {
         super();
      }
      
      public static function OpenMenu(count:int) : void
      {
         Model_ShiZhuangSuiPian.myPiecesCount = count;
         View_ShiZhuangSuiPian_menu.instance.UpdatePieces();
         View_ShiZhuangSuiPian_menu.instance.visible = true;
      }
      
      public static function SetResult(id:int, status:int, count:int) : void
      {
         Model_ShiZhuangSuiPian.myPiecesCount = count;
         View_ShiZhuangSuiPian_menu.instance.UpdatePieces();
         switch(status)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("时装碎片不足");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("背包已满");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("兑换成功");
               View_ShiZhuangSuiPian_buyMenu.instance.visible = false;
               break;
            default:
               trace("CNM谁乱发数据!!!!");
         }
      }
   }
}

