package com.yiTian.view.modules.guangMingDing
{
   import Layout.VGroup;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.GuangMingDingCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.pet.PetPanel;
   import com.yiTian.view.modules.pet.PetVO;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class View_guangMingDingTeamPanel extends Panel123
   {
      
      private var _tfRoomIndex:MyTextField;
      
      private var _tfNumPlayer:MyTextField;
      
      private var _bmLock:Bitmap;
      
      private var _bmUnlock:Bitmap;
      
      private var _playerModels:Array = [];
      
      private var _rewardsGridLay:VGroup;
      
      private var _rewardsArr:Array = [];
      
      private var _bg:DisplayObject;
      
      public var _enteredItem:Child_EnteredItem;
      
      public var _modelPosArr:Array = [317,356,4,121,310,4,525,304,4];
      
      private var _lockSp:Sprite;
      
      private var pool:Array = [];
      
      public function View_guangMingDingTeamPanel()
      {
         super();
         regResource("lang/ch/GuangMingDing_Img.swf","GuangMingDing_Imgdm");
         super.visible = false;
      }
      
      public static function getInstance() : View_guangMingDingTeamPanel
      {
         return Singleton.getInstance(View_guangMingDingTeamPanel);
      }
      
      override protected function initUI2() : void
      {
         this._bg = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":908,
            "height":470
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_YCGMD",this,{
            "x":374,
            "y":5
         },Global.GuangMingDing_Imgdm);
         ComponentUtil.getBitmap("Back_Team",this,{
            "x":24,
            "y":40
         },Global.GuangMingDing_Imgdm);
         ComponentUtil.getBitmap("Back_Inf",this,{
            "x":26,
            "y":42
         },Global.GuangMingDing_Imgdm);
         move = new Rectangle(0,0,this._bg.width,35);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":874,
            "y":6,
            "callBack":this.hideAndLeave
         },Global.Img_Cdm);
         this._lockSp = new Sprite();
         this._lockSp.x = 38;
         this._lockSp.y = 49;
         addChild(this._lockSp);
         this._bmLock = ComponentUtil.getBitmap("Lock_Img",this._lockSp,null,Global.GuangMingDing_Imgdm);
         this._bmUnlock = ComponentUtil.getBitmap("UnLock_Img",this._lockSp,{"visible":false},Global.GuangMingDing_Imgdm);
         this._lockSp.addEventListener(MouseEvent.ROLL_OVER,this.lockOverHd);
         this._lockSp.addEventListener(MouseEvent.ROLL_OUT,this.lockOutHd);
         this._lockSp.addEventListener(MouseEvent.MOUSE_MOVE,this.lockMoveHd);
         this._lockSp.buttonMode = true;
         this._lockSp.addEventListener(MouseEvent.CLICK,this.lockClickHd);
         this._tfRoomIndex = ComponentUtil.getTextField("",this,{
            "x":85,
            "y":50
         });
         this._tfNumPlayer = ComponentUtil.getTextField("",this,{
            "x":120,
            "y":50
         });
         this._enteredItem = new Child_EnteredItem();
         this._enteredItem.x = 584;
         this._enteredItem.y = 46;
         addChild(this._enteredItem);
         bAutoRemove = false;
         Global.control.registerCallBack(Msg_guangMingDing.GMD_PASSWORD_CHANGE,this.updatePassWord);
      }
      
      private function lockMoveHd(e:MouseEvent) : void
      {
         var pwTxt:String = Model_guangMingDing.passWord != "" ? "当前密码：<font color=\'#ffff33\'>" + Model_guangMingDing.passWord + "</font>" : "您还没有设置密码";
         pwTxt += "<font color=\'#33ff33\'><br>点击可修改密码</font>";
         TipManager.update(pwTxt);
      }
      
      private function lockOverHd(e:MouseEvent) : void
      {
         this._lockSp.transform.colorTransform = Util.colorWhite2;
      }
      
      private function lockOutHd(e:MouseEvent) : void
      {
         this._lockSp.transform.colorTransform = Util.colorNomal;
         TipManager.hide();
      }
      
      private function lockClickHd(e:MouseEvent) : void
      {
         Global.delegate.dosomething(View_gmdPassWordChangePnl.instance,function():void
         {
            View_gmdPassWordChangePnl.instance.show(2);
            View_gmdPassWordChangePnl.instance.setTxt(Model_guangMingDing.passWord);
         });
      }
      
      public function showPetInfoView(petVO:PetVO) : void
      {
         UIManager.petInfoPanel.petVO = petVO;
         UIManager.petInfoPanel.update();
         this.petInfoVisible(true);
      }
      
      public function petInfoVisible(value:Boolean) : void
      {
         var point:Point = null;
         PetPanel.curPanel = this;
         UIManager.petInfoPanel.visible = value;
         point = localToGlobal(new Point(mouseX,mouseY));
         UIManager.petInfoPanel.x = point.x;
         UIManager.petInfoPanel.y = point.y - 280;
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
      
      public function updateRoomID(id:Number) : void
      {
         this._tfRoomIndex.text = "NO." + id.toString();
      }
      
      public function updatePassWord(pw:String) : void
      {
         this._bmLock.visible = pw != "";
         this._bmUnlock.visible = !this._bmLock.visible;
      }
      
      public function updateMembers(infos:Object) : void
      {
         var u:UnitComp = null;
         var i:int = 0;
         var info:Array = null;
         i = 0;
         while(i < infos.length)
         {
            info = infos[i];
            if(!this._playerModels[i])
            {
               u = Boolean(this.pool.length) ? this.pool.shift() : new UnitComp();
               this._playerModels.push(u);
               u.x = this._modelPosArr[i * 3];
               u.y = this._modelPosArr[i * 3 + 1];
               u._model.way = this._modelPosArr[i * 3 + 2];
            }
            else
            {
               u = this._playerModels[i];
            }
            addChild(u);
            u.update(info);
            i += 1;
         }
         var j:int = this._playerModels.length - 1;
         while(j >= i)
         {
            u = this._playerModels[j];
            removeChild(u);
            this._playerModels.splice(j,1);
            this.pool.push(u);
            j -= 1;
         }
         this._lockSp.mouseEnabled = Model_guangMingDing.isLeader(GameUnitManager.hero.id);
         SelectedMenu.instance.visible = false;
      }
      
      private function onFrame(i:int) : void
      {
         var unit:UnitComp = null;
         for each(unit in this._playerModels)
         {
            if(unit._model.modelId != 0 && Boolean(unit.visible))
            {
               unit._model.onFrame(i);
            }
         }
      }
      
      public function show(param:* = null) : void
      {
         if(SceneConfig.getSceneType() == SceneConfig.GMD)
         {
            this.hide();
            return;
         }
         this.visible = true;
         pop();
      }
      
      public function hide(param:* = null) : void
      {
         this.visible = false;
      }
      
      public function hideAndLeave(param:* = null) : void
      {
         this.visible = false;
         if(SceneConfig.getSceneType() != SceneConfig.GMD)
         {
            GuangMingDingCGMessage.CG_GMD_LEAVE_TEAM();
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onFrame);
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_SCENE,this.changeScene);
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_FUBEN,this.changeScene);
            GuangMingDingConfig.checkToCancelGuaJi();
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onFrame);
            Global.control.sendNotification(Msg_guangMingDing.TEAMPANEL_HIDE,this);
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTER_SCENE,this.changeScene);
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTER_FUBEN,this.changeScene);
            this.clearEffect();
         }
         super.visible = value;
         Model_guangMingDing.isTeamShow = value;
      }
      
      public function clearEffect() : void
      {
         var u:UnitComp = null;
         for each(u in this._playerModels)
         {
            u.clearEff();
         }
      }
      
      private function changeScene(sId:int) : void
      {
         this.visible = false;
         if(SceneConfig.getSceneType() != SceneConfig.GMD)
         {
            this.hideAndLeave();
            Model_guangMingDing.teamPnlHideFlag = false;
         }
      }
      
      override public function get width() : Number
      {
         return this._bg.width;
      }
      
      override public function get height() : Number
      {
         return this._bg.height;
      }
   }
}

import Layout.HGroup;
import Layout.ILayout;
import com.ui.controls.Button;
import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.utils.Util;
import com.yiTian.Global;
import com.yiTian.command.Enum_MsgType;
import com.yiTian.data.config.Enum_job;
import com.yiTian.data.model.Model_heFu;
import com.yiTian.gameUnit.magic.Effect;
import com.yiTian.manager.EffectManager;
import com.yiTian.manager.GameUnitManager;
import com.yiTian.manager.UIManager;
import com.yiTian.net.handler.GuangMingDingCGMessage;
import com.yiTian.net.message.cg.ChatCGMessage;
import com.yiTian.net.message.cg.PetCGMessage;
import com.yiTian.utils.Bitmap2;
import com.yiTian.utils.Singleton;
import com.yiTian.view.modules.guangMingDing.Enum_guangMingDing;
import com.yiTian.view.modules.guangMingDing.Model_guangMingDing;
import com.yiTian.view.modules.guangMingDing.Msg_guangMingDing;
import com.yiTian.view.modules.guangMingDing.View_guangMingDingTeamPanel;
import com.yiTian.view.modules.tianTi.Child_tianTiUnit;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextFieldAutoSize;

class UnitComp extends Sprite
{
   
   public var _tfName:MyTextField;
   
   private var _effLayer:Sprite;
   
   public var _model:Child_tianTiUnit;
   
   public var id:Number = 0;
   
   private var bmTrace:Bitmap2;
   
   public var _data:Array;
   
   private var _eff:Effect;
   
   public function UnitComp()
   {
      super();
      this._effLayer = new Sprite();
      addChild(this._effLayer);
      this._model = new Child_tianTiUnit();
      addChild(this._model);
      this._model.buttonMode = true;
      this._tfName = ComponentUtil.getTextField("",this,{
         "y":-155,
         "realWidth":0,
         "leading":3
      });
      this._tfName.align = "center";
      this._tfName.autoSize = TextFieldAutoSize.CENTER;
      this.bmTrace = new Bitmap2();
      this.bmTrace.x = 27;
      this.bmTrace.y = -150;
      addChild(this.bmTrace);
      this._model.addEventListener(MouseEvent.CLICK,this.onModelClick);
      this._model.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
      this._model.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
      Global.control.removeCallBack(Msg_guangMingDing.TEAMPANEL_HIDE,this.onTeamPnlHide);
   }
   
   public function update(info:Array) : void
   {
      this._data = info;
      var job:int = int(info[Enum_guangMingDing.MEMBER_JOB]);
      var nameTxt:String = Enum_job.getJobColorStr(Model_heFu.repNameByHero(info[Enum_guangMingDing.MEMBER_NAME]),job);
      if(info[Enum_guangMingDing.MEMBER_POSTION] == 0)
      {
         nameTxt = "<font color=\'#ffdd22\'>【队长】</font>" + nameTxt;
      }
      nameTxt += "<font color=\'#33ff33\'>\n等级." + info[Enum_guangMingDing.MEMBER_LEVEL].toString() + "</font>";
      this._tfName.htmlText = nameTxt;
      this._model.type = Child_tianTiUnit.PLAYER;
      this._model.job = job;
      this._model.sex = info[Enum_guangMingDing.MEMBER_SEX];
      this._model.modelId = info[Enum_guangMingDing.MEMBER_FASHION];
      this._model.weaponDir = info[Enum_guangMingDing.MEMBER_WEAPON].toString();
      this._model.wing = info[Enum_guangMingDing.MEMBER_WING];
      this.id = info[Enum_guangMingDing.MEMBER_ROLEID];
      this._model.updateLayer();
      this.setReady(info[Enum_guangMingDing.MEMBER_ISREAY] == 1);
   }
   
   public function setReady(v:Boolean) : void
   {
      if(Model_guangMingDing.isLeader(this._data[Enum_guangMingDing.MEMBER_ROLEID]))
      {
         if(!this._eff)
         {
            this._eff = EffectManager.addEffect("35178",this._effLayer,1000,0,-10,true);
         }
         this.bmTrace.load("resource/image/kuafujingjichang/kaishi.png");
      }
      else if(v)
      {
         if(!this._eff)
         {
            this._eff = EffectManager.addEffect("35178",this._effLayer,1000,0,-10,true);
         }
         this.bmTrace.load("resource/image/kuafujingjichang/zb.png");
      }
      else
      {
         if(Boolean(this._eff))
         {
            EffectManager.removeEffect(this._eff);
            this._eff = null;
         }
         this.bmTrace.load(null);
      }
   }
   
   public function clearEff() : void
   {
      if(Boolean(this._eff))
      {
         EffectManager.removeEffect(this._eff);
         this._eff = null;
      }
   }
   
   private function onTeamPnlHide() : void
   {
      if(Boolean(this._eff))
      {
         EffectManager.removeEffect(this._eff);
         this._eff = null;
      }
      this.bmTrace.load(null);
   }
   
   private function onModelClick(e:MouseEvent) : void
   {
      var sm:SelectedMenu = null;
      sm = SelectedMenu.instance;
      sm.clear();
      if(this.id == GameUnitManager.hero.id)
      {
         return;
      }
      sm.appendItem("私聊",this.chat);
      sm.appendItem("查看资料",this.check);
      sm.appendItem("查看宠物",this.checkPet);
      if(Model_guangMingDing.isLeader(GameUnitManager.hero.id))
      {
         sm.appendItem("转移队长",this.swapLeader);
         sm.appendItem("踢出队伍",this.kickMember);
      }
      else if(Model_guangMingDing.isLeader(this.id))
      {
         sm.appendItem("申请队长",this.applyLeader);
      }
      addChild(sm);
      sm.visible = true;
      sm.x = mouseX;
      sm.y = mouseY;
      Global.stage.addEventListener(MouseEvent.CLICK,this.onStageClick,true);
   }
   
   private function applyLeader(p:* = null) : void
   {
      UIManager.centerBroadcast.addMsg("请求已发送，等待对方回复");
      GuangMingDingCGMessage.CG_GMD_APPLY_TEAMLEADER(this.id);
   }
   
   private function kickMember(p:* = null) : void
   {
      GuangMingDingCGMessage.CG_GMD_KICK_TEAMMEMBER(this.id);
   }
   
   private function chat(p:* = null) : void
   {
      ChatCGMessage.CG_SID_CHAT(this.id);
   }
   
   private function check(p:* = null) : void
   {
      Global.control.sendNotification(Enum_MsgType.MSG_CHECKOTHERROLE,this.id);
   }
   
   private function swapLeader(p:* = null) : void
   {
      GuangMingDingCGMessage.CG_GMD_SWAP_TEAMLEADER(this.id);
   }
   
   private function checkPet(p:* = null) : void
   {
      var petID:Number = Number(this._data[Enum_guangMingDing.MEMBER_PETID]);
      if(petID != 0)
      {
         PetCGMessage.CG_PET_OTHER_INFO(petID);
         View_guangMingDingTeamPanel.getInstance().petInfoVisible(true);
      }
   }
   
   private function onRollOver(e:MouseEvent) : void
   {
      this._model.transform.colorTransform = Util.colorWhite2;
   }
   
   private function onRollOut(e:MouseEvent) : void
   {
      this._model.transform.colorTransform = Util.colorNomal;
   }
   
   private function onStageClick(e:Event) : void
   {
      if(!contains(e.target as DisplayObject))
      {
         SelectedMenu.instance.visible = false;
         Global.stage.removeEventListener(MouseEvent.CLICK,this.onStageClick,true);
      }
   }
}

class SelectedMenu extends Sprite
{
   
   public static var pool:Array = [];
   
   public var gi:ILayout;
   
   public var bg:DisplayObject;
   
   public var btns:Array = [];
   
   public function SelectedMenu()
   {
      super();
      this.gi = this.gi || new HGroup(5,4,0,0,0,20);
      addEventListener(MouseEvent.CLICK,this.onClick);
      this.bg = ComponentUtil.getScaleBitmap("Back_Floating",[8,9,4,2],this,{
         "x":0,
         "y":0,
         "width":87,
         "height":95
      },Global.Img_Cdm);
   }
   
   public static function get instance() : SelectedMenu
   {
      return Singleton.getInstance(SelectedMenu);
   }
   
   public function appendItem(label:String, callBack:Function) : void
   {
      var btn:Button = Boolean(pool.length) ? pool.pop() : ComponentUtil.getButton("","ChannelButtonFour",null,null);
      btn.label = label;
      btn.callBack = callBack;
      addChild(btn);
      this.gi.appendItem(btn);
      this.btns.push(btn);
      addEventListener(Event.EXIT_FRAME,this.align);
   }
   
   public function clear() : void
   {
      var o:DisplayObject = null;
      this.gi.clearItem();
      while(Boolean(this.btns.length))
      {
         o = this.btns.pop();
         removeChild(o);
         pool.push(o);
      }
   }
   
   private function onClick(e:MouseEvent) : void
   {
      visible = false;
   }
   
   public function align(param:* = null) : void
   {
      this.gi.align();
      this.bg.width = 88;
      this.bg.height = this.btns.length * 20 + 9;
      removeEventListener(Event.EXIT_FRAME,this.align);
   }
}
