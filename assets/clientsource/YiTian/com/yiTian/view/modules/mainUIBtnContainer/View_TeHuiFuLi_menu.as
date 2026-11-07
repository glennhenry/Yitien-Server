package com.yiTian.view.modules.mainUIBtnContainer
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.fund.FundConfig;
   import com.yiTian.view.modules.tuanGou.ViewTuanGouTip;
   import com.yiTian.view.modules.worldLevel.View_wlRewardBtn;
   import flash.events.MouseEvent;
   
   public class View_TeHuiFuLi_menu extends HideMenuBase
   {
      
      private static var _instance:View_TeHuiFuLi_menu;
      
      public function View_TeHuiFuLi_menu()
      {
         super(Enum_mainUIBtn_hide.TeHuiFuLi);
      }
      
      public static function get instance() : View_TeHuiFuLi_menu
      {
         if(!_instance)
         {
            _instance = new View_TeHuiFuLi_menu();
         }
         return _instance;
      }
      
      override protected function initStaticView() : void
      {
         super.initStaticView();
         ComponentUtil.getBitmap("Title_THFL",this,{
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
               (itemArray[i] as hideMenuListItem).setStatus(arr[1],arr[2]);
               break;
            }
         }
         sort();
      }
      
      override protected function onClickEnter(id:int) : void
      {
         switch(id)
         {
            case Enum_mainUIBtn_hide.JingCaiHuoDong:
               UIManager.actKaiFu.bmBtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
               break;
            case Enum_mainUIBtn_hide.JiJin:
               FundConfig.mainBtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
               break;
            case Enum_mainUIBtn_hide.TuanGou:
               ViewTuanGouTip.instance.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
               break;
            case Enum_mainUIBtn_hide.ShiJieFuLi:
               View_wlRewardBtn.instance.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
   }
}

