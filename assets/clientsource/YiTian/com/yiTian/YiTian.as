package com.yiTian
{
   import com.utils.Util;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.model.Model_initStr;
   import com.yiTian.manager.DailyRemainManager;
   import com.yiTian.manager.KeyBorderHandler;
   import com.yiTian.manager.KeyboardManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.LoadManager;
   import com.yiTian.manager.ResourceManager;
   import com.yiTian.manager.SceneManager;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.manager.StageManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.LoginHandler;
   import com.yiTian.net.message.cg.FangChenMiCGMessage;
   import com.yiTian.net.message.cg.FriendCGMessage;
   import com.yiTian.net.message.cg.QplusShareCGMessage;
   import com.yiTian.net.message.cg.SceneCGMessage;
   import com.yiTian.net.message.cg.WanJiaZhaoHuiCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.scene.LoadingScene;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.DAU.Model_DAU;
   import com.yiTian.view.modules.QShow.QShowSkinCGMessage;
   import com.yiTian.view.modules.ShengDan.ShengDanVO;
   import com.yiTian.view.modules.actions.frids.NewFriends;
   import com.yiTian.view.modules.aixin.AiXinBtn;
   import com.yiTian.view.modules.changxiang.ChangXiangBtn;
   import com.yiTian.view.modules.newYear.Config_NewYear;
   import com.yiTian.view.modules.playerExtend.CGXTestPan;
   import com.yiTian.view.modules.qqPackage.QQGroupStaticFunctions;
   import com.yiTian.view.modules.tip.tips.OffLineTip;
   import com.yiTian.view.modules.yellowDiamond.ActionsCtrl;
   import com.yiTian.view.modules.yellowDiamond.BaoshiQingYuanTip;
   import com.yiTian.view.modules.yellowDiamond.HuiyuanGiftTip;
   import com.yiTian.view.modules.yellowDiamond.QQGameZheKouJuanTips;
   import com.yiTian.view.modules.yellowDiamond.QQgameLibao;
   import com.yiTian.view.modules.yellowDiamond.View_qqHuiyuan;
   import com.yiTian.view.modules.yellowDiamond.newAct.NewYearActTip;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.external.ExternalInterface;
   import flash.net.Socket;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.utils.getTimer;
   
   [SWF(width="500", height="375", backgroundColor="#000000", frameRate="24")]
   [SWF(backgroundColor="#000000")]
   public class YiTian extends Sprite
   {
      
      public function YiTian()
      {
         var loader:Loader = null;
         super();
         if(!stage)
         {
            return;
         }
         loader = new Loader();
         loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(e:Event):void
         {
            loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,arguments.callee);
            loader.contentLoaderInfo.content["init"](stage);
         });
         loader.load(new URLRequest(stage.loaderInfo.parameters["loadFile"]));
      }
      
      public static function warnByTime(type:int) : void
      {
         FangChenMiCGMessage.CG_FCM_RETURN(type);
      }
      
      public function init(stage:Stage, loadScene:Object, heroId:Number, socket:Socket, socketIndex:Array, socketSend:Function, printFun:Function, socketReceive:Function) : void
      {
         if(!stage)
         {
            return;
         }
         Model_initStr.initStr();
         Utils.print = printFun;
         Global.loadScene = loadScene;
         LoadingScene.setProperty(loadScene);
         SocketManager.socket = socket;
         SocketManager.index = socketIndex;
         SocketManager.send = socketSend;
         SocketManager.receive = socketReceive;
         SocketManager.registerMessage();
         ActionsCtrl.initCmdDic();
         Global.config.font = "Tahoma";
         Global.config.lang = "ch";
         ResourceManager.resourceIndex = Util.resourcePool;
         if(!StageManager.init(stage))
         {
            return;
         }
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.testInfoShow);
         var parameters:Object = Global.stage.loaderInfo.parameters;
         KeyBorderHandler.PHPParam = parameters;
         ActionsCtrl.initPHPParam(parameters);
         Global.account = parameters["account"];
         Global.fcm = parameters["fcm"];
         Global.openkey = Boolean(parameters["openkey"]) ? parameters["openkey"] : "";
         Global.pf = Boolean(parameters["pf"]) ? parameters["pf"] : "";
         if(Enum_SPStr.isUnion(Global.pf))
         {
            Global.pf = Enum_SPStr.QZONE;
         }
         Global.fpkey = Boolean(parameters["fpkey"]) ? parameters["fpkey"] : "";
         Global.invkey = Boolean(parameters["invkey"]) ? parameters["invkey"] : "";
         Global.itime = Boolean(parameters["itime"]) ? parameters["itime"] : "";
         Global.iopenid = Boolean(parameters["iopenid"]) ? parameters["iopenid"] : "";
         Global.app_custom = Boolean(parameters["app_custom"]) ? parameters["app_custom"] : "";
         Global.zoneid = Boolean(parameters["zoneid"]) ? parameters["zoneid"] : "";
         Global.via = Boolean(parameters["via"]) ? parameters["via"] : "";
         Global.adtag = Boolean(parameters["adtag"]) ? parameters["adtag"] : "";
         Global.user_source = Boolean(parameters["user_source"]) ? parameters["user_source"] : "";
         Global.contract_id = Boolean(parameters["contract_id"]) ? parameters["contract_id"] : "";
         Global.tx_action_assitant_H = Boolean(parameters["txAction_assis_H"]) ? true : false;
         Global.tx_action_assitant_L = Boolean(parameters["txAction_assis_L"]) ? true : false;
         Global.tx_action_assitant_HY = Boolean(parameters["txAction_assis_HY"]) ? true : false;
         Global.huiYuanIconCtrl = Boolean(parameters["huiYuanIconCtrl"]) ? true : false;
         Global.huangZAct = Boolean(parameters["huangZAct"]) ? true : false;
         Global.BaoShiQYTimecrl = Boolean(parameters["BaoShiQYTimecrl"]) ? parameters["BaoShiQYTimecrl"] : "时间没传";
         Global.QQGameTimeCrl = Boolean(parameters["QQGameTimeCrl"]) ? parameters["QQGameTimeCrl"] : "时间（蓝钻）";
         Global.guanWangTimeCrl = Boolean(parameters["guanWangTimeCrl"]) ? parameters["guanWangTimeCrl"] : "时间（官网会员礼包）";
         Global.sheNianGfTipCtr = Boolean(parameters["sheNianGfTipCtr"]) ? Boolean(parameters["sheNianGfTipCtr"]) : Boolean("");
         Global.huangZTimeCtr = Boolean(parameters["guanWangTimeCrl"]) ? parameters["guanWangTimeCrl"] : "2013年3月16至3月23日";
         Global.qqJinQuanCtr = Boolean(parameters["qqJinQuanCtr"]) ? true : false;
         Global.isShowCaiFuTong = Boolean(parameters["isShowCaiFuTong"]) ? true : false;
         Global.iconCtrlUnknown = Boolean(parameters["iconCtrlUnknown"]) ? true : false;
         Global.WabIconCtrl = Boolean(parameters["WabIconCtrl"]) ? true : false;
         KeyBorderHandler.isUsingKeyBoardP = Boolean(parameters["isUsingKeyBoardP"]) ? true : false;
         Global.filMoviesCTRL = Boolean(parameters["filMoviesCTRL"]) ? true : false;
         Global.HZTimeCtr = Boolean(parameters["HZTimeCtr"]) ? parameters["HZTimeCtr"] : "默认时间";
         Global.conSumBackCtrl = Boolean(parameters["conSumBackCtrl"]) ? true : false;
         Global.xianShiGiftCtrl = Boolean(parameters["xianShiGiftCtrl"]) ? true : false;
         Global.WXIconCtrl = Boolean(parameters["WXIconCtrl"]) ? true : false;
         Global.QTIconCtrl = Boolean(parameters["QTIconCtrl"]) ? true : false;
         Global.JiangHuMiLing = Boolean(parameters["JiangHuMiLing"]) ? true : false;
         Global.JiaoShiJieZhuFu = Boolean(parameters["JiaoShiJieZhuFu"]) ? true : false;
         Global.QuWeiZhongQiu = Boolean(parameters["QuWeiZhongQiu"]) ? true : false;
         Global.GuoQingKuangHuan = Boolean(parameters["GuoQingKuangHuan"]) ? true : false;
         Global.ShiZhuangTouPiao = Boolean(parameters["ShiZhuangTouPiao"]) ? true : false;
         Global.VarsiongConfigCtl = Boolean(parameters["VarsiongConfigCtl"]) ? parameters["VarsiongConfigCtl"] : "";
         Global.HD2VarsionCrl = Boolean(parameters["HD2VarsionCrl"]) ? parameters["HD2VarsionCrl"] : "";
         Global.festivalActs = Boolean(parameters["festivalActs"]) ? true : false;
         Global.qingrenjieActs = Boolean(parameters["qingrenjieActs"]) ? true : false;
         Global.QQGameBackCtrl = Boolean(parameters["QQGameBackCtrl"]) ? true : false;
         Global.HZShengYan = Boolean(parameters["HZShengYan"]) ? true : false;
         Global.DLXiaXin = Boolean(parameters["DLXiaXin"]) ? true : false;
         Global.BeCaHua = Boolean(parameters["BeCaHua"]) ? true : false;
         Global.QQGameCJBtnCtrl = Boolean(parameters["QQGameCJBtnCtrl"]) ? true : false;
         Global.theBeautyIcon = Boolean(parameters["theBeautyIcon"]) ? true : false;
         Global.theChampionIcon = Boolean(parameters["theChampionIcon"]) ? true : false;
         Global.QT_night_partyCtrl = Boolean(parameters["QT_night_partyCtrl"]) ? true : false;
         Global.LoveAct = Boolean(parameters["LoveAct"]) ? true : false;
         Global.showSkinAct = Boolean(parameters["showSkinAct"]) ? true : false;
         NewFriends.inerSend = Boolean(parameters["inerSend"]) ? true : false;
         Global.redDiamond = Boolean(parameters["redDiamond"]) ? true : false;
         Global.fd = Boolean(parameters["fd"]) ? parameters["fd"] : "";
         Global.seqid = Boolean(parameters["seqid"]) ? parameters["seqid"] : "";
         Global.dengluQuHao = Boolean(parameters["dengluQuHao"]) ? int(parameters["dengluQuHao"]) : 1;
         Global.QQGameZKJ = Boolean(parameters["QQGameZKJ"]) ? true : false;
         Global.tempParam = parameters["QQGameZKJ"];
         Global.jinJuanStore = Boolean(parameters["jinJuanStore"]) ? true : false;
         Global.huiYuanLibao = Boolean(parameters["huiYuanLibao"]) ? true : false;
         Global.QQGameIcon = Boolean(parameters["QQGameIcon"]) ? true : false;
         Global.ShengDanTimes = Boolean(parameters["ShengDanTimes"]) ? parameters["ShengDanTimes"] : "";
         Global.merriIcon = Boolean(parameters["merriIcon"]) ? true : false;
         Global.twoEggs = Boolean(parameters["twoEggs"]) ? true : false;
         Global.baoshiQingYuan = Boolean(parameters["baoshiQingYuan"]) ? true : false;
         Global.config.resUrl = parameters["resourceHost"];
         Global.config.mapUrl = parameters["mapHost"];
         Global.config.modelUrl = parameters["modelHost"];
         Utils.print("Global.config.resUrl",Global.config.resUrl);
         Utils.print("Global.config.mapHost",Global.config.mapUrl);
         Utils.print("Global.config.modelHost",Global.config.modelUrl);
         Global.config.ip = parameters["ip"];
         Global.config.port = parameters["port"];
         Global.config.tstamp = Boolean(parameters["tstamp"]) ? parameters["tstamp"] : "1";
         Global.config.officialWebsite = Boolean(parameters["officialWebsite"]) ? parameters["officialWebsite"] : "";
         Global.config.lunWebsite = Boolean(parameters["lunWebsite"]) ? parameters["lunWebsite"] : "";
         Global.config.playerQQGroup = parameters["playerQQGroup"];
         Global.config.fcm = Boolean(parameters["fcm"]) ? parameters["fcm"] : "1";
         Global.config.key = Boolean(parameters["ticket"]) ? parameters["ticket"] : null;
         Global.config.smallTip = Boolean(parameters["smallTip"]) ? parameters["smallTip"].splice(",") : null;
         if(Boolean(parameters["binVersion"]))
         {
            Version.VERSION = parameters["binVersion"];
         }
         if(Boolean(parameters["isRelease"]))
         {
            ResourceVersionConfig.isRelease = false;
         }
         if(Boolean(parameters["newYearSwitch"]))
         {
            Config_NewYear.ActSwitch(parameters["newYearSwitch"]);
         }
         if(Boolean(parameters["jiaodianUrl"]))
         {
            Global.jiaodianUrl = parameters["jiaodianUrl"];
         }
         if(Boolean(parameters["jiaodianLinkUrl"]))
         {
            Global.jiaodianLinkUrl = parameters["jiaodianLinkUrl"];
         }
         if(parameters["aixin"] == "1")
         {
            Global.AiXin = true;
         }
         if(parameters["changxiang"] == "1")
         {
            Global.changxiang = true;
         }
         if(parameters["DAUSwitch"] == "1")
         {
            Global.DAUCtrl = true;
         }
         Global.YiAiZhiMing = Boolean(parameters["YiAiZhiMing"]) ? true : false;
         Global.fcmBoolean = parameters["fcmBoolean"] == "1" ? true : false;
         Global.QT = Boolean(parameters["QT"]) ? true : false;
         Global.LZFuLi = Boolean(parameters["LZFuLi"]) ? true : false;
         Utils.print("ip",Global.config.ip,"port",Global.config.port);
         Global.activityGuide = Boolean(parameters["activityGuide"]) ? true : false;
         this.regesterJsCall();
         ResourceVersionConfig.initialize();
         LoginHandler.loadResource();
         Global.stage.addEventListener(Event.ENTER_FRAME,GameScene.instance.frameEvent);
         if(Boolean(heroId))
         {
            LoginHandler.heroId = heroId;
         }
         LoadManager.loadFirst();
         Model_heFu.init();
      }
      
      public function sendEnterScene(heroId:Number) : void
      {
         LoginHandler.heroId = heroId;
         if(Boolean(Global.UIdm))
         {
            SceneCGMessage.CG_ENTER_SCENE(heroId);
         }
      }
      
      private function validataIsLogin() : void
      {
         var loadurl:String = "http://api1.app100621282.twsapp.com//openapi.php?mod=arealogin&datatype=text&openid=" + Global.account + "&openkey=" + Global.openkey + "&seqid=" + Global.seqid + "&pf=" + Global._pf + "&r=" + getTimer();
         var loader:URLLoader = new URLLoader();
         var url:URLRequest = new URLRequest(loadurl);
         url.method = URLRequestMethod.GET;
         loader.dataFormat = URLLoaderDataFormat.TEXT;
         loader.addEventListener(Event.COMPLETE,this.validateReturn);
         loader.load(url);
      }
      
      private function validateReturn(e:Event) : void
      {
         Utils.print("登录验证：" + e.target.data);
         if(int(e.target.data) == 0)
         {
            SocketManager.connect(Global.config.ip,Global.config.port);
         }
         else
         {
            Model_initStr.OFFLINETIP = "<font color=\"#FFFFFF\">亲爱的玩家：<br>您的登录会话已失效，请重新从平台登录进入游戏。</font>";
            OffLineTip.getInstance().show();
         }
      }
      
      private function regesterJsCall() : void
      {
         ExternalInterface.addCallback("chongzhiSuccess",this.chongzhiSuccess);
         ExternalInterface.addCallback("exitGame",this.exitGame);
         ExternalInterface.addCallback("inviteFriends",this.inviteFriends);
         ExternalInterface.addCallback("shareSuccess",this.shareSuccess);
         ExternalInterface.addCallback("newYearSwitch",Config_NewYear.ActSwitch);
         ExternalInterface.addCallback("qqgroup",this.qqgroup);
         ExternalInterface.addCallback("aixin",AiXinBtn.remove);
         ExternalInterface.addCallback("DAUSwitch",this.DAUSwitchClose);
         ExternalInterface.addCallback("changxiang",ChangXiangBtn.remove);
         ExternalInterface.addCallback("warnByTime",warnByTime);
         ExternalInterface.addCallback("askShowSkinSuccess",this.askShowSkinSuccess);
      }
      
      private function askShowSkinSuccess(opt:Object) : void
      {
         QShowSkinCGMessage.CG_SHOWSKIN_SAVE(Global._curQShowSkinType);
      }
      
      private function qqgroup(ret:Object, unionid:Object, groupopenid:Object) : void
      {
         QQGroupStaticFunctions.handleCreate(ret,unionid,groupopenid);
      }
      
      private function DAUSwitchClose() : void
      {
         Global.DAUCtrl = false;
         Model_DAU.hideBTN();
      }
      
      private function inviteFriends(... pram) : void
      {
         FriendCGMessage.CG_INVITE_FRIENDS();
         QplusShareCGMessage.CG_INVITE_RESULT();
         if(!pram.length)
         {
            WanJiaZhaoHuiCGMessage.CG_WJZH_INVITE(3);
         }
         else
         {
            WanJiaZhaoHuiCGMessage.CG_WJZH_INVITE(int(pram[0]));
         }
      }
      
      private function chongzhiSuccess(opt:Object) : void
      {
         View_Alert.show(Model_initStr.YITIANSTR1 + opt.context,View_Alert.OK);
      }
      
      private function shareSuccess() : void
      {
         QplusShareCGMessage.CG_SHARE_RESULT(Global.shareType);
         Global.control.sendNotification(Enum_MsgType.QPLUS_SHARE_EFFTER,Global.sharePoint);
      }
      
      private function exitGame() : String
      {
         var tip:String = null;
         var i:int = 0;
         var count:int = 0;
         if(SceneManager.nowScene == GameScene.instance)
         {
            tip = "";
            i = 0;
            while(i < DailyRemainManager.dailyData.length)
            {
               count = int(DailyRemainManager.dailyData[i]);
               if(Boolean(count))
               {
                  tip += LangConfig.getWord("3000" + i,3,count) + "\n";
               }
               i++;
            }
            return tip;
         }
         return "";
      }
      
      private function testInfoShow(e:KeyboardEvent) : void
      {
         if(e.altKey && e.shiftKey && e.ctrlKey && e.keyCode == KeyboardManager.A)
         {
            UIManager.smallMap.GmEnable = true;
            return;
         }
         if(e.altKey && e.ctrlKey && e.keyCode == KeyboardManager.K)
         {
            View_qqHuiyuan.instance.show();
            return;
         }
         if(e.altKey && e.ctrlKey && e.keyCode == KeyboardManager.G)
         {
            QQGameZheKouJuanTips.ins.showTip();
            return;
         }
         if(e.altKey && e.ctrlKey && e.keyCode == KeyboardManager.F)
         {
            CGXTestPan.instance.updata();
            return;
         }
         if(e.altKey && e.ctrlKey && e.keyCode == KeyboardManager.H)
         {
            CGXTestPan.instance.hide();
            return;
         }
         if(e.altKey && e.ctrlKey && e.keyCode == KeyboardManager.V)
         {
            ShengDanVO.see = 1;
            UIManager.shengdanBtn.show();
            return;
         }
         if(e.altKey && e.ctrlKey && e.keyCode == KeyboardManager.Y)
         {
            QQgameLibao.instance.showTip();
            return;
         }
         if(e.altKey && e.ctrlKey && e.keyCode == KeyboardManager.W)
         {
            HuiyuanGiftTip.instance.show();
            return;
         }
         if(e.altKey && e.ctrlKey && e.keyCode == KeyboardManager.B)
         {
            BaoshiQingYuanTip.instance.show();
            return;
         }
         if(e.altKey && e.ctrlKey && e.keyCode == KeyboardManager.X)
         {
            NewYearActTip.instance.show(true);
            return;
         }
         if(e.altKey && e.ctrlKey && e.keyCode == KeyboardManager.E)
         {
            LoginHandler.GC_OFF_LINE(4);
         }
      }
   }
}

