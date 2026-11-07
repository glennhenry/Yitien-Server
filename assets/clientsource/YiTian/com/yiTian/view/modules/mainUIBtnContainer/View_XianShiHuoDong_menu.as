package com.yiTian.view.modules.mainUIBtnContainer
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.Kunlun.View_klTipBtn;
   import com.yiTian.view.modules.WulinDaHui.Model_wuLin;
   import com.yiTian.view.modules.banhui.View_BangTipBtn;
   import com.yiTian.view.modules.banhui.model_bang.Model_plant;
   import com.yiTian.view.modules.fishing.View_FishTipBtn;
   import com.yiTian.view.modules.worldBoss.WorldBossUtil;
   import flash.events.MouseEvent;
   
   public class View_XianShiHuoDong_menu extends HideMenuBase
   {
      
      private static var _instance:View_XianShiHuoDong_menu;
      
      public function View_XianShiHuoDong_menu()
      {
         super(Enum_mainUIBtn_hide.XianShiHuoDong);
      }
      
      public static function get instance() : View_XianShiHuoDong_menu
      {
         if(!_instance)
         {
            _instance = new View_XianShiHuoDong_menu();
         }
         return _instance;
      }
      
      override protected function initStaticView() : void
      {
         super.initStaticView();
         ComponentUtil.getBitmap("Title_XSHD",this,{
            "x":184,
            "y":5
         },Global.Img_Cdm);
      }
      
      override protected function setItemStatus(arr:Array) : void
      {
         var i:* = undefined;
         for(i in itemArray)
         {
            if(itemArray[i].id == arr[0])
            {
               if(arr[1] == 1)
               {
                  (itemArray[i] as hideMenuListItem).setStatus(arr[1]);
                  sort();
               }
               else if(arr[1] != -1)
               {
                  (itemArray[i] as hideMenuListItem).setStatus(arr[1]);
                  sort();
               }
               else
               {
                  (itemArray[i] as hideMenuListItem).setStatus(-1);
                  getNowDate();
               }
               Global.control.sendNotification(Enum_mainUIBtn_hide.ICON_EFFECT,arr);
               break;
            }
         }
      }
      
      override protected function setStartEndByDate(itemId:int) : void
      {
         var date:Date = new Date(nowTime);
         switch(itemArray[itemId].id)
         {
            case Enum_mainUIBtn_hide.DiaoYu:
               if(date.hours > 12)
               {
                  (itemArray[itemId] as hideMenuListItem).setStatus(2);
                  break;
               }
               (itemArray[itemId] as hideMenuListItem).setStatus(0);
               break;
            case Enum_mainUIBtn_hide.ShiJieBOSS:
               if(date.hours > 14 || date.hours == 14 && date.minutes >= 25)
               {
                  (itemArray[itemId] as hideMenuListItem).setStatus(2);
                  break;
               }
               (itemArray[itemId] as hideMenuListItem).setStatus(0);
               break;
            case Enum_mainUIBtn_hide.DuoRenJingJi:
               if(date.hours < 22)
               {
                  (itemArray[itemId] as hideMenuListItem).setStatus(0);
                  break;
               }
               (itemArray[itemId] as hideMenuListItem).setStatus(2);
               break;
            case Enum_mainUIBtn_hide.KunLunShan:
               if(date.hours > 19 || date.hours == 19 && date.minutes >= 40)
               {
                  (itemArray[itemId] as hideMenuListItem).setStatus(2);
                  break;
               }
               (itemArray[itemId] as hideMenuListItem).setStatus(0);
               break;
            case Enum_mainUIBtn_hide.WuLinDaHui:
               if((date.day == 2 || date.day == 4 || date.day == 6) && (date.hours > 20 || date.hours == 20 && date.minutes >= 50))
               {
                  (itemArray[itemId] as hideMenuListItem).setStatus(2);
                  break;
               }
               (itemArray[itemId] as hideMenuListItem).setStatus(0);
               break;
            case Enum_mainUIBtn_hide.BangHuiZhan:
               if((date.day == 1 || date.day == 3 || date.day == 5) && (date.hours > 20 || date.hours == 20 && date.minutes >= 50))
               {
                  (itemArray[itemId] as hideMenuListItem).setStatus(2);
                  break;
               }
               (itemArray[itemId] as hideMenuListItem).setStatus(0);
               break;
            case Enum_mainUIBtn_hide.BangHuiZhongZhi:
               if(date.hours > 21 || date.hours == 21 && date.minutes >= 30)
               {
                  (itemArray[itemId] as hideMenuListItem).setStatus(2);
                  break;
               }
               (itemArray[itemId] as hideMenuListItem).setStatus(0);
               break;
            case Enum_mainUIBtn_hide.PaoBiao:
               if(date.hours > 21 || date.hours == 21 && date.minutes >= 50)
               {
                  (itemArray[itemId] as hideMenuListItem).setStatus(2);
                  break;
               }
               (itemArray[itemId] as hideMenuListItem).setStatus(0);
         }
      }
      
      override protected function onClickEnter(id:int) : void
      {
         switch(id)
         {
            case Enum_mainUIBtn_hide.DiaoYu:
               View_FishTipBtn.instance.clickHandle();
               break;
            case Enum_mainUIBtn_hide.ShiJieBOSS:
               WorldBossUtil.btnClickHd(null);
               break;
            case Enum_mainUIBtn_hide.DuoRenJingJi:
               UIManager.kuafuBtn.KuaFuBtnClick(null);
               break;
            case Enum_mainUIBtn_hide.KunLunShan:
               View_klTipBtn.instance.clickHandle();
               break;
            case Enum_mainUIBtn_hide.WuLinDaHui:
               Model_wuLin.instance.wulinClick();
               break;
            case Enum_mainUIBtn_hide.BangHuiZhan:
               View_BangTipBtn.instance.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
               break;
            case Enum_mainUIBtn_hide.BangHuiZhongZhi:
               Model_plant.instance.plantBtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
               break;
            case Enum_mainUIBtn_hide.PaoBiao:
               UIManager.paoBiaoPanel.icon.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
   }
}

