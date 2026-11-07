package com.yiTian.view.modules.map
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.data.config.Enum_npc_type;
   import com.yiTian.data.config.Enum_pata_map;
   import com.yiTian.data.model.Model_KuaFuPaiDui;
   import com.yiTian.data.model.Model_kunlun;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.data.model.Model_trans;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.gameUnit.role.Hero;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.gameUnit.role.Role;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.MapManager;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.LetterCGMessage;
   import com.yiTian.net.message.cg.LoginCGMessage;
   import com.yiTian.net.message.cg.MartCGMessage;
   import com.yiTian.net.message.cg.PaiHangCGMessage;
   import com.yiTian.net.message.cg.RetrieExpCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.utils.WorldConfig;
   import com.yiTian.utils.auto.HandupMgr;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.Enum_explor;
   import com.yiTian.view.MainUIBase;
   import com.yiTian.view.modules.AiDeBaoBao.AiDeBaoBao_control;
   import com.yiTian.view.modules.actions.qqXuanfeng.QQXuanFeng;
   import com.yiTian.view.modules.activity.Model_actDaily;
   import com.yiTian.view.modules.boatChall.BoatManager;
   import com.yiTian.view.modules.fishing.Model_fishing;
   import com.yiTian.view.modules.guangMingDing.Enum_guangMingDing;
   import com.yiTian.view.modules.jingmaiHang.View_JiMaiHang;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import com.yiTian.view.modules.qingMing.Model_QingMing;
   import com.yiTian.view.modules.qingMing.Msg_QingMing;
   import com.yiTian.view.modules.qingMing.View_zhuaGuiPanel;
   import com.yiTian.view.modules.retrieExp.View_retrieExp;
   import com.yiTian.view.modules.roleHead.View_HeroHead;
   import com.yiTian.view.modules.ship.Ship;
   import com.yiTian.view.modules.sign.SignUtil;
   import com.yiTian.view.modules.test.TestPackage;
   import com.yiTian.view.modules.worldBoss.WorldBossUtil;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class SmallMap extends MainUIBase
   {
      
      private static var openQQXuanFeng:Boolean = false;
      
      private var Button_Shi:Button;
      
      private var Button_Point:Button;
      
      public var Button_Gu:Button;
      
      private var Button_Tu:Button;
      
      private var Button_Bang:Button;
      
      private var Button_Xin:Button;
      
      private var Button_GM:Button;
      
      private var Button_Bi:Button;
      
      private var Button_Huo:Button;
      
      public var Button_Fu:Button;
      
      private var Button_Zi:Button;
      
      public var Button_KF:Button;
      
      private var Place_text:MyTextField;
      
      private var _btnHandup:Button;
      
      public var map:Map = new Map();
      
      private var maskbg:Shape = new Shape();
      
      private var heroPoint:MapPoint;
      
      private var mapItemList:Array = [];
      
      private var textItemList:Array = [];
      
      private var objVec:Vector.<Button>;
      
      private var effectDic:Dictionary;
      
      private var _timeDic:Dictionary;
      
      private const MAP_X:int = 30;
      
      private const MAP_Y:int = 30;
      
      private var yellowDia:MainUIBtn;
      
      private var posArr:Array = [1,41,150,146,7,115,23,142,0,80,65,173,180,98,-50,125];
      
      private var _handup:int = -1;
      
      private var npcs:Array = [];
      
      private var _mapName:String;
      
      private var points:Array = [];
      
      private var teamPoints:Array = [];
      
      public function SmallMap()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var onClick:Function = null;
         var back:Bitmap = null;
         var _back:Bitmap = null;
         onClick = function(e:MouseEvent):void
         {
            TestPackage.getInstance().visible = true;
         };
         this.objVec = new Vector.<Button>();
         this.effectDic = new Dictionary();
         this._timeDic = new Dictionary();
         if(!openQQXuanFeng)
         {
            openQQXuanFeng = Global.pf == Enum_SPStr.GUANWANG ? true : false;
         }
         if(openQQXuanFeng)
         {
            back = ComponentUtil.getBitmap("Back_ViewMap",this,{
               "x":0,
               "y":0
            },Global.Scenedm);
            this.Button_Zi = ComponentUtil.getButton("资","Button_Round",this,{
               "x":182.5,
               "y":101,
               "textColor":16184781
            },Global.Img_Cdm);
            this.Button_Zi.callBack = this.ziClick;
         }
         else
         {
            _back = ComponentUtil.getBitmap("Back_ViewMapCo",this,{
               "x":0,
               "y":0
            },Global.Scenedm);
         }
         this.Button_KF = ComponentUtil.getButton("GM","Button_Round",this,{
            "x":180.9,
            "y":99,
            "textColor":16184781,
            "callBack":function():void
            {
               Model_GM_KF.outOf_btn_call = false;
               if(Model_GM_KF.isShowEff)
               {
                  Model_GM_KF.showEff(false);
               }
               LoginCGMessage.CG_BTN_EFF();
               LoginCGMessage.CG_GM_KEFU(encodeURI(View_HeroHead.playerName));
            }
         },Global.Img_Cdm);
         this.Button_Shi = ComponentUtil.getButton(LangConfig.getWord("10490",1),"Button_Round",this,{
            "x":177,
            "y":57,
            "textColor":15854525
         },Global.Img_Cdm);
         this.Button_Shi.callBack = this.shiClick;
         this.Button_Gu = ComponentUtil.getButton(LangConfig.getWord("10491",1),"Button_Round",this,{
            "x":27,
            "y":146,
            "textColor":15854525
         },Global.Img_Cdm);
         this.Button_Tu = ComponentUtil.getButton(LangConfig.getWord("10492",1),"Button_Round",this,{
            "x":172,
            "y":128,
            "textColor":15854525
         },Global.Img_Cdm);
         this.Button_Tu.callBack = this.tuClick;
         this.Button_Bang = ComponentUtil.getButton(LangConfig.getWord("10493",1),"Button_Round",this,{
            "x":163,
            "y":33,
            "textColor":15854525
         },Global.Img_Cdm);
         this.Button_Bang.callBack = this.bangClick;
         this.Button_Point = ComponentUtil.getButton("目标","Button_Point",this,{
            "x":73,
            "y":172,
            "textColor":15854525
         },Global.Img_Cdm);
         this.Button_Point.callBack = this.CLICK_BTN_CHIP;
         this.Button_Xin = ComponentUtil.getButton(LangConfig.getWord("10494",1),"Button_Round",this,{
            "x":154,
            "y":149,
            "textColor":15854525
         },Global.Img_Cdm);
         this.Button_Xin.callBack = this.xinClick;
         this.Button_GM = ComponentUtil.getButton(LangConfig.getWord("10495",1),"Button_Round",this,{
            "x":11,
            "y":119,
            "textColor":15854525
         },Global.Img_Cdm);
         this.Button_GM.callBack = this.jiaoyiHandle;
         this.Button_Bi = ComponentUtil.getButton(LangConfig.getWord("10496",1),"Button_Round",this,{
            "x":31,
            "y":25,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_Huo = ComponentUtil.getButton("","Button_HuoDong",this,{
            "x":5,
            "y":46,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_Huo.callBack = this.huoClick;
         this.Button_Gu.callBack = this.guClick;
         this.Button_Bi.callBack = this.biClick;
         this.Place_text = ComponentUtil.getTextField("",this,{
            "x":45,
            "y":3,
            "color":9893119,
            "size":12,
            "leading":0
         });
         this.Place_text.mouseEnabled = true;
         this.Place_text.doubleClickEnabled = true;
         this.Button_Fu = ComponentUtil.getButton("","Button_Gift",this,{
            "x":4,
            "y":85,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_Fu.callBack = this.fuClick;
         this.objVec.push(this.Button_Huo,this.Button_Fu,this.Button_Point,this.Button_Xin,this.Button_GM,this.Button_Gu,this.Button_Tu,this.Button_Bang,this.Button_Shi);
         this._btnHandup = ComponentUtil.getButton("","Button_Begin",this,{
            "x":-20,
            "y":155,
            "visible":false,
            "callBack":this.handUpClickHd
         },Global.Scenedm);
         if(GameUnitManager.hero.level < 30)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP,this.lvUpHd);
         }
         this.tipShow();
         this.bindBtnInit();
         this.Place_text.addEventListener(MouseEvent.DOUBLE_CLICK,onClick);
      }
      
      public function set GmEnable(value:Boolean) : void
      {
         if(value == false)
         {
            this.Button_KF.mouseEnabled = false;
            this.Button_KF.filters = Util.disabled;
         }
         else
         {
            this.Button_KF.mouseEnabled = true;
            this.Button_KF.filters = [];
         }
      }
      
      public function bindBtnInit() : void
      {
         Enum_explor.bindDic[Enum_explor.BTN_HUODONG] = this.Button_Huo;
         Enum_explor.bindDic[Enum_explor.BTN_FU] = this.Button_Fu;
         Enum_explor.bindDic[Enum_explor.BTN_JIAOYI] = this.Button_GM;
         Enum_explor.bindDic[Enum_explor.BTN_FINDEXP] = this.Button_Gu;
         Enum_explor.bindDic[Enum_explor.BTN_POINT] = this.Button_Point;
         Enum_explor.bindDic[Enum_explor.BTN_LETTER] = this.Button_Xin;
         Enum_explor.bindDic[Enum_explor.BTN_MAP] = this.Button_Tu;
         Enum_explor.bindDic[Enum_explor.BTN_MART] = this.Button_Shi;
         Enum_explor.bindDic[Enum_explor.BTN_BANG] = this.Button_Bang;
         Enum_explor.bindDic[Enum_explor.BTN_Bi] = this.Button_Bi;
         Enum_explor.bindDic[Enum_explor.Button_Zi] = this.Button_Zi;
      }
      
      public function setAllBtnEnabled(value:Boolean) : void
      {
         Enum_explor.bindDic[Enum_explor.BTN_MAP].enabled = value;
         Enum_explor.bindDic[Enum_explor.BTN_Bi].enabled = value;
         Enum_explor.bindDic[Enum_explor.BTN_HUODONG].enabled = value;
         Enum_explor.bindDic[Enum_explor.BTN_JIAOYI].enabled = value;
         Enum_explor.bindDic[Enum_explor.BTN_FINDEXP].enabled = value;
         Enum_explor.bindDic[Enum_explor.BTN_LETTER].enabled = value;
         Enum_explor.bindDic[Enum_explor.BTN_BANG].enabled = value;
         Enum_explor.bindDic[Enum_explor.BTN_MART].enabled = value;
         Enum_explor.bindDic[Enum_explor.BTN_POINT].enabled = value;
         Enum_explor.bindDic[Enum_explor.BTN_FU].enabled = value;
      }
      
      public function changeBtnEnable(value:Boolean) : void
      {
         var i:int = 0;
         i = 0;
         while(i < this.objVec.length)
         {
            if(this.objVec[i] != this.Button_Tu)
            {
               if(value == false)
               {
                  this.objVec[i].mouseEnabled = false;
                  this.objVec[i].filters = Util.disabled;
                  this.removeTip(i);
               }
               else
               {
                  this.objVec[i].mouseEnabled = true;
                  this.objVec[i].filters = [];
               }
            }
            i++;
         }
         if(Global.sceneMap == 14401)
         {
            this.Button_Bi.enabled = this.Button_KF.enabled = value;
         }
      }
      
      public function getBtnPoint(_target:Object) : Point
      {
         var item:Button = null;
         for each(item in this.objVec)
         {
            if(_target == item)
            {
               return localToGlobal(new Point(item.x,item.y));
            }
         }
         return new Point(0,0);
      }
      
      private function tipShow() : void
      {
         TipManager.bind(this.Button_Bi,LangConfig.getWord("10497",1));
         TipManager.bind(this.Button_Bang,LangConfig.getWord("10498",1));
         TipManager.bind(this.Button_Shi,LangConfig.getWord("10499",1));
         TipManager.bind(this.Button_Tu,LangConfig.getWord("10500",1));
         TipManager.bind(this.Button_Xin,LangConfig.getWord("10501",1));
         TipManager.bind(this.Button_Huo,LangConfig.getWord("10502",1));
         TipManager.bind(this.Button_Fu,"在线签到奖励");
         TipManager.bind(this.Button_GM,LangConfig.getWord("10504",1));
         TipManager.bind(this.Button_Gu,LangConfig.getWord("10505",1));
         if(Boolean(this.Button_Zi))
         {
            TipManager.bind(this.Button_Zi,"QQ旋风");
         }
      }
      
      public function addMoveYellowDia(sour:String) : void
      {
      }
      
      private function lvUpHd(lv:int) : void
      {
         if(lv >= 30)
         {
            this.addTip(0);
            Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP,this.lvUpHd);
         }
      }
      
      public function addTip(itemIndex:int, countTime:int = -1) : void
      {
         var size:int = 0;
         var dir:String = null;
         var obj:Object = null;
         if(Boolean(this.effectDic[itemIndex]))
         {
            return;
         }
         if(countTime > 0)
         {
            if(Boolean(this._timeDic[itemIndex]))
            {
               obj = this._timeDic[itemIndex];
            }
            else
            {
               obj = new Object();
               this._timeDic[itemIndex] = obj;
            }
            obj.countTime = countTime;
            obj.startTime = getTimer();
            obj.runTime = 0;
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.frameStep);
         }
         if(itemIndex == 0)
         {
            size = 2;
         }
         else if(itemIndex == 4)
         {
            size = 3;
         }
         else if(itemIndex == 5)
         {
            size = 4;
         }
         else if(itemIndex == 7)
         {
            size = 5;
         }
         else
         {
            size = 1;
         }
         var px:Number = 0;
         var py:Number = 0;
         switch(size)
         {
            case 1:
               dir = "35014";
               px = 14;
               py = 14;
               break;
            case 2:
               dir = "35015";
               px = 19;
               py = 19;
               break;
            case 3:
               dir = "35074";
               px = 17;
               py = 19;
               break;
            case 4:
               dir = "35075";
               px = 39;
               py = 11;
               break;
            case 5:
               dir = "35076";
               break;
            default:
               return;
         }
         var _x:Number = Number(this.posArr[itemIndex * 2]);
         var _y:Number = Number(this.posArr[itemIndex * 2 + 1]);
         var eff:Effect = EffectManager.addEffect(dir,this,1000,this.posArr[itemIndex * 2] + px,this.posArr[itemIndex * 2 + 1] + py,true);
         this.effectDic[itemIndex] = eff;
      }
      
      public function hasTip(index:int) : Boolean
      {
         return this.effectDic[index] != null;
      }
      
      public function removeTip(itemIndex:int) : void
      {
         if(Boolean(this.effectDic) && Boolean(this.effectDic[itemIndex]))
         {
            EffectManager.removeEffect(this.effectDic[itemIndex]);
            delete this.effectDic[itemIndex];
         }
      }
      
      public function frameStep(interval:int) : void
      {
         var key:String = null;
         var obj:Object = null;
         var length:int = 0;
         for(key in this._timeDic)
         {
            length += 1;
            obj = this._timeDic[key];
            obj.runTime += interval;
            if(obj.runTime - obj.startTime > obj.countTime)
            {
               this.removeTip(int(key));
               delete this._timeDic[key];
            }
         }
         if(length == 0)
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.frameStep);
         }
      }
      
      override protected function initDynamicView() : void
      {
         this.maskbg.graphics.beginFill(0,1);
         this.maskbg.graphics.drawCircle(70,70,70);
         this.maskbg.graphics.endFill();
         this.maskbg.x = this.MAP_X + 3;
         this.maskbg.y = this.MAP_Y;
         addChild(this.maskbg);
         this.map.mask = this.maskbg;
         var _temp_1:* = this.map;
         this.map.sy = 10;
         _temp_1.sx = 10;
         this.map.smoothing = true;
         addChild(this.map);
         this.heroPoint = MapPoint.getPoint();
         this.heroPoint.x = this.MAP_X + 70;
         this.heroPoint.y = this.MAP_Y + 70;
         this.heroPoint.enabled = false;
         this.heroPoint.mouseEnabled = false;
         this.heroPoint.init({"type":MapPoint.SELF});
         this.map.addChild(this.heroPoint);
         this.setRotation(90 + GameUnitManager.hero.way * 45);
         Global.control.registerCallBack(HandupMgr.TURNON,this.onHandupTurnon);
         Global.control.registerCallBack(HandupMgr.TURNOFF,this.onHandupTurnoff);
         Global.control.registerCallBack(HandupMgr.SHOW,this.onHandupShow);
         Global.control.registerCallBack(HandupMgr.HIDE,this.onHandupHide);
      }
      
      private function tuClick(e:MouseEvent) : void
      {
         UIManager.mappanel.visible = !UIManager.mappanel.visible;
      }
      
      private function jiaoyiHandle(e:MouseEvent) : void
      {
         Model_trans.open_trans_panel();
      }
      
      private function plantHandle(e:MouseEvent = null) : void
      {
         UIManager.bangPlant.visible = !UIManager.bangPlant.visible;
      }
      
      public function shiClick(e:MouseEvent = null) : void
      {
         UIManager.JMH_panel.visible = !UIManager.JMH_panel.visible;
         if(UIManager.JMH_panel.visible)
         {
            MartCGMessage.CG_MARTSOLD(0,1,View_JiMaiHang.searchPrice["sell"]);
         }
      }
      
      public function bangClick(e:MouseEvent = null) : void
      {
         UIManager.paiHangPanel.visible = !UIManager.paiHangPanel.visible;
         if(UIManager.paiHangPanel.visible)
         {
            PaiHangCGMessage.CG_PAIHANG_DENGJI(0,1);
         }
      }
      
      private function handUpClickHd(e:MouseEvent) : void
      {
         this.removeTip(7);
         if(!Model_team.hasTeam() || Model_team.isCap())
         {
            if(this._handup == 1)
            {
               HandupMgr.turnoff();
               GameUnitManager.hero.stopGo();
            }
            else
            {
               HandupMgr.turnon();
               HandupMgr.execute();
            }
         }
         else
         {
            UIManager.centerBroadcast.addMsg("您不是队长，不能进行挂机");
            HandupMgr.turnoff();
         }
      }
      
      private function onHandupTurnon(prm:* = null) : void
      {
         this._handup = 1;
         this._btnHandup.style = "Button_Stop";
         this.updateHandupBtn();
         WorldBossUtil.setAutoBattle(true);
         Global.control.registerCallBack(Enum_MsgType.TEAM_CHANGE,this.onTeamChange);
      }
      
      private function onHandupTurnoff(prm:* = null) : void
      {
         if(GameUnitManager.hero.captainId == GameUnitManager.hero.id || GameUnitManager.hero.teamPosition == 0)
         {
            GameUnitManager.hero.stopGo();
         }
         this._handup = 2;
         this._btnHandup.style = "Button_Begin";
         WorldBossUtil.setAutoBattle(false);
         this.updateHandupBtn();
      }
      
      private function onHandupShow(prm:* = null) : void
      {
         this._btnHandup.visible = true;
         if(GameUnitManager.hero.level < 50)
         {
            this._btnHandup.enabled = false;
            this._btnHandup.mouseEnabled = true;
            TipManager.bind(this._btnHandup,"<font color=\'#ffff55\'>50级将开启挂机爬塔功能</font>");
         }
         else
         {
            this._btnHandup.enabled = true;
         }
         this.updateHandupBtn();
      }
      
      private function onHandupHide(prm:* = null) : void
      {
         this._handup = -1;
         this._btnHandup.visible = false;
         this.removeTip(7);
         WorldBossUtil.setAutoBattle(false);
         Global.control.removeCallBack(Enum_MsgType.TEAM_CHANGE,this.onTeamChange);
      }
      
      private function onTeamChange() : void
      {
         if(Model_team.hasTeam() && !Model_team.isCap())
         {
            HandupMgr.turnoff();
         }
         this.updateHandupBtn();
      }
      
      private function updateHandupBtn() : void
      {
         if(!this._btnHandup.enabled)
         {
            return;
         }
         if(Model_team.hasTeam())
         {
            if(Model_team.isCap())
            {
               TipManager.bind(this._btnHandup,"<font color=\'#55ff55\'>点击可以激活或取消挂机打怪</font>");
            }
            else
            {
               TipManager.bind(this._btnHandup,"<font color=\'#999999\'>您不是队长，无法进行挂机打怪</font>");
            }
         }
         else
         {
            TipManager.bind(this._btnHandup,"<font color=\'#55ff55\'>点击可以激活或取消挂机打怪</font>");
         }
      }
      
      private function xinClick(e:MouseEvent) : void
      {
         UIManager.letterManagerViewPanel.visible = !UIManager.letterManagerViewPanel.visible;
         if(UIManager.letterManagerViewPanel.visible)
         {
            LetterCGMessage.CG_MAIL(1,1);
         }
      }
      
      public function huoClick(evt:MouseEvent = null) : void
      {
         if(!Model_actDaily.getInstance().hasAct())
         {
            this.removeTip(0);
         }
         UIManager.amPanel.visible = !UIManager.amPanel.visible;
      }
      
      private function fuClick(e:MouseEvent) : void
      {
         SignUtil.askShowSignPanel();
      }
      
      private function ziClick(e:MouseEvent) : void
      {
         var pnl:QQXuanFeng = null;
         pnl = Singleton.getInstance(QQXuanFeng) as QQXuanFeng;
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pnl,function():void
         {
            pnl.open();
         });
         UIManager.smallMap.removeTip(6);
      }
      
      public function biClick(e:MouseEvent) : void
      {
         GameUnitManager.isShowPlayer = !GameUnitManager.isShowPlayer;
         this.Button_Bi.label = GameUnitManager.isShowPlayer ? LangConfig.getWord("10508",1) : LangConfig.getWord("10509",1);
         TipManager.bind(this.Button_Bi,this.Button_Bi.label == LangConfig.getWord("10508",1) ? LangConfig.getWord("10510",1) : LangConfig.getWord("10511",1));
      }
      
      public function guClick(evt:MouseEvent = null) : void
      {
         if(GameUnitManager.hero.level < 30)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10512",1));
            return;
         }
         if(Model_actDaily.getInstance().retExpArr != null && Model_actDaily.getInstance().retExpArr.length == 0 && !this.hasTip(3))
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10513",1));
            return;
         }
         var ins:DisplayObject = Singleton.getInstance(View_retrieExp);
         if(ins.visible == false)
         {
            RetrieExpCGMessage.CG_RETRIEEXP_INFO();
         }
         else
         {
            ins.visible = false;
         }
      }
      
      public function refresh() : void
      {
         var col:int = 0;
         var tem:BitmapData = null;
         if(Boolean(this.map.bitmapData))
         {
            this.map.bitmapData.dispose();
         }
         this.setTitle();
         var mapData:BitmapData = new BitmapData(MapManager.mapInfo.width / 10,MapManager.mapInfo.height / 10);
         var block_row:int = Math.ceil(MapManager.mapInfo.height / MapManager.BLOCK_HEIGHT);
         var block_col:int = Math.ceil(MapManager.mapInfo.width / MapManager.BLOCK_WIDTH);
         Utils.rect = new Rectangle(0,0,MapManager.BLOCK_WIDTH / 10,MapManager.BLOCK_HEIGHT / 10);
         var row:int = 0;
         while(row < block_row)
         {
            col = 0;
            while(col < block_col)
            {
               tem = ComponentUtil.getBitmapData("M" + row + "_" + col,Global.thumbdm);
               Utils.point.x = col * Utils.rect.width;
               Utils.point.y = row * Utils.rect.height;
               mapData.copyPixels(tem,Utils.rect,Utils.point);
               tem.dispose();
               col++;
            }
            row++;
         }
         this.map.bitmapData = mapData;
         this.updateList();
      }
      
      private function updateList() : void
      {
         var item:Object = null;
         var temp_text:Object = null;
         var npcType:int = 0;
         var temName:String = null;
         var mapItem:MapPoint = null;
         var npcTF:MyTextField = null;
         var type:int = 0;
         var type2:int = 0;
         var pointX:int = 0;
         var pointY:int = 0;
         var doorPoint:MapPoint = null;
         var pointText:MyTextField = null;
         var pointName:String = null;
         var s:String = null;
         this.clear();
         var pointDic:Dictionary = new Dictionary();
         this.npcs = [];
         var arr:Array = MapManager.mapInfo.items;
         var maptype:int = SceneConfig.getSceneType();
         for each(item in MapManager.mapInfo.items)
         {
            if(item.type == MapPoint.FUN_NPC)
            {
               if(Data_lib.npc[item.id])
               {
                  npcType = int(Data_lib.npc[item.id][Npc.NPC_TYPE]);
                  if(!(!Enum_npc_type.canDialog(npcType) && npcType != Enum_npc_type.BAO_XIANG && item.id != 53536 && item.id != 53535))
                  {
                     item.name = Data_lib.npc[item.id][Npc.NAME];
                     if(item.name != "0")
                     {
                        item.official = Data_lib.npc[item.id][Npc.OFFICIAL];
                        temName = "";
                        if(item.official != null)
                        {
                           if(item.name != null)
                           {
                              temName = (item.official == "0" ? "" : item.official + "\n") + Data_lib.npc[item.id][Npc.NAME];
                           }
                           else
                           {
                              item.name = item.official;
                              temName = item.official;
                           }
                        }
                        else
                        {
                           temName = item.name;
                        }
                        this.npcs.push(item);
                        mapItem = MapPoint.getPoint();
                        mapItem.x = item.lx = int(item.x / 10);
                        mapItem.y = item.ly = int(item.y / 10);
                        mapItem.init({
                           "type":MapPoint.FUN_NPC,
                           "name":temName,
                           "minimap_label":item.minimap_label
                        });
                        this.map.addChild(mapItem);
                        this.mapItemList.push(mapItem);
                        npcTF = ComponentUtil.getTextField("",null,{"color":16776960});
                        npcTF.multiline = true;
                        npcTF.htmlText = item.name;
                        npcTF.x = mapItem.x - npcTF.width / 2;
                        npcTF.y = mapItem.y - npcTF.height - 5;
                        if(npcTF.x + npcTF.width > this.map.width)
                        {
                           npcTF.x = this.map.width - npcTF.width - 5;
                        }
                        this.textItemList.push(npcTF);
                     }
                  }
               }
            }
            else if(item.type == MapPoint.JUMP_POINT)
            {
               if(maptype == SceneConfig.KUNLUN)
               {
                  item.name = item.id == 1 ? LangConfig.getWord("10514",1) : LangConfig.getWord("10515",1);
               }
               else if(maptype == SceneConfig.PATA)
               {
                  type = int(Data_lib.sceneData[Global.sceneID][Enum_pata_map.JUMPPOINT_TYPE]);
                  item.name = type == UnitType.FUBENG_POINT ? LangConfig.getWord("10516",1) : LangConfig.getWord("10517",1);
               }
               else if(maptype == SceneConfig.PATA2)
               {
                  type2 = int(Data_lib.sceneData[Global.sceneID][Enum_pata_map.JUMPPOINT_TYPE]);
                  item.name = type2 == UnitType.FUBENG_POINT ? LangConfig.getWord("10516",1) : LangConfig.getWord("10517",1);
               }
               else if(maptype == SceneConfig.GMD)
               {
                  item.name = "光眀顶";
               }
               else
               {
                  if(!WorldConfig.getMapConfig(item.tarMap))
                  {
                     continue;
                  }
                  item.name = Data_lib.map[WorldConfig.getMapConfig(item.tarMap).id][0];
               }
               if(!pointDic[item.name])
               {
                  pointDic[item.name] = item.name;
                  pointX = int(item.x / 10);
                  pointY = int(item.y / 10);
                  doorPoint = MapPoint.getPoint();
                  doorPoint.x = pointX;
                  doorPoint.y = pointY;
                  doorPoint.init({
                     "type":MapPoint.JUMP_POINT,
                     "name":LangConfig.getWord("10518",1) + item.name
                  });
                  this.map.addChild(doorPoint);
                  this.mapItemList.push(doorPoint);
                  pointText = ComponentUtil.getTextField(LangConfig.getWord("10518",1) + item.name,null,{"color":16776960});
                  pointText.x = doorPoint.x - pointText.width / 2;
                  pointText.y = doorPoint.y - pointText.height - 5;
                  if(pointText.x + pointText.width > this.map.width)
                  {
                     pointText.x = this.map.width - pointText.width - 5;
                  }
                  if(pointText.x < 0)
                  {
                     pointText.x = 0;
                  }
                  this.textItemList.push(pointText);
               }
            }
            else if(item.type == MapPoint.FUBENG_POINT)
            {
               if(maptype == SceneConfig.PATA)
               {
                  type = int(Data_lib.sceneData[Global.sceneID][Enum_pata_map.JUMPPOINT_TYPE]);
                  s = LangConfig.getWord("10517",1);
                  pointName = type == UnitType.FUBENG_POINT ? LangConfig.getWord("10516",1) : s;
               }
               else if(maptype == SceneConfig.WANANSI)
               {
                  type = int(Data_lib.sceneData[Global.sceneID][Enum_pata_map.JUMPPOINT_TYPE]);
                  s = "出万安寺";
                  pointName = type == UnitType.FUBENG_POINT ? LangConfig.getWord("10516",1) : s;
               }
               else if(maptype == SceneConfig.PATA2)
               {
                  type = int(Data_lib.sceneData[Global.sceneID][Enum_pata_map.JUMPPOINT_TYPE]);
                  s = LangConfig.getWord("10517",1);
                  pointName = type == UnitType.FUBENG_POINT ? LangConfig.getWord("10516",1) : s;
               }
               else
               {
                  if(!Data_lib.fubenPoint[item.id])
                  {
                     pointName = Data_lib.fubenPoint[item.id][1];
                  }
                  pointName = Data_lib.fubenPoint[item.id][1];
               }
               doorPoint = MapPoint.getPoint();
               doorPoint.x = int(item.x / 10);
               doorPoint.y = int(item.y / 10);
               doorPoint.init({
                  "type":MapPoint.FUBENG_POINT,
                  "name":LangConfig.getWord("10518",1) + pointName + LangConfig.getWord("10519",1)
               });
               this.map.addChild(doorPoint);
               this.mapItemList.push(doorPoint);
               pointText = ComponentUtil.getTextField("",null,{"color":9109248});
               pointText.htmlText = LangConfig.getWord("10518",1) + pointName + HtmlUtil.fontNoSize(LangConfig.getWord("10519",1),"#ffc533");
               pointText.x = doorPoint.x - pointText.width / 2;
               pointText.y = doorPoint.y - pointText.height - 5;
               if(pointText.x + pointText.width > this.map.width)
               {
                  pointText.x = this.map.width - pointText.width - 5;
               }
               if(pointText.x < 0)
               {
                  pointText.x = 0;
               }
               this.textItemList.push(pointText);
            }
         }
         for each(temp_text in this.textItemList)
         {
            if(temp_text is MyTextField)
            {
               this.map.addChild(temp_text as MyTextField);
            }
         }
      }
      
      private function clear() : void
      {
         var text:MyTextField = null;
         while(Boolean(this.mapItemList.length))
         {
            this.mapItemList.pop().dispose();
         }
         for each(text in this.textItemList)
         {
            if(Boolean(text.parent))
            {
               text.parent.removeChild(text);
            }
            text.dispose();
         }
         this.mapItemList.length = 0;
         this.textItemList.length = 0;
      }
      
      public function wacth() : void
      {
         var ship:Ship = null;
         var hero:Hero = null;
         if(Global.sceneMap == 14401)
         {
            if(Boolean(Ship.myShip))
            {
               ship = Ship.myShip;
               this.heroPoint.x = ship.global_x / 10;
               this.heroPoint.y = ship.global_y / 10;
               this.map.x = this.MAP_X + 70 - ship.global_x / 10;
               this.map.y = this.MAP_Y + 70 - ship.global_y / 10;
            }
            else
            {
               this.map.x = this.MAP_X + 70 - BoatManager.WATCH_X / 10;
               this.map.y = this.MAP_Y + 70 - BoatManager.WATCH_Y / 10;
            }
            if(this.heroPoint.visible)
            {
               this.heroPoint.visible = false;
            }
         }
         else
         {
            hero = GameUnitManager.hero;
            this.heroPoint.x = hero.global_x / 10;
            this.heroPoint.y = hero.global_y / 10;
            this.map.x = this.MAP_X + 70 - GameUnitManager.hero.global_x / 10;
            this.map.y = this.MAP_Y + 70 - GameUnitManager.hero.global_y / 10;
            if(!this.heroPoint.visible)
            {
               this.heroPoint.visible = true;
            }
         }
         if(this.map.x > this.MAP_X)
         {
            this.map.x = this.MAP_X;
         }
         if(this.map.x < this.MAP_X + 140 - this.map.width)
         {
            this.map.x = this.MAP_X + 140 - this.map.width;
         }
         if(this.map.y > this.MAP_Y)
         {
            this.map.y = this.MAP_Y;
         }
         if(this.map.y < this.MAP_Y + 140 - this.map.height)
         {
            this.map.y = this.MAP_Y + 140 - this.map.height;
         }
      }
      
      public function removeShip(ship:Ship) : void
      {
         this.map.removeShip(ship);
         UIManager.mappanel.curMap.removeShip(ship);
      }
      
      public function setRotation(rotation:Number) : void
      {
         this.heroPoint.rotation = rotation;
      }
      
      public function setTitle() : void
      {
         var obj:Object = null;
         var level:int = 0;
         var layer:String = null;
         var st:int = SceneConfig.getSceneType();
         if(st == SceneConfig.PATA)
         {
            this._mapName = LangConfig.getWord("10520",1,Data_lib.sceneData[Global.sceneID][0]);
         }
         else if(st == SceneConfig.PATA2)
         {
            this._mapName = LangConfig.reTxt("地狱{0}层",Data_lib.sceneData[Global.sceneID][0] % 1000);
         }
         else if(st == SceneConfig.GMD)
         {
            this._mapName = Data_lib.ycgmd[Global.sceneID][Enum_guangMingDing.LIB_MAP_NAME];
         }
         else if(Global.sceneID == 12201)
         {
            this._mapName = LangConfig.getWord("10521",1) + Model_fishing.getInstance().currentRiverId.toString();
         }
         else if(Global.sceneID == 12202)
         {
            this._mapName = MapManager.mapInfo.name + ":" + (Model_fishing.getInstance().currentRiverId - 36);
         }
         else if(Global.sceneID == 12001)
         {
            obj = Model_kunlun.myKLInfo.getData();
            if(!obj)
            {
               this._mapName = LangConfig.getWord("10522",1,1);
            }
            else
            {
               level = Boolean(obj.myIndex) ? int(obj.myIndex + 1) : 1;
               this._mapName = LangConfig.getWord("10522",1,level.toString());
            }
         }
         else if(Global.sceneID == 12301)
         {
            if(GameUnitManager.hero.level >= 30 && GameUnitManager.hero.level <= 49)
            {
               this._mapName = MapManager.mapInfo.name + "-" + LangConfig.getWord("10523",1);
            }
            else if(GameUnitManager.hero.level >= 50 && GameUnitManager.hero.level <= 69)
            {
               this._mapName = MapManager.mapInfo.name + "-" + LangConfig.getWord("10524",1);
            }
            else if(GameUnitManager.hero.level >= 70)
            {
               this._mapName = MapManager.mapInfo.name + "-" + LangConfig.getWord("10525",1);
            }
         }
         else if(st == SceneConfig.WANANSI)
         {
            layer = Data_lib.sceneData[Global.sceneID][0];
            layer = layer.substr(layer.length - 2,2);
            if(Global.sceneID >= 19101 && Global.sceneID <= 19130)
            {
               this._mapName = "地狱" + LangConfig.getWord("10635",1,layer);
            }
            else
            {
               this._mapName = LangConfig.getWord("10635",1,layer);
            }
         }
         else if(st == SceneConfig.AiDeBaoBao)
         {
            this._mapName = Data_lib.map[Global.sceneMap][0] + AiDeBaoBao_control.roomId.toString();
         }
         else if(st == SceneConfig.KuaFuPaiDui)
         {
            this._mapName = "服务器" + Model_KuaFuPaiDui.myServerId + " 房间" + Model_KuaFuPaiDui.myRoomId;
         }
         else
         {
            this._mapName = Data_lib.map[Global.sceneMap][0];
         }
         this.setPosition();
      }
      
      public function setPosition() : void
      {
         var position:String = "  [" + int(GameUnitManager.hero.global_x / 20) + "，" + int(GameUnitManager.hero.global_y / 20) + "]";
         this.Place_text.text = this._mapName + position;
         this.Place_text.x = (210 - this.Place_text.width) / 2;
      }
      
      public function get mapData() : BitmapData
      {
         return this.map.bitmapData;
      }
      
      public function drawPath(path:Array) : void
      {
         this.map.drawPath(path,10,10);
      }
      
      public function clearPath() : void
      {
         this.map.clearPath();
      }
      
      public function get hasPath() : Boolean
      {
         return this.map.hasPath;
      }
      
      public function addPoint(role:Role) : void
      {
         var point:MapPoint = null;
         var playerType:int = 0;
         if(Boolean(this.points[role.id]))
         {
            this.delPoint(role.id);
         }
         point = MapPoint.getPoint();
         if(role.type == UnitType.PLAYER)
         {
            playerType = this.checkRelation(role);
            point.init({"type":playerType});
            if(playerType == MapPoint.TEAM)
            {
               UIManager.mappanel.addTeamPoint(role.id,role.name,role.global_x,role.global_y);
               this.teamPoints[role.id] = point;
            }
         }
         else if(role.type == UnitType.NPC)
         {
            point.init({"type":MapPoint.MONSTER});
         }
         point.enabled = false;
         point.x = int(role.global_x / 10);
         point.y = int(role.global_y / 10);
         this.map.addChild(point);
         this.points[role.id] = point;
      }
      
      public function addShipPoint(ship:Ship) : void
      {
         this.map.addShip(ship);
         UIManager.mappanel.curMap.addShipPoint(ship);
      }
      
      private function getPoint(id:Number) : MapPoint
      {
         return this.points[id];
      }
      
      public function refreshShip(ship:Ship) : void
      {
         this.map.refreshShip(ship);
         UIManager.mappanel.curMap.refreshShip(ship);
      }
      
      public function refreshPoint(role:Role) : void
      {
         if(Boolean(this.points[role.id]))
         {
            this.points[role.id].x = int(role.global_x / 10);
            this.points[role.id].y = int(role.global_y / 10);
            UIManager.mappanel.refreshTeamPoint(role.id,role.global_x,role.global_y);
         }
      }
      
      public function delPoint(id:Number) : void
      {
         var point:MapPoint = null;
         if(this.points[id] != null)
         {
            point = this.points[id];
            delete this.points[id];
            if(Boolean(this.teamPoints[id]))
            {
               delete this.teamPoints[id];
            }
            if(Boolean(point))
            {
               point.dispose();
            }
            UIManager.mappanel.delTeamPoint(id);
         }
      }
      
      private function checkRelation(role:Role) : int
      {
         if(Model_team.getIsTeamMember(role.id))
         {
            return MapPoint.TEAM;
         }
         if(role.status == Status.KUN_LUN)
         {
            return MapPoint.MONSTER;
         }
         return MapPoint.PLAYER;
      }
      
      public function resetTeamMembers() : void
      {
         var id:String = null;
         var teamMembers:Array = null;
         var member:Array = null;
         var memberid:int = 0;
         var mappoint:MapPoint = null;
         for(id in this.teamPoints)
         {
            if(Boolean(this.teamPoints[int(id)]) && !Model_team.getIsTeamMember(int(id)))
            {
               this.teamPoints[int(id)].reset({"type":MapPoint.PLAYER});
               UIManager.mappanel.delTeamPoint(int(id));
               delete this.teamPoints[int(id)];
            }
         }
         teamMembers = Model_team.teamMumberInfo_data_save;
         for each(member in teamMembers)
         {
            memberid = int(member[member.length - 1]);
            mappoint = this.points[memberid];
            if(!this.teamPoints[memberid] && Boolean(mappoint))
            {
               mappoint.reset({"type":MapPoint.TEAM});
               UIManager.mappanel.addTeamPoint(int(memberid),mappoint.data.name,mappoint.x * 10,mappoint.y * 10);
               this.teamPoints[memberid] = this.points[memberid];
            }
         }
         if(View_zhuaGuiPanel.instance.visible == true)
         {
            Global.control.sendNotification(Msg_QingMing.QUALITY_UPDATE,Model_QingMing._curLv);
         }
      }
      
      private function resetTeamMember(sid:int) : void
      {
         var mapPoint:MapPoint = this.getPoint(sid) as MapPoint;
         if(!mapPoint)
         {
            return;
         }
         if(Model_team.getIsTeamMember(sid))
         {
            mapPoint.reset({"type":MapPoint.TEAM});
         }
         else
         {
            mapPoint.reset({"type":MapPoint.PLAYER});
         }
      }
      
      override public function resetPosition() : void
      {
         x = Global.stage.stageWidth - 208;
         y = 0;
      }
      
      private function CLICK_BTN_CHIP(e:MouseEvent) : void
      {
         UIManager.panelChip.changeVis();
      }
   }
}

