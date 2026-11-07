package com.yiTian.view.modules.chat
{
   import com.ui.constants.ScrollAutoType;
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScrollBar;
   import com.ui.controls.TabButton;
   import com.ui.controls.TextInput;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.config.KeyBoardConst;
   import com.yiTian.data.config.valuable.Enum_filter;
   import com.yiTian.data.model.Model_CrossDart;
   import com.yiTian.data.model.Model_bang;
   import com.yiTian.data.model.Model_chat;
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.gameUnit.role.BattleUnit;
   import com.yiTian.gameUnit.role.Role;
   import com.yiTian.manager.BattleManager;
   import com.yiTian.manager.BattleUnitManager;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.QiJuHandler;
   import com.yiTian.net.handler.ZhuTiZhouHandler;
   import com.yiTian.net.message.cg.BoatCGMessage;
   import com.yiTian.net.message.cg.ChatCGMessage;
   import com.yiTian.net.message.cg.KuaFuJingJiChangCGMessage;
   import com.yiTian.net.message.cg.MoneyTreeCGMessage;
   import com.yiTian.net.message.cg.RechargeFeedbackCGMessage;
   import com.yiTian.net.message.cg.RoleCGMessage;
   import com.yiTian.net.message.cg.ShouChongTiaoZhengCGMessage;
   import com.yiTian.net.message.cg.TeamCGMessage;
   import com.yiTian.net.message.cg.XiaoFeiTuanGouCGMessage;
   import com.yiTian.net.message.cg.ZhaoCaiMaoCGMessage;
   import com.yiTian.net.message.cg.ZhuTiZhouCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.StrFilter;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.MainUIBase;
   import com.yiTian.view.modules.Card.View_card_panel;
   import com.yiTian.view.modules.ShouChongTiaoZheng.View_ShouChongTiaoZheng_menu;
   import com.yiTian.view.modules.actions.ciRiLibao.tomorrDayGf.TomGifICon;
   import com.yiTian.view.modules.chatM.Channel;
   import com.yiTian.view.modules.chatM.ChatPanM;
   import com.yiTian.view.modules.chatM.FaceChooser;
   import com.yiTian.view.modules.chatM.face.Model_face;
   import com.yiTian.view.modules.moneyTree.View_MoneyTree;
   import com.yiTian.view.modules.playerExtend.View_PlayerExtendPanel;
   import com.yiTian.view.modules.qingrenjie.View_QingRenJie;
   import com.yiTian.view.modules.rechargeFeedback.reChangeBack.View_chargeBackPan;
   import com.yiTian.view.modules.roleHead.View_HeroHead;
   import com.yiTian.view.modules.ship.Ship;
   import com.yiTian.view.modules.tip.tips.View_Equip;
   import com.yiTian.view.modules.wuXing.WuXingMter;
   import com.yiTian.view.modules.yellowDiamond.Model_init;
   import com.yiTian.view.modules.zhutizhou.ActivityTopicPanel;
   import flash.display.DisplayObject;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.net.URLLoader;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   
   public class View_ChatPanel extends MainUIBase
   {
      
      public static var Button_choose:Button;
      
      public static var chat_contact:TextInput;
      
      private static var _Str_channel:Array;
      
      private static var loader:URLLoader;
      
      public static var _chatType:int = 0;
      
      public static var fuJinChatCount:Dictionary = new Dictionary();
      
      public static var worldChatCount:Dictionary = new Dictionary();
      
      private static var chatJiluDic:Dictionary = new Dictionary();
      
      private static var roleDic:Dictionary = new Dictionary();
      
      public static var view_equip:View_Equip = new View_Equip();
      
      private var B:DisplayObject;
      
      private var Send_Button:Button;
      
      private var Button_suoxiao:Button;
      
      private var liaotian_face:Button;
      
      public var liaotian_laba:Button;
      
      private var liaotian_open:Button;
      
      private var liaotian_lock:Button;
      
      public var TabButton_jianghu:TabButton;
      
      public var TabButton_fujian:TabButton;
      
      public var TabButton_duiwu:TabButton;
      
      public var TabButton_banghui:TabButton;
      
      public var TabButton_xitong:TabButton;
      
      public var TabButton_kuafu:TabButton;
      
      private var LiaoTianNeiRong_text:MyTextField;
      
      private var DaLaBa_text:MyTextField;
      
      private var chat_text:MyTextField;
      
      private var sex_sign:Array = ["♂","♀"];
      
      private var vip_level:int = 1;
      
      private var vip_sign:Array;
      
      private var record:Array = [];
      
      private var _isLock:Boolean = false;
      
      private var isInputFocus:Boolean = false;
      
      private var isFocus:Boolean = false;
      
      private var tf:TextField;
      
      private var curIndex:int = -1;
      
      private var timeOutArr:Array = [];
      
      private var faceChooser:FaceChooser;
      
      private var _chann:Channel;
      
      private var worldList:ChatList;
      
      private var labaList:LabaList;
      
      private var fujinList:ChatList;
      
      private var teamList:ChatList;
      
      private var bangList:ChatList;
      
      private var sysList:ChatList;
      
      private var kuafuList:ChatList;
      
      private var preLabaSendTime:int = -10000;
      
      private var preJianghuSendTime:int = 0;
      
      private var preFujinSendTime:int = 0;
      
      private const KFLB:int = 44725;
      
      private var lineEff:Effect;
      
      private var getStr:String = "";
      
      private var colorArr:Array = ["#ffffff","#1ABA36","#19FFDA","#BB00FF"];
      
      public var job_color_arr:Array = ["#ff5d38","#1ecbf8","#83e200","#e230ce"];
      
      private var chan_color_arr:Array = ["#ffffff","#b3fd6a","#03B6FF","#32CD32"];
      
      private var sex_color_arr:Array = ["#7CCCF2","#E87AF3"];
      
      private var effBtn:TabButton;
      
      public var now:TabButton;
      
      private var preType:int;
      
      public function View_ChatPanel()
      {
         super();
      }
      
      public static function get Str_channel() : Array
      {
         if(!_Str_channel)
         {
            _Str_channel = [LangConfig.getWord("842",0),LangConfig.getWord("843",0),LangConfig.getWord("844",0),LangConfig.getWord("523",0),LangConfig.getWord("845",0),"跨服"];
         }
         return _Str_channel;
      }
      
      public static function show(str:String, _vo:Vo_valuable) : void
      {
         if(chat_contact.text.length >= 60)
         {
            return;
         }
         chat_contact.text += str;
         Global.focus = chat_contact.focus;
         chat_contact.setSelection(chat_contact.text.length,chat_contact.text.length);
         Model_chat.chat_save.push([_vo,str]);
      }
      
      public static function getSpace(diaLvl:int, isYear:int, huangZLv:int, isHuangZYear:int, huiyuan:int = 0, isHuiYuanYear:int = 0, superLan:int = 0, superLanYear:int = 0, isSuperHuang:int = 0) : String
      {
         if(Global.pf == Enum_SPStr.QQ3366)
         {
            return "";
         }
         if(Global.pf == "qqgame")
         {
            if(Boolean(superLanYear) && superLan > 0)
            {
               return "        ";
            }
            if(superLan > 0)
            {
               return "    ";
            }
            if(Boolean(isYear) && diaLvl > 0)
            {
               return "        ";
            }
            if(diaLvl > 0)
            {
               return "    ";
            }
         }
         else if(Global.pf == "qplus" || Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isUnion(Global.pf))
         {
            if(Boolean(isHuiYuanYear) && huiyuan > 0)
            {
               return "              ";
            }
            if(huiyuan > 0)
            {
               return "          ";
            }
         }
         else if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isIwan(Global.pf))
         {
            if(Boolean(isSuperHuang))
            {
               if(Boolean(isHuangZYear) && huangZLv > 0)
               {
                  return "         ";
               }
               if(huangZLv > 0)
               {
                  return "     ";
               }
            }
            else
            {
               if(Boolean(isHuangZYear) && huangZLv > 0)
               {
                  return "        ";
               }
               if(huangZLv > 0)
               {
                  return "    ";
               }
            }
         }
         return "";
      }
      
      override protected function initStaticView() : void
      {
         tmpParent = GameScene.sysLayer;
         this.setDynamic();
         this.vip_sign = ["","<a href=\'event:vip_hun\'>" + LangConfig.getWord("60108",6) + "</a>","<a href=\'event:vip_hun\'>" + LangConfig.getWord("60108",6) + "</a>","<a href=\'event:vip_hun\'>" + LangConfig.getWord("60108",6) + "</a>"];
         ComponentUtil.getScaleBitmap("Back_Translucent",[2,2,4,4],this,{
            "x":0,
            "y":0,
            "width":269,
            "height":238
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_ComboBox",[4,4,3,3],this,{
            "x":2,
            "y":214,
            "width":226,
            "height":22,
            "alpha":0.3
         },Global.Img_Cdm);
         this.Send_Button = ComponentUtil.getButton("","Button_LiaoTian_send",this,{
            "x":228,
            "y":214,
            "textColor":16184781
         },Global.Img_Cdm);
         Button_choose = ComponentUtil.getButton(Str_channel[0],"Button_TiliteFour",this,{
            "x":2,
            "y":215,
            "textColor":16773818
         },Global.Img_Cdm);
         this.liaotian_face = ComponentUtil.getButton("","Button_LiaoTian_biaoqing",this,{
            "x":202,
            "y":194,
            "textColor":16184781
         },Global.Img_Cdm);
         this.liaotian_laba = ComponentUtil.getButton("","Button_LiaoTian_LaBa",this,{
            "x":224,
            "y":194,
            "textColor":16184781
         },Global.Img_Cdm);
         this.liaotian_lock = ComponentUtil.getButton("","Button_LiaoTian_suo",this,{
            "x":246,
            "y":194,
            "textColor":16184781,
            "tabIndex":1
         },Global.Img_Cdm);
         TipManager.bind(this.liaotian_lock,Model_chat.txtArr[8]);
         this.liaotian_open = ComponentUtil.getButton("","Button_LiaoTian_open",this,{
            "x":246,
            "y":194,
            "tabIndex":2
         },Global.Img_Cdm);
         TipManager.bind(this.liaotian_open,Model_chat.txtArr[7]);
         this.Send_Button.name = "send";
         this.liaotian_laba.name = "laba";
         this.TabButton_jianghu = ComponentUtil.getTabButton(LangConfig.getWord("842",0),"TabButton_Two_Chat",this,{
            "x":2,
            "y":194,
            "textColor":16773818,
            "chooseColor":16773818,
            "tabIndex":1
         },Global.Img_Cdm);
         this.TabButton_jianghu.choose = true;
         this.now = this.TabButton_jianghu;
         this.TabButton_fujian = ComponentUtil.getTabButton(LangConfig.getWord("843",0),"TabButton_Two_Chat",this,{
            "x":42,
            "y":194,
            "textColor":16773818,
            "chooseColor":16773818,
            "tabIndex":2
         },Global.Img_Cdm);
         this.TabButton_duiwu = ComponentUtil.getTabButton(LangConfig.getWord("844",0),"TabButton_Two_Chat",this,{
            "x":82,
            "y":194,
            "textColor":16773818,
            "chooseColor":16773818,
            "tabIndex":3
         },Global.Img_Cdm);
         this.TabButton_banghui = ComponentUtil.getTabButton(LangConfig.getWord("523",0),"TabButton_Two_Chat",this,{
            "x":122,
            "y":194,
            "textColor":16773818,
            "chooseColor":16773818,
            "tabIndex":4
         },Global.Img_Cdm);
         this.TabButton_xitong = ComponentUtil.getTabButton(LangConfig.getWord("846",0),"TabButton_Two_Chat",this,{
            "x":162,
            "y":194,
            "textColor":16773818,
            "chooseColor":16773818,
            "tabIndex":5
         },Global.Img_Cdm);
         this.TabButton_xitong.visible = false;
         this.TabButton_kuafu = ComponentUtil.getTabButton("跨服","TabButton_Two_Chat",this,{
            "x":162,
            "y":194,
            "textColor":16773818,
            "chooseColor":16773818,
            "tabIndex":5
         },Global.Img_Cdm);
         this.worldList = new ChatList(255,192,ScrollBar.LEFT);
         ComponentUtil.setPropertie(this.worldList,{"y":4});
         addChild(this.worldList);
         chat_contact = ComponentUtil.getTextInput("","wenzikuang",this,{
            "x":52,
            "y":214,
            "height":24,
            "width":176
         });
         chat_contact.maxChars = 50;
         chat_contact.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         this.DaLaBa_text = ComponentUtil.getTextField(" ",this,{
            "x":40.8,
            "y":8,
            "realWidth":235,
            "wordWrap":true,
            "leading":6
         });
         Button_choose.addEventListener(MouseEvent.CLICK,this.chanOnDown);
         Button_choose.addEventListener(MouseEvent.MOUSE_DOWN,this.OnDownStopPo);
         this.liaotian_lock.callBack = this.lockHandle;
         this.liaotian_open.callBack = this.lockHandle;
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_FUBEN,this.askChangeScene);
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_SCENE,this.askChangeScene);
         Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_PRE_START,this.pre);
         Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_START,this.end);
         Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_PRE_END,this.pre);
         Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_END,this.end);
         if(!Model_init.isUseNewChat)
         {
            addEventListener(MouseEvent.CLICK,this.onClick);
         }
         Global.control.registerCallBack(Enum_MsgType.STAGE_RESIZE,this.resetPosition);
         this.isLock = false;
      }
      
      public function set isLock(value:Boolean) : void
      {
         this.liaotian_lock.visible = value;
         this.liaotian_open.visible = !value;
         this._isLock = value;
      }
      
      public function get isLock() : Boolean
      {
         return this._isLock;
      }
      
      public function setCrossCampChannal(value:String) : void
      {
         this.TabButton_kuafu.text = value;
         _Str_channel[5] = value;
         TipManager.bind(this.TabButton_kuafu,value);
         if(value == "演兵")
         {
            this.TabButton_kuafu.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
         else
         {
            this.TabButton_jianghu.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
      
      private function pre() : void
      {
         this.isInputFocus = Global.focus == chat_contact.textField;
      }
      
      private function end() : void
      {
         if(this.isInputFocus && Global.focus != chat_contact.textField)
         {
            Global.focus = chat_contact.textField;
            this.isInputFocus = false;
         }
      }
      
      private function askChangeScene() : void
      {
         if(Global.focus is TextField)
         {
            this.tf = Global.focus as TextField;
            Global.control.registerCallBack(Enum_MsgType.MSG_ASK_CHANGE_SCENE_OK,this.cbSetFocus);
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_FUBEN_OK,this.cbSetFocus);
         }
      }
      
      private function cbSetFocus() : void
      {
         Global.control.removeCallBack(Enum_MsgType.MSG_ASK_CHANGE_SCENE_OK,this.cbSetFocus);
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTER_FUBEN_OK,this.cbSetFocus);
      }
      
      private function onKeyDown(event:KeyboardEvent) : void
      {
         event.stopImmediatePropagation();
         if(event.keyCode == KeyBoardConst.ENTER)
         {
            this.Send_Button.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
         else if(event.keyCode == KeyBoardConst.UP)
         {
            if(this.record.length > 0)
            {
               this.curIndex = (this.curIndex + 1) % this.record.length;
               chat_contact.text = this.record[this.curIndex];
               this.timeOutArr.push(setTimeout(function():void
               {
                  chat_contact.setSelection(chat_contact.text.length,chat_contact.text.length);
                  clearTimeOutArr();
               },1));
            }
         }
         else if(event.keyCode == KeyBoardConst.DOWN)
         {
            if(this.record.length > 0)
            {
               if(this.curIndex <= 0)
               {
                  this.curIndex = this.record.length - 1;
               }
               else
               {
                  this.curIndex = (this.curIndex - 1) % this.record.length;
               }
               chat_contact.text = this.record[this.curIndex];
            }
         }
      }
      
      private function clearTimeOutArr() : void
      {
         var i:int = 0;
         for each(i in this.timeOutArr)
         {
            clearTimeout(i);
         }
         this.timeOutArr.splice(0);
      }
      
      public function setFocus() : void
      {
         Global.focus = chat_contact.focus;
      }
      
      private function lockHandle(e:MouseEvent) : void
      {
         if(Model_init.isUseNewChat)
         {
            ChatPanM.instance.setLock(e.target.tabIndex);
         }
         if(_chatType == 0)
         {
            this.worldList.lock = !this.worldList.lock;
         }
         else if(_chatType == 1)
         {
            this.fujinList.lock = !this.fujinList.lock;
         }
         else if(_chatType == 2)
         {
            this.teamList.lock = !this.teamList.lock;
         }
         else if(_chatType == 3)
         {
            this.bangList.lock = !this.bangList.lock;
         }
         else if(_chatType == 5)
         {
            this.sysList.lock = !this.sysList.lock;
         }
         else if(_chatType == 7)
         {
            this.kuafuList.lock = !this.kuafuList.lock;
         }
         this.updateLock();
      }
      
      private function updateLock() : void
      {
         if(_chatType == 0)
         {
            this.isLock = this.worldList.lock;
         }
         else if(_chatType == 1)
         {
            this.isLock = this.fujinList.lock;
         }
         else if(_chatType == 2)
         {
            this.isLock = this.teamList.lock;
         }
         else if(_chatType == 3)
         {
            this.isLock = this.bangList.lock;
         }
         else if(_chatType == 5)
         {
            this.isLock = this.sysList.lock;
         }
         else if(_chatType == 7)
         {
            this.isLock = this.kuafuList.lock;
         }
      }
      
      public function setPosition(... parem) : void
      {
         var obj:Object = null;
         var _chan:ChatList = null;
         var i:int = 0;
         while(i < parem.length)
         {
            obj = parem[i];
            if(obj is ChatList)
            {
               _chan = obj as ChatList;
               ComponentUtil.setPropertie(_chan,{
                  "y":2,
                  "x":(_chan.dragbarVis ? 2 : -14),
                  "tf_width":(this.worldList.dragbarVis ? 242 : 256)
               });
            }
            i++;
         }
      }
      
      public function addItem(str:String, callBack:Function, param:Object, types:Array) : void
      {
         var type:int = 0;
         for each(type in types)
         {
            if(type == 1)
            {
               this.worldList.addItem(str,-1,param,callBack);
            }
            else if(type == 2)
            {
               this.fujinList.addItem(str,-1,param,callBack);
            }
            else if(type == 3)
            {
               this.teamList.addItem(str,-1,param,callBack);
            }
            else if(type == 10)
            {
               this.labaList.addItem(str,-1,param,callBack);
            }
         }
      }
      
      public function jlmAddMsg(string:String) : void
      {
         if(Model_init.isUseNewChat)
         {
            return;
         }
         this.worldList.addItem(HtmlUtil.font(string,"#ff0000"),-1);
         this.fujinList.addItem(HtmlUtil.font(string,"#ff0000"),-1);
         this.teamList.addItem(HtmlUtil.font(string,"#ff0000"),-1);
         this.sysList.addItem(HtmlUtil.font(string,"#ff0000"),-1);
         this.kuafuList.addItem(HtmlUtil.font(string,"#ff0000"),-1);
      }
      
      override protected function initDynamicView() : void
      {
         this.TabButton_jianghu.addEventListener(MouseEvent.CLICK,this.clickEvent);
         TipManager.bind(this.TabButton_jianghu,Model_chat.txtArr[0]);
         this.TabButton_fujian.addEventListener(MouseEvent.CLICK,this.clickEvent);
         TipManager.bind(this.TabButton_fujian,Model_chat.txtArr[1]);
         this.TabButton_duiwu.addEventListener(MouseEvent.CLICK,this.clickEvent);
         TipManager.bind(this.TabButton_duiwu,Model_chat.txtArr[2]);
         this.TabButton_banghui.addEventListener(MouseEvent.CLICK,this.clickEvent);
         TipManager.bind(this.TabButton_banghui,Model_chat.txtArr[3]);
         this.TabButton_xitong.addEventListener(MouseEvent.CLICK,this.clickEvent);
         TipManager.bind(this.TabButton_xitong,Model_chat.txtArr[4]);
         this.TabButton_kuafu.addEventListener(MouseEvent.CLICK,this.clickEvent);
         TipManager.bind(this.TabButton_kuafu,"跨服");
         this.liaotian_laba.addEventListener(MouseEvent.CLICK,this.clickEvent);
         TipManager.bind(this.liaotian_laba,Model_chat.txtArr[6]);
         this.worldList = new ChatList(255,192,ScrollBar.LEFT,271,28);
         this.worldList.scrollAutoType = ScrollAutoType.TO_BOTTOM;
         ComponentUtil.setPropertie(this.worldList,{
            "y":4,
            "x":-16
         });
         addChild(this.worldList);
         if(Model_init.isUseNewChat)
         {
            this.worldList.visible = false;
         }
         this.fujinList = new ChatList(255,192,ScrollBar.LEFT,271,28);
         this.fujinList.scrollAutoType = ScrollAutoType.TO_BOTTOM;
         ComponentUtil.setPropertie(this.fujinList,{
            "y":4,
            "x":-16
         });
         addChild(this.fujinList);
         this.fujinList.visible = false;
         this.teamList = new ChatList(255,192,ScrollBar.LEFT,271,28);
         this.teamList.scrollAutoType = ScrollAutoType.TO_BOTTOM;
         ComponentUtil.setPropertie(this.teamList,{
            "y":4,
            "x":-16
         });
         addChild(this.teamList);
         this.teamList.visible = false;
         this.bangList = new ChatList(255,192,ScrollBar.LEFT,271,28);
         this.bangList.scrollAutoType = ScrollAutoType.TO_BOTTOM;
         ComponentUtil.setPropertie(this.bangList,{
            "y":4,
            "x":-16
         });
         addChild(this.bangList);
         this.bangList.visible = false;
         this.sysList = new ChatList(255,192,ScrollBar.LEFT,271,28);
         this.sysList.scrollAutoType = ScrollAutoType.TO_BOTTOM;
         ComponentUtil.setPropertie(this.sysList,{
            "y":4,
            "x":-16
         });
         addChild(this.sysList);
         this.sysList.visible = false;
         this.kuafuList = new ChatList(255,192,ScrollBar.LEFT,271,28);
         this.kuafuList.scrollAutoType = ScrollAutoType.TO_BOTTOM;
         ComponentUtil.setPropertie(this.kuafuList,{
            "y":4,
            "x":-16
         });
         addChild(this.kuafuList);
         this.kuafuList.visible = false;
         this.labaList = new LabaList(263,49);
         this.labaList.x = 2;
         this.labaList.y = 2;
         addChild(this.labaList);
         this.labaList.visible = false;
         this.Send_Button.addEventListener(MouseEvent.CLICK,this.sendMessage);
         this.liaotian_face.addEventListener(MouseEvent.MOUSE_DOWN,this.OnDownStopPo);
         this.liaotian_face.addEventListener(MouseEvent.CLICK,this.faceClick);
         TipManager.bind(this.liaotian_face,Model_chat.txtArr[5]);
         this.faceChooser = FaceChooser.instance;
         this.faceChooser.init(this.addFace);
         this.faceChooser.visible = false;
         this._chann = Channel.instance;
         this._chann.visible = false;
         this.updateLock();
      }
      
      private function sendMessage(e:MouseEvent) : void
      {
         var temStr:String;
         var reg2:RegExp;
         var tem_num:int = 0;
         var data_str:String = null;
         var temChatType:int = 0;
         var sendJianghuTime:int = 0;
         var sendFujinTime:int = 0;
         var sendLabaTime:int = 0;
         var _sendLabaTime:int = 0;
         while(this.record.length > 6)
         {
            this.record.pop();
         }
         if(!(this.record.length > 0 && chat_contact.text == this.record[0]))
         {
            this.record.unshift(chat_contact.text);
         }
         this.curIndex = -1;
         temStr = chat_contact.text;
         reg2 = /<([^>]*)>/gi;
         temStr = temStr.replace(reg2,"");
         data_str = this.getSpecialStr(temStr);
         temChatType = _chatType + 1;
         if(data_str.length > 200)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("851",0));
            return;
         }
         if(!(e.target.name == "laba" && chat_contact.text != ""))
         {
            if(e.target.name == "send" && chat_contact.text != "")
            {
               if(temChatType == 1)
               {
                  if(Global.isInHome && !Model_CrossDart.inCrossScence)
                  {
                     UIManager.centerBroadcast.addMsg("亲，在跨服家园中，不能进行世界聊天。");
                     return;
                  }
                  if(GameUnitManager.hero.level < 15)
                  {
                     if(Model_init.isUseNewChat)
                     {
                        ChatPanM.instance.addMes(1,HtmlUtil.fontNoSize(LangConfig.getWord("852",0),"#ff0000"),null,true);
                     }
                     else
                     {
                        this.worldList.addItem(HtmlUtil.fontNoSize(LangConfig.getWord("852",0),"#ff0000"),-1);
                     }
                     this.setPosition(this.worldList);
                     return;
                  }
                  sendJianghuTime = getTimer();
                  if(!(sendJianghuTime - this.preJianghuSendTime >= 30000 || this.preJianghuSendTime == 0))
                  {
                     if(Model_init.isUseNewChat)
                     {
                        ChatPanM.instance.addMes(1,HtmlUtil.font(LangConfig.getWord("853",0),"#ff0000"),null,true);
                     }
                     else
                     {
                        this.worldList.addItem(HtmlUtil.font(LangConfig.getWord("853",0),"#ff0000"),-1,null,null);
                     }
                     this.setPosition(this.worldList);
                     return;
                  }
                  StrFilter.load(data_str,function(te:String):void
                  {
                     var lvl:int = 0;
                     var dicCountLvlW:int = 0;
                     var cleanTe:String = StrFilter.replace(te);
                     if(GameUnitManager.hero.level < 30 && GameUnitManager.hero.level >= 15)
                     {
                        lvl = GameUnitManager.hero.level;
                        dicCountLvlW = int(worldChatCount[lvl]);
                        dicCountLvlW++;
                        if(dicCountLvlW > 10)
                        {
                           UIManager.centerBroadcast.addMsg("在30级以前在江湖频道聊天每等级限制只能发言10句");
                           return;
                        }
                        worldChatCount[lvl] = dicCountLvlW;
                     }
                     ChatCGMessage.CG_CHAT(temChatType,cleanTe);
                  });
                  this.preJianghuSendTime = sendJianghuTime;
               }
               else if(temChatType == 2)
               {
                  sendFujinTime = getTimer();
                  if(data_str == "hideAllBtn_CGX")
                  {
                     UIManager.mainUiBtnContainer.hideAllBtn();
                  }
                  else if(data_str == "showAllBtn_CGX")
                  {
                     UIManager.mainUiBtnContainer.showAllBtn();
                  }
                  if(!(sendFujinTime - this.preFujinSendTime > 3000 || this.preFujinSendTime == 0))
                  {
                     if(Model_init.isUseNewChat)
                     {
                        ChatPanM.instance.addMes(1,HtmlUtil.font(LangConfig.getWord("853",0),"#ff0000"),null,true);
                        ChatPanM.instance.addMes(2,HtmlUtil.font(LangConfig.getWord("853",0),"#ff0000"),null,true);
                     }
                     else
                     {
                        this.worldList.addItem(HtmlUtil.font(LangConfig.getWord("853",0),"#ff0000"),-1,null,null);
                        this.fujinList.addItem(HtmlUtil.font(LangConfig.getWord("853",0),"#ff0000"),-1,null,null);
                     }
                     this.setPosition(this.worldList,this.fujinList);
                     return;
                  }
                  StrFilter.load(data_str,function(te:String):void
                  {
                     var lvl:int = 0;
                     var dicCountLvl:int = 0;
                     var cleanTe:String = StrFilter.replace(te);
                     if(GameUnitManager.hero.level < 30)
                     {
                        lvl = GameUnitManager.hero.level;
                        dicCountLvl = int(fuJinChatCount[lvl]);
                        dicCountLvl++;
                        if(dicCountLvl > 10)
                        {
                           UIManager.centerBroadcast.addMsg("在30级以前在附近频道聊天每等级限制只能发言10句");
                           return;
                        }
                        fuJinChatCount[lvl] = dicCountLvl;
                     }
                     ChatCGMessage.CG_CHAT(temChatType,cleanTe);
                  });
                  this.preFujinSendTime = sendFujinTime;
               }
               else if(temChatType == 3)
               {
                  if(!(Boolean(Model_team.isTeam[GameUnitManager.hero.id] || SceneConfig.getSceneType() == SceneConfig.KuaFuPaiDui) || Boolean(SceneConfig.getSceneType() == SceneConfig.AiDeBaoBao) || Boolean(Global.sceneMap == 14401) && Boolean(Ship.myShip)))
                  {
                     UIManager.centerBroadcast.addMsg(LangConfig.getWord("854",0));
                     return;
                  }
                  StrFilter.load(data_str,function(te:String):void
                  {
                     var cleanTe:String = StrFilter.replace(te);
                     ChatCGMessage.CG_CHAT(temChatType,cleanTe);
                  });
               }
               else if(temChatType == 6)
               {
                  if(SceneConfig.getSceneType() == SceneConfig.KFBZ_BATTLE)
                  {
                     return;
                  }
                  sendLabaTime = getTimer();
                  if(sendLabaTime - this.preLabaSendTime < 10000)
                  {
                     UIManager.centerBroadcast.addMsg(LangConfig.getWord("853",0));
                     chat_contact.text = "";
                     return;
                  }
                  this.preLabaSendTime = sendLabaTime;
                  trace("get data..",!CommandManager.get_bag_vec(Enum_filter.ID,null,[46353]).length);
                  if(!CommandManager.get_bag_vec(Enum_filter.ID,null,[46353]).length)
                  {
                     UIManager.chatPrompt.show(function():void
                     {
                        if(GameUnitManager.hero.money >= 10)
                        {
                           StrFilter.load(data_str,function(te:String):void
                           {
                              var cleanTe:String = StrFilter.replace(te);
                              ChatCGMessage.CG_CHAT(temChatType,cleanTe,0);
                           });
                        }
                        else
                        {
                           UIManager.centerBroadcast.addMsg(LangConfig.getWord("139",0));
                        }
                     });
                  }
                  else
                  {
                     StrFilter.load(data_str,function(te:String):void
                     {
                        var cleanTe:String = StrFilter.replace(te);
                        tem_num = CommandManager.get_bag_vec(Enum_filter.ID,null,[46353])[0].gridId;
                        ChatCGMessage.CG_CHAT(temChatType,cleanTe,tem_num);
                     });
                  }
               }
               else if(temChatType == 4)
               {
                  if(!GameUnitManager.hero.partyId && Model_bang.partyType == 0)
                  {
                     UIManager.centerBroadcast.addMsg(LangConfig.getWord("855",0));
                     return;
                  }
                  StrFilter.load(data_str,function(te:String):void
                  {
                     var cleanTe:String = StrFilter.replace(te);
                     ChatCGMessage.CG_CHAT(temChatType,cleanTe);
                  });
               }
               else
               {
                  if(temChatType == 5)
                  {
                     UIManager.centerBroadcast.addMsg(LangConfig.getWord("856",0));
                     return;
                  }
                  if(temChatType == 8)
                  {
                     if(Model_CrossDart.inCrossScence)
                     {
                        UIManager.centerBroadcast.addMsg("跨服跑镖不能进行跨服聊天。");
                        return;
                     }
                     if(Global.isInHome && !Model_CrossDart.inCrossScence)
                     {
                        UIManager.centerBroadcast.addMsg("亲，在跨服家园中，不能进行跨服聊天。");
                        return;
                     }
                     if(GameUnitManager.hero.level < 40)
                     {
                        UIManager.centerBroadcast.addMsg("40级以上可在跨服频道发言");
                        return;
                     }
                     if(CommandManager.get_bag_count(this.KFLB,2) > 0)
                     {
                        StrFilter.load(data_str,function(te:String):void
                        {
                           var cleanTe:String = StrFilter.replace(te);
                           tem_num = CommandManager.get_bag_vec(Enum_filter.ID,null,[44725])[0].gridId;
                           ChatCGMessage.CG_CHAT(8,cleanTe);
                        });
                     }
                     else if(!CommandManager.get_bag_vec(Enum_filter.ID,null,[this.KFLB]).length)
                     {
                        UIManager.chatPrompt2.show(function():void
                        {
                           if(GameUnitManager.hero.money >= 15)
                           {
                              StrFilter.load(data_str,function(te:String):void
                              {
                                 var cleanTe:String = StrFilter.replace(te);
                                 ChatCGMessage.CG_CHAT(8,cleanTe);
                              });
                           }
                           else
                           {
                              UIManager.centerBroadcast.addMsg(LangConfig.getWord("139",0));
                           }
                        });
                     }
                     else
                     {
                        StrFilter.load(data_str,function(te:String):void
                        {
                           var cleanTe:String = StrFilter.replace(te);
                           tem_num = CommandManager.get_bag_vec(Enum_filter.ID,null,[KFLB])[0].gridId;
                           ChatCGMessage.CG_CHAT(8,cleanTe);
                        });
                     }
                  }
                  else if(temChatType == 11)
                  {
                     if(SceneConfig.getSceneType() == SceneConfig.CROSS_CAMP_BATTLE)
                     {
                        StrFilter.load(data_str,function(te:String):void
                        {
                           var cleanTe:String = StrFilter.replace(te);
                           ChatCGMessage.CG_CHAT(11,cleanTe);
                        });
                     }
                  }
               }
               chat_contact.text = "";
            }
         }
      }
      
      public function add(str:String, roleId:Number = 0, chatType:int = 0, roleName:String = "name") : void
      {
         if(chatType == 8)
         {
            this.kuafuList.addItem(str,-1,{
               "id":roleId,
               "chat_type":chatType,
               "name":roleName
            },this.linkHandle);
            this.setPosition(this.kuafuList);
            return;
         }
         if(Model_init.isUseNewChat)
         {
            ChatPanM.instance.addMes(1,str,{
               "id":roleId,
               "chat_type":chatType
            });
         }
         else
         {
            this.worldList.addItem(str,-1,{
               "id":roleId,
               "chat_type":chatType,
               "name":roleName
            },this.linkHandle);
            this.setPosition(this.worldList);
         }
      }
      
      public function addFlower(str:String, setname:String, getname:String) : void
      {
      }
      
      public function addBangMess(result:int, roleId:Number, roleName:String) : void
      {
         var ss:String = null;
         var str:String = HtmlUtil.font(" " + Str_channel[4 - 1] + "  ",this.chan_color_arr[4 - 1]);
         if(result == 1)
         {
            this.bangList.addItem(str + " " + HtmlUtil.font(roleName + " ","#33CCFF") + LangConfig.getWord("980",0),-1,{
               "id":roleId,
               "chat_type":4
            });
         }
         else if(result == 2)
         {
            this.bangList.addItem(str + " " + HtmlUtil.font(roleName + " ","#33CCFF") + LangConfig.getWord("981",0),-1,{
               "id":roleId,
               "chat_type":4
            },this.linkHandle);
         }
         else if(result == 3)
         {
            ss = LangConfig.getWord("1133",0,HtmlUtil.font(roleName + " ","#33CCFF"));
            this.bangList.addItem(str + " " + ss,-1,{"chat_type":4},this.linkHandle);
         }
         if(!this.bangList.visible)
         {
            this.getEffect("bang");
         }
         this.setPosition(this.bangList);
      }
      
      public function addStr(type:int, str:String) : void
      {
         var __str:String = HtmlUtil.font(" " + Str_channel[type - 1] + "  ",this.chan_color_arr[type - 1]);
         if(Model_init.isUseNewChat)
         {
            ChatPanM.instance.addMes(4,__str + " " + str,{"chat_type":4});
         }
         else
         {
            this.bangList.addItem(__str + " " + str,-1,{"chat_type":4},this.linkHandle);
         }
         if(!this.bangList.visible)
         {
            this.getEffect("bang");
         }
         this.setPosition(this.bangList);
      }
      
      public function addBangHuiPinDao(msg:String) : void
      {
         this.bangList.addItem(HtmlUtil.font(" " + Str_channel[4 - 1] + "  ","#32cd32") + HtmlUtil.font(msg,"#fffc70"),-1,{"chat_type":4},this.linkHandle);
         if(!this.bangList.visible)
         {
            this.getEffect("bang");
         }
      }
      
      public function addFireworkMsg(msg:String, name:String = "name") : void
      {
         if(Model_init.isUseNewChat)
         {
            ChatPanM.instance.addMes(1,HtmlUtil.font(" 系统  ","#32cd32") + HtmlUtil.font(msg,"#fffc70"),{"chat_type":1});
         }
         else
         {
            this.worldList.addItem(HtmlUtil.font(" 系统  ","#32cd32") + HtmlUtil.font(msg,"#fffc70"),-1,{
               "chat_type":1,
               "name":name
            },this.linkHandle);
         }
         this.setPosition(this.worldList);
      }
      
      public function removeEffect() : void
      {
         EffectManager.removeEffect(this.lineEff);
         this.lineEff = null;
      }
      
      private function getSpecialStr(str:String) : String
      {
         this.getStr = "";
         var tem_num_start:int = str.indexOf("【");
         var tem_num_end:int = str.indexOf("】");
         if(tem_num_start == -1 || tem_num_end == -1)
         {
            return str;
         }
         this.hanlde_str(str);
         return this.getStr;
      }
      
      private function hanlde_str(str:String) : void
      {
         var tem_vo:Vo_valuable = null;
         var tem_type:int = 0;
         if(!str.length)
         {
            return;
         }
         var startIndex:int = str.indexOf("【");
         var endIndex:int = str.indexOf("】");
         if(startIndex == -1)
         {
            startIndex = str.length;
         }
         var str1:String = str.slice(0,startIndex);
         var temStr:String = str.slice(startIndex,endIndex + 1);
         var temBool:int = this.matchStr(temStr);
         if(temBool != -1)
         {
            tem_vo = Model_chat.chat_save[temBool][0];
            if(tem_vo is Vo_equip)
            {
               tem_type = 2;
               this.getStr += str1 + "<a href=\'event:" + "show" + "_" + String(tem_type) + "_" + String(tem_vo.id_server) + "\'>" + HtmlUtil.font(temStr,Model_shop.get_color_arr[tem_vo.color - 1]) + "</a>";
            }
            else if(tem_vo is Vo_item)
            {
               tem_type = 1;
               this.getStr += str1 + "<a href=\'event:" + "show" + "_" + String(tem_type) + "_" + String(tem_vo.id) + "\'>" + HtmlUtil.font(temStr,Model_shop.get_color_arr[tem_vo.color - 1]) + "</a>";
            }
         }
         else
         {
            this.getStr += str1 + temStr;
         }
         str = str.replace(str.slice(0,endIndex + 1),"");
         if(startIndex == -1 || endIndex == -1)
         {
            str = "";
         }
         this.hanlde_str(str);
      }
      
      private function matchStr(str:String) : int
      {
         if(!Model_chat.chat_save.length)
         {
            return -1;
         }
         var i:int = 0;
         while(i < Model_chat.chat_save.length)
         {
            if(Model_chat.chat_save[i][1] == str)
            {
               return i;
            }
            i++;
         }
         return -1;
      }
      
      public function addSysMessage(content:String) : void
      {
         if(Boolean(this.worldList))
         {
            this.worldList.addItem(HtmlUtil.font(" " + Str_channel[0] + "  ",this.chan_color_arr[0]) + content,-1,null,this.linkHandle);
         }
      }
      
      public function addMessage(chatType:int, chatContact:String, roleName:String, sex:int, vip:int, roleId:Number, job:int, diaLv:int = 0, isYearDi:int = 0, huangZLv:int = 0, isHuangZYear:int = 0, huiyuan:int = 0, huiyuanYear:int = 0, superLan:int = 0, superLanYear:int = 0, isSuperHuang:int = 0, faceInfo:String = "") : void
      {
         var _channel:ChatList = null;
         var i:int = 0;
         var id:int = 0;
         var voim:Vo_item = null;
         var _arr:Array = null;
         var _mStr:String = null;
         var unit:BattleUnit = null;
         if(vip == 4)
         {
            vip = 2;
         }
         var role:Role = GameUnitManager.findUnit(roleId,UnitType.PLAYER) as Role;
         if(roleId == GameUnitManager.hero.id)
         {
            RichTF.roleVipDic[View_HeroHead.playerName] = GameUnitManager.hero.vip;
         }
         else
         {
            RichTF.roleVipDic[roleName] = vip;
         }
         Model_face.chatRoleHasOwnedFaceInfo[roleName] = [];
         var tArr:Array = faceInfo.split(",");
         if(Boolean(tArr) && Boolean(tArr.length))
         {
            i = 0;
            while(i < tArr.length)
            {
               id = int(tArr[i]);
               voim = new Vo_item();
               voim.id = id;
               voim.Init_lib();
               Model_face.chatRoleHasOwnedFaceInfo[roleName].push(voim.face_icon_id);
               i++;
            }
         }
         if(GameUnitManager.hero.id == roleId)
         {
            if(!chatJiluDic[chatContact])
            {
               chatJiluDic[chatContact] = [];
               chatJiluDic[chatContact].push(chatContact);
            }
            else
            {
               _arr = chatJiluDic[chatContact];
               if(_arr.length > 0)
               {
                  _mStr = _arr[0];
                  if(_mStr == chatContact)
                  {
                     chatJiluDic[chatContact].push(chatContact);
                  }
               }
               if(chatJiluDic[chatContact].length >= 5)
               {
               }
            }
         }
         if(chatType == 7)
         {
            if(!this.lineEff)
            {
               this.lineEff = EffectManager.addEffect("35020",UIManager.laba_panel,2000,132,34,true);
            }
            if(!UIManager.laba_panel.visible)
            {
               UIManager.laba_panel.visible = true;
            }
            UIManager.laba_panel.updateFlowerMessage(chatContact);
            return;
         }
         if(chatType == 6)
         {
            UIManager.laba_panel.update(roleName,chatContact,sex,roleId,diaLv,isYearDi,huangZLv,isHuangZYear,huiyuan,huiyuanYear,chatType,job,0,superLan,superLanYear,isSuperHuang);
            return;
         }
         if(chatType == 1)
         {
            _channel = this.worldList;
            if(GameUnitManager.hero.id == roleId)
            {
               this.worldList.addItem(HtmlUtil.font(" " + Str_channel[chatType - 1] + "  ",this.chan_color_arr[chatType - 1]) + getSpace(diaLv,isYearDi,huangZLv,isHuangZYear,huiyuan,huiyuanYear,superLan,superLanYear,isSuperHuang) + HtmlUtil.font(this.sex_sign[sex - 1],this.sex_color_arr[sex - 1]) + HtmlUtil.font("【" + roleName + "】",this.job_color_arr[Enum_job.getBaseJob(job) - 1]) + HtmlUtil.font(this.vip_sign[vip] + "：",Boolean(vip) ? this.colorArr[vip] : "#f9ff00") + HtmlUtil.font(chatContact,"#fffc70"),-1,{
                  "chat_type":chatType,
                  "diaLvl":diaLv,
                  "isYearDia":isYearDi,
                  "hzLvl":huangZLv,
                  "isYearHz":isHuangZYear,
                  "isHuiyuan":huiyuan,
                  "isHuiYuanYear":huiyuanYear,
                  "superLan":superLan,
                  "superLanYear":superLanYear,
                  "contant":chatContact,
                  "isSuperHuang":isSuperHuang
               },this.linkHandle);
            }
            else
            {
               this.worldList.addItem(HtmlUtil.font(" " + Str_channel[chatType - 1] + "  ",this.chan_color_arr[chatType - 1]) + getSpace(diaLv,isYearDi,huangZLv,isHuangZYear,huiyuan,superLan,superLanYear,isSuperHuang) + HtmlUtil.font(this.sex_sign[sex - 1],this.sex_color_arr[sex - 1]) + HtmlUtil.link(HtmlUtil.font("【" + roleName + "】",this.job_color_arr[Enum_job.getBaseJob(job) - 1]),String(roleId)) + HtmlUtil.font(this.vip_sign[vip] + "：",Boolean(vip) ? this.colorArr[vip] : "#f9ff00") + HtmlUtil.font(chatContact,"#fffc70"),-1,{
                  "id":roleId,
                  "name":roleName,
                  "linkArr":Model_chat.chat_save,
                  "chat_type":chatType,
                  "diaLvl":diaLv,
                  "isYearDia":isYearDi,
                  "hzLvl":huangZLv,
                  "isYearHz":isHuangZYear,
                  "isHuiyuan":huiyuan,
                  "isHuiYuanYear":huiyuanYear,
                  "superLan":superLan,
                  "superLanYear":superLanYear,
                  "contant":chatContact,
                  "isSuperHuang":isSuperHuang
               },this.linkHandle);
            }
            this.setPosition(this.worldList);
         }
         else if(chatType == 2)
         {
            _channel = this.fujinList;
            if(GameUnitManager.hero.level >= 30)
            {
               if(Boolean(role))
               {
                  role.say(HtmlUtil.font(chatContact,"#fffc70"),{"name":roleName});
               }
               if(Global.isInBattle)
               {
                  unit = BattleUnitManager.findUnit(roleId) as BattleUnit;
                  if(Boolean(unit))
                  {
                     unit.say(HtmlUtil.font(chatContact,"#fffc70"),{"name":roleName});
                  }
               }
            }
            if(GameUnitManager.hero.id == roleId)
            {
               this.worldList.addItem(HtmlUtil.font(" " + Str_channel[chatType - 1] + "  ",this.chan_color_arr[chatType - 1]) + getSpace(diaLv,isYearDi,huangZLv,isHuangZYear,huiyuan,huiyuanYear,superLan,superLanYear,isSuperHuang) + HtmlUtil.font(this.sex_sign[sex - 1],this.sex_color_arr[sex - 1]) + HtmlUtil.font("【" + roleName + "】",this.job_color_arr[Enum_job.getBaseJob(job) - 1]) + HtmlUtil.font(this.vip_sign[vip] + "：",Boolean(vip) ? this.colorArr[vip] : "#f9ff00") + HtmlUtil.font(chatContact,"#fffc70"),-1,{
                  "chat_type":chatType,
                  "diaLvl":diaLv,
                  "isYearDia":isYearDi,
                  "hzLvl":huangZLv,
                  "isYearHz":isHuangZYear,
                  "isHuiyuan":huiyuan,
                  "isHuiYuanYear":huiyuanYear,
                  "superLan":superLan,
                  "superLanYear":superLanYear,
                  "contant":chatContact,
                  "isSuperHuang":isSuperHuang
               },this.linkHandle);
               this.fujinList.addItem(HtmlUtil.font(" " + Str_channel[chatType - 1] + "  ",this.chan_color_arr[chatType - 1]) + getSpace(diaLv,isYearDi,huangZLv,isHuangZYear,huiyuan,huiyuanYear,superLan,superLanYear,isSuperHuang) + HtmlUtil.font(this.sex_sign[sex - 1],this.sex_color_arr[sex - 1]) + HtmlUtil.font("【" + roleName + "】",this.job_color_arr[Enum_job.getBaseJob(job) - 1]) + HtmlUtil.font(this.vip_sign[vip] + "：",Boolean(vip) ? this.colorArr[vip] : "#f9ff00") + HtmlUtil.font(chatContact,"#fffc70"),-1,{
                  "chat_type":chatType,
                  "diaLvl":diaLv,
                  "isYearDia":isYearDi,
                  "hzLvl":huangZLv,
                  "isYearHz":isHuangZYear,
                  "isHuiyuan":huiyuan,
                  "isHuiYuanYear":huiyuanYear,
                  "superLan":superLan,
                  "superLanYear":superLanYear,
                  "contant":chatContact,
                  "isSuperHuang":isSuperHuang
               },this.linkHandle);
               this.setPosition(this.worldList,this.fujinList);
            }
            else
            {
               this.worldList.addItem(HtmlUtil.font(" " + Str_channel[chatType - 1] + "  ",this.chan_color_arr[chatType - 1]) + getSpace(diaLv,isYearDi,huangZLv,isHuangZYear,huiyuan,huiyuanYear,superLan,superLanYear,isSuperHuang) + HtmlUtil.font(this.sex_sign[sex - 1],this.sex_color_arr[sex - 1]) + HtmlUtil.link(HtmlUtil.font("【" + roleName + "】",this.job_color_arr[Enum_job.getBaseJob(job) - 1]),String(roleId)) + HtmlUtil.font(this.vip_sign[vip] + "：",Boolean(vip) ? this.colorArr[vip] : "#f9ff00") + HtmlUtil.font(chatContact,"#fffc70"),-1,{
                  "id":roleId,
                  "name":roleName,
                  "linkArr":Model_chat.chat_save,
                  "chat_type":chatType,
                  "diaLvl":diaLv,
                  "isYearDia":isYearDi,
                  "hzLvl":huangZLv,
                  "isYearHz":isHuangZYear,
                  "isHuiyuan":huiyuan,
                  "isHuiYuanYear":huiyuanYear,
                  "superLan":superLan,
                  "superLanYear":superLanYear,
                  "contant":chatContact,
                  "isSuperHuang":isSuperHuang
               },this.linkHandle);
               this.fujinList.addItem(HtmlUtil.font(" " + Str_channel[chatType - 1] + "  ",this.chan_color_arr[chatType - 1]) + getSpace(diaLv,isYearDi,huangZLv,isHuangZYear,huiyuan,huiyuanYear,superLan,superLanYear,isSuperHuang) + HtmlUtil.font(this.sex_sign[sex - 1],this.sex_color_arr[sex - 1]) + HtmlUtil.link(HtmlUtil.font("【" + roleName + "】",this.job_color_arr[Enum_job.getBaseJob(job) - 1]),String(roleId)) + HtmlUtil.font(this.vip_sign[vip] + "：",Boolean(vip) ? this.colorArr[vip] : "#f9ff00") + HtmlUtil.font(chatContact,"#fffc70"),-1,{
                  "id":roleId,
                  "name":roleName,
                  "linkArr":Model_chat.chat_save,
                  "chat_type":chatType,
                  "diaLvl":diaLv,
                  "isYearDia":isYearDi,
                  "hzLvl":huangZLv,
                  "isYearHz":isHuangZYear,
                  "isHuiyuan":huiyuan,
                  "isHuiYuanYear":huiyuanYear,
                  "superLan":superLan,
                  "superLanYear":superLanYear,
                  "contant":chatContact,
                  "isSuperHuang":isSuperHuang
               },this.linkHandle);
            }
            this.setPosition(this.worldList,this.fujinList);
         }
         else if(chatType == 3)
         {
            _channel = this.teamList;
            if(Boolean(role))
            {
               role.say(HtmlUtil.font(chatContact,"#fffc70"),{"name":roleName});
            }
            if(Global.isInBattle)
            {
               unit = BattleUnitManager.findUnit(roleId) as BattleUnit;
               if(Boolean(unit))
               {
                  unit.say(HtmlUtil.font(chatContact,"#fffc70"),{"name":roleName});
               }
            }
            if(GameUnitManager.hero.id == roleId)
            {
               this.teamList.addItem(HtmlUtil.font(" " + Str_channel[chatType - 1] + "  ",this.chan_color_arr[chatType - 1]) + getSpace(diaLv,isYearDi,huangZLv,isHuangZYear,huiyuan,huiyuanYear,superLan,superLanYear,isSuperHuang) + HtmlUtil.font(this.sex_sign[sex - 1],this.sex_color_arr[sex - 1]) + HtmlUtil.font("【" + roleName + "】",this.job_color_arr[Enum_job.getBaseJob(job) - 1]) + HtmlUtil.font(this.vip_sign[vip] + "：",Boolean(vip) ? this.colorArr[vip] : "#f9ff00") + HtmlUtil.font(chatContact,"#fffc70"),-1,{
                  "chat_type":chatType,
                  "diaLvl":diaLv,
                  "isYearDia":isYearDi,
                  "hzLvl":huangZLv,
                  "isYearHz":isHuangZYear,
                  "isHuiyuan":huiyuan,
                  "isHuiYuanYear":huiyuanYear,
                  "superLan":superLan,
                  "superLanYear":superLanYear,
                  "isSuperHuang":isSuperHuang
               },this.linkHandle);
            }
            else
            {
               if(!this.teamList.visible)
               {
                  this.getEffect("team");
               }
               this.teamList.addItem(HtmlUtil.font(" " + Str_channel[chatType - 1] + "  ",this.chan_color_arr[chatType - 1]) + getSpace(diaLv,isYearDi,huangZLv,isHuangZYear,huiyuan,huiyuanYear,superLan,superLanYear,isSuperHuang) + HtmlUtil.font(this.sex_sign[sex - 1],this.sex_color_arr[sex - 1]) + HtmlUtil.link(HtmlUtil.font("【" + roleName + "】",this.job_color_arr[Enum_job.getBaseJob(job) - 1]),String(roleId)) + HtmlUtil.font(this.vip_sign[vip] + "：",Boolean(vip) ? this.colorArr[vip] : "#f9ff00") + HtmlUtil.font(chatContact,"#fffc70"),-1,{
                  "id":roleId,
                  "name":roleName,
                  "linkArr":Model_chat.chat_save,
                  "chat_type":chatType,
                  "diaLvl":diaLv,
                  "isYearDia":isYearDi,
                  "hzLvl":huangZLv,
                  "isYearHz":isHuangZYear,
                  "isHuiyuan":huiyuan,
                  "isHuiYuanYear":huiyuanYear,
                  "superLan":superLan,
                  "superLanYear":superLanYear,
                  "isSuperHuang":isSuperHuang
               },this.linkHandle);
            }
            this.setPosition(this.worldList,this.teamList);
         }
         else if(chatType == 4)
         {
            _channel = this.bangList;
            if(GameUnitManager.hero.id == roleId)
            {
               this.bangList.addItem(HtmlUtil.font(" " + Str_channel[chatType - 1] + "  ",this.chan_color_arr[chatType - 1]) + getSpace(diaLv,isYearDi,huangZLv,isHuangZYear,huiyuan,huiyuanYear,superLan,superLanYear,isSuperHuang) + HtmlUtil.font(this.sex_sign[sex - 1],this.sex_color_arr[sex - 1]) + HtmlUtil.font(" ","#3399ff") + HtmlUtil.font("【" + roleName + "】",this.job_color_arr[Enum_job.getBaseJob(job) - 1]) + HtmlUtil.font(this.vip_sign[vip] + "：",Boolean(vip) ? this.colorArr[vip] : "#f9ff00") + HtmlUtil.font(chatContact,"#fffc70"),-1,{
                  "chat_type":chatType,
                  "diaLvl":diaLv,
                  "isYearDia":isYearDi,
                  "hzLvl":huangZLv,
                  "isYearHz":isHuangZYear,
                  "isHuiyuan":huiyuan,
                  "isHuiYuanYear":huiyuanYear,
                  "superLan":superLan,
                  "superLanYear":superLanYear,
                  "isSuperHuang":isSuperHuang
               },this.linkHandle);
            }
            else
            {
               if(!this.bangList.visible)
               {
                  this.getEffect("bang");
               }
               this.bangList.addItem(HtmlUtil.font(" " + Str_channel[chatType - 1] + "  ",this.chan_color_arr[chatType - 1]) + getSpace(diaLv,isYearDi,huangZLv,isHuangZYear,huiyuan,huiyuanYear,superLan,superLanYear,isSuperHuang) + HtmlUtil.font(this.sex_sign[sex - 1],this.sex_color_arr[sex - 1]) + HtmlUtil.font(" ","#3399ff") + HtmlUtil.link(HtmlUtil.font("【" + roleName + "】",this.job_color_arr[Enum_job.getBaseJob(job) - 1]),String(roleId)) + HtmlUtil.font(this.vip_sign[vip] + "：",Boolean(vip) ? this.colorArr[vip] : "#f9ff00") + HtmlUtil.font(chatContact,"#fffc70"),-1,{
                  "id":roleId,
                  "name":roleName,
                  "linkArr":Model_chat.chat_save,
                  "chat_type":chatType,
                  "diaLvl":diaLv,
                  "isYearDia":isYearDi,
                  "hzLvl":huangZLv,
                  "isYearHz":isHuangZYear,
                  "isHuiyuan":huiyuan,
                  "isHuiYuanYear":huiyuanYear,
                  "superLan":superLan,
                  "superLanYear":superLanYear,
                  "isSuperHuang":isSuperHuang
               },this.linkHandle);
            }
            this.setPosition(this.worldList,this.bangList);
         }
         else if(chatType == 5)
         {
            _channel = this.sysList;
            this.worldList.addItem(HtmlUtil.font(chatContact,"#ff0000"),-1,null,this.linkHandle);
            this.sysList.addItem(HtmlUtil.font(chatContact,"#ff0000"),-1,null,this.linkHandle);
            this.setPosition(this.sysList);
         }
         else if(chatType == 8)
         {
            _channel = this.kuafuList;
            if(Boolean(role))
            {
               role.say(HtmlUtil.font(chatContact,"#fffc70"),{"name":roleName});
            }
            if(Global.isInBattle)
            {
               unit = BattleUnitManager.findUnit(roleId) as BattleUnit;
               if(Boolean(unit))
               {
                  unit.say(HtmlUtil.font(chatContact,"#fffc70"),{"name":roleName});
               }
            }
            if(GameUnitManager.hero.id == roleId)
            {
               this.kuafuList.addItem(HtmlUtil.font(" " + Str_channel[5] + "  ",this.chan_color_arr[0]) + getSpace(diaLv,isYearDi,huangZLv,isHuangZYear,huiyuan,huiyuanYear,superLan,superLanYear,isSuperHuang) + HtmlUtil.font(this.sex_sign[sex - 1],this.sex_color_arr[sex - 1]) + HtmlUtil.font("【" + roleName + "】",this.job_color_arr[Enum_job.getBaseJob(job) - 1]) + HtmlUtil.font(this.vip_sign[vip] + "：",Boolean(vip) ? this.colorArr[vip] : "#f9ff00") + HtmlUtil.font(chatContact,"#fffc70"),-1,{
                  "chat_type":chatType,
                  "diaLvl":diaLv,
                  "isYearDia":isYearDi,
                  "hzLvl":huangZLv,
                  "isYearHz":isHuangZYear,
                  "isHuiyuan":huiyuan,
                  "isHuiYuanYear":huiyuanYear,
                  "superLan":superLan,
                  "superLanYear":superLanYear,
                  "contant":chatContact,
                  "isSuperHuang":isSuperHuang
               },this.linkHandle);
            }
            else
            {
               this.kuafuList.addItem(HtmlUtil.font(" " + Str_channel[5] + "  ",this.chan_color_arr[0]) + getSpace(diaLv,isYearDi,huangZLv,isHuangZYear,huiyuan,huiyuanYear,superLan,superLanYear,isSuperHuang) + HtmlUtil.font(this.sex_sign[sex - 1],this.sex_color_arr[sex - 1]) + HtmlUtil.link(HtmlUtil.font("【" + roleName + "】",this.job_color_arr[Enum_job.getBaseJob(job) - 1]),String(roleId)) + HtmlUtil.font(this.vip_sign[vip] + "：",Boolean(vip) ? this.colorArr[vip] : "#f9ff00") + HtmlUtil.font(chatContact,"#fffc70"),-1,{
                  "id":roleId,
                  "name":roleName,
                  "linkArr":Model_chat.chat_save,
                  "chat_type":chatType,
                  "diaLvl":diaLv,
                  "isYearDia":isYearDi,
                  "hzLvl":huangZLv,
                  "isYearHz":isHuangZYear,
                  "isHuiyuan":huiyuan,
                  "isHuiYuanYear":huiyuanYear,
                  "superLan":superLan,
                  "superLanYear":superLanYear,
                  "contant":chatContact,
                  "isSuperHuang":isSuperHuang
               },this.linkHandle);
            }
            this.setPosition(this.kuafuList);
         }
         else if(chatType == 11)
         {
            _channel = this.kuafuList;
            if(GameUnitManager.hero.id == roleId)
            {
               this.kuafuList.addItem(HtmlUtil.font(" " + Str_channel[5] + "  ",this.chan_color_arr[0]) + getSpace(diaLv,isYearDi,huangZLv,isHuangZYear,huiyuan,huiyuanYear,superLan,superLanYear,isSuperHuang) + HtmlUtil.font(sex - 1 < 0 ? "" : this.sex_sign[sex - 1],this.sex_color_arr[sex - 1]) + HtmlUtil.font("【" + roleName + "】",this.job_color_arr[Enum_job.getBaseJob(job) - 1]) + HtmlUtil.font(this.vip_sign[vip] + "：",Boolean(vip) ? this.colorArr[vip] : "#f9ff00") + HtmlUtil.font(chatContact,"#fffc70"),-1,{
                  "chat_type":chatType,
                  "diaLvl":diaLv,
                  "isYearDia":isYearDi,
                  "hzLvl":huangZLv,
                  "isYearHz":isHuangZYear,
                  "isHuiyuan":huiyuan,
                  "isHuiYuanYear":huiyuanYear,
                  "superLan":superLan,
                  "superLanYear":superLanYear,
                  "contant":chatContact,
                  "isSuperHuang":isSuperHuang
               },this.linkHandle);
            }
            else
            {
               this.kuafuList.addItem(HtmlUtil.font(" " + Str_channel[5] + "  ",this.chan_color_arr[0]) + getSpace(diaLv,isYearDi,huangZLv,isHuangZYear,huiyuan,huiyuanYear,superLan,superLanYear,isSuperHuang) + HtmlUtil.font(sex - 1 < 0 ? "" : this.sex_sign[sex - 1],this.sex_color_arr[sex - 1]) + HtmlUtil.link(HtmlUtil.font("【" + roleName + "】",this.job_color_arr[Enum_job.getBaseJob(job) - 1]),String(roleId)) + HtmlUtil.font(this.vip_sign[vip] + "：",Boolean(vip) ? this.colorArr[vip] : "#f9ff00") + HtmlUtil.font(chatContact,"#fffc70"),-1,{
                  "id":roleId,
                  "name":roleName,
                  "linkArr":Model_chat.chat_save,
                  "chat_type":chatType,
                  "diaLvl":diaLv,
                  "isYearDia":isYearDi,
                  "hzLvl":huangZLv,
                  "isYearHz":isHuangZYear,
                  "isHuiyuan":huiyuan,
                  "isHuiYuanYear":huiyuanYear,
                  "superLan":superLan,
                  "superLanYear":superLanYear,
                  "contant":chatContact,
                  "isSuperHuang":isSuperHuang
               },this.linkHandle);
            }
            this.setPosition(this.kuafuList);
         }
         Model_chat.chat_save = [];
      }
      
      private function linkHandle(e:TextEvent, data:Object) : void
      {
         var temStr:String = null;
         var pan:View_PlayerExtendPanel = null;
         var ids:int = 0;
         var temType:int = 0;
         var temId:Number = NaN;
         var temVoItem:Vo_item = null;
         var temChatTip:ChatTip = null;
         var teamData:Array = null;
         var teamId:int = 0;
         var teamType:int = 0;
         var tem:int = 0;
         if(SceneConfig.getSceneType() == SceneConfig.AiDeBaoBao || SceneConfig.getSceneType() == SceneConfig.CROSS_CAMP_BATTLE)
         {
            return;
         }
         GameScene.instance.onTextEventLink();
         temStr = e.text;
         if(temStr == "jingjiLuckyNum")
         {
            UIManager.jjc_panel.visible = true;
            return;
         }
         if(temStr == "tomorrDayGift")
         {
            TomGifICon.instance.clickHd();
            return;
         }
         if(temStr.indexOf("boatJoin_") != -1)
         {
            if(Global.sceneMap != 14401)
            {
               UIManager.centerBroadcast.addMsg("您不在龙舟地图哦");
               return;
            }
            BoatCGMessage.CG_RENTSHIP(temStr.split("boatJoin_")[1]);
            return;
         }
         if(data.chat_type == 8)
         {
            if(temStr.slice(0,4) != "kftz")
            {
               pan = View_PlayerExtendPanel.instance;
               pan.getItem(false,8,9);
            }
         }
         else if(data.chat_type == 11)
         {
            pan = View_PlayerExtendPanel.instance;
            pan.getItem(false,1,2,3,4,5,6,7,11);
         }
         else
         {
            if(data.chat_type == 888)
            {
               ZhaoCaiMaoCGMessage.CG_ZHAOCAIMAO_WEIYANG(data.id);
               return;
            }
            if(temStr == "qingrenjie")
            {
               (Singleton.getInstance(Delegate123) as Delegate123).dosomething(View_QingRenJie.instance,function():void
               {
                  View_QingRenJie.instance.visible = !View_QingRenJie.instance.visible;
               });
               return;
            }
            if(temStr == "moneytree")
            {
               (Singleton.getInstance(Delegate123) as Delegate123).dosomething(View_MoneyTree.instance,function():void
               {
                  View_MoneyTree.instance.visible = !View_MoneyTree.instance.visible;
                  MoneyTreeCGMessage.CG_MONEYTREE_OPENWIN();
               });
               return;
            }
            if(temStr == "zhutizhou")
            {
               ids = Boolean(ActivityTopicPanel.index) ? ActivityTopicPanel.index : ZhuTiZhouHandler.tempId;
               ZhuTiZhouCGMessage.CG_ZTZ_GONGGAO(ids);
               return;
            }
            if(temStr == "xiaofeituangou")
            {
               XiaoFeiTuanGouCGMessage.CG_XFTG_OPEN();
               return;
            }
            pan = View_PlayerExtendPanel.instance;
            pan.getItem(false,1,2,3,4,5,6,7);
         }
         if(temStr.slice(0,4) == "show")
         {
            temType = int(temStr.slice(5,6));
            temId = Number(temStr.slice(7,temStr.length));
            if(temType == 2)
            {
               ChatCGMessage.CG_SHOW(temId);
            }
            else
            {
               temVoItem = new Vo_item();
               temVoItem.id = temId;
               temVoItem.Init_lib();
               temChatTip = ChatTip.getInstance();
               temChatTip.show(temVoItem);
            }
            return;
         }
         if(temStr.slice(0,4) == "invi")
         {
            if(!data.id || data.id == GameUnitManager.hero.id)
            {
               return;
            }
            TeamCGMessage.CG_DIRECT_TEAM_STATE(0,data.id.toString());
            return;
         }
         if(temStr.slice(0,4) == "role")
         {
            if(!data.id || data.id == GameUnitManager.hero.id)
            {
               return;
            }
            Global.control.sendNotification(Enum_MsgType.MSG_CHECKOTHERROLE,data.id);
            return;
         }
         if(temStr.slice(0,4) == "qiju")
         {
            if(!data.id || data.id == GameUnitManager.hero.id)
            {
               return;
            }
            teamData = temStr.split("_");
            teamId = int(teamData[1]);
            teamType = int(teamData[2]);
            QiJuHandler.joinQijuTeam(teamId,teamType);
            return;
         }
         if(temStr.slice(0,4) == "ping")
         {
            UIManager.smallMap.bangClick(null);
            return;
         }
         if(temStr.slice(0,4) == "open")
         {
            RoleCGMessage.CG_CHECK_OTHERROLE(data.id);
            return;
         }
         if(temStr == "becomeWuHun")
         {
            UIManager.vipPanel.visible = !UIManager.vipPanel.visible;
            return;
         }
         if(temStr.slice(0,4) == "kftz")
         {
            UIManager.chatPrompt4.show(function():void
            {
               var kftzArr:Array = null;
               if(GameUnitManager.hero.money >= 15)
               {
                  kftzArr = temStr.split("_");
                  if(Global.isInBattle)
                  {
                     UIManager.centerBroadcast.addMsg("正在战斗");
                  }
                  else
                  {
                     KuaFuJingJiChangCGMessage.CG_TIAOZHAN_CLICK(kftzArr[1],kftzArr[2],kftzArr[3]);
                  }
               }
               else
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("139",0));
               }
            });
            return;
         }
         if(temStr == "cgx_libao")
         {
            ShouChongTiaoZhengCGMessage.CG_ShouChongTiaoZheng_LINK();
            return;
         }
         if(temStr == "cgx_chongzhi")
         {
            if(Boolean(View_ShouChongTiaoZheng_menu.instance.btn.stage))
            {
               View_ShouChongTiaoZheng_menu.instance.visible = true;
            }
            else
            {
               UIManager.centerBroadcast.addMsg("您已经领完所有奖励",1);
            }
            return;
         }
         if(temStr == "jingjichang")
         {
            Global.control.sendNotification(Enum_MsgType.MSG_CHECKOTHERROLE,data.id);
            return;
         }
         if(temStr == "vip_hun")
         {
            UIManager.vipPanel.visible = !UIManager.vipPanel.visible;
            return;
         }
         if(temStr == "bangYao")
         {
            UIManager.bangMoneyTree.visible = !UIManager.bangMoneyTree.visible;
            return;
         }
         if(temStr == "ChongZhiDaLiBao")
         {
            if(GameUnitManager.hero.level < 18)
            {
               UIManager.centerBroadcast.addMsg("等级达到18级开启此活动");
            }
            else
            {
               WuXingMter.getPan(View_chargeBackPan,function(pan:View_chargeBackPan):void
               {
                  RechargeFeedbackCGMessage.CG_OPEN_FEEDBACK();
                  pan.visible = true;
               });
            }
            return;
         }
         if(temStr == "card")
         {
            if(GameUnitManager.hero.level < 45)
            {
               UIManager.centerBroadcast.addMsg("卡牌系统45级开启，大侠请速去练级",1);
            }
            else
            {
               View_card_panel.instance.icon.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            }
            return;
         }
         pan = View_PlayerExtendPanel.instance;
         pan.visible = true;
         pan.x = Global.stage.mouseX;
         pan.y = Global.stage.mouseY;
         if(pan.y + pan.perfectHeight > Global.stage.stageHeight)
         {
            tem = pan.y + pan.perfectHeight - Global.stage.stageHeight;
            pan.y = Global.stage.mouseY - tem - 10;
         }
         View_PlayerExtendPanel._priChatOtherRoleId = Number(e.text);
         View_PlayerExtendPanel._OtherRoleName = data.name;
         View_PlayerExtendPanel._chatContant = data.contant;
      }
      
      private function getEffect(str:String) : void
      {
         if(str == "nearBy")
         {
            this.effBtn = this.TabButton_fujian;
         }
         else if(str == "team")
         {
            this.effBtn = this.TabButton_duiwu;
         }
         else if(str == "bang")
         {
            this.effBtn = this.TabButton_banghui;
         }
         EffecObj.getEffec(this.effBtn);
      }
      
      private function removeBtnEffect(btn:TabButton) : void
      {
         EffecObj.removeEffect(btn);
      }
      
      public function getExtrLaba() : void
      {
         this.liaotian_laba.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         Global.focus = chat_contact.focus;
      }
      
      private function faceClick(e:MouseEvent) : void
      {
         this.faceChooser.visible = !this.faceChooser.visible;
         if(this.faceChooser.visible)
         {
            this.faceChooser.parent.setChildIndex(this.faceChooser,this.faceChooser.parent.numChildren - 1);
         }
         var __x:int = e.target.x + this.x;
         var __y:int = e.target.y + this.y;
         this.faceChooser.x = __x - this.faceChooser.width / 2 + 8;
         this.faceChooser.y = __y - this.faceChooser.height;
      }
      
      private function addFace(faceIndex:int) : void
      {
         var tfIndex:int = chat_contact.caretIndex;
         var ss:String = faceIndex.toString();
         if(faceIndex < 10)
         {
            ss = "00" + faceIndex;
         }
         else if(faceIndex < 100 && faceIndex >= 10)
         {
            ss = "0" + faceIndex;
         }
         chat_contact.replaceText(tfIndex,tfIndex,"/" + ss);
         this.setFocus();
      }
      
      private function OnDownStopPo(e:MouseEvent) : void
      {
         e.stopPropagation();
      }
      
      private function chanOnDown(e:MouseEvent) : void
      {
         this._chann.visible = !this._chann.visible;
         if(this._chann.visible)
         {
            this._chann.parent.setChildIndex(this._chann,this._chann.parent.numChildren - 1);
         }
         var __x:int = e.target.x + this.x;
         var __y:int = e.target.y + this.y;
         this._chann.x = __x - 4;
         this._chann.y = __y - 213;
      }
      
      private function clickEvent(e:MouseEvent) : void
      {
         if(!(e.target is TabButton))
         {
            Button_choose.label = LangConfig.getWord("845",0);
            _chatType = 5;
            return;
         }
         var btn:TabButton = e.target as TabButton;
         if(Boolean(this.now))
         {
            this.now.choose = false;
         }
         btn.choose = true;
         this.now = btn;
         if(e.target.text != LangConfig.getWord("846",0))
         {
            Button_choose.label = e.target.text;
         }
         this.fujinList.visible = false;
         this.worldList.visible = false;
         this.teamList.visible = false;
         this.bangList.visible = false;
         this.sysList.visible = false;
         this.kuafuList.visible = false;
         this.preType = _chatType;
         if(Model_init.isUseNewChat)
         {
            if(e.target.tabIndex != 5)
            {
               ChatPanM.instance.addMes(e.target.tabIndex,"",null,true);
            }
         }
         if(e.target.text == LangConfig.getWord("842",0))
         {
            _chatType = 0;
            if(!Model_init.isUseNewChat)
            {
               this.worldList.visible = true;
            }
         }
         else if(e.target.text == LangConfig.getWord("843",0))
         {
            _chatType = 1;
            if(!Model_init.isUseNewChat)
            {
               this.fujinList.visible = true;
            }
         }
         else if(e.target.text == LangConfig.getWord("844",0))
         {
            _chatType = 2;
            if(!Model_init.isUseNewChat)
            {
               this.teamList.visible = true;
            }
            this.removeBtnEffect(btn);
         }
         else if(e.target.text == LangConfig.getWord("846",0))
         {
            _chatType = 4;
            if(!Model_init.isUseNewChat)
            {
               this.sysList.visible = true;
            }
         }
         else if(e.target.text == LangConfig.getWord("523",0))
         {
            _chatType = 3;
            if(!Model_init.isUseNewChat)
            {
               this.bangList.visible = true;
            }
            this.removeBtnEffect(btn);
         }
         else if(e.target.text == "跨服")
         {
            if(!Model_init.isUseNewChat)
            {
               this.kuafuList.visible = true;
            }
            _chatType = 7;
         }
         else if(e.target.text == "演兵")
         {
            if(!Model_init.isUseNewChat)
            {
               this.kuafuList.visible = true;
            }
            _chatType = 10;
         }
         this.updateLock();
      }
      
      override public function resetPosition() : void
      {
         x = 0;
         y = Global.stage.stageHeight - 238;
      }
      
      private function onClick(e:MouseEvent) : void
      {
         if(parent == GameScene.uiLayer)
         {
            GameScene.instance.uiOnGo(e);
         }
      }
      
      public function setDynamic() : void
      {
         Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_PRE_START,this.bStartHd);
         Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_END,this.bEndHd);
         Global.control.registerCallBack(Enum_MsgType.MODAL_SHOW,this.onModalShow);
         Global.control.registerCallBack(Enum_MsgType.MODAL_HIDE,this.onModalHide);
      }
      
      private function bStartHd() : void
      {
         GameScene.sysLayer.addChild(this);
         bindParent = GameScene.sysLayer;
      }
      
      private function bEndHd() : void
      {
         if(Boolean(_tmpParent) && ModalUIManager.isShow)
         {
            bindParent = _tmpParent;
            _tmpParent.addChildAt(this,0);
         }
         else
         {
            bindParent = GameScene.uiLayer;
            GameScene.uiLayer.addChildAt(this,0);
         }
      }
      
      private function onModalShow() : void
      {
         if(!BattleManager.isPlaying)
         {
            if(Boolean(_tmpParent))
            {
               bindParent = _tmpParent;
               _tmpParent.addChildAt(this,0);
            }
         }
      }
      
      private function onModalHide() : void
      {
         if(!BattleManager.isPlaying)
         {
            bindParent = GameScene.uiLayer;
            GameScene.uiLayer.addChildAt(this,0);
         }
      }
   }
}

