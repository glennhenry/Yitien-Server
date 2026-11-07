package com.yiTian.view.modules.mainUIBtnContainer
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.guangMingDing.GuangMingDingConfig;
   import com.yiTian.view.modules.qiJu.QiJu_Btn;
   import flash.events.MouseEvent;
   
   public class View_XiaZheShiLian_menu extends HideMenuBase
   {
      
      private static var _instance:View_XiaZheShiLian_menu;
      
      public function View_XiaZheShiLian_menu()
      {
         super(Enum_mainUIBtn_hide.XiaZheShiLian);
      }
      
      public static function get instance() : View_XiaZheShiLian_menu
      {
         if(!_instance)
         {
            _instance = new View_XiaZheShiLian_menu();
         }
         return _instance;
      }
      
      override protected function initStaticView() : void
      {
         super.initStaticView();
         ComponentUtil.getBitmap("Title_XZSL",this,{
            "x":184,
            "y":5
         },Global.Img_Cdm);
         setItemStatus([Enum_mainUIBtn_hide.ZhangMenRen,1]);
         setItemStatus([Enum_mainUIBtn_hide.TongTianFeng,2]);
         setItemStatus([Enum_mainUIBtn_hide.GuangMingDing,2]);
         setItemStatus([Enum_mainUIBtn_hide.JingJiChang,1]);
      }
      
      override protected function onClickEnter(id:int) : void
      {
         switch(id)
         {
            case Enum_mainUIBtn_hide.ZhangMenRen:
               UIManager.tianTiPanel.imgBtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
               break;
            case Enum_mainUIBtn_hide.TongTianFeng:
               UIManager.mainUiBtnContainer.enterTTFBtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
               break;
            case Enum_mainUIBtn_hide.GuangMingDing:
               GuangMingDingConfig.btnClick(null);
               break;
            case Enum_mainUIBtn_hide.WanAnSi:
               UIManager.wanAnSiPanel.icon.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
               break;
            case Enum_mainUIBtn_hide.QiJu:
               QiJu_Btn.instance.onClick();
               break;
            case Enum_mainUIBtn_hide.JingJiChang:
               UIManager.jjc_panel.jingBtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
   }
}

