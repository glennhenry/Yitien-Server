package com.yiTian.view.modules.guangMingDing
{
   import Layout.VGroup;
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.GuangMingDingCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class Child_EnteredItem extends Sprite
   {
      
      private var _rewardsGridLay:VGroup;
      
      private var _rewardsArr:Array = [];
      
      private var _tfRemain:MyTextField;
      
      private var _tfBestRecord:MyTextField;
      
      private var _btnBegin:Button;
      
      private var _btnReady:Button;
      
      private var _btnCancelReady:Button;
      
      private var _btnIntroduce:Button;
      
      public var _btnInvite:Button;
      
      private var lastStartClickTime:int;
      
      public function Child_EnteredItem()
      {
         var vo:Vo_item = null;
         super();
         ComponentUtil.getBitmap("Back_GuanQia",this,{
            "x":0,
            "y":0
         },Global.GuangMingDing_Imgdm);
         ComponentUtil.getBitmap("FuBen_Img",this,{
            "x":15,
            "y":9
         },Global.GuangMingDing_Imgdm);
         this._tfRemain = ComponentUtil.getTextField("",this,{
            "x":29,
            "y":52,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this._tfBestRecord = ComponentUtil.getTextField("",this,{
            "x":29,
            "y":74,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this._btnIntroduce = ComponentUtil.getButton("","Button_WFSM",this,{
            "x":230,
            "y":12,
            "callBack":this.introduceClickHd
         },Global.GuangMingDing_Imgdm);
         ComponentUtil.getButton("","Button_FanHui",this,{
            "x":24,
            "y":305,
            "callBack":this.returnClickHd
         },Global.GuangMingDing_Imgdm);
         this._btnInvite = ComponentUtil.getButton("","Button_YaoQing",this,{
            "x":104,
            "y":305,
            "callBack":this.inviteClickHd
         },Global.GuangMingDing_Imgdm);
         this._btnBegin = ComponentUtil.getButton("","Button_KaiShi",this,{
            "x":184,
            "y":297,
            "callBack":this.startClickHd
         },Global.GuangMingDing_Imgdm);
         this._btnReady = ComponentUtil.getButton("","Button_Ready",this,{
            "x":184,
            "y":297,
            "callBack":this.readyClickHd
         },Global.GuangMingDing_Imgdm);
         this._btnCancelReady = ComponentUtil.getButton("","Button_Cancel",this,{
            "x":184,
            "y":297,
            "callBack":this.cancelReadyClickHd
         },Global.GuangMingDing_Imgdm);
         this._rewardsGridLay = new VGroup(32,247,0,0,0,49);
         var gridInfos:Array = [];
         var info:Array = GuangMingDingConfig.getStaticRewards();
         var ii:int = 0;
         while(ii < info.length)
         {
            vo = new Vo_item();
            vo.id = info[ii];
            vo.Init_lib();
            gridInfos.push(vo);
            ii += 1;
         }
         this.updateRewards(gridInfos);
         this.recordUpdateHd(Model_guangMingDing.record);
         this.remainUpdateHd(Model_guangMingDing.remain);
         Global.control.registerCallBack(Msg_guangMingDing.GMD_RECORD_UPDATE,this.recordUpdateHd);
         Global.control.registerCallBack(Msg_guangMingDing.GMD_REMAIN_UPDATE,this.remainUpdateHd);
         TipManager.bind(this._btnReady,"点击准备");
         TipManager.bind(this._btnCancelReady,"点击取消准备");
         TipManager.bind(this._btnIntroduce,GuangMingDingConfig.getIntroduceTxt());
      }
      
      private function recordUpdateHd(value:int) : void
      {
         this._tfBestRecord.htmlText = GuangMingDingConfig.getRecordTxt(value);
      }
      
      private function remainUpdateHd(value:int) : void
      {
         this._tfRemain.htmlText = GuangMingDingConfig.getRemainTimsTxt(value);
      }
      
      public function updateRewards(infos:Object) : void
      {
         var vo:Vo_item = null;
         var grid:View_Grid = null;
         for each(vo in infos)
         {
            grid = new View_Grid();
            grid.set_bmp_bg();
            grid.set_bmp_over(true,null);
            grid.vo = vo;
            addChild(grid);
            this._rewardsArr.push(grid);
            this._rewardsGridLay.appendItem(grid);
         }
         this._rewardsGridLay.align();
      }
      
      public function updateBtn() : void
      {
         var info:Array = null;
         if(Model_guangMingDing.isLeader(GameUnitManager.hero.id))
         {
            this._btnInvite.enabled = this._btnInvite.enabled || true;
            this._btnCancelReady.visible = false;
            this._btnReady.visible = false;
            this._btnBegin.visible = true;
            if(Model_guangMingDing.isAllMemberReady())
            {
               this._btnBegin.enabled = true;
               TipManager.bind(this._btnBegin,"点击开始进行");
            }
            else
            {
               this._btnBegin.enabled = false;
               this._btnBegin.mouseEnabled = true;
               TipManager.bind(this._btnBegin,"队员尚未全部准备");
            }
            this._btnInvite.enabled = true;
         }
         else
         {
            info = Model_guangMingDing.findInfoBytePlayerId(GameUnitManager.hero.id);
            this._btnBegin.visible = false;
            if(info[Enum_guangMingDing.MEMBER_ISREAY] == 1)
            {
               this._btnCancelReady.visible = this._btnCancelReady.visible || true;
               this._btnReady.visible = false;
            }
            else
            {
               this._btnReady.visible = this._btnReady.visible || true;
               this._btnCancelReady.visible = false;
            }
            this._btnInvite.enabled = false;
         }
      }
      
      private function returnClickHd(e:MouseEvent) : void
      {
         if(SceneConfig.getSceneType() != SceneConfig.GMD)
         {
            GuangMingDingCGMessage.CG_GMD_LEAVE_TEAM();
         }
      }
      
      private function inviteClickHd(e:MouseEvent) : void
      {
         var invitePnl:View_guangMingDingInvitePanel = Singleton.getInstance(View_guangMingDingInvitePanel);
         Global.delegate.dosomething(invitePnl,invitePnl.visible ? invitePnl.hide : invitePnl.show);
      }
      
      private function startClickHd(e:MouseEvent) : void
      {
         this.begin();
      }
      
      private function readyClickHd(e:MouseEvent) : void
      {
         GuangMingDingCGMessage.CG_GMD_MEMBER_READY(1);
      }
      
      private function cancelReadyClickHd(e:MouseEvent) : void
      {
         GuangMingDingCGMessage.CG_GMD_MEMBER_READY(0);
      }
      
      private function begin() : void
      {
         View_Alert.show("您将进入光眀顶",View_Alert.OK_CANCAL,function():void
         {
            var now:int = getTimer();
            if(now - lastStartClickTime > 5000)
            {
               lastStartClickTime = now;
               GuangMingDingCGMessage.CG_GMD_ENTER_MAP();
            }
            else
            {
               UIManager.centerBroadcast.addMsg("您的操作太频繁，请稍等片刻");
            }
         });
      }
      
      private function introduceClickHd(e:MouseEvent) : void
      {
      }
   }
}

