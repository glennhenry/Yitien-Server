package com.yiTian.view.modules.mainUIBtnContainer
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.FeiXingQi.Model_FeiXingQi;
   import com.yiTian.view.modules.farm.ViewFarmIcon;
   import com.yiTian.view.modules.jianghulixian.View_Jianghulixian_icon;
   import flash.events.MouseEvent;
   
   public class View_RiChangWanFa_menu extends HideMenuBase
   {
      
      private static var _instance:View_RiChangWanFa_menu;
      
      public function View_RiChangWanFa_menu()
      {
         super(Enum_mainUIBtn_hide.RiChangWanFa);
      }
      
      public static function get instance() : View_RiChangWanFa_menu
      {
         if(!_instance)
         {
            _instance = new View_RiChangWanFa_menu();
         }
         return _instance;
      }
      
      override protected function initStaticView() : void
      {
         super.initStaticView();
         ComponentUtil.getBitmap("Title_RCWF",this,{
            "x":184,
            "y":5
         },Global.Img_Cdm);
         this.setItemStatus([Enum_mainUIBtn_hide.WuLinShanZhuang,1]);
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
            case Enum_mainUIBtn_hide.ChuangGuan:
               Model_FeiXingQi.tipBtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
               break;
            case Enum_mainUIBtn_hide.JiangHuLiXian:
               View_Jianghulixian_icon.instance.onClickHandle();
               break;
            case Enum_mainUIBtn_hide.WuLinShanZhuang:
               ViewFarmIcon.instance.clickHandle();
               break;
            case Enum_mainUIBtn_hide.LingQi:
               UIManager.lingQiWuHunPanel.lingBtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
   }
}

