package com.yiTian.net.handler
{
   import com.yiTian.data.model.Model_tiliStore;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.roleHead.View_HeroHead;
   import com.yiTian.view.modules.tiliStore.View_tiliStore;
   import com.yiTian.view.modules.tiliStore.View_tiliTip;
   
   public class TiLiHandle
   {
      
      private static var tiliArr:Array = [500,200,100];
      
      public function TiLiHandle()
      {
         super();
      }
      
      public static function GC_TILI_STORE_STATUS(result1:int, result2:int, result3:int) : void
      {
         View_tiliStore.res1 = result1;
         View_tiliStore.res2 = result2;
         View_tiliStore.res3 = result3;
      }
      
      public static function GC_TILI_STORE_BOUGHT(result:int) : void
      {
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("109",0) + String(tiliArr[Model_tiliStore._boughtIndex]));
               UIManager.tiliStore.setBtn(Model_tiliStore._boughtIndex,false);
               trace(Model_tiliStore._boughtIndex);
               if(Model_tiliStore._boughtIndex == 0)
               {
                  View_tiliStore.res1 = 1;
                  break;
               }
               if(Model_tiliStore._boughtIndex == 1)
               {
                  View_tiliStore.res2 = 1;
                  break;
               }
               if(Model_tiliStore._boughtIndex == 2)
               {
                  View_tiliStore.res3 = 1;
               }
               break;
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("110",0));
               break;
            case 3:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("111",0));
               break;
            case 4:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("112",0));
         }
      }
      
      public static function GC_SHOW_TILI_ICON() : void
      {
         UIManager.meiWeiJiaYaoPanel.showMUB();
      }
      
      public static function GC_GET_TILI(result:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("113",0));
            UIManager.meiWeiJiaYaoPanel.hideMUB();
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("114",0));
         }
      }
      
      public static function GC_TILI_TISHI() : void
      {
         var tiliTip:View_tiliTip = null;
         Model_tiliStore.isTiliFull = true;
         if(View_HeroHead.isInit)
         {
            tiliTip = View_tiliTip.getInstance();
            tiliTip.visible = true;
         }
      }
   }
}

