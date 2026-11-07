package com.yiTian.manager
{
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.valuable.Enum_new_push;
   import com.yiTian.net.handler.FarmHandler;
   import com.yiTian.net.handler.HuaShanHandle;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.FeiXingQi.Model_FeiXingQi;
   import com.yiTian.view.modules.KFHomeland.HomeLandBtn;
   import com.yiTian.view.modules.KFHomeland.VoHome;
   import com.yiTian.view.modules.farm.ViewFarmIcon;
   import com.yiTian.view.modules.guide.View_new_push;
   import com.yiTian.view.modules.mainUIBtnContainer.Enum_mainUIBtn_hide;
   import com.yiTian.view.modules.mainUIBtnContainer.IMainUiBtn;
   import com.yiTian.view.modules.qiJu.QiJu_Btn;
   
   public class NewPushManager
   {
      
      public static var isShow:Boolean = false;
      
      public function NewPushManager()
      {
         super();
      }
      
      public static function showNew(lv:int) : void
      {
         var icon:IMainUiBtn = null;
         var farmView:ViewFarmIcon = null;
         if(lv == Enum_new_push.ZHANG_MEN_REN)
         {
            icon = UIManager.tianTiPanel.addTipBtn();
         }
         else if(lv == Enum_new_push.CHUANG_GUAN)
         {
            icon = Model_FeiXingQi.showTipBtn();
         }
         else if(lv == Enum_new_push.JING_JI_CHANG)
         {
            icon = UIManager.jjc_panel.show_jjc_btn();
         }
         else if(lv == Enum_new_push.TTF)
         {
            icon = UIManager.mainUiBtnContainer.showTTFBtn();
         }
         else if(lv == Enum_new_push.LIN_QI)
         {
            icon = UIManager.lingQiWuHunPanel.showLingBtn();
         }
         else if(lv == Enum_new_push.WU_LIN_SHAN_ZHUANG)
         {
            farmView = ViewFarmIcon.instance;
            FarmHandler.viewFarmIcon = farmView;
            if(!UIManager.mainUiBtnContainer.hasBTN(farmView))
            {
               UIManager.mainUiBtnContainer.addBTN(farmView);
            }
            Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.WuLinShanZhuang,1]);
            icon = farmView;
         }
         else if(lv == Enum_new_push.HUA_SHAN)
         {
            icon = HuaShanHandle.showHSIcon();
         }
         else if(lv == Enum_new_push.ZHENG_LONG)
         {
            icon = QiJu_Btn.instance.show();
         }
         else if(lv == Enum_new_push.WAN_AN)
         {
            icon = UIManager.wanAnSiPanel.showIcon();
         }
         else if(lv == Enum_new_push.HOME && VoHome.isActivity)
         {
            icon = HomeLandBtn.instance.homeBtn;
         }
         if(Boolean(icon))
         {
            if(isShow == true)
            {
               icon.visible = true;
            }
            else
            {
               icon.visible = false;
            }
            deal(lv,icon);
            isShow = false;
         }
      }
      
      private static function deal(level:int, icon:IMainUiBtn) : void
      {
         var pan:View_new_push = null;
         if(Boolean(Data_lib.newPush[level]))
         {
            pan = Singleton.getInstance(View_new_push) as View_new_push;
            (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pan,function():void
            {
               pan.show();
               pan.update(icon,Data_lib.newPush[level][0]);
            });
         }
      }
   }
}

