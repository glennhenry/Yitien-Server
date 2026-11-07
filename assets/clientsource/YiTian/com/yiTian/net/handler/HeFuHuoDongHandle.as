package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.model.Model_HeFuHuoDong;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.HeFuHuoDong.View_HeFuHuoDong_icon;
   import com.yiTian.view.modules.HeFuHuoDong.View_HeFuHuoDong_menu;
   import com.yiTian.view.modules.HeFuHuoDong.View_HefuHuoDong0;
   import com.yiTian.view.modules.HeFuHuoDong.View_HefuHuoDong1;
   import com.yiTian.view.modules.HeFuHuoDong.View_HefuHuoDong2;
   import com.yiTian.view.modules.HeFuHuoDong.View_HefuHuoDong5;
   
   public class HeFuHuoDongHandle
   {
      
      public function HeFuHuoDongHandle()
      {
         super();
      }
      
      public static function TurnOn(flag:int = 1) : void
      {
         if(Boolean(flag))
         {
            if(GameUnitManager.hero.level < 30)
            {
               Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP_2,TurnOn);
            }
            else
            {
               Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP_2,TurnOn);
               UIManager.mainUiBtnContainer.addBTN(View_HeFuHuoDong_icon.instance);
            }
         }
         else
         {
            UIManager.mainUiBtnContainer.removeBTN(View_HeFuHuoDong_icon.instance);
         }
      }
      
      public static function HeFu(arr:Array) : void
      {
         Model_HeFuHuoDong.arr0 = arr;
         View_HeFuHuoDong_menu.instance.setTabBtn(View_HefuHuoDong0.instance);
      }
      
      public static function UpdateGet(menu:int, id:int, status:int) : void
      {
         switch(status)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("背包已满");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("领取成功");
               if(menu == 0)
               {
                  Model_HeFuHuoDong.arr0[id - 1] = 8;
                  View_HefuHuoDong0.instance.updateMenu();
                  View_HefuHuoDong0.instance.FlyToBag();
                  break;
               }
               if(menu == 1)
               {
                  Model_HeFuHuoDong.arr1[id - 1] = 8;
                  View_HefuHuoDong1.instance.updateMenu();
                  View_HefuHuoDong1.instance.FlyToBag();
                  break;
               }
               if(menu == 2)
               {
                  Model_HeFuHuoDong.arr2[id - 1] = 2;
                  View_HefuHuoDong2.instance.updateMenu();
                  View_HefuHuoDong2.instance.FlyToBag();
                  break;
               }
               if(menu == 5)
               {
                  if(id == 1)
                  {
                     View_HefuHuoDong5.instance.FlyToBag();
                     View_HefuHuoDong5.instance.YaoJiangGetComplete();
                     break;
                  }
                  if(id == 2)
                  {
                     View_HefuHuoDong5.instance.LiQuanGetComplete();
                  }
               }
         }
      }
      
      public static function HuiGui(arr:Array) : void
      {
         if(arr.pop() == 0)
         {
            arr = [-1,-1,-1,-1,-1,-1,-1];
         }
         Model_HeFuHuoDong.arr1 = arr;
         View_HeFuHuoDong_menu.instance.setTabBtn(View_HefuHuoDong1.instance);
      }
      
      public static function ChongZhi(count:int, arr:Array) : void
      {
         Model_HeFuHuoDong.arr2 = arr;
         View_HeFuHuoDong_menu.instance.setTabBtn(View_HefuHuoDong2.instance);
         View_HefuHuoDong2.instance.setProgress(count);
      }
      
      public static function ZaiXian(haveOnlineTime:int, keepOnlineTime:int, canGetLiQuan:int, haveGetLiQuan:int, ChouJiangStatus:int, ChouJiangTimes:int, nowDay:int, flag:int, arr:Array) : void
      {
         Model_HeFuHuoDong.arr5 = arguments;
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(View_HeFuHuoDong_menu.instance,function():void
         {
            View_HeFuHuoDong_menu.instance.setTabBtn(View_HefuHuoDong5.instance);
         });
      }
      
      public static function YaoJiang(times:int, item:String) : void
      {
         Model_HeFuHuoDong.arr5[5] = times;
         var itemArr:Array = item.split("_");
         var i:int = 0;
         while(Boolean(itemArr[i]))
         {
            itemArr[i] = Number(itemArr[i]);
            i++;
         }
         Model_HeFuHuoDong.arr5[8] = itemArr;
         View_HefuHuoDong5.instance.StartRun();
      }
   }
}

