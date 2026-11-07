package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_XianGou;
   import com.yiTian.data.model.Model_XianGou;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.XianGou.View_XianGou_menu2;
   
   public class XianGouHandler
   {
      
      public function XianGouHandler()
      {
         super();
      }
      
      public static function TurnOnHandler() : void
      {
         Global.control.sendNotification(Enum_XianGou.TURN_ON,Model_XianGou.Turn_On);
      }
      
      public static function Init() : void
      {
         View_XianGou_menu2.instance.SetItem();
      }
      
      public static function returnFlag(num:int, id:int) : void
      {
         switch(num)
         {
            case 0:
               if(id != -1)
               {
                  UIManager.centerBroadcast.addMsg("购买成功");
                  View_XianGou_menu2.instance.FlyToBag(id);
                  break;
               }
               UIManager.centerBroadcast.addMsg("背包已满，请查收信件");
               break;
            case 1:
               UIManager.centerBroadcast.addMsg("库存不足");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("超出限购");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("元宝不足");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("礼券不足");
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("银两不足");
         }
      }
   }
}

