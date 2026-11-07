package com.yiTian.view.modules.qiJu
{
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.manager.DailyBtnManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.QiJuCGMessage;
   import com.yiTian.view.modules.mainUIBtnContainer.Enum_mainUIBtn_hide;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import com.yiTian.view.modules.mainUIBtnContainer.View_mainUiBtn_container;
   import flash.events.MouseEvent;
   
   public class QiJu_Btn
   {
      
      public static var isInit:Boolean;
      
      private static var _instance:QiJu_Btn;
      
      public var qiJuBtn:MainUIBtn;
      
      public function QiJu_Btn()
      {
         super();
         this.init();
         isInit = true;
      }
      
      public static function get instance() : QiJu_Btn
      {
         if(!_instance)
         {
            _instance = new QiJu_Btn();
         }
         return _instance;
      }
      
      private function init() : void
      {
         this.qiJuBtn = new MainUIBtn("resource/image/qiJu/qiJu.png",null,null,null,true);
      }
      
      public function show() : MainUIBtn
      {
         UIManager.mainUiBtnContainer.addBTN(this.qiJuBtn);
         Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.QiJu,1]);
         this.qiJuBtn.addEventListener(MouseEvent.CLICK,this.onClick);
         this.updateCount(DailyBtnManager.getCount(DailyBtnManager.QI_JU));
         return this.qiJuBtn;
      }
      
      public function updateCount(count:int) : void
      {
         this.qiJuBtn.showTime(count);
         Global.control.sendNotification(Enum_mainUIBtn_hide.SET_COUNT,[Enum_mainUIBtn_hide.QiJu,count]);
      }
      
      public function hide() : void
      {
         UIManager.mainUiBtnContainer.removeBTN(this.qiJuBtn);
         Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.QiJu,2]);
         this.qiJuBtn.removeEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      public function onClick(event:MouseEvent = null) : void
      {
         if(UIManager.mainUiBtnContainer.curFuBenType != 0 && UIManager.mainUiBtnContainer.curFuBenType != View_mainUiBtn_container.QIJU || Global.sceneID == 12304)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("80173",8));
            return;
         }
         if(GameUnitManager.hero.paoBiao != 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("80174",8));
            return;
         }
         if(View_JoinQiJu.instance.visible || UIManager.mainUiBtnContainer.curFuBenType == View_mainUiBtn_container.QIJU)
         {
            return;
         }
         if(Model_team.hasTeam())
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("80141",8));
            return;
         }
         QiJuCGMessage.CG_CLICK_QIJU();
      }
   }
}

