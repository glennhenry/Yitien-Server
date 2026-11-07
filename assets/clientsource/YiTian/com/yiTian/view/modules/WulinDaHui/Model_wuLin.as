package com.yiTian.view.modules.WulinDaHui
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.WulinPartyHandle;
   import com.yiTian.net.message.cg.WulinPartyCGMessage;
   import com.yiTian.view.modules.mainUIBtnContainer.Enum_mainUIBtn_hide;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   
   public class Model_wuLin
   {
      
      private static var _instance:Model_wuLin;
      
      private var wlEff:Effect;
      
      private var _wulinBtn:MainUIBtn;
      
      public var rs:Boolean = false;
      
      private var _bEff:Boolean = false;
      
      public function Model_wuLin()
      {
         super();
      }
      
      public static function get instance() : Model_wuLin
      {
         if(!_instance)
         {
            _instance = new Model_wuLin();
         }
         return _instance;
      }
      
      public function show_wulin_btn(hasEff:Boolean) : void
      {
         this._bEff = hasEff;
         if(GameUnitManager.hero.level < 30)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP,this.wulinBtnLogin);
         }
         else
         {
            this.wulinBtnLogin();
            Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP,this.wulinBtnLogin);
         }
      }
      
      public function remove_wulin_btn() : void
      {
         Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP,this.wulinBtnLogin);
         if(Boolean(this.wulinBtn))
         {
            UIManager.mainUiBtnContainer.removeBTN(this.wulinBtn);
         }
         if(Boolean(this.wlEff))
         {
            EffectManager.removeEffect(this.wlEff);
            this.wlEff = null;
            this._bEff = false;
         }
         Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.WuLinDaHui,2]);
      }
      
      private function wulinBtnLogin() : void
      {
         if(GameUnitManager.hero.level < 30)
         {
            return;
         }
         if(this.rs)
         {
            WulinPartyHandle.getTishi();
            this.rs = false;
         }
         Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP,this.wulinBtnLogin);
         if(!this.wulinBtn)
         {
            this._wulinBtn = new MainUIBtn("resource/image/wulinParty/wulinPar.png",null,null,null,true);
            this.wulinBtn.addEventListener(MouseEvent.CLICK,this.wulinClick);
         }
         if(this._bEff && !this.wlEff)
         {
            this.wlEff = EffectManager.addEffect("35343",this.wulinBtn,1000,32,29,true);
         }
         if(!this._bEff && Boolean(this.wlEff))
         {
            EffectManager.removeEffect(this.wlEff);
            this.wlEff = null;
         }
         UIManager.mainUiBtnContainer.addBTN(this.wulinBtn);
         Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.WuLinDaHui,1]);
      }
      
      public function wulinClick(e:MouseEvent = null) : void
      {
         if(GameUnitManager.hero.status == Status.NOMAL || GameUnitManager.hero.status == Status.SIT)
         {
            if(GameUnitManager.hero.level < 30)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("10506",1,30));
               return;
            }
            WulinPartyCGMessage.CG_WULIN_ENTER_RESULT_HANDLE();
         }
         else if(GameUnitManager.hero.status == Status.WU_LING)
         {
            UIManager.wulin_intro.visible = !UIManager.wulin_intro.visible;
            UIManager.wulin_intro.setTile(2);
         }
      }
      
      public function get wulinBtn() : MainUIBtn
      {
         return this._wulinBtn;
      }
   }
}

