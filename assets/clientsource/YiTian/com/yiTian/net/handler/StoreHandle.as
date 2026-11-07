package com.yiTian.net.handler
{
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.model.Model_store;
   import com.yiTian.data.vo.Vo_store;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.modules.Shopping.shoppingMall.ShoppingMallPan;
   
   public class StoreHandle
   {
      
      public function StoreHandle()
      {
         super();
      }
      
      public static function GC_PLAZA(storeArr:Array) : void
      {
         var _vo:Vo_store = storeArr[0];
         ShoppingMallPan.dataDic[_vo.sign] = storeArr;
         var pan:ShoppingMallPan = Singleton.getInstance(ShoppingMallPan) as ShoppingMallPan;
         pan.showData(pan._curPage);
      }
      
      private static function specialHandle(_voStore:Vo_store, _sign:int) : void
      {
         if(_voStore.job == Enum_job.getBaseJob(GameUnitManager.hero.job) || _voStore.job == 0)
         {
            Model_store.store_data_sava[_sign].push(_voStore);
         }
      }
      
      public static function GC_BUY_GOODS(result:int) : void
      {
         if(Boolean(result))
         {
            UIManager.shoppingMall.updateMoney(UIManager.shoppingMall._sign);
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("12",0) + "</font></a>");
         }
         else
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ff0000\'>" + LangConfig.getWord("115",0) + "</font></a>");
         }
      }
   }
}

