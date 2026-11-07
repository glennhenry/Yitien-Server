package com.yiTian.net.handler
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.NationalTreasureCGMessage;
   import com.yiTian.view.modules.nationalTreasure.Model_NationalTreasure;
   import com.yiTian.view.modules.nationalTreasure.View_NationalTreasurePanel;
   
   public class NationalTreasureHandler
   {
      
      public function NationalTreasureHandler()
      {
         super();
      }
      
      public static function GC_SHOW_ICON(result:int) : void
      {
      }
      
      public static function GC_WABAO_DATA(wabaoData:String, broadcastData:String, jifen:int) : void
      {
         Model_NationalTreasure.setGridData(wabaoData);
         Model_NationalTreasure.setBroadcastData(broadcastData);
         Model_NationalTreasure.setWabaoJifen(jifen);
         Model_NationalTreasure.setShopJifen(jifen);
         if(Model_NationalTreasure.needfresh() == true)
         {
            NationalTreasureCGMessage.CG_REFRESH_DATA(Model_NationalTreasure.currentArea);
         }
      }
      
      public static function GC_WABAO_RESULT(result:int) : void
      {
         switch(result)
         {
            case 0:
               View_NationalTreasurePanel.instance.showFlyIcon(Model_NationalTreasure.currentGridIndex);
               UIManager.centerBroadcast.addMsg("挖宝成功");
               break;
            case 1:
               UIManager.centerBroadcast.addMsg("没有挖宝钥匙");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("元宝不足");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("该宝箱已被挖过，请刷新面板");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("背包空间不足");
         }
      }
      
      public static function GC_GOODS_QUERY(jifen:int) : void
      {
         Model_NationalTreasure.setShopJifen(jifen);
         Model_NationalTreasure.setWabaoJifen(jifen);
      }
      
      public static function GC_BUY_GOODS_RESULT(jifen:int, result:int) : void
      {
         Model_NationalTreasure.setShopJifen(jifen);
         Model_NationalTreasure.setWabaoJifen(jifen);
         switch(result)
         {
            case 0:
               UIManager.centerBroadcast.addMsg("兑换成功");
               break;
            case 1:
               UIManager.centerBroadcast.addMsg("积分不足");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("背包空间不足");
         }
      }
   }
}

