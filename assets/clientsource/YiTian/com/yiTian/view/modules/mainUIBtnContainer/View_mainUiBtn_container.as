package com.yiTian.view.modules.mainUIBtnContainer
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.manager.DailyBtnManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.KeyBorderHandler;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.GuangMingDingCGMessage;
   import com.yiTian.net.handler.ZhuTiZhouHandler;
   import com.yiTian.net.message.cg.AiDeBaoBaoCGMessage;
   import com.yiTian.net.message.cg.KejuCGMessage;
   import com.yiTian.net.message.cg.PataCGMessage;
   import com.yiTian.net.message.cg.QiJuCGMessage;
   import com.yiTian.net.message.cg.SceneCGMessage;
   import com.yiTian.net.message.cg.TreeDownCLCGMessage;
   import com.yiTian.net.message.cg.WanAnSiCGMessage;
   import com.yiTian.net.message.cg.WulinPartyCGMessage;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.MainUIBase;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.FeiXingQi.Model_FeiXingQi;
   import com.yiTian.view.modules.JiaNianHua.View_JiaNianHua_panel;
   import com.yiTian.view.modules.JiaNianHua.View_JiaNianHua_panel_2;
   import com.yiTian.view.modules.Kunlun.View_RoomTipBtn;
   import com.yiTian.view.modules.Kunlun.View_klTipBtn;
   import com.yiTian.view.modules.ShouChongTiaoZheng.View_ShouChongTiaoZheng_menu;
   import com.yiTian.view.modules.SmallActivityLink.SmallActManager;
   import com.yiTian.view.modules.WulinDaHui.Model_wuLin;
   import com.yiTian.view.modules.awardOnline.View_AwardWaitTip;
   import com.yiTian.view.modules.banhui.View_BangTipBtn;
   import com.yiTian.view.modules.banhui.model_bang.Model_plant;
   import com.yiTian.view.modules.blueDiamondND.ViewBuleDiamondTip;
   import com.yiTian.view.modules.boatChall.BoatManager;
   import com.yiTian.view.modules.farm.ViewFarmIcon;
   import com.yiTian.view.modules.fishing.View_FishTipBtn;
   import com.yiTian.view.modules.fund.FundConfig;
   import com.yiTian.view.modules.guangMingDing.GuangMingDingConfig;
   import com.yiTian.view.modules.jianghulixian.View_Jianghulixian_icon;
   import com.yiTian.view.modules.kuafujingjichang.KuaFuJJCVO;
   import com.yiTian.view.modules.moneyTree.Icon_MoneyTree;
   import com.yiTian.view.modules.qiJu.QiJu_Btn;
   import com.yiTian.view.modules.touzijijin.View_TouZiJiJin_Icon;
   import com.yiTian.view.modules.tuanGou.ViewTuanGouTip;
   import com.yiTian.view.modules.worldBoss.WorldBossUtil;
   import com.yiTian.view.modules.worldLevel.View_wlRewardBtn;
   import com.yiTian.view.modules.xuyuanshu.View_XuYuanShu_Icon;
   import com.yiTian.view.modules.yellowDiamond.JinJuanTips;
   import com.yiTian.view.modules.yellowDiamond.Model_txAction;
   import com.yiTian.view.modules.yellowDiamond.QQGameZheKouJuanTips;
   import com.yiTian.view.modules.yellowDiamond_NationalDay.View_YellowDiamond_ND_Tip;
   import com.yiTian.view.modules.zhutizhou.ActivityTopicPanel;
   import com.yiTian.view.modules.zhutizhou.View_XianShiLiBaoPanel;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class View_mainUiBtn_container extends MainUIBase
   {
      
      public static const PATA:int = 1;
      
      public static const COMMON:int = 2;
      
      public static const FISHING:int = 3;
      
      public static const KLSHAN:int = 4;
      
      public static const BANGZHAN:int = 8;
      
      public static const WULINDAHUI:int = 9;
      
      public static const WANANSI:int = 10;
      
      public static const QIJU:int = 13;
      
      public static const KUAFU_BANGZHAN:int = 14;
      
      public static const DSCL:int = 15;
      
      public static const ADD_BTN:String = "add_btn";
      
      private static var partRemoveArr:Array = [];
      
      private static var partRemoveArrIconHide:Array = [];
      
      public var enterTTFBtn:MainUIBtn;
      
      private const btnW:int = 64;
      
      private const btnH:int = 61;
      
      private const WW:int = 2;
      
      private const HH:int = 2;
      
      private const RIGHT_X:int = 0;
      
      private const TOP:int = 6;
      
      private const HIDE_TOP:int = -400;
      
      public var leaveBtn:MainUIBtn;
      
      private var tfZhanKai:MyTextField;
      
      private const NUMS:int = 8;
      
      public var btnScaleTrace:Button;
      
      private var _btnCont:Sprite = new Sprite();
      
      private var hideBtn:Button;
      
      private var showBtn:Button;
      
      private var XianShiBtn:MainUIBtn;
      
      private var XiaZheBtn:MainUIBtn;
      
      private var RiChangBtn:MainUIBtn;
      
      private var TeHuiBtn:MainUIBtn;
      
      private var XianShiBtnEffArray:Array;
      
      private var XiaZheBtnEffArray:Array;
      
      private var RiChangBtnEffArray:Array;
      
      private var TeHuiBtnEffArray:Array;
      
      private var _scale:Number = 1;
      
      private var _fubenType:int;
      
      public var _btnArr:Array = [];
      
      private var isInCrossClanBattle:Boolean;
      
      private var leaveBtnY:int;
      
      private var _pointDic:Dictionary = new Dictionary();
      
      public function View_mainUiBtn_container()
      {
         super();
         addChild(this._btnCont);
      }
      
      public function setBtnScale(v:Number) : void
      {
         this.btnScaleTrace.label = "x" + v;
         this._scale = v;
         this._btnCont.scaleX = this._btnCont.scaleY = v;
         var txt:String = "当前缩放倍数:" + v;
         TipManager.bind(this.btnScaleTrace,txt);
         TipManager.update(txt);
      }
      
      override protected function initStaticView() : void
      {
         var spC:Sprite = null;
         if(KeyBorderHandler.isUsingKeyBoardP)
         {
            spC = new Sprite();
            spC.graphics.beginFill(0,1);
            spC.graphics.drawRect(0,0,65,65);
            spC.graphics.endFill();
            addChild(spC);
            spC.buttonMode = true;
            this.tfZhanKai = ComponentUtil.getTextField("隐藏",spC,{
               "x":20,
               "y":25
            });
            this._btnArr.unshift({
               "b":spC,
               "l":-1
            });
            spC.addEventListener(MouseEvent.CLICK,function():void
            {
               if(tfZhanKai.text == "展开")
               {
                  tfZhanKai.text = "隐藏";
                  showAllBtn();
               }
               else if(tfZhanKai.text == "隐藏")
               {
                  tfZhanKai.text = "展开";
                  hideAllBtn();
               }
            });
         }
         if(GameUnitManager.hero.level >= 30)
         {
            this.showTTFBtn();
         }
         if(Global.pf == Enum_SPStr.QZONE || Global.pf == Enum_SPStr.PENGYOU || Enum_SPStr.isIwan(Global.pf))
         {
            if(Global.jinJuanStore)
            {
               JinJuanTips.instance.showJinJuanTip();
            }
         }
         this.hideBtn = ComponentUtil.getButton("","Button_SouSuo",this,{
            "x":0,
            "y":54
         },Global.Img_Cdm);
         this.hideBtn.callBack = function():void
         {
            showHideMenuBtn();
            Global.control.sendNotification(Enum_mainUIBtn_hide.MOVE_TO_HIDE,null);
         };
         this.showBtn = ComponentUtil.getButton("","Button_KuoZhan",this,{
            "x":0,
            "y":54
         },Global.Img_Cdm);
         this.showBtn.callBack = function():void
         {
            hideHideMenuBtn();
            UIManager.mainUiBtnContainer.partAdd(1);
            Global.control.sendNotification(Enum_mainUIBtn_hide.HIDE_MENU,null);
         };
         this.showBtn.visible = false;
         this.XianShiBtnEffArray = [];
         this.XianShiBtn = new MainUIBtn("resource/image/hideMenu/Icon_XSHD.png");
         this.XianShiBtn.addEventListener(MouseEvent.CLICK,this.onXianShiBtnClick);
         this.XianShiBtn.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         this.XianShiBtn.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         this.XiaZheBtnEffArray = [];
         this.XiaZheBtn = new MainUIBtn("resource/image/hideMenu/Icon_XZSL.png");
         this.XiaZheBtn.addEventListener(MouseEvent.CLICK,this.onXiaZheBtnClick);
         this.XiaZheBtn.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         this.XiaZheBtn.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         this.RiChangBtnEffArray = [];
         this.RiChangBtn = new MainUIBtn("resource/image/hideMenu/Icon_RCWF.png");
         this.RiChangBtn.addEventListener(MouseEvent.CLICK,this.onRiChangBtnBtnClick);
         this.RiChangBtn.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         this.RiChangBtn.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         this.TeHuiBtnEffArray = [];
         this.TeHuiBtn = new MainUIBtn("resource/image/hideMenu/Icon_THFL.png");
         this.TeHuiBtn.addEventListener(MouseEvent.CLICK,this.onTeHuiBtnBtnClick);
         this.TeHuiBtn.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         this.TeHuiBtn.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         if(GameUnitManager.hero.level < 30)
         {
            this.hideBtn.visible = false;
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP_2,this.checkLevel30);
         }
         Enum_mainUIBtn_hide.initIconPath();
         Global.control.registerCallBack(Enum_mainUIBtn_hide.ICON_EFFECT,this.onIconHideEffect);
         Global.control.registerCallBack(Enum_MsgType.STAGE_RESIZE,this.resetPosition);
      }
      
      private function checkLevel30() : void
      {
         if(GameUnitManager.hero.level >= 30)
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP_2,this.checkLevel30);
            this.hideBtn.visible = true;
         }
      }
      
      private function showHideMenuBtn() : void
      {
         this.hideBtn.visible = false;
         this.showBtn.visible = true;
         this.addBTN(this.XianShiBtn,1);
         this.addBTN(this.XiaZheBtn,2);
         this.addBTN(this.RiChangBtn,3);
         this.addBTN(this.TeHuiBtn,4);
      }
      
      private function hideHideMenuBtn() : void
      {
         this.hideBtn.visible = true;
         this.showBtn.visible = false;
         this.removeBTN(this.XianShiBtn);
         this.removeBTN(this.XiaZheBtn);
         this.removeBTN(this.RiChangBtn);
         this.removeBTN(this.TeHuiBtn);
      }
      
      private function onRollOver(e:MouseEvent) : void
      {
         e.currentTarget.transform.colorTransform = Util.colorWhite2;
      }
      
      private function onRollOut(e:MouseEvent) : void
      {
         e.currentTarget.transform.colorTransform = Util.colorNomal;
      }
      
      private function onXianShiBtnClick(e:MouseEvent) : void
      {
         View_XianShiHuoDong_menu.instance.visible = !View_XianShiHuoDong_menu.instance.visible;
      }
      
      private function onXiaZheBtnClick(e:MouseEvent) : void
      {
         View_XiaZheShiLian_menu.instance.visible = !View_XiaZheShiLian_menu.instance.visible;
      }
      
      private function onRiChangBtnBtnClick(e:MouseEvent) : void
      {
         if(this.RiChangBtnEffArray.length == 0)
         {
            this.RiChangBtn.effectEnd();
         }
         View_RiChangWanFa_menu.instance.visible = !View_RiChangWanFa_menu.instance.visible;
      }
      
      private function onTeHuiBtnBtnClick(e:MouseEvent) : void
      {
         View_TeHuiFuLi_menu.instance.visible = !View_TeHuiFuLi_menu.instance.visible;
      }
      
      public function dispatchLeaveEvent() : void
      {
         this.leaveBtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
      }
      
      private function btnScaleClickHd(e:MouseEvent) : void
      {
         if(this._scale <= 0.5)
         {
            this.setBtnScale(1);
         }
         else
         {
            this.setBtnScale((this._scale * 100 - 10) / 100);
         }
      }
      
      protected function clickBtnHandler(event:MouseEvent) : void
      {
         var sId:int = 0;
         var st:int = 0;
         switch(event.target.name)
         {
            case "enterTTFBtn":
               UIManager.pataOverlordViewPanel.visible = !UIManager.pataOverlordViewPanel.visible;
               if(UIManager.pataOverlordViewPanel.visible)
               {
                  PataCGMessage.CG_OVERLORD();
               }
               break;
            case "leaveBtn":
               GameUnitManager.hero.stopGo();
               sId = Global.sceneID;
               st = SceneConfig.getSceneType();
               if((st == SceneConfig.BZ_BATTLE || st == SceneConfig.BZ_READY) && Model_team.teamMumberInfo_data_save.length > 0 && Model_team.isCap() == false)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("10307",1));
                  return;
               }
               if(st == SceneConfig.FISH || st == SceneConfig.BZ_BATTLE || st == SceneConfig.BZ_READY || st == SceneConfig.KUNLUN || st == SceneConfig.BEACH || st == SceneConfig.KFBZ_BATTLE)
               {
                  Global.control.sendNotification(Enum_MsgType.MSG_LEAVEFB_BTN,null);
                  return;
               }
               View_Alert.show(LangConfig.getWord("10308",1),View_Alert.OK_CANCAL,function():void
               {
                  if(st == SceneConfig.WULIN)
                  {
                     WulinPartyCGMessage.CG_QUIT_MEETING();
                     return;
                  }
                  if(st == SceneConfig.GMD)
                  {
                     GuangMingDingCGMessage.CG_GMD_LEAVE_FUBEN(1);
                     return;
                  }
                  if(st == SceneConfig.AiDeBaoBao)
                  {
                     AiDeBaoBaoCGMessage.CG_AiDeBaoBao_EXIT();
                     return;
                  }
                  if(st == SceneConfig.DSCL)
                  {
                     TreeDownCLCGMessage.CG_QUIT_TREEMAP();
                     return;
                  }
                  if(_fubenType == PATA || _fubenType == WANANSI)
                  {
                     if(Model_team.teamMumberInfo_data_save.length > 0)
                     {
                        if(Model_team.isCap())
                        {
                           if(Model_team.isAway() || Model_team.isOffLine())
                           {
                              UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10309",1) + "</font>");
                           }
                           else if(_fubenType == PATA)
                           {
                              PataCGMessage.CG_LEAVE_TTF();
                           }
                           else if(_fubenType == WANANSI)
                           {
                              WanAnSiCGMessage.CG_WANANSI_QUIT();
                           }
                        }
                        else
                        {
                           UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10310",1) + "</font>");
                        }
                     }
                     else if(_fubenType == PATA)
                     {
                        PataCGMessage.CG_LEAVE_TTF();
                     }
                     else if(_fubenType == WANANSI)
                     {
                        WanAnSiCGMessage.CG_WANANSI_QUIT();
                     }
                  }
                  else if(_fubenType == COMMON)
                  {
                     SceneCGMessage.CG_LEVEA_FUBEN();
                  }
                  else if(_fubenType == WULINDAHUI)
                  {
                     WulinPartyCGMessage.CG_QUIT_MEETING();
                  }
                  else if(_fubenType == SceneConfig.KEJU)
                  {
                     KejuCGMessage.CG_QUIT_KEJU(1);
                  }
                  else if(_fubenType == SceneConfig.QIJU)
                  {
                     QiJuCGMessage.CG_EXIT_QIJUGAME(1);
                  }
               });
         }
      }
      
      public function get curFuBenType() : int
      {
         return this._fubenType;
      }
      
      public function showLeaveBtn(fubenType:int) : void
      {
         if(!this.leaveBtn)
         {
            this.leaveBtn = new MainUIBtn("resource/image/pata/Exit_Icon.png");
            this.leaveBtn.name = "leaveBtn";
            this.leaveBtn.addEventListener(MouseEvent.CLICK,this.clickBtnHandler);
         }
         this.leaveBtn.transform.colorTransform = Util.colorNomal;
         this.leaveBtn.mouseEnabled = true;
         this.leaveBtn.visible = true;
         this.leaveBtn.filters = [];
         this._fubenType = fubenType;
         if(Global.sceneID == 12401)
         {
            this._fubenType = BANGZHAN;
         }
         if(Global.sceneID == 12301)
         {
            this._fubenType = WULINDAHUI;
         }
         if(Global.sceneID == 12305)
         {
            this._fubenType = SceneConfig.KEJU;
         }
         if(Global.sceneID == 12409)
         {
            this._fubenType = SceneConfig.QIJU;
         }
         if(Global.sceneID == 14128)
         {
            this._fubenType = SceneConfig.DSCL;
         }
         this.addBTN(this.leaveBtn);
         this.updataLeaveBtn();
      }
      
      public function hideLeaveBtn() : void
      {
         if(Boolean(this.leaveBtn))
         {
            this.leaveBtn.mouseEnabled = true;
            this.leaveBtn.filters = [];
            this._fubenType = 0;
            this.removeBTN(this.leaveBtn);
         }
      }
      
      public function updataLeaveBtn() : void
      {
         if(!this.hasBTN(this.leaveBtn))
         {
            return;
         }
         if(Model_team.teamMumberInfo_data_save.length > 0)
         {
            if(!Model_team.isCap())
            {
               this.leaveBtn.mouseEnabled = false;
               this.leaveBtn.filters = Util.disabled;
            }
            else
            {
               this.leaveBtn.mouseEnabled = true;
               this.leaveBtn.filters = [];
            }
         }
         if(SceneConfig.getSceneType() == SceneConfig.KFBZ_BATTLE)
         {
            if(Model_team.hasTeam() == false)
            {
               this.leaveBtn.mouseEnabled = true;
               this.leaveBtn.filters = [];
            }
         }
      }
      
      private function indexOfBtn(btn:Object) : int
      {
         var index:int = -1;
         var i:uint = 0;
         while(i < this._btnArr.length)
         {
            if(this._btnArr[i].b == btn)
            {
               index = int(i);
               break;
            }
            i++;
         }
         return index;
      }
      
      public function invalidateResetPos() : void
      {
         if(this.isInCrossClanBattle == true)
         {
            return;
         }
         addEventListener(Event.EXIT_FRAME,this.repositionBtn);
      }
      
      public function checkCrossClanBattleBtnVisible(value:Boolean) : void
      {
         var dobj:DisplayObject = null;
         if(value == false)
         {
            this.isInCrossClanBattle = false;
         }
         if(!UIManager.isInit)
         {
            return;
         }
         var i:int = 0;
         while(i < this._btnArr.length)
         {
            dobj = this._btnArr[i].b;
            if(dobj == this.leaveBtn)
            {
               dobj.visible = value;
               if(value == true)
               {
                  this.isInCrossClanBattle = true;
                  removeEventListener(Event.EXIT_FRAME,this.repositionBtn);
                  dobj.x = this.RIGHT_X - this.btnW;
                  this.leaveBtnY = dobj.y;
                  dobj.y = 10;
               }
               else
               {
                  this.removeBTN(this.leaveBtn);
                  dobj.y = this.leaveBtnY;
               }
            }
            else if(value == false && dobj is View_AwardWaitTip)
            {
               this._btnCont.addChild(dobj);
            }
            else if(value == true && dobj is View_AwardWaitTip)
            {
               this._btnCont.removeChild(dobj);
            }
            else
            {
               dobj.visible = !value;
            }
            i++;
         }
      }
      
      private function repositionBtn(e:Event) : void
      {
         var i:uint = 0;
         var j:uint = 0;
         var nums2:int = 0;
         var nums:int = 0;
         var dobj:DisplayObject = null;
         var isPass:Boolean = false;
         var len1:int = 0;
         var actPanel:ActivityTopicPanel = null;
         var l:int = 0;
         var isPass1:Boolean = false;
         var len2:int = 0;
         var libaoPanel:View_XianShiLiBaoPanel = null;
         var m:int = 0;
         var len:int = 0;
         var actTopicPanel:ActivityTopicPanel = null;
         var k:int = 0;
         var lenn:int = 0;
         var view_libaoPanel:View_XianShiLiBaoPanel = null;
         var k1:int = 0;
         if(!UIManager.isInit)
         {
            return;
         }
         removeEventListener(Event.EXIT_FRAME,this.repositionBtn);
         var tempArr:Array = [];
         i = 0;
         j = 0;
         for(; i < this._btnArr.length; i++)
         {
            dobj = this._btnArr[i].b;
            if(dobj == this.leaveBtn)
            {
               nums++;
               dobj.x = this.RIGHT_X - this.btnW;
               dobj.y = this.TOP + (this.btnH + this.HH);
            }
            else if(dobj is View_RoomTipBtn)
            {
               nums++;
               dobj.x = this.RIGHT_X - this.btnW * 2 - this.WW;
               dobj.y = this.TOP + (this.btnH + this.HH);
            }
            else if(dobj == UIManager.qplusShare.qplusBtn)
            {
               nums2++;
            }
            else if(dobj == View_ShouChongTiaoZheng_menu.instance.btn)
            {
               nums2++;
            }
            else if(dobj == Icon_MoneyTree.instance)
            {
               nums2++;
            }
            else
            {
               if(Boolean(ZhuTiZhouHandler.panelArr.length))
               {
                  isPass = false;
                  len1 = int(ZhuTiZhouHandler.panelArr.length);
                  l = 0;
                  while(l < len1)
                  {
                     actPanel = ZhuTiZhouHandler.panelArr[l];
                     if(dobj == actPanel.scBtn)
                     {
                        nums2++;
                        isPass = true;
                        break;
                     }
                     l++;
                  }
                  if(isPass)
                  {
                     continue;
                  }
               }
               if(Boolean(ZhuTiZhouHandler.libaoPanelArr.length))
               {
                  isPass1 = false;
                  len2 = int(ZhuTiZhouHandler.libaoPanelArr.length);
                  m = 0;
                  while(m < len2)
                  {
                     libaoPanel = ZhuTiZhouHandler.libaoPanelArr[m];
                     if(dobj == libaoPanel.libaoBtn)
                     {
                        nums2++;
                        isPass1 = true;
                        break;
                     }
                     m++;
                  }
                  if(isPass1)
                  {
                     continue;
                  }
               }
               if(dobj == View_TouZiJiJin_Icon.instance)
               {
                  nums2++;
               }
               else if(dobj == View_XuYuanShu_Icon.instance)
               {
                  nums2++;
               }
               else if(dobj == View_JiaNianHua_panel.instance.icon)
               {
                  nums2++;
               }
               else if(dobj == Model_txAction.instance.yellowBtn)
               {
                  nums2++;
               }
               else if(dobj == ViewBuleDiamondTip.instance)
               {
                  nums2++;
               }
               else if(dobj == View_YellowDiamond_ND_Tip.instance.tipBtn)
               {
                  nums2++;
               }
               else if(dobj == UIManager.daysAPan.showDaysA)
               {
                  nums2++;
               }
               else if(dobj == QQGameZheKouJuanTips.ins.tips)
               {
                  nums2++;
               }
               else if(dobj == JinJuanTips.instance.tipBtn)
               {
                  nums2++;
               }
               else if(dobj == UIManager.shengdanBtn.shengDanYll)
               {
                  nums2++;
               }
               else if(dobj == View_JiaNianHua_panel_2.instance.icon)
               {
                  nums2++;
               }
               else
               {
                  tempArr[j++] = dobj;
               }
            }
         }
         i = 0;
         if(this.hasBTN(View_JiaNianHua_panel_2.instance.icon))
         {
            View_JiaNianHua_panel_2.instance.icon.x = this.RIGHT_X - this.btnW - (this.btnW + this.WW) * i++;
            View_JiaNianHua_panel_2.instance.icon.y = this.TOP + (this.btnH + this.HH) * 2;
         }
         if(this.hasBTN(View_ShouChongTiaoZheng_menu.instance.btn))
         {
            View_ShouChongTiaoZheng_menu.instance.btn.x = this.RIGHT_X - this.btnW - (this.btnW + this.WW) * i++;
            View_ShouChongTiaoZheng_menu.instance.btn.y = this.TOP + (this.btnH + this.HH) * 2;
         }
         if(ZhuTiZhouHandler.panelArr.length > 0)
         {
            len = int(ZhuTiZhouHandler.panelArr.length);
            k = 0;
            while(k < len)
            {
               actTopicPanel = ZhuTiZhouHandler.panelArr[k];
               if(this.hasBTN(actTopicPanel.scBtn))
               {
                  if(i < this.NUMS)
                  {
                     actTopicPanel.scBtn.x = this.RIGHT_X - this.btnW - (this.btnW + this.WW) * i++;
                     actTopicPanel.scBtn.y = this.TOP + (this.btnH + this.HH) * 2;
                  }
                  else
                  {
                     actTopicPanel.scBtn.x = this.RIGHT_X - this.btnW - (this.btnW + this.WW) * (i % this.NUMS);
                     actTopicPanel.scBtn.y = this.TOP + (this.btnH + this.HH) * (2 + int(i / 7));
                     i++;
                  }
               }
               k++;
            }
         }
         if(ZhuTiZhouHandler.libaoPanelArr.length > 0)
         {
            lenn = int(ZhuTiZhouHandler.libaoPanelArr.length);
            k1 = 0;
            while(k1 < lenn)
            {
               view_libaoPanel = ZhuTiZhouHandler.libaoPanelArr[k1];
               if(this.hasBTN(view_libaoPanel.libaoBtn))
               {
                  if(i < this.NUMS)
                  {
                     view_libaoPanel.libaoBtn.x = this.RIGHT_X - this.btnW - (this.btnW + this.WW) * i++;
                     view_libaoPanel.libaoBtn.y = this.TOP + (this.btnH + this.HH) * 2;
                  }
                  else
                  {
                     view_libaoPanel.libaoBtn.x = this.RIGHT_X - this.btnW - (this.btnW + this.WW) * (i % this.NUMS);
                     view_libaoPanel.libaoBtn.y = this.TOP + (this.btnH + this.HH) * (2 + int(i / 7));
                     i++;
                  }
               }
               k1++;
            }
         }
         if(this.hasBTN(Icon_MoneyTree.instance))
         {
            Icon_MoneyTree.instance.x = this.RIGHT_X - this.btnW - (this.btnW + this.WW) * i++;
            Icon_MoneyTree.instance.y = this.TOP + (this.btnH + this.HH) * 2;
         }
         if(this.hasBTN(View_TouZiJiJin_Icon.instance))
         {
            View_TouZiJiJin_Icon.instance.x = this.RIGHT_X - this.btnW - (this.btnW + this.WW) * i++;
            View_TouZiJiJin_Icon.instance.y = this.TOP + (this.btnH + this.HH) * 2;
         }
         if(this.hasBTN(View_XuYuanShu_Icon.instance))
         {
            View_XuYuanShu_Icon.instance.x = this.RIGHT_X - this.btnW - (this.btnW + this.WW) * i++;
            View_XuYuanShu_Icon.instance.y = this.TOP + (this.btnH + this.HH) * 2;
         }
         if(this.hasBTN(View_JiaNianHua_panel.instance.icon))
         {
            View_JiaNianHua_panel.instance.icon.x = this.RIGHT_X - this.btnW - (this.btnW + this.WW) * i++;
            View_JiaNianHua_panel.instance.icon.y = this.TOP + (this.btnH + this.HH) * 2;
         }
         if(this.hasBTN(Model_txAction.instance.yellowBtn))
         {
            Model_txAction.instance.yellowBtn.x = this.RIGHT_X - this.btnW - (this.btnW + this.WW) * i++;
            Model_txAction.instance.yellowBtn.y = this.TOP + (this.btnH + this.HH) * 2;
         }
         if(this.hasBTN(ViewBuleDiamondTip.instance))
         {
            ViewBuleDiamondTip.instance.x = this.RIGHT_X - this.btnW - (this.btnW + this.WW) * i++;
            ViewBuleDiamondTip.instance.y = this.TOP + (this.btnH + this.HH) * 2;
         }
         if(this.hasBTN(View_YellowDiamond_ND_Tip.instance.tipBtn))
         {
            View_YellowDiamond_ND_Tip.instance.tipBtn.x = this.RIGHT_X - this.btnW - (this.btnW + this.WW) * i++;
            View_YellowDiamond_ND_Tip.instance.tipBtn.y = this.TOP + (this.btnH + this.HH) * 2;
         }
         if(this.hasBTN(UIManager.daysAPan.showDaysA))
         {
            UIManager.daysAPan.showDaysA.x = this.RIGHT_X - this.btnW - (this.btnW + this.WW) * i++;
            UIManager.daysAPan.showDaysA.y = this.TOP + (this.btnH + this.HH) * 2;
         }
         if(this.hasBTN(QQGameZheKouJuanTips.ins.tips))
         {
            QQGameZheKouJuanTips.ins.tips.x = this.RIGHT_X - this.btnW - (this.btnW + this.WW) * i++;
            QQGameZheKouJuanTips.ins.tips.y = this.TOP + (this.btnH + this.HH) * 2;
         }
         if(this.hasBTN(UIManager.qplusShare.qplusBtn))
         {
            UIManager.qplusShare.qplusBtn.x = this.RIGHT_X - this.btnW - (this.btnW + this.WW) * i++;
            UIManager.qplusShare.qplusBtn.y = this.TOP + (this.btnH + this.HH) * 2;
         }
         if(this.hasBTN(JinJuanTips.instance.tipBtn))
         {
            JinJuanTips.instance.tipBtn.x = this.RIGHT_X - this.btnW - (this.btnW + this.WW) * i++;
            JinJuanTips.instance.tipBtn.y = this.TOP + (this.btnH + this.HH) * 2;
         }
         if(this.hasBTN(UIManager.shengdanBtn.shengDanYll))
         {
            UIManager.shengdanBtn.shengDanYll.x = this.RIGHT_X - this.btnW - (this.btnW + this.WW) * i++;
            UIManager.shengdanBtn.shengDanYll.y = this.TOP + (this.btnH + this.HH) * 2;
         }
         i = 0;
         while(i < tempArr.length)
         {
            dobj = tempArr[i];
            if(Boolean(nums) && nums2 == 0)
            {
               if(i < this.NUMS)
               {
                  dobj.x = this.RIGHT_X - this.btnW - (this.btnW + this.WW) * (i % this.NUMS);
                  dobj.y = this.TOP + (this.btnH + this.HH) * Math.floor(i / this.NUMS);
               }
               else if(i >= this.NUMS && i <= this.NUMS * 2 - 1 - nums)
               {
                  dobj.x = this.leaveBtn.x - (this.btnW + this.WW) * ((i + nums) % this.NUMS);
                  dobj.y = this.TOP + (this.btnH + this.HH) * Math.floor(i / this.NUMS);
               }
               else if(i > this.NUMS * 2 - 1 - nums)
               {
                  dobj.x = this.RIGHT_X - this.btnW - (this.btnW + this.WW) * ((i + nums) % this.NUMS);
                  dobj.y = this.TOP + (this.btnH + this.HH) * Math.floor((i + nums) / this.NUMS);
               }
            }
            else if(Boolean(nums2) && nums == 0)
            {
               if(i < this.NUMS * 2)
               {
                  dobj.x = this.RIGHT_X - this.btnW - (this.btnW + this.WW) * (i % this.NUMS);
                  dobj.y = this.TOP + (this.btnH + this.HH) * Math.floor(i / this.NUMS);
               }
               else
               {
                  dobj.x = this.RIGHT_X - this.btnW - (this.btnW + this.WW) * ((i + nums2) % this.NUMS);
                  dobj.y = this.TOP + (this.btnH + this.HH) * Math.floor((i + nums2) / this.NUMS);
               }
            }
            else if(Boolean(nums) && Boolean(nums2))
            {
               if(i < this.NUMS)
               {
                  dobj.x = this.RIGHT_X - this.btnW - (this.btnW + this.WW) * (i % this.NUMS);
                  dobj.y = this.TOP + (this.btnH + this.HH) * Math.floor(i / this.NUMS);
               }
               else if(i >= this.NUMS && i <= this.NUMS * 2 - 1 - nums)
               {
                  dobj.x = this.leaveBtn.x - (this.btnW + this.WW) * ((i + nums) % this.NUMS);
                  dobj.y = this.TOP + (this.btnH + this.HH) * Math.floor(i / this.NUMS);
               }
               else if(i > this.NUMS * 2 - 1 - nums)
               {
                  dobj.x = this.RIGHT_X - this.btnW - (this.btnW + this.WW) * ((i + nums + nums2) % this.NUMS);
                  dobj.y = this.TOP + (this.btnH + this.HH) * Math.floor((i + nums + nums2) / this.NUMS);
               }
            }
            else
            {
               dobj.x = this.RIGHT_X - this.btnW - (this.btnW + this.WW) * (i % this.NUMS);
               dobj.y = this.TOP + (this.btnH + this.HH) * Math.floor(i / this.NUMS);
            }
            i++;
         }
         if(Boolean(SmallActManager.instance.telChargeBtn) && this.hasBTN(SmallActManager.instance.telChargeBtn))
         {
            SmallActManager.instance.telChargeBtn.x -= 14;
            SmallActManager.instance.telChargeBtn.y -= 10;
         }
         if(Boolean(SmallActManager.instance.loveActBtn) && this.hasBTN(SmallActManager.instance.loveActBtn))
         {
            SmallActManager.instance.loveActBtn.x -= 14;
            SmallActManager.instance.loveActBtn.y -= 8;
         }
      }
      
      public function hideAllBtnExc(... param) : void
      {
         var item:Object = null;
         var disObj:DisplayObject = null;
         for each(item in this._btnArr)
         {
            item.b.visible = false;
         }
         for each(disObj in param)
         {
            if(Boolean(disObj))
            {
               disObj.visible = true;
            }
         }
      }
      
      public function showAllExc(... param) : void
      {
         var item:Object = null;
         var disObj:DisplayObject = null;
         var obj:DisplayObject = null;
         for each(item in this._btnArr)
         {
            obj = item.b;
            obj.visible = true;
            if(obj is View_AwardWaitTip)
            {
               if(!this._btnCont.contains(obj))
               {
                  this._btnCont.addChild(obj);
               }
            }
         }
         for each(disObj in param)
         {
            if(Boolean(disObj))
            {
               disObj.visible = false;
            }
         }
      }
      
      public function partPauseRemove(btn:DisplayObject, partArrType:int = 0) : void
      {
         var index:int = this.indexOfBtn(btn);
         if(index >= 0)
         {
            this._btnCont.removeChild(this._btnArr[index].b);
            this._btnArr.splice(index,1);
            this.invalidateResetPos();
            btn.removeEventListener(MouseEvent.MOUSE_OVER,this.btnOnMouseOver);
            btn.removeEventListener(MouseEvent.MOUSE_OUT,this.btnOnMouseOut);
            if(partArrType == 0)
            {
               partRemoveArr.push(btn);
            }
            else if(partArrType == 1)
            {
               partRemoveArrIconHide.push(btn);
            }
         }
      }
      
      public function partAdd(partRemoveArrType:int = 0) : void
      {
         var i:int = 0;
         var btn:DisplayObject = null;
         var j:int = 0;
         if(partRemoveArrType == 0)
         {
            i = 0;
            while(i < partRemoveArr.length)
            {
               btn = partRemoveArr[i];
               this.addBTN(btn);
               i++;
            }
            while(Boolean(partRemoveArr.length))
            {
               partRemoveArr.shift();
            }
         }
         else if(partRemoveArrType == 1)
         {
            j = 0;
            while(j < partRemoveArrIconHide.length)
            {
               this.addBTN(partRemoveArrIconHide[j] as DisplayObject);
               j++;
            }
            while(Boolean(partRemoveArrIconHide.length))
            {
               partRemoveArrIconHide.shift();
            }
         }
      }
      
      public function hideAllBtn() : void
      {
         var point:Point = null;
         var item:Object = null;
         var _dObj:Object = this._btnArr[0];
         point = new Point(_dObj.b.x,_dObj.b.y);
         for each(item in this._btnArr)
         {
            if(item.l != -1)
            {
               this._pointDic[item.b] = new Point(item.b.x,item.b.y);
               Tween.to(item.b,100,{
                  "x":[item.b.x,point.x + _dObj.b.width / 2],
                  "y":[item.b.y,point.y + _dObj.b.height / 2],
                  "scaleX":[1,0],
                  "scaleY":[1,0]
               },function(target:DisplayObject):void
               {
                  target.visible = false;
               });
            }
         }
      }
      
      public function showAllBtn() : void
      {
         var point:Point = null;
         var item:Object = null;
         var _p:Point = null;
         var _dObj:Object = this._btnArr[0];
         point = new Point(_dObj.b.x,_dObj.b.y);
         for each(item in this._btnArr)
         {
            if(item.l != -1)
            {
               if(Boolean(this._pointDic[item.b]))
               {
                  _p = this._pointDic[item.b];
               }
               item.b.visible = true;
               Tween.to(item.b,100,{
                  "x":[point.x + _dObj.b.width / 2,_p.x],
                  "y":[point.y + _dObj.b.height / 2,_p.y],
                  "scaleX":[0,1],
                  "scaleY":[0,1]
               });
            }
         }
      }
      
      private function sortOnBtn() : void
      {
         this._btnArr.sort(function(a:Object, b:Object):int
         {
            if(a.l < b.l)
            {
               return 1;
            }
            if(a.l > b.l)
            {
               return -1;
            }
            return 0;
         });
      }
      
      public function addBTN(btn:DisplayObject, level:int = 0) : void
      {
         var index:int = this.indexOfBtn(btn);
         if(Boolean(btn) && index < 0)
         {
            if(Boolean(this.showBtn) && this.showBtn.visible)
            {
               switch(btn)
               {
                  case View_FishTipBtn.instance:
                  case WorldBossUtil.btn:
                  case UIManager.kuafuBtn.KuaFuBtn:
                  case View_klTipBtn.instance:
                  case Model_wuLin.instance.wulinBtn:
                  case View_BangTipBtn.instance:
                  case Model_plant.instance.plantBtn:
                  case Model_FeiXingQi.tipBtn:
                  case View_Jianghulixian_icon.instance:
                  case ViewFarmIcon.instance:
                  case UIManager.lingQiWuHunPanel.lingBtn:
                  case UIManager.tianTiPanel.imgBtn:
                  case this.enterTTFBtn:
                  case GuangMingDingConfig.bmBtn:
                  case UIManager.wanAnSiPanel.icon:
                  case QiJu_Btn.instance.qiJuBtn:
                  case UIManager.actKaiFu.bmBtn:
                  case FundConfig.mainBtn:
                  case ViewTuanGouTip.instance:
                  case View_wlRewardBtn.instance:
                  case UIManager.paoBiaoPanel.icon:
                  case UIManager.jjc_panel.jingBtn:
                     if(partRemoveArrIconHide.indexOf(btn) == -1)
                     {
                        partRemoveArrIconHide.push(btn);
                     }
                     break;
                  default:
                     this._btnArr[this._btnArr.length] = {
                        "b":btn,
                        "l":level
                     };
                     this._btnCont.addChild(btn);
                     this.invalidateResetPos();
                     btn.addEventListener(MouseEvent.MOUSE_OVER,this.btnOnMouseOver);
                     btn.addEventListener(MouseEvent.MOUSE_OUT,this.btnOnMouseOut);
                     Global.control.sendNotification(ADD_BTN,btn);
                     this.sortOnBtn();
               }
            }
            else
            {
               this._btnArr[this._btnArr.length] = {
                  "b":btn,
                  "l":level
               };
               this._btnCont.addChild(btn);
               this.invalidateResetPos();
               btn.addEventListener(MouseEvent.MOUSE_OVER,this.btnOnMouseOver);
               btn.addEventListener(MouseEvent.MOUSE_OUT,this.btnOnMouseOut);
               Global.control.sendNotification(ADD_BTN,btn);
               this.sortOnBtn();
            }
         }
      }
      
      public function getT(_target:DisplayObject) : Point
      {
         var obj:Object = null;
         for each(obj in this._btnArr)
         {
            if(obj.b == _target)
            {
               return localToGlobal(new Point(obj.b.x,obj.b.y));
            }
         }
         return null;
      }
      
      protected function btnOnMouseOver(e:Event) : void
      {
         (e.target as DisplayObject).transform.colorTransform = Util.colorWhite2;
      }
      
      protected function btnOnMouseOut(e:Event) : void
      {
         (e.target as DisplayObject).transform.colorTransform = Util.colorNomal;
      }
      
      public function hasBTN(btn:DisplayObject) : Boolean
      {
         var obj:Object = null;
         for each(obj in this._btnArr)
         {
            if(obj.b === btn)
            {
               return true;
            }
         }
         return false;
      }
      
      public function removeBTN(btn:DisplayObject) : void
      {
         var index:int = this.indexOfBtn(btn);
         if(Boolean(btn) && partRemoveArr.indexOf(btn) >= 0)
         {
            partRemoveArr.splice(partRemoveArr.indexOf(btn),1);
         }
         if(Boolean(btn) && partRemoveArrIconHide.indexOf(btn) >= 0)
         {
            partRemoveArrIconHide.splice(partRemoveArrIconHide.indexOf(btn),1);
         }
         if(index >= 0)
         {
            this._btnCont.removeChild(this._btnArr[index].b);
            this._btnArr.splice(index,1);
            this.invalidateResetPos();
            btn.removeEventListener(MouseEvent.MOUSE_OVER,this.btnOnMouseOver);
            btn.removeEventListener(MouseEvent.MOUSE_OUT,this.btnOnMouseOut);
         }
      }
      
      public function showTTFBtn() : IMainUiBtn
      {
         if(!this.enterTTFBtn)
         {
            this.enterTTFBtn = new MainUIBtn("resource/image/pata/btn.png",null,null,null,true);
            this.enterTTFBtn.name = "enterTTFBtn";
            this.enterTTFBtn.addEventListener(MouseEvent.CLICK,this.clickBtnHandler);
         }
         this.addBTN(this.enterTTFBtn);
         Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.TongTianFeng,1]);
         this.updateTTFCount(DailyBtnManager.getCount(DailyBtnManager.TTF));
         return this.enterTTFBtn;
      }
      
      public function removeTTFBtn() : void
      {
         if(Boolean(this.enterTTFBtn))
         {
            this.removeBTN(this.enterTTFBtn);
         }
         Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.TongTianFeng,2]);
      }
      
      public function updateTTFCount(count:int) : void
      {
         if(Boolean(this.enterTTFBtn))
         {
            this.enterTTFBtn.showTime(count);
            Global.control.sendNotification(Enum_mainUIBtn_hide.SET_COUNT,[Enum_mainUIBtn_hide.TongTianFeng,count]);
            if(count == 0)
            {
               this.removeBTN(this.enterTTFBtn);
               Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.TongTianFeng,2]);
            }
            else
            {
               if(!this.hasBTN(this.enterTTFBtn))
               {
                  this.addBTN(this.enterTTFBtn);
               }
               Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.TongTianFeng,1]);
            }
         }
      }
      
      private function getShape() : Sprite
      {
         var s:Sprite = new Sprite();
         s.graphics.beginFill(16777215,0.5);
         s.graphics.drawRect(0,0,50,50);
         s.graphics.endFill();
         return s;
      }
      
      override public function resetPosition() : void
      {
         x = Global.stage.stageWidth - 256;
         y = BoatManager.mainUIConY;
         this.invalidateResetPos();
      }
      
      private function onIconHideEffect(arr:Array) : void
      {
         var index:int = 0;
         var iconType:int = 0;
         var i:* = undefined;
         for(i in Data_lib.iconHide)
         {
            if(Data_lib.iconHide[i][5] == arr[0])
            {
               iconType = int(Data_lib.iconHide[i][0]);
               break;
            }
         }
         switch(iconType)
         {
            case Enum_mainUIBtn_hide.XianShiHuoDong:
               index = this.XianShiBtnEffArray.indexOf(arr[0]);
               if(arr[1] == 1 && index == -1)
               {
                  if(arr[0] == Enum_mainUIBtn_hide.DuoRenJingJi)
                  {
                     if(KuaFuJJCVO.see == 4)
                     {
                        this.XianShiBtn.effectBegin();
                        this.XianShiBtnEffArray.push(arr[0]);
                     }
                     break;
                  }
                  this.XianShiBtn.effectBegin();
                  this.XianShiBtnEffArray.push(arr[0]);
                  break;
               }
               if(arr[1] != 1 && index != -1)
               {
                  this.XianShiBtnEffArray.splice(index,1);
                  if(this.XianShiBtnEffArray.length == 0)
                  {
                     this.XianShiBtn.effectEnd();
                  }
               }
               break;
            case Enum_mainUIBtn_hide.XiaZheShiLian:
               index = this.XiaZheBtnEffArray.indexOf(arr[0]);
               if(arr[1] == 1 && index == -1)
               {
                  this.XiaZheBtn.effectBegin();
                  this.XiaZheBtnEffArray.push(arr[0]);
                  break;
               }
               if(arr[1] != 1 && index != -1)
               {
                  this.XiaZheBtnEffArray.splice(index,1);
                  if(this.XiaZheBtnEffArray.length == 0)
                  {
                     this.XiaZheBtn.effectEnd();
                  }
               }
               break;
            case Enum_mainUIBtn_hide.RiChangWanFa:
               index = this.RiChangBtnEffArray.indexOf(arr[0]);
               if(arr[1] == 1 && index == -1)
               {
                  this.RiChangBtn.effectBegin();
                  this.RiChangBtnEffArray.push(arr[0]);
                  break;
               }
               if(arr[1] != 1 && index != -1)
               {
                  this.RiChangBtnEffArray.splice(index,1);
                  if(this.RiChangBtnEffArray.length == 0)
                  {
                     this.RiChangBtn.effectEnd();
                  }
               }
               break;
            case Enum_mainUIBtn_hide.TeHuiFuLi:
               index = this.TeHuiBtnEffArray.indexOf(arr[0]);
               if(arr[1] == 1 && index == -1)
               {
                  this.TeHuiBtn.effectBegin();
                  this.TeHuiBtnEffArray.push(arr[0]);
                  break;
               }
               if(arr[1] != 1 && index != -1)
               {
                  this.TeHuiBtnEffArray.splice(index,1);
                  if(this.TeHuiBtnEffArray.length == 0)
                  {
                     this.TeHuiBtn.effectEnd();
                  }
               }
         }
      }
   }
}

