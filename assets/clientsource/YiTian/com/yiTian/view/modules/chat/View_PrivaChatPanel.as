package com.yiTian.view.modules.chat
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScrollBar;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Const_strImg;
   import com.yiTian.data.config.KeyBoardConst;
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.gameUnit.role.Hero;
   import com.yiTian.manager.BattleManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.ChatCGMessage;
   import com.yiTian.net.message.cg.FriendCGMessage;
   import com.yiTian.net.message.cg.TeamCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Bitmap2;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.StrFilter;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel2;
   import com.yiTian.view.modules.chatM.ChatL;
   import com.yiTian.view.modules.chatM.FaceChooser;
   import com.yiTian.view.modules.friends.Model_Friends;
   import com.yiTian.view.modules.roleHead.View_HeroHead;
   import com.yiTian.view.modules.tianTi.Child_tianTiUnit;
   import com.yiTian.view.modules.yellowDiamond.Model_init;
   import com.yiTian.view.modules.zhuanZhi.View_ZhuanZhiAtbSp;
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.system.IME;
   import flash.text.TextFieldType;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class View_PrivaChatPanel extends Panel2
   {
      
      private static var _otherRoleIcon:int;
      
      public static var pool:Array = [];
      
      private static const VIPBMDIRSET:Array = [View_HeroHead.VIP_DISABLED,View_HeroHead.VIP1,View_HeroHead.VIP2,View_HeroHead.VIP3,View_HeroHead.VIP_DISABLED];
      
      private var back:DisplayObjectContainer;
      
      private var face:Button;
      
      private var Transaction:Button;
      
      private var check:Button;
      
      private var team:Button;
      
      private var addFriend:Button;
      
      private var email:Button;
      
      private var Button_Minimze:Button;
      
      private var Button_close01:Button;
      
      private var Button_SiLiao_send:Button;
      
      private var PlayerName_text:MyTextField;
      
      private var siliao_inputTxt:MyTextField;
      
      private var roleName:String = "";
      
      private var _btnCheck:Button;
      
      private var _btnPresentFlower:Button;
      
      private var pri_btn_tishi:PriChat_tishi;
      
      private var priList:ChatList;
      
      private var _med:ChatMediator;
      
      private var _targetModel:Child_tianTiUnit = new Child_tianTiUnit();
      
      private var _targetHeadNameTf:MyTextField;
      
      private var _targetVipSp:Sprite;
      
      private var _targetVipBm:Bitmap2;
      
      private var _targetJobDirLabel:View_ZhuanZhiAtbSp;
      
      private var _tfTargetName:MyTextField;
      
      private var _myModel:Child_tianTiUnit = new Child_tianTiUnit();
      
      private var _myHeadNameTf:MyTextField;
      
      private var _myVipSp:Sprite;
      
      private var _myVipBm:Bitmap2;
      
      private var _myJobDirLabel:View_ZhuanZhiAtbSp;
      
      private var _tfMyName:MyTextField;
      
      private var bmbg:Bitmap;
      
      private var timeArr:Array = [];
      
      private var faceChooser:FaceChooser;
      
      private var nowChatChann:ChatL;
      
      private var flag:Boolean = false;
      
      private var _time:int;
      
      private var _isFriend:int;
      
      private var _otherRoleMap:String;
      
      private var headBM:Bitmap;
      
      private var isLoad:Boolean = false;
      
      private var _isInitComplete:Boolean = false;
      
      public function View_PrivaChatPanel()
      {
         super();
         init();
      }
      
      public static function pop() : View_PrivaChatPanel
      {
         return Boolean(pool.length) ? pool.pop() : new View_PrivaChatPanel();
      }
      
      public function set med(value:ChatMediator) : void
      {
         this._med = value;
         if(Boolean(value))
         {
            value.targetPanel = this;
            this.bmbg = Utils.getLoadBitmap("resource/image/iconBg/grid_Skill_open.png",this.bmbg,{
               "x":8,
               "y":7
            });
            addChild(this.bmbg);
            this.headBM = Utils.getLoadBitmap(Const_strImg.getPlayerHead(this._med.roleJob,this.med.roleSex,2),this.headBM,{
               "x":11,
               "y":10
            });
            this.resetNameText();
            addChild(this.headBM);
         }
      }
      
      private function resetNameText() : void
      {
         var isFriend:Boolean = false;
         if(Boolean(this._med))
         {
            this.PlayerName_text.htmlText = this._med.roleName;
            isFriend = Model_Friends.getFriendVoById(this._med.roleId) != null || Boolean(Model_Friends.getCrossFriendVoById(this._med.roleId));
            this.PlayerName_text.htmlText += isFriend ? LangConfig.getWord("29135",2) : LangConfig.getWord("29136",2);
         }
      }
      
      public function get med() : ChatMediator
      {
         return this._med;
      }
      
      override protected function initStaticView() : void
      {
         tmpParent = GameScene.sysLayer;
         super.initStaticView();
         this.back = new Sprite();
         this.back.mouseEnabled = false;
         addChild(this.back);
         move = new Rectangle(0,0,463,380);
         CloseButton = ComponentUtil.getButton("","NPC_Close",this,{
            "x":425,
            "y":5,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_close01 = ComponentUtil.getButton(LangConfig.getWord("29087",2),"Button_Two",this,{
            "x":170,
            "y":340,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_SiLiao_send = ComponentUtil.getButton(LangConfig.getWord("29122",2),"Button_Two",this,{
            "x":230,
            "y":340,
            "textColor":16184781
         },Global.Img_Cdm);
         this.PlayerName_text = ComponentUtil.getTextField("",this,{
            "x":55,
            "y":17,
            "color":14662203
         });
         this.PlayerName_text.textColor = 16043313;
         ComponentUtil.getTextField("请勿轻信汇款、中奖信息、出售元宝等信息",this,{
            "x":55,
            "y":35,
            "color":16667989
         });
         this.pri_btn_tishi = new PriChat_tishi();
         addChild(this.pri_btn_tishi);
         this.pri_btn_tishi.visible = false;
         this.siliao_inputTxt = ComponentUtil.getTextField(" ",this,{
            "x":10,
            "y":245,
            "realWidth":279,
            "realHeight":80,
            "wordWrap":true,
            "type":TextFieldType.INPUT
         });
         this.siliao_inputTxt.multiline = true;
         this.siliao_inputTxt.maxChars = 50;
         this.siliao_inputTxt.addEventListener(KeyboardEvent.KEY_DOWN,function(e:KeyboardEvent):void
         {
            if(e.keyCode == KeyBoardConst.ENTER)
            {
               sendHandle();
               timeArr.push(setTimeout(inputTimeOut,1));
            }
            e.stopPropagation();
         });
         this.siliao_inputTxt.addEventListener(FocusEvent.FOCUS_IN,this.onFocusIn);
         this._targetModel.x = 385;
         this._targetModel.y = this._targetModel.jumpBindY = 173;
         this._targetModel.scaleX = this._targetModel.scaleY = 0.6;
         this._myModel.x = 385;
         this._myModel.y = this._myModel.jumpBindY = 337;
         this._myModel.scaleX = this._myModel.scaleY = 0.6;
      }
      
      private function onFocusIn(e:FocusEvent) : void
      {
         IME.enabled = true;
      }
      
      private function inputTimeOut() : void
      {
         var i:int = 0;
         this.siliao_inputTxt.text = "";
         for each(i in this.timeArr)
         {
            clearTimeout(i);
         }
         this.timeArr.splice(0);
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
         this.priList = new ChatList(306,150,ScrollBar.RIGHT,250);
         ComponentUtil.setPropertie(this.priList,{
            "x":7 - 20,
            "y":60
         });
         addChild(this.priList);
         if(Model_init.isUseNewChat)
         {
            this.priList.visible = false;
            this.nowChatChann = new ChatL(289,150,"right",this);
            this.nowChatChann.getPos({
               "x":6,
               "y":60
            });
         }
         this.faceChooser = new FaceChooser();
         this.faceChooser.init(this.addFace);
         addChild(this.faceChooser);
         this.faceChooser.visible = false;
         this.Button_close01.callBack = this.cloHandle;
         CloseButton.callBack = this.cloHandle;
         Global.control.registerCallBack(Enum_MsgType.MSG_FRIEND_C,this.resetNameText);
         Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_PRE_START,this.pre);
         Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_PRE_END,this.pre);
      }
      
      private function pre() : void
      {
         this.flag = Global.focus == this.siliao_inputTxt;
      }
      
      override protected function bStartHd() : void
      {
         if(this.flag && Global.focus != this.siliao_inputTxt)
         {
            Global.focus = this.siliao_inputTxt;
         }
      }
      
      override protected function bEndHd() : void
      {
         if(this.flag && Global.focus != this.siliao_inputTxt)
         {
            Global.focus = this.siliao_inputTxt;
         }
      }
      
      private function getColorHandle(e:MouseEvent) : void
      {
      }
      
      private function addFriHandle(e:MouseEvent) : void
      {
         if(BattleManager.isPlaying)
         {
            return;
         }
         FriendCGMessage.CG_ADD_FRIEND(this.med.roleName);
      }
      
      private function checkHandle(e:MouseEvent) : void
      {
         Global.control.sendNotification(Enum_MsgType.MSG_CHECKOTHERROLE,this.med.roleId);
      }
      
      private function sendFlower(e:MouseEvent) : void
      {
         UIManager.bestowFlower.show(this._med.roleId);
         UIManager.bestowFlower.visible = true;
         GameScene.sysLayer.addChild(UIManager.bestowFlower);
      }
      
      private function teamHandle(e:MouseEvent) : void
      {
         if(BattleManager.isPlaying)
         {
            return;
         }
         TeamCGMessage.CG_DIRECT_TEAM_STATE(0,this.med.roleId.toString());
      }
      
      private function emailFriHandle(e:MouseEvent = null) : void
      {
         if(BattleManager.isPlaying)
         {
            return;
         }
         Global.control.sendNotification(Enum_MsgType.MSG_SENDMAIL,this.med.roleName);
      }
      
      private function tsHandle(e:MouseEvent) : void
      {
         if(BattleManager.isPlaying)
         {
            return;
         }
         UIManager.trans_panel.show_trans_send(this.med.roleName);
      }
      
      private function outHandle(e:MouseEvent) : void
      {
         this.pri_btn_tishi.visible = false;
      }
      
      private function miniHandle(e:MouseEvent = null) : void
      {
         this.visible = false;
         PriChatManager.getInstance().resetTipPos();
      }
      
      private function cloHandle(e:MouseEvent = null) : void
      {
         this._med.state = ChatMediator.HIDE;
         PriChatManager.getInstance().resetTipPos();
      }
      
      public function maimeng() : void
      {
         if(Boolean(this._targetModel) && visible)
         {
            Tween.to(this._targetModel,550,{"y":[this._targetModel.jumpBindY,this._targetModel.jumpBindY - 20]},null,null,this.sinsin);
         }
      }
      
      private function sinsin(n:Number) : Number
      {
         return Math.abs(Math.sin(2 * n * Math.PI));
      }
      
      private function vipHd(e:MouseEvent) : void
      {
         UIManager.openVipPanel.visible = !UIManager.openVipPanel.visible;
      }
      
      public function showMessage(roleName:String, time:int, contact:String) : void
      {
         var date:Date = new Date();
         var test:int = time;
         date.setTime(test * 1000);
         var hours:int = date.getHours();
         var minus:int = date.getMinutes();
         var seCond:int = date.getSeconds();
         var str3:String = Utils.changeNumStr(hours) + ":" + Utils.changeNumStr(minus) + ":" + Utils.changeNumStr(seCond);
         if(roleName == GameUnitManager.hero.name)
         {
            RichTF.roleVipDic[roleName] = GameUnitManager.hero.vip;
         }
         else
         {
            RichTF.roleVipDic[roleName] = this._med.vipLv;
         }
         if(contact.match("/") != null)
         {
            this.priList.addItem(HtmlUtil.font(roleName,roleName == GameUnitManager.hero.name ? "#F9FF00" : "#AFE4E4") + "   " + HtmlUtil.font(str3,roleName == GameUnitManager.hero.name ? "#F9FF00" : "#AFE4E4") + "\n" + "  " + HtmlUtil.font(contact,"#ffffff"),25,{"name":roleName});
         }
         else
         {
            this.priList.addItem(HtmlUtil.font(roleName,roleName == GameUnitManager.hero.name ? "#F9FF00" : "#AFE4E4") + "   " + HtmlUtil.font(str3,roleName == GameUnitManager.hero.name ? "#F9FF00" : "#AFE4E4") + "\n" + "  " + HtmlUtil.font(contact,"#ffffff"),25,{"name":roleName});
         }
      }
      
      private function showEmptyContact() : void
      {
         if(Model_init.isUseNewChat)
         {
            this.nowChatChann.init(HtmlUtil.font(LangConfig.getWord("29124",2),"#ffff00"),null,null);
         }
         else
         {
            this.priList.addItem(HtmlUtil.font(LangConfig.getWord("29124",2),"#ffff00"),25);
         }
      }
      
      private function sendHandle(e:MouseEvent = null) : void
      {
         var data_str:String = null;
         if(this.siliao_inputTxt.text != "")
         {
            data_str = this.siliao_inputTxt.text;
            StrFilter.load(data_str,function(te:String):void
            {
               var cleanTe:String = StrFilter.replace(te);
               ChatCGMessage.CG_SID_CHAT_SEND(med.roleId,cleanTe,med.roleName,med.crossType);
            });
         }
         else
         {
            this.showEmptyContact();
         }
         this.siliao_inputTxt.text = "";
      }
      
      public function sendContent(content:String) : void
      {
         if(Model_init.isUseNewChat)
         {
            this.nowChatChann.init(content,null,null);
         }
         else
         {
            this.priList.addItem(content,25);
         }
      }
      
      private function initT() : void
      {
         ComponentUtil.getBitmap("Back_SiLiao",this.back,{
            "x":0,
            "y":0
         },Global.FriendShip_Imgsdm);
         this.face = ComponentUtil.getButton("","Button_Face",this,{
            "x":10,
            "y":215
         },Global.FriendShip_Imgsdm);
         this.face.addEventListener(MouseEvent.CLICK,function(e:* = null):void
         {
            faceChooser.visible = !faceChooser.visible;
            faceChooser.x = face.x + 8 - faceChooser.width / 2;
            faceChooser.y = 215 - faceChooser.height;
            faceChooser.parent.setChildIndex(faceChooser,faceChooser.parent.numChildren - 1);
         });
         this.check = ComponentUtil.getButton("","Button_Check",this,{
            "x":38,
            "y":215
         },Global.FriendShip_Imgsdm);
         this.team = ComponentUtil.getButton("","Button_Team",this,{
            "x":66,
            "y":215
         },Global.FriendShip_Imgsdm);
         this.addFriend = ComponentUtil.getButton("","Button_Join",this,{
            "x":94,
            "y":215
         },Global.FriendShip_Imgsdm);
         this.email = ComponentUtil.getButton("","Button_Mail",this,{
            "x":122,
            "y":215
         },Global.FriendShip_Imgsdm);
         this.Transaction = ComponentUtil.getButton("","Button_JiaoYi",this,{
            "x":150,
            "y":215
         },Global.FriendShip_Imgsdm);
         TipManager.bind(this.face,LangConfig.getWord("29116",2));
         TipManager.bind(this.check,LangConfig.getWord("29117",2));
         TipManager.bind(this.team,LangConfig.getWord("29118",2));
         TipManager.bind(this.addFriend,LangConfig.getWord("29119",2));
         TipManager.bind(this.email,LangConfig.getWord("29120",2));
         TipManager.bind(this.Transaction,LangConfig.getWord("29121",2));
         this.Button_SiLiao_send.addEventListener(MouseEvent.CLICK,this.sendHandle);
         TipManager.bind(this.Button_SiLiao_send,LangConfig.getWord("29123",2));
         this.addFriend.callBack = this.addFriHandle;
         this.check.callBack = this.checkHandle;
         this.team.callBack = this.teamHandle;
         this.email.callBack = this.emailFriHandle;
         this.Transaction.callBack = this.tsHandle;
         this.Button_Minimze = ComponentUtil.getButton("","Button_Min",this,{
            "x":398,
            "y":5,
            "textColor":16184781
         },Global.FriendShip_Imgsdm);
         this.Button_Minimze.callBack = this.miniHandle;
         this.back.addChild(this._targetModel);
         this.back.addChild(this._myModel);
         this._btnCheck = ComponentUtil.getButton("","Button_ChaKan",this,{
            "x":310,
            "y":193
         },Global.FriendShip_Imgsdm);
         this._btnPresentFlower = ComponentUtil.getButton("","Button_ZengSong",this,{
            "x":381,
            "y":193
         },Global.FriendShip_Imgsdm);
         this._targetVipSp = new Sprite();
         this._targetVipSp.x = 314;
         this._targetVipSp.y = 64;
         this._targetVipSp.buttonMode = true;
         addChild(this._targetVipSp);
         this._targetVipSp.addChild(this._targetVipBm = new Bitmap2());
         this._targetVipSp.addEventListener(MouseEvent.CLICK,this.vipHd);
         this._myVipSp = new Sprite();
         this._myVipSp.x = 314;
         this._myVipSp.y = 230;
         this._myVipSp.buttonMode = true;
         addChild(this._myVipSp);
         this._myVipSp.addChild(this._myVipBm = new Bitmap2());
         this._myVipSp.addEventListener(MouseEvent.CLICK,this.vipHd);
         this._targetJobDirLabel = new View_ZhuanZhiAtbSp(false);
         this._targetJobDirLabel.enableLoad();
         this._targetJobDirLabel.x = 314;
         this._targetJobDirLabel.y = 86;
         addChild(this._targetJobDirLabel);
         this._myJobDirLabel = new View_ZhuanZhiAtbSp(false);
         this._myJobDirLabel.enableLoad();
         this._myJobDirLabel.x = 314;
         this._myJobDirLabel.y = 252;
         addChild(this._myJobDirLabel);
         this._tfTargetName = ComponentUtil.getTextField("",this,{
            "x":364,
            "y":63,
            "color":16043313
         });
         this._tfMyName = ComponentUtil.getTextField("",this,{
            "x":364,
            "y":229,
            "color":3394867
         });
         this._btnCheck.callBack = this.checkHandle;
         this._btnPresentFlower.callBack = this.sendFlower;
         this._isInitComplete = true;
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            if(!this.isLoad)
            {
               this.isLoad = true;
               SingleLoader.add("lang/ch/FriendShip_Imgs.swf",function(info:Object):void
               {
                  Global.FriendShip_Imgsdm = info.applicationDomain;
                  initT();
                  visible = true;
               });
               return;
            }
            if(!this._isInitComplete)
            {
               return;
            }
            Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_PRE_START,this.pre);
            Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_PRE_END,this.pre);
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onFrame);
            this.updateBtnEnabled();
            this.updateMyModel();
            this.updateTargetModel();
            Global.focus = this.siliao_inputTxt;
            this.siliao_inputTxt.setSelection(this.siliao_inputTxt.text.length,this.siliao_inputTxt.text.length);
         }
         else
         {
            this.faceChooser.visible = false;
            Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_PRE_START,this.pre);
            Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_PRE_END,this.pre);
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onFrame);
         }
         super.visible = value;
      }
      
      private function updateBtnEnabled() : void
      {
         var eb:Boolean = false;
         eb = this.med.crossType == 0;
         this._btnCheck.enabled = this.Transaction.enabled = this.check.enabled = this.team.enabled = this.addFriend.enabled = this.email.enabled = eb;
      }
      
      private function updateMyModel() : void
      {
         var h:Hero = GameUnitManager.hero;
         this._myModel.type = Child_tianTiUnit.PLAYER;
         this._myModel.way = 5;
         this._myModel.modelId = h.body;
         this._myModel.horse = h.horse;
         this._myModel.weaponDir = h.weapon.toString();
         this._myModel.state = Action.STAND;
         this._myModel.sex = h.sex;
         this._myModel.wing = h.wing;
         this._myModel.job = h.job;
         this._myModel.updateHorseLayer();
         this._myModel.updateLayer();
         var myVip:int = h.vip;
         this._myVipBm.bitmapData = ComponentUtil.getBitmapData(VIPBMDIRSET[myVip]);
         this._myJobDirLabel.setJob(h.job);
         this._tfMyName.htmlText = h.name;
      }
      
      private function updateTargetModel() : void
      {
         this._targetModel.type = Child_tianTiUnit.PLAYER;
         this._targetModel.way = 5;
         this._targetModel.modelId = this._med.roleBody;
         this._targetModel.horse = this._med.roleHorse;
         this._targetModel.weaponDir = this._med.roleWeapon.toString();
         this._targetModel.state = Action.STAND;
         this._targetModel.sex = this._med.roleSex;
         this._targetModel.job = this._med.roleJob;
         this._targetModel.wing = this._med.roleWing;
         this._targetModel.updateHorseLayer();
         this._targetModel.updateLayer();
         this._targetVipBm.bitmapData = ComponentUtil.getBitmapData(VIPBMDIRSET[this._med.vipLv]);
         this._targetJobDirLabel.setJob(this._med.roleJob);
         this._tfTargetName.htmlText = this._med.roleName;
      }
      
      private function onFrame(interval:int) : void
      {
         this._myModel.onFrame(interval);
         this._targetModel.onFrame(interval);
      }
      
      private function addFace(faceIndex:int) : void
      {
         var tfIndex:int = this.siliao_inputTxt.caretIndex;
         var ss:String = faceIndex.toString();
         if(faceIndex < 10)
         {
            ss = "00" + faceIndex;
         }
         else if(faceIndex < 100 && faceIndex >= 10)
         {
            ss = "0" + faceIndex;
         }
         this.siliao_inputTxt.replaceText(tfIndex,tfIndex,"/" + ss);
         this.siliao_inputTxt.setSelection(tfIndex + 4,tfIndex + 4);
         Global.focus = this.siliao_inputTxt;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 463) / 2;
         y = (Global.stage.stageHeight - 380) / 2;
      }
      
      public function dispose() : void
      {
         this.siliao_inputTxt.text = "";
         if(Boolean(parent))
         {
            parent.removeChild(this);
         }
         this.visible = false;
         if(Model_init.isUseNewChat)
         {
            this.nowChatChann.dispose();
         }
         else
         {
            this.priList.dispose();
         }
         pool.push(this);
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.Sprite;

class PriChat_tishi extends Sprite
{
   
   private var TF:MyTextField;
   
   public function PriChat_tishi()
   {
      super();
      var back:DisplayObject = ComponentUtil.getDisplayObject("TiShiKuang_background02",null);
      this.TF = ComponentUtil.getTextField("99",this,{
         "x":1,
         "y":1
      });
   }
   
   public function update(str:String) : void
   {
      if(str == null)
      {
         return;
      }
      this.TF.text = str;
   }
   
   private function dispose() : void
   {
   }
}

class getColor extends Sprite
{
   
   private var shape_arr:Array = [];
   
   public var color_arr:Array = ["0xffffff","0x000000","0x336699","0x66cc00","0x33ff00","0x9993366","0xffcc00","0xcc0066","0x66cc00","0xffcc00"];
   
   public function getColor()
   {
      var i:int = 0;
      var shape:Shape = null;
      super();
      var back:DisplayObject = ComponentUtil.getDisplayObject("TiShiKuang_background02",null);
      i = 0;
      while(i < 9)
      {
         shape = ComponentUtil.getShape(41.6,30.1,this.color_arr[i]);
         shape.x = 47 * int(i % 5);
         shape.y = 39 * int(i / 5);
         addChild(shape);
         this.shape_arr.push(shape);
         i++;
      }
   }
}
