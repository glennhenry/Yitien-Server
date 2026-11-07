package com.yiTian.net.handler
{
   import com.yiTian.manager.UIManager;
   import flash.utils.getTimer;
   
   public class FruitShopHandler
   {
      
      public static var dateNum:uint;
      
      public static var lastDateUpdateTime:int;
      
      public static var list:Array = new Array();
      
      public static var MAX_PAGE_SIZE:int = 6;
      
      public static var _tipFlag_1:int = 1;
      
      public static var _tipFlag_2:int = 2;
      
      public static var _tipFlag_3:int = 3;
      
      public static var _tipFlag_4:int = 4;
      
      public static var _tipFlag_5:int = 5;
      
      public static var _tipFlag_6:int = 6;
      
      public static var _tipFlag_7:int = 7;
      
      public function FruitShopHandler()
      {
         super();
      }
      
      public static function GC_FRUIT_SHOP_DATA(arr:Array) : void
      {
         if(UIManager.fruitShop.visible)
         {
            UIManager.fruitShop.updateList();
         }
      }
      
      public static function GC_FRUIT_SHOP_BUY(tipFlag:int) : void
      {
         switch(tipFlag)
         {
            case _tipFlag_1:
               UIManager.centerBroadcast.addMsg("购买成功");
               break;
            case _tipFlag_2:
               UIManager.centerBroadcast.addMsg("水果不足");
               break;
            case _tipFlag_3:
               UIManager.centerBroadcast.addMsg("非活动时间");
               break;
            case _tipFlag_4:
               UIManager.centerBroadcast.addMsg("此商品购买次数已满");
               break;
            case _tipFlag_5:
               UIManager.centerBroadcast.addMsg("商城没此商品");
               break;
            case _tipFlag_6:
               UIManager.centerBroadcast.addMsg("水果过期了");
               break;
            case _tipFlag_7:
               UIManager.centerBroadcast.addMsg("非本平台活动");
         }
      }
      
      public static function GC_FRUIT_SHOP_SER_TIME(serTime:uint) : void
      {
         dateNum = serTime;
         lastDateUpdateTime = getTimer();
      }
   }
}

