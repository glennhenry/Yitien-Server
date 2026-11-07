package com.yiTian.view.modules.crossClanBattle
{
   import Layout.VGroup;
   import com.ui.controls.Button;
   import com.ui.controls.MaskProgressBar;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.CrossClanBattleCGMessage;
   import com.yiTian.utils.Bitmap2;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Enum_explor;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.baby.babyManager.Model_baby;
   import com.yiTian.view.modules.mainUIBtnContainer.View_mainUiBtn_container;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public final class View_ClanBattleInfo extends Panel
   {
      
      private static const initX:int = 105;
      
      private static const initY:int = 40;
      
      private static var h:int = 22;
      
      public static const bmDirs:Array = ["","resource/image/bangZhan/1.png","resource/image/bangZhan/2.png","resource/image/bangZhan/3.png","resource/image/bangZhan/4.png"];
      
      private var bg:DisplayObject;
      
      private var txtTime:MyTextField;
      
      private var txtClanNameOne:MyTextField;
      
      private var txtClanNameTwo:MyTextField;
      
      private var txtCrystalSelf:MyTextField;
      
      private var txtCrystalEnemy:MyTextField;
      
      private var txtPointOne:MyTextField;
      
      private var txtPointTwo:MyTextField;
      
      private var bm_pbBar:Bitmap;
      
      private var bm_pbBg:Bitmap;
      
      private var pb_kuangTime:MaskProgressBar;
      
      private var btnSearch:Button;
      
      private var btnHelp:Button;
      
      private var lastTime:uint;
      
      private var time:uint;
      
      private var barTime:int;
      
      private var maxBarTime:int;
      
      private var bmSelfArr:Array = [];
      
      private var bmSelfVGroup:VGroup = new VGroup(initX + 55,initY + h * 1,0,0,0,24);
      
      private var bmEnemyArr:Array = [];
      
      private var bmEnemyVGroup:VGroup = new VGroup(initX + 55,initY + h * 3,0,0,0,24);
      
      public function View_ClanBattleInfo()
      {
         super();
         init();
      }
      
      public static function get instance() : View_ClanBattleInfo
      {
         return Singleton.getInstance(View_ClanBattleInfo);
      }
      
      public static function showPanel() : void
      {
         var j:int = 0;
         var spr:Sprite = null;
         var i:int = UIManager.visiblePanels.length - 1;
         while(i >= 0)
         {
            j = UIManager.visiblePanels[i].length - 1;
            while(j >= 0)
            {
               spr = UIManager.visiblePanels[i][j] as Sprite;
               spr.visible = false;
               j--;
            }
            i--;
         }
         if(Model_CrossClanBattle.preTime > 0)
         {
            Global.delegate.dosomething(View_MsgPanel.instance,View_MsgPanel.instance.showPreTime);
         }
         instance.visible = true;
         View_CrossChuanGongIcon.instance.visible = true;
         Global.control.registerCallBack(Enum_MsgType.MSG_LEAVEFB_BTN,instance.leaveCb);
         UIManager.questTraceView.visible = false;
         UIManager.special_btn.visible = false;
         UIManager.newMainBtnContainer.visible = false;
         UIManager.tipBtnContainer.visible = false;
         View_ClanBattleBuffPanel.instance.visible = true;
         Model_baby.isEnableRole_beside_icon = false;
         UIManager.mainUiBtnContainer.showLeaveBtn(View_mainUiBtn_container.KUAFU_BANGZHAN);
         UIManager.mainUiBtnContainer.checkCrossClanBattleBtnVisible(true);
         if(View_AllCityPanel.instance.visible == true)
         {
            View_AllCityPanel.instance.hide();
         }
         if(view_AllSiegeTimePanel.instance.visible == true)
         {
            view_AllSiegeTimePanel.instance.hide();
         }
         if(View_BattleConfirmPanel.instance.visible == true)
         {
            View_BattleConfirmPanel.instance.hide();
         }
         if(UIManager.guajiPanel.visible == true)
         {
            UIManager.guajiPanel.cancel();
         }
         if(View_HelpTipPanel.instance.visible == true)
         {
            View_HelpTipPanel.instance.visible = false;
         }
         View_CrossChuanGongIcon.showAlert();
         UIManager.smallMap.changeBtnEnable(false);
         UIManager.mainMenu.updateCrossClanBtn(false);
      }
      
      public static function hidePanel() : void
      {
         if(View_MsgPanel.instance.visible == true)
         {
            View_MsgPanel.instance.hide();
         }
         View_CrossChuanGongIcon.instance.visible = false;
         View_HelpTipPanel.instance.visible = false;
         UIManager.questTraceView.visible = true;
         UIManager.special_btn.visible = true;
         UIManager.mainMenu.updateCrossClanBtn(true);
         UIManager.mainMenu.visible = true;
         Model_baby.isEnableRole_beside_icon = true;
         UIManager.newMainBtnContainer.visible = true;
         UIManager.tipBtnContainer.visible = true;
         UIManager.teamSignTogether.visible = false;
         View_ClanBattleBuffPanel.instance.visible = false;
         View_CrossChuanGongIcon.hide();
         UIManager.mainUiBtnContainer.checkCrossClanBattleBtnVisible(false);
         UIManager.smallMap.changeBtnEnable(true);
         UIManager.mainMenu.resetPosition();
         UIManager.special_btn.resetPosition();
         UIManager.mainUiBtnContainer.resetPosition();
      }
      
      override protected function initStaticView() : void
      {
         this.bg = ComponentUtil.getScaleBitmap("Back_HuoDong",[60,36,3,5],this,{
            "x":0,
            "y":0,
            "width":295,
            "height":165
         },Global.Img_Cdm);
         ComponentUtil.getTextField("公会战信息",this,{
            "x":116,
            "y":6,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("战场时间：",this,{
            "x":36,
            "y":initY,
            "color":13424242,
            "size":12,
            "leading":0
         });
         this.txtClanNameOne = ComponentUtil.getTextField("本帮资源：",this,{
            "x":36,
            "y":initY + h,
            "color":13424242,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("本帮水晶：",this,{
            "x":36,
            "y":initY + h * 2,
            "color":13424242,
            "size":12,
            "leading":0
         });
         this.txtClanNameTwo = ComponentUtil.getTextField("敌帮资源：",this,{
            "x":36,
            "y":initY + h * 3,
            "color":13424242,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("敌帮水晶：",this,{
            "x":36,
            "y":initY + h * 4,
            "color":13424242,
            "size":12,
            "leading":0
         });
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
         this.txtPointOne = ComponentUtil.getTextField("00000",this,{
            "x":initX,
            "y":initY + h,
            "color":16776960,
            "size":12,
            "leading":0
         });
         this.txtPointTwo = ComponentUtil.getTextField("00000",this,{
            "x":initX,
            "y":initY + h * 3,
            "color":16776960,
            "size":12,
            "leading":0
         });
         this.txtCrystalSelf = ComponentUtil.getTextField("00000",this,{
            "x":initX,
            "y":initY + h * 2,
            "color":16776960,
            "size":12,
            "leading":0
         });
         this.txtCrystalEnemy = ComponentUtil.getTextField("00000",this,{
            "x":initX,
            "y":initY + h * 4,
            "color":16776960,
            "size":12,
            "leading":0
         });
         this.txtTime = ComponentUtil.getTextField("00:00:00",this,{
            "x":initX,
            "y":initY,
            "color":16776960,
            "size":14,
            "leading":0
         });
         this.btnHelp = ComponentUtil.getButton("","Button_HDTips",this,{
            "x":241,
            "y":2,
            "textColor":16184781,
            "callBack":this.showHelpTip
         },Global.Img_Cdm);
         Enum_explor.bindDic[Enum_explor.BTN_CROSS_CLAN_HELP] = this.btnHelp;
         Global.control.registerCallBack(Enum_MsgType.MSG_LEAVEFB_BTN,this.leaveCb);
      }
      
      private function showHelpTip(e:MouseEvent) : void
      {
         View_HelpTipPanel.instance.showIn();
      }
      
      public function getBtnPoint(_target:Object) : Point
      {
         return localToGlobal(new Point(_target.x,_target.y));
      }
      
      public function start() : void
      {
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.frameStep);
      }
      
      public function show(time:uint, data:Array) : void
      {
         visible = true;
         this.time = time;
         var timeStr:String = DateUtil.getMSBySecond2(time < 0 ? 0 : time);
         this.txtPointOne.htmlText = data[2];
         this.txtPointTwo.htmlText = data[5];
         this.txtTime.htmlText = timeStr;
         this.updateSelfLord(data[6]);
         this.updateEnemyLord(data[7]);
         this.barTime = data[8];
         this.maxBarTime = data[9];
      }
      
      public function refreshBlood(party:String, blood:String) : void
      {
         if(Model_heFu.compareServName(party,GameUnitManager.hero.party))
         {
            this.txtCrystalSelf.htmlText = blood;
         }
         else
         {
            this.txtCrystalEnemy.htmlText = blood;
         }
      }
      
      public function hide() : void
      {
         visible = false;
         GameUnitManager.hero.status = Status.NOMAL;
         Global.control.removeCallBack(Enum_MsgType.MSG_LEAVEFB_BTN,this.leaveCb);
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.frameStep);
      }
      
      public function leaveCb() : void
      {
         CrossClanBattleCGMessage.CG_KUAFUCLAN_BATTLE_EXIT();
      }
      
      private function frameStep() : void
      {
         var timeStr:String = null;
         var now:uint = uint(getTimer());
         if(now - this.lastTime > 1000)
         {
            --this.time;
            timeStr = DateUtil.getMSBySecond2(this.time);
            this.txtTime.htmlText = timeStr;
            this.lastTime = now;
            if(this.time <= 0)
            {
               Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.frameStep);
            }
         }
      }
      
      public function updateSelfLord(bArr:Array) : void
      {
         var bm:Bitmap2 = null;
         var bmm:Bitmap2 = null;
         for each(bm in this.bmSelfArr)
         {
            removeChild(bm);
            bm.load(null);
         }
         this.bmSelfArr.splice(0);
         this.bmSelfVGroup.clearItem();
         if(!bArr.length)
         {
            return;
         }
         var j:int = 0;
         while(j < bArr.length)
         {
            bmm = new Bitmap2();
            bmm.load(bmDirs[bArr[j]]);
            this.bmSelfVGroup.appendItem(bmm);
            this.bmSelfArr.push(bmm);
            addChild(bmm);
            j += 1;
         }
         this.bmSelfVGroup.align();
      }
      
      public function updateEnemyLord(bArr:Array) : void
      {
         var bm:Bitmap2 = null;
         var bmm:Bitmap2 = null;
         for each(bm in this.bmEnemyArr)
         {
            removeChild(bm);
            bm.load(null);
         }
         this.bmEnemyArr.splice(0);
         this.bmEnemyVGroup.clearItem();
         if(!bArr.length)
         {
            return;
         }
         var j:int = 0;
         while(j < bArr.length)
         {
            bmm = new Bitmap2();
            bmm.load(bmDirs[bArr[j]]);
            this.bmEnemyVGroup.appendItem(bmm);
            this.bmEnemyArr.push(bmm);
            addChild(bmm);
            j += 1;
         }
         this.bmEnemyVGroup.align();
      }
      
      override public function resetPosition() : void
      {
         x = Global.stage.stageWidth - this.width;
         y = (Global.stage.stageHeight - this.height) / 2 + 85;
      }
      
      override public function get height() : Number
      {
         if(!this.bg)
         {
            return super.height;
         }
         return this.bg.height;
      }
      
      override public function get width() : Number
      {
         if(!this.bg)
         {
            return super.width;
         }
         return this.bg.width;
      }
   }
}

