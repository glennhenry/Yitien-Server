package com.yiTian.view.modules.banhui
{
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_bang;
   import com.yiTian.data.vo.Vo_shenshou;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BangCGMessage;
   import com.yiTian.net.message.cg.ShenshouCGMessage;
   import com.yiTian.utils.Bitmap2;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.view.Enum_explor;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.banhui.bangMorePlays.BangMPlayerPan;
   import com.yiTian.view.modules.banhui.shenshou.ViewShenShou;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   
   public class View_banghuiBack extends Panel
   {
      
      public static var isInitBangSf:Boolean = false;
      
      private var Button_ZhenFa:TabButton;
      
      private var Button_Building:TabButton;
      
      private var Button_Member:TabButton;
      
      private var Button_Informat:TabButton;
      
      private var Button_BangList:TabButton;
      
      public var Button_ShenShou:TabButton;
      
      public var bangShenShou:ViewShenShou = new ViewShenShou();
      
      private var _tfMask:MyTextField;
      
      private var morePlaysBtn:TabButton;
      
      private var morePlaysPan:BangMPlayerPan;
      
      public var bang_info:BangHuiInfo;
      
      public var bang_members:BangMembers;
      
      public var bang_map:BangMap;
      
      public var bang_zhanfa:bangZhenfa;
      
      public var bangInerList:View_bangInterList;
      
      public var now:TabButton;
      
      private var bmMask:Bitmap2 = new Bitmap2();
      
      private var tmp:Bitmap;
      
      private var isFirstOpen:Boolean = true;
      
      private var eff:Effect;
      
      public function View_banghuiBack()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var back:ScaleBitmap;
         var back2:ScaleBitmap;
         isTween = true;
         Model_bang.INIT_ZF();
         move = new Rectangle(0,0,698,38);
         back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":728,
            "height":460
         },Global.Img_Cdm);
         this.Button_ZhenFa = ComponentUtil.getTabButton(LangConfig.getWord("22710",2),"TabButton_Four",this,{
            "x":263,
            "y":43,
            "textColor":11770414,
            "chooseColor":16773818
         },Global.Img_Cdm);
         this.Button_Building = ComponentUtil.getTabButton(LangConfig.getWord("22711",2),"TabButton_Four",this,{
            "x":186,
            "y":43,
            "textColor":11770414,
            "chooseColor":16773818
         },Global.Img_Cdm);
         this.Button_Member = ComponentUtil.getTabButton(LangConfig.getWord("22712",2),"TabButton_Four",this,{
            "x":109,
            "y":43,
            "textColor":11770414,
            "chooseColor":16773818
         },Global.Img_Cdm);
         this.Button_Informat = ComponentUtil.getTabButton(LangConfig.getWord("22713",2),"TabButton_Four",this,{
            "x":32,
            "y":43,
            "textColor":11770414,
            "chooseColor":16773818
         },Global.Img_Cdm);
         this.Button_BangList = ComponentUtil.getTabButton(LangConfig.getWord("22714",2),"TabButton_Four",this,{
            "x":415,
            "y":43,
            "textColor":11770414,
            "chooseColor":16773818
         },Global.Img_Cdm);
         this.Button_ShenShou = ComponentUtil.getTabButton(LangConfig.getWord("30015",3),"TabButton_Four",this,{
            "x":340,
            "y":43,
            "textColor":11770414,
            "chooseColor":16773818
         },Global.Img_Cdm);
         this.morePlaysBtn = ComponentUtil.getTabButton("更多玩法","TabButton_Four",this,{
            "x":490,
            "y":43,
            "textColor":11770414,
            "chooseColor":16773818
         },Global.Img_Cdm);
         back2 = ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":64,
            "width":680,
            "height":387
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":690,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_ShenShou.visible = true;
         this.Button_Informat.choose = true;
         this.Button_ZhenFa.addEventListener(MouseEvent.CLICK,this.cliHandle);
         this.Button_Building.addEventListener(MouseEvent.CLICK,this.cliHandle);
         this.Button_Member.addEventListener(MouseEvent.CLICK,this.cliHandle);
         this.Button_Informat.addEventListener(MouseEvent.CLICK,this.cliHandle);
         this.Button_BangList.addEventListener(MouseEvent.CLICK,this.cliHandle);
         this.Button_ShenShou.addEventListener(MouseEvent.CLICK,this.cliHandle);
         this.morePlaysBtn.addEventListener(MouseEvent.CLICK,this.cliHandle);
         this.bang_info = new BangHuiInfo();
         addChild(this.bang_info);
         this.bang_members = new BangMembers();
         addChild(this.bang_members);
         this.bang_map = new BangMap();
         addChild(this.bang_map);
         this.bang_zhanfa = new bangZhenfa();
         addChild(this.bang_zhanfa);
         this.bangInerList = new View_bangInterList();
         addChild(this.bangInerList);
         this.bang_map.visible = false;
         this.bang_members.visible = false;
         this.bang_zhanfa.visible = false;
         this.bangInerList.visible = false;
         addChild(this.bangShenShou);
         this.bangShenShou.visible = false;
         this._tfMask = ComponentUtil.getTextField("",this,{
            "x":364,
            "y":320
         });
         this._tfMask.autoSize = TextFieldAutoSize.CENTER;
         this._tfMask.mouseEnabled = true;
         this._tfMask.addEventListener(TextEvent.LINK,this.tfMaskLinkHd);
         super.CloseButton.addEventListener(MouseEvent.CLICK,function():void
         {
            visible = false;
         });
      }
      
      private function addNewUnit_morePlays() : void
      {
         this.morePlaysPan = new BangMPlayerPan();
         addChild(this.morePlaysPan);
         this.morePlaysPan.visible = false;
      }
      
      protected function tfMaskLinkHd(event:TextEvent) : void
      {
         BangCGMessage.CG_GET_BANG_LIST(1);
      }
      
      public function openShenShou() : void
      {
         UIManager.mainMenu.bangHandle();
         this.Button_ShenShou.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
      }
      
      private function cliHandle(e:MouseEvent) : void
      {
         var btn:TabButton = null;
         var linkTxt:String = null;
         var txtRep:String = null;
         if(GameUnitManager.hero.partyId == 0 && Model_bang.partyType == 0)
         {
            this.visible = false;
            return;
         }
         btn = e.target as TabButton;
         if(this.now == btn)
         {
            return;
         }
         if(Boolean(this.now))
         {
            this.now.choose = false;
         }
         btn.choose = true;
         this.now = btn;
         this.bang_info.visible = false;
         this.bang_members.visible = false;
         this.bang_members.role_name = "";
         this.bang_map.visible = false;
         this.bang_zhanfa.visible = false;
         this.bangInerList.visible = false;
         this.bangShenShou.visible = false;
         if(Boolean(this.morePlaysPan))
         {
            this.morePlaysPan.visible = false;
         }
         this.bmMask.x = 29;
         this.bmMask.y = 69;
         this.bmMask.visible = false;
         this._tfMask.htmlText = "";
         addChild(this.bmMask);
         addChild(this._tfMask);
         linkTxt = HtmlUtil.createLink("<font color=\'#ff3333\'>查看帮会列表</font>");
         txtRep = "<font size=\'14\'>功能开启条件：<font color=\'#ffff33\'>加入玩家创建的帮会（{0}）</font></font>";
         if(btn.text == LangConfig.getWord("22713",2))
         {
            BangCGMessage.CG_BANG_PAGE_SEARCH(1,"","",1);
            this.bang_info.visible = true;
         }
         else if(btn.text == LangConfig.getWord("22712",2))
         {
            BangCGMessage.CG_BANG_CHECK_SELF(2,1);
            this.bang_members.visible = true;
         }
         else if(btn.text == LangConfig.getWord("22711",2))
         {
            if(Model_bang.partyType == 0)
            {
               BangCGMessage.CG_BANG_CHECK_SELF(3,0);
               this.bang_map.visible = true;
            }
            else
            {
               this.bmMask.visible = true;
               this.bmMask.load("resource/image/bang/jianzuMask.jpg");
               this._tfMask.htmlText = LangConfig.reTxt(txtRep,linkTxt);
            }
         }
         else if(btn.text == LangConfig.getWord("22710",2))
         {
            if(Model_bang.partyType == 0)
            {
               this.bang_zhanfa.visible = true;
               this.bang_zhanfa.resetChoose1();
               BangCGMessage.CG_BANG_CHECK_SELF(4,0);
            }
            else
            {
               this.bmMask.visible = true;
               this.bmMask.load("resource/image/bang/zhenFaMask.jpg");
               this._tfMask.htmlText = LangConfig.reTxt(txtRep,linkTxt);
            }
         }
         else if(btn.text == LangConfig.getWord("22714",2))
         {
            this.bangInerList.visible = true;
            BangCGMessage.CG_GET_BANG_LIST(1);
         }
         else if(btn.text == LangConfig.getWord("30015",3))
         {
            if(Boolean(this.eff))
            {
               EffectManager.removeEffect(this.eff);
            }
            if(Model_bang.partyType == 0)
            {
               this.bangShenShou.visible = true;
            }
            else
            {
               this.bmMask.visible = true;
               this.bmMask.load("resource/image/bang/shenShouMask.jpg");
               this._tfMask.htmlText = LangConfig.reTxt(txtRep,linkTxt);
            }
         }
         else if(btn.text == "更多玩法")
         {
            if(Boolean(this.morePlaysPan))
            {
               this.morePlaysPan.visible = true;
            }
         }
      }
      
      public function showShenShou() : void
      {
         if(Boolean(this.eff))
         {
            EffectManager.removeEffect(this.eff);
         }
         if(!this.visible)
         {
            this.visible = true;
         }
         this.Button_ShenShou.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
      }
      
      private function initTl() : void
      {
         this.tmp = ComponentUtil.getBitmap("Title_Bang",this,{
            "x":267,
            "y":5
         },Global.Bang_Imgsdm);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!isInitBangSf)
            {
               SingleLoader.add("lang/ch/Bang_Imgs.swf",function(info:Object):void
               {
                  Global.Bang_Imgsdm = info.applicationDomain;
                  isInitBangSf = true;
                  initTl();
                  addNewUnit_morePlays();
               });
            }
            if(this.isFirstOpen)
            {
               this.isFirstOpen = false;
               bind_target = Enum_explor.bind(Enum_explor.BTN_PARTY);
            }
            ShenshouCGMessage.CG_SHEN_SHOU();
            this.Button_Informat.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
         else
         {
            if(Boolean(this.eff))
            {
               EffectManager.removeEffect(this.eff);
            }
            BangCGMessage.CG_CLOSE_PARTY();
            if(Boolean(this.now))
            {
               this.now.choose = false;
            }
            this.now = null;
         }
      }
      
      public function set BeastButEffter(vo:Vo_shenshou) : void
      {
         var dir:String = null;
         var px:Number = NaN;
         var py:Number = NaN;
         var _x:Number = NaN;
         var _y:Number = NaN;
         if(this.bangShenShou.visible)
         {
            return;
         }
         if(Boolean(this.eff))
         {
            EffectManager.removeEffect(this.eff);
         }
         if(!visible)
         {
            return;
         }
         if(vo.challBoo == 3 || vo.feedState == 1)
         {
            dir = "35075";
            px = 35;
            py = 11;
            _x = this.Button_ShenShou.x;
            _y = this.Button_ShenShou.y;
            this.eff = EffectManager.addEffect(dir,this,1000,_x + px,_y + py,true);
         }
         else if(Boolean(this.eff))
         {
            EffectManager.removeEffect(this.eff);
         }
      }
      
      private function cloHandle(e:MouseEvent) : void
      {
         this.reset();
         BangCGMessage.CG_CLOSE_PARTY();
      }
      
      public function reset() : void
      {
         this.Button_Building.choose = false;
         this.Button_Member.choose = false;
         this.Button_ZhenFa.choose = false;
         this.Button_BangList.choose = false;
         this.bang_members.visible = false;
         this.bang_members.role_name = "";
         this.bang_map.visible = false;
         this.bang_zhanfa.visible = false;
         this.bangInerList.visible = false;
         this.bang_info.visible = true;
         this.Button_Informat.choose = true;
         this.now = this.Button_Informat;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

import com.ui.controls.Button;
import com.ui.controls.ComboBox;
import com.ui.controls.MyTextField;
import com.ui.controls.ScaleBitmap;
import com.utils.ComponentUtil;
import com.utils.DateUtil;
import com.utils.Util;
import com.yiTian.Global;
import com.yiTian.command.Enum_MsgType;
import com.yiTian.data.Data_lib;
import com.yiTian.data.Enum_SPStr;
import com.yiTian.data.config.Enum_job;
import com.yiTian.data.model.Model_bag;
import com.yiTian.data.model.Model_bang;
import com.yiTian.data.model.Model_shenshou;
import com.yiTian.data.model.Model_shop;
import com.yiTian.data.vo.Vo_bangMem;
import com.yiTian.data.vo.Vo_partyInfo;
import com.yiTian.manager.GameUnitManager;
import com.yiTian.manager.LangConfig;
import com.yiTian.manager.SceneConfig;
import com.yiTian.manager.TipManager;
import com.yiTian.manager.UIManager;
import com.yiTian.net.message.cg.BangCGMessage;
import com.yiTian.utils.HtmlUtil;
import com.yiTian.utils.SingleLoader;
import com.yiTian.view.modules.banhui.View_bangJoin;
import com.yiTian.view.modules.banhui.View_bangMemberItems;
import com.yiTian.view.modules.banhui.View_bang_ZhenFa_Items;
import com.yiTian.view.modules.banhui.View_banghuiBack;
import com.yiTian.view.modules.banhui.bBindQQGroup.BindPan;
import com.yiTian.view.modules.chat.EffecObj;
import com.yiTian.view.modules.mainMenu.View_MainMenu;
import com.yiTian.view.modules.qqPackage.QQGroupStaticFunctions;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.FocusEvent;
import flash.events.MouseEvent;
import flash.net.URLRequest;
import flash.net.navigateToURL;
import flash.text.TextFieldAutoSize;
import flash.text.TextFieldType;

class BangHuiInfo extends Sprite
{
   
   private static var btnEff:Boolean = false;
   
   private var Button_XGXuanYan:Button;
   
   private var Button_XGGongGao:Button;
   
   private var Button_leave:Button;
   
   private var Button_ShiJian:Button;
   
   private var Button_TanHe:Button;
   
   private var Button_Invite:Button;
   
   private var Button_InviteLt:Button;
   
   private var Button_FuLi:Button;
   
   private var Button_YYChange:Button;
   
   private var Button_QQChange:Button;
   
   private var BangName_text:MyTextField;
   
   private var BZName_text:MyTextField;
   
   private var Lever_text:MyTextField;
   
   private var Rank_text:MyTextField;
   
   private var Member_text:MyTextField;
   
   private var CaiFu_text:MyTextField;
   
   private var WHFeiYong_text:MyTextField;
   
   private var QQ_text:MyTextField;
   
   private var YYPinDao_text:MyTextField;
   
   private var QQGroup_text:MyTextField;
   
   private var GongGao_text:MyTextField;
   
   private var Post_text:MyTextField;
   
   private var FuLi_text:MyTextField;
   
   private var GRGongXian_text:MyTextField;
   
   private var XuanYan_text:MyTextField;
   
   private var enterGarDen:Button;
   
   private var Button_Recruit:Button;
   
   private var btnQQGroupState:int = -1;
   
   private var tfVecUp:Vector.<MyTextField> = new Vector.<MyTextField>();
   
   private var tfVecDown:Vector.<MyTextField> = new Vector.<MyTextField>();
   
   private var tfVecRight:Vector.<MyTextField> = new Vector.<MyTextField>();
   
   private var exBmpVec:Vector.<ExtendBmp> = new Vector.<ExtendBmp>();
   
   private var tmp:Bitmap;
   
   private var sourceArr:Array = ["Icon_FuLi","Icon_Grone","Icon_tree","Icon_Store"];
   
   private var _lastQQBtnClickTime:int;
   
   private var _ggStr:String;
   
   private var _xyStr:String;
   
   public var partyId:Number;
   
   public function BangHuiInfo()
   {
      super();
      this.init();
   }
   
   public function init() : void
   {
      var i:int = 0;
      var WHFY_tipSp:Sprite = null;
      var extendbmp:ExtendBmp = null;
      var back:ScaleBitmap = ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
         "x":33,
         "y":71,
         "width":235,
         "height":270
      },Global.Img_Cdm);
      i = 0;
      while(i < 9)
      {
         if(i == 7)
         {
            this.tfVecUp.push(ComponentUtil.getTextField("QT频道  :",this,{
               "x":41,
               "y":86 + 27 * i,
               "color":16773818
            }));
         }
         else if(i != 8)
         {
            this.tfVecUp.push(ComponentUtil.getTextField(LangConfig.getWord((29294 + i).toString(),2),this,{
               "x":40,
               "y":86 + 27 * i,
               "color":16773818
            }));
         }
         else
         {
            this.tfVecUp.push(ComponentUtil.getTextField(LangConfig.getWord((29294 + i).toString(),2),this,{
               "x":41,
               "y":86 + 27 * i,
               "color":16773818
            }));
         }
         i++;
      }
      ComponentUtil.getTextField("成员招募",this,{
         "x":181,
         "y":86,
         "color":3407667
      });
      var back2:ScaleBitmap = ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
         "x":107,
         "y":275,
         "width":100,
         "height":20
      },Global.Img_Cdm);
      var back3:ScaleBitmap = ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
         "x":107,
         "y":302,
         "width":100,
         "height":20
      },Global.Img_Cdm);
      var back4:ScaleBitmap = ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
         "x":33,
         "y":346,
         "width":235,
         "height":97
      },Global.Img_Cdm);
      var back5:ScaleBitmap = ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
         "x":34,
         "y":347,
         "width":233,
         "height":20
      },Global.Img_Cdm);
      var back6:ScaleBitmap = ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
         "x":273,
         "y":71,
         "width":422,
         "height":100
      },Global.Img_Cdm);
      var back7:ScaleBitmap = ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
         "x":273,
         "y":176,
         "width":422,
         "height":100
      },Global.Img_Cdm);
      var back8:ScaleBitmap = ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
         "x":273,
         "y":281,
         "width":422,
         "height":127
      },Global.Img_Cdm);
      var back9:ScaleBitmap = ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
         "x":274,
         "y":72,
         "width":420,
         "height":20
      },Global.Img_Cdm);
      var back10:ScaleBitmap = ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
         "x":274,
         "y":177,
         "width":420,
         "height":20
      },Global.Img_Cdm);
      var back11:ScaleBitmap = ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
         "x":274,
         "y":282,
         "width":420,
         "height":20
      },Global.Img_Cdm);
      i = 0;
      while(i < 2)
      {
         this.tfVecDown.push(ComponentUtil.getTextField(LangConfig.getWord((29303 + i).toString(),2),this,{
            "x":40,
            "y":(i == 0 ? 347 : 380 + (i - 1) * 28),
            "color":(i == 0 ? 16764206 : 16773818)
         }));
         i++;
      }
      this.tfVecDown.push(ComponentUtil.getTextField("个人贡献：",this,{
         "x":40,
         "y":408,
         "color":16773818
      }));
      i = 0;
      while(i < 3)
      {
         this.tfVecRight.push(ComponentUtil.getTextField(LangConfig.getWord((29306 + i).toString(),2),this,{
            "x":450,
            "y":72 + i * 105,
            "color":16764206
         }));
         i++;
      }
      this.Button_XGXuanYan = ComponentUtil.getButton(LangConfig.getWord("50027",5),"ChannelButtonFive",this,{
         "x":611.85,
         "y":77
      },ComponentUtil.domain);
      this.Button_XGGongGao = ComponentUtil.getButton(LangConfig.getWord("50028",5),"ChannelButtonFive",this,{
         "x":611.85,
         "y":175
      },ComponentUtil.domain);
      this.Button_XGGongGao.visible = false;
      this.Button_XGXuanYan.visible = false;
      var tfExPlain:MyTextField = ComponentUtil.getTextField(LangConfig.getWord("29309",2),this,{
         "x":289,
         "y":309,
         "color":14662240,
         "size":12,
         "leading":0
      });
      this.enterGarDen = ComponentUtil.getButton(LangConfig.getWord("22717",2),"Button_Orange",this,{
         "x":593,
         "y":308,
         "textColor":16184781
      },Global.Img_Cdm);
      this.Button_InviteLt = ComponentUtil.getButton(LangConfig.getWord("22722",2),"Button_Four",this,{
         "x":285,
         "y":415,
         "textColor":16184781
      },Global.Img_Cdm);
      this.Button_Invite = ComponentUtil.getButton(LangConfig.getWord("22721",2),"Button_Four",this,{
         "x":366,
         "y":415,
         "textColor":16184781
      },Global.Img_Cdm);
      this.Button_TanHe = ComponentUtil.getButton(LangConfig.getWord("22720",2),"Button_Four",this,{
         "x":447,
         "y":415,
         "textColor":16184781
      },Global.Img_Cdm);
      this.Button_ShiJian = ComponentUtil.getButton(LangConfig.getWord("22719",2),"Button_Four",this,{
         "x":528,
         "y":415,
         "textColor":16184781
      },Global.Img_Cdm);
      this.Button_leave = ComponentUtil.getButton(LangConfig.getWord("22718",2),"Button_Four",this,{
         "x":609,
         "y":415,
         "textColor":16184781
      },Global.Img_Cdm);
      this.Button_FuLi = ComponentUtil.getButton(LangConfig.getWord("22723",2),"Button_TiliteFour",this,{
         "x":222.15,
         "y":407.95,
         "textColor":16383744
      },ComponentUtil.domain);
      this.Button_FuLi.visible = false;
      this.Button_YYChange = ComponentUtil.getButton(LangConfig.getWord("29033",2),"Button_Two",this,{
         "x":209,
         "y":273,
         "textColor":16184781
      },Global.Img_Cdm);
      this.Button_QQChange = ComponentUtil.getButton("","Button_Two",this,{
         "x":209,
         "y":300,
         "textColor":16184781
      },Global.Img_Cdm);
      this.BangName_text = ComponentUtil.getTextField("",this,{
         "x":107,
         "y":86
      });
      this.BZName_text = ComponentUtil.getTextField("",this,{
         "x":107,
         "y":113
      });
      this.Lever_text = ComponentUtil.getTextField("",this,{
         "x":107,
         "y":140
      });
      this.Rank_text = ComponentUtil.getTextField("",this,{
         "x":107,
         "y":167
      });
      this.Member_text = ComponentUtil.getTextField("",this,{
         "x":107,
         "y":194
      });
      this.CaiFu_text = ComponentUtil.getTextField("",this,{
         "x":107,
         "y":221
      });
      this.WHFeiYong_text = ComponentUtil.getTextField("",this,{
         "x":107,
         "y":248
      });
      this.YYPinDao_text = ComponentUtil.getTextField("",this,{
         "x":109,
         "y":275,
         "realWidth":98,
         "realHeight":20,
         "maxChars":11
      });
      this.QQGroup_text = ComponentUtil.getTextField("",this,{
         "x":109,
         "y":302
      });
      this.QQ_text = ComponentUtil.getTextField("",this,{
         "x":109,
         "y":302,
         "realWidth":98,
         "realHeight":20,
         "maxChars":11
      });
      WHFY_tipSp = new Sprite();
      WHFY_tipSp.graphics.beginFill(16777215,0);
      WHFY_tipSp.graphics.drawRect(0,0,70,18);
      WHFY_tipSp.x = 20;
      WHFY_tipSp.y = 245.1;
      TipManager.bind(WHFY_tipSp,LangConfig.getWord("22725",2));
      addChild(WHFY_tipSp);
      var BHCH_tipSp:Sprite = new Sprite();
      BHCH_tipSp.graphics.beginFill(16777215,0);
      BHCH_tipSp.graphics.drawRect(0,0,70,18);
      BHCH_tipSp.x = 20;
      BHCH_tipSp.y = 216.25;
      TipManager.bind(BHCH_tipSp,LangConfig.getWord("29266",2));
      addChild(BHCH_tipSp);
      this.YYPinDao_text.restrict = "0-9";
      this.QQ_text.restrict = "0-9";
      this.QQ_text.name = "qq";
      this.QQ_text.maxChars = 9;
      this.YYPinDao_text.name = "yy";
      this.Button_YYChange.callBack = this.yyChangeHandle;
      this.Button_QQChange.callBack = this.qqChangeHandle;
      this.Post_text = ComponentUtil.getTextField("",this,{
         "x":112,
         "y":380,
         "size":12,
         "leading":0
      });
      this.GRGongXian_text = ComponentUtil.getTextField("",this,{
         "x":112,
         "y":408,
         "size":12,
         "leading":0
      });
      this.XuanYan_text = ComponentUtil.getTextField(LangConfig.getWord("22726",2),this,{
         "x":284,
         "y":97,
         "color":16773818,
         "realHeight":72,
         "realWidth":410,
         "multiline":true,
         "wordWrap":true,
         "maxChars":80,
         "leading":2
      });
      this.GongGao_text = ComponentUtil.getTextField(LangConfig.getWord("22728",2),this,{
         "x":285,
         "y":202,
         "color":16773818,
         "realHeight":72,
         "realWidth":410,
         "multiline":true,
         "wordWrap":true,
         "maxChars":80,
         "leading":2
      });
      this.FuLi_text = ComponentUtil.getTextField("",this,{
         "x":93.85,
         "y":407
      });
      this.FuLi_text.visible = false;
      this.GongGao_text.name = "gonggao";
      this.XuanYan_text.name = "xuanyan";
      this.Button_Invite.callBack = this.invideHandle;
      this.Button_FuLi.callBack = this.getFuliHandle;
      this.Button_ShiJian.callBack = this.eventHandle;
      this.Button_leave.callBack = this.leaveHandle;
      this.Button_TanHe.callBack = this.tanHeHandle;
      this.Button_InviteLt.callBack = this.joinHeHandle;
      var j:int = 0;
      while(j < 4)
      {
         extendbmp = new ExtendBmp(this.sourceArr[j],j + 1,this.partyId);
         extendbmp.x = 305 + 98 * j;
         extendbmp.y = 340;
         addChild(extendbmp);
         this.exBmpVec.push(extendbmp);
         j++;
      }
      this.enterGarDen.callBack = this.enterGarden;
      this.Button_InviteLt.LabelResize(10,3);
      this.Button_Invite.LabelResize(10,3);
      this.Button_TanHe.LabelResize(10,3);
      this.Button_ShiJian.LabelResize(10,3);
      this.Button_leave.LabelResize(10,3);
      this.enterGarDen.LabelResize(10,3);
   }
   
   private function joinHeHandle(e:MouseEvent) : void
   {
      if(btnEff)
      {
         EffecObj.removeEffect(this.Button_InviteLt);
      }
      UIManager.bangJoinList.visible = !UIManager.bangJoinList.visible;
   }
   
   private function enterGarden(e:MouseEvent) : void
   {
      if(SceneConfig.getSceneType() != SceneConfig.COMMON)
      {
         UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10379",1) + "</font>");
         return;
      }
      if(Boolean(GameUnitManager.hero.paoBiao))
      {
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("990",0));
         return;
      }
      if(SceneConfig.getSceneType() == SceneConfig.BANGPLANT)
      {
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("29310",2));
         return;
      }
      BangCGMessage.CG_BANG_ENTER_PLANT();
   }
   
   private function tanHeHandle(e:MouseEvent) : void
   {
      BangCGMessage.CG_BANG_RIGHT(2);
   }
   
   private function yyChangeHandle(e:MouseEvent) : void
   {
      if(this.YYPinDao_text.text == "帮会QT频道" || this.YYPinDao_text.text == "")
      {
         UIManager.centerBroadcast.addMsg("帮主暂时还没设置QT频道");
         return;
      }
      var id:int = parseInt(this.YYPinDao_text.text);
      if(Boolean(id))
      {
         navigateToURL(new URLRequest("http://qt.qq.com/go.html?roomid=" + id.toString() + "&iGameID=536023512&iRoomType=1"));
      }
   }
   
   private function qqChangeHandle(e:MouseEvent) : void
   {
      var now:int;
      if(this.btnQQGroupState == 1)
      {
         if(Global.pf == Enum_SPStr.QZONE)
         {
            if(BindPan.instance.visible == false)
            {
               BangCGMessage.CG_ASK_HANDLE_QQGROUP();
            }
            else
            {
               BindPan.instance.visible = false;
            }
         }
         else
         {
            UIManager.centerBroadcast.addMsg("只有空间开放该功能");
         }
      }
      else if(this.btnQQGroupState == 2)
      {
         if(Global.pf == Enum_SPStr.QZONE)
         {
            if(Model_bang.bangQQGroupOpenId != "" && Model_bang.bangQQGroupOpenId != null)
            {
               QQGroupStaticFunctions.addQQGroup(Model_bang.bangQQGroupUnionId,GameUnitManager.hero.name,Model_bang.bangQQGroupOpenId);
            }
            else
            {
               UIManager.centerBroadcast.addMsg("帮会未绑定QQ群");
            }
         }
         else
         {
            UIManager.centerBroadcast.addMsg("只有空间开放该功能");
         }
      }
   }
   
   private function XYChangeHandle(e:MouseEvent) : void
   {
      BangCGMessage.CG_BANG_CHANGED_ANNOUNCEMENT(3,this.partyId,this.XuanYan_text.text);
   }
   
   private function GGChangeHandle(e:MouseEvent) : void
   {
      BangCGMessage.CG_BANG_CHANGED_ANNOUNCEMENT(4,this.partyId,this.GongGao_text.text);
   }
   
   private function eventHandle(e:MouseEvent) : void
   {
      BangCGMessage.CG_BANG_EVENT_CHECK(this.partyId,1);
   }
   
   private function getFuliHandle(e:MouseEvent = null) : void
   {
      if(GameUnitManager.hero.vigor >= 1500)
      {
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("22733",2));
         return;
      }
      if(!UIManager.bang_prompt.visible)
      {
         UIManager.bang_prompt.visible = true;
      }
      UIManager.bang_prompt.updateText(2);
      UIManager.bang_prompt.partyId = this.partyId;
      UIManager.bang_prompt.parent.setChildIndex(UIManager.bang_prompt,UIManager.bang_prompt.parent.numChildren - 1);
   }
   
   private function leaveHandle(e:MouseEvent) : void
   {
      if(Model_bag.pwdLockState == Model_bag.PWD_STATE_LOCK_T && Model_bang.partyType != Model_bang.PARTY_TYPE_NEWS)
      {
         UIManager.bagPwdPutIn.visible = true;
         return;
      }
      var st:int = SceneConfig.getSceneType();
      if(st == SceneConfig.BZ_BATTLE || st == SceneConfig.BZ_READY)
      {
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("22734",2));
         return;
      }
      if(Model_shenshou.challBoo == 3)
      {
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("30077",3));
         return;
      }
      if(!UIManager.bang_prompt.visible)
      {
         UIManager.bang_prompt.visible = true;
      }
      UIManager.bang_prompt.updateText(3);
      UIManager.bang_prompt.partyId = this.partyId;
      UIManager.bang_prompt.parent.setChildIndex(UIManager.bang_prompt,UIManager.bang_prompt.parent.numChildren - 1);
   }
   
   private function party_right_offer(_pos:int) : void
   {
      if(_pos == Model_bang.LEADER || _pos == Model_bang.FU_LEADER || _pos == Model_bang.ZHANGLAO)
      {
         this.Button_Invite.enabled = true;
         this.Button_Invite.useHandCursor = true;
      }
      else
      {
         this.Button_Invite.enabled = false;
         this.Button_Invite.useHandCursor = false;
      }
   }
   
   public function update_party_ui_info(data_arr:Array) : void
   {
      this.partyId = data_arr[0];
      this.BangName_text.text = data_arr[1];
      this.BZName_text.text = data_arr[2];
      this.Lever_text.text = String(data_arr[3]);
      this.Rank_text.text = String(data_arr[4]);
      this.Member_text.text = String(data_arr[5]) + "/" + String(data_arr[6]);
      this.CaiFu_text.text = String(data_arr[7]);
      this.YYPinDao_text.text = data_arr[8];
      this.QQ_text.text = data_arr[9];
      Model_bang.bangHuiID = this.partyId;
      this.WHFeiYong_text.text = data_arr[12];
   }
   
   public function update_self_info(data_arr:Array) : void
   {
      this.Post_text.text = Model_bang.position_arr[data_arr[0]];
      this.GRGongXian_text.text = String(data_arr[1]) + "/" + String(data_arr[2]);
      this.FuLi_text.text = String(data_arr[3]) + LangConfig.getWord("22735",2);
   }
   
   public function updateByModel() : void
   {
      var pos:int = 0;
      if(Boolean(Model_bang.partyInfo))
      {
         pos = Model_bang.partyInfo.party_position;
         if(Model_bang.partyType == 0)
         {
            this.Button_TanHe.enabled = pos != 1;
            this.Button_Invite.enabled = Boolean(this.Button_Invite.enabled) || true;
            this.Button_InviteLt.enabled = Boolean(this.Button_InviteLt.enabled) || true;
            this.Button_QQChange.enabled = Boolean(this.Button_QQChange.enabled) || true;
            this.Button_YYChange.enabled = Boolean(this.Button_YYChange.enabled) || true;
            this.enterGarDen.enabled = true;
            this.exBmpVec[1].enabled = true;
            TipManager.unBind(this.exBmpVec[1]);
            this.XuanYan_text.text = Model_bang.partyInfo.party_declaration;
            this.GongGao_text.text = Model_bang.partyInfo.party_announce;
            if(Boolean(this.Button_Recruit))
            {
               this.Button_Recruit.enabled = true;
            }
         }
         else
         {
            if(btnEff == true)
            {
               EffecObj.removeEffect(this.Button_InviteLt);
               btnEff = false;
            }
            this.Button_Invite.enabled = false;
            this.XuanYan_text.htmlText = "倚天新手之家可以让新手玩家体验帮会部分玩法";
            this.GongGao_text.htmlText = "1.新手之家可以领取帮派福利，帮会摇钱、帮会商店购买道具<br>2.玩家创建的帮派可以体验挑战帮派神兽、帮派战、学习帮派阵法、帮派种植等玩法";
            this.Button_TanHe.enabled = false;
            this.Button_Invite.enabled = false;
            this.Button_InviteLt.enabled = false;
            this.enterGarDen.enabled = false;
            this.Button_QQChange.enabled = false;
            this.Button_YYChange.enabled = false;
            this.exBmpVec[1].enabled = false;
            TipManager.bind(this.exBmpVec[1],"<font color=\'#ff3333\'>公共帮会无法参与果园活动</font>");
            if(Boolean(this.Button_Recruit))
            {
               this.Button_Recruit.enabled = false;
            }
         }
         if(pos == 1)
         {
            this.Button_QQChange.label = "操作";
            this.btnQQGroupState = 1;
         }
         else
         {
            this.Button_QQChange.label = "申请";
            this.btnQQGroupState = 2;
            if(Model_bang.bangQQGroupOpenId != "" && Model_bang.bangQQGroupOpenId != null)
            {
               this.Button_QQChange.enabled = true;
            }
            else
            {
               this.Button_QQChange.enabled = false;
            }
         }
      }
   }
   
   override public function set visible(value:Boolean) : void
   {
      var item:ExtendBmp = null;
      super.visible = value;
      if(value)
      {
         if(!View_banghuiBack.isInitBangSf)
         {
            SingleLoader.add("lang/ch/Bang_Imgs.swf",function(info:Object):void
            {
               var item:ExtendBmp = null;
               Global.Bang_Imgsdm = info.applicationDomain;
               Button_Recruit = ComponentUtil.getButton("","Button_Recruit",UIManager.banghuiBack.bang_info,{
                  "x":235,
                  "y":83,
                  "callBack":recruitClickHd
               },Global.Bang_Imgsdm);
               if(Boolean(Model_bang.partyInfo))
               {
                  Button_Recruit.enabled = Model_bang.partyType != 1;
               }
               View_banghuiBack.isInitBangSf = true;
               for each(item in exBmpVec)
               {
                  item.init();
               }
            });
         }
         else
         {
            for each(item in this.exBmpVec)
            {
               item.init();
            }
         }
         if(Boolean(View_bangJoin.dataArr.length))
         {
            btnEff = true;
            EffecObj.getEffec(this.Button_InviteLt);
         }
         this.updateByModel();
         if(View_MainMenu.isLightResult == 3)
         {
            this.Button_InviteLt.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
   }
   
   public function update(vo_party:Vo_partyInfo, arr:Array) : void
   {
      this.reset_btn_data();
      this.partyId = vo_party.party_id;
      Model_bang.partyInfo = vo_party;
      this.BangName_text.text = vo_party.party_name;
      this.BZName_text.text = vo_party.leader_name;
      this.Lever_text.text = String(vo_party.party_lvl);
      this.Rank_text.text = String(vo_party.party_paiming);
      this.Member_text.text = String(vo_party.party_mem_num) + "/" + String(vo_party.party_mem_num_lim);
      this.CaiFu_text.text = String(vo_party.party_forturn);
      this.YYPinDao_text.text = vo_party.party_voice_channel;
      this.QQ_text.text = vo_party.party_qq;
      this.WHFeiYong_text.text = vo_party.party_weihu_cost.toString();
      this.Post_text.text = Model_bang.position_arr[vo_party.party_position];
      UIManager.banghuiBack.bang_members._position = vo_party.party_position;
      this.GRGongXian_text.text = String(vo_party.party_self_gong) + "/" + String(vo_party.party_gong);
      this.FuLi_text.text = String(vo_party.party_benefit) + LangConfig.getWord("22735",2);
      var pos:int = vo_party.party_position;
      if(this.YYPinDao_text.text == "")
      {
         this.YYPinDao_text.text = "帮会QT频道";
      }
      if(this.QQ_text.text == "")
      {
         this.QQ_text.text = LangConfig.getWord("22731",2);
      }
      if(this.GongGao_text.text == "")
      {
         this.GongGao_text.text = LangConfig.getWord("22736",2);
      }
      if(this.XuanYan_text.text == "")
      {
         this.XuanYan_text.text = LangConfig.getWord("22737",2);
      }
      if(vo_party.party_position <= Model_bang.LEADER)
      {
         if(Model_bang.isBindQQGroup == 0)
         {
            this.QQ_text.type = TextFieldType.INPUT;
         }
         else if(Model_bang.isBindQQGroup == 1)
         {
            this.QQ_text.type = TextFieldType.DYNAMIC;
         }
         this.QQ_text.addEventListener(FocusEvent.FOCUS_OUT,this.f_outHandle);
         this.QQ_text.addEventListener(FocusEvent.FOCUS_IN,this.downHandle);
      }
      else
      {
         this.QQ_text.type = TextFieldType.DYNAMIC;
      }
      if(vo_party.party_position <= Model_bang.FU_LEADER)
      {
         this.Button_XGXuanYan.useHandCursor = true;
         this.Button_XGXuanYan.enabled = true;
         this.Button_XGGongGao.useHandCursor = true;
         this.Button_XGGongGao.enabled = true;
         this.YYPinDao_text.type = TextFieldType.INPUT;
         this.GongGao_text.type = TextFieldType.INPUT;
         this.XuanYan_text.type = TextFieldType.INPUT;
         this.XuanYan_text.addEventListener(FocusEvent.FOCUS_IN,this.downHandle);
         this.GongGao_text.addEventListener(FocusEvent.FOCUS_IN,this.downHandle);
         this.YYPinDao_text.addEventListener(FocusEvent.FOCUS_IN,this.downHandle);
         this.XuanYan_text.addEventListener(FocusEvent.FOCUS_OUT,this.f_outHandle);
         this.GongGao_text.addEventListener(FocusEvent.FOCUS_OUT,this.f_outHandle);
         this.YYPinDao_text.addEventListener(FocusEvent.FOCUS_OUT,this.f_outHandle);
      }
      else
      {
         this.YYPinDao_text.type = TextFieldType.DYNAMIC;
         this.GongGao_text.type = TextFieldType.DYNAMIC;
         this.XuanYan_text.type = TextFieldType.DYNAMIC;
      }
   }
   
   private function reset_btn_data() : void
   {
      this.Button_XGXuanYan.enabled = false;
      this.Button_XGGongGao.enabled = false;
   }
   
   private function downHandle(e:FocusEvent) : void
   {
      var tf:MyTextField = e.target as MyTextField;
      if(tf.name == "qq")
      {
         if(tf.text == LangConfig.getWord("22731",2))
         {
            tf.text = "";
         }
      }
      else if(tf.name == "yy")
      {
         if(tf.text == "帮会QT频道")
         {
            tf.text = "";
         }
      }
      else if(tf.name == "gonggao")
      {
         if(tf.text == LangConfig.getWord("22736",2))
         {
            tf.text = "";
         }
         this._xyStr = tf.text;
      }
      else if(tf.name == "xuanyan")
      {
         if(tf.text == LangConfig.getWord("22737",2))
         {
            tf.text = "";
         }
         this._ggStr = tf.text;
      }
   }
   
   private function recruitClickHd(e:MouseEvent) : void
   {
      BangCGMessage.TRY_JIANGHU_INVITE();
   }
   
   private function f_outHandle(e:FocusEvent) : void
   {
      var tf:MyTextField = e.target as MyTextField;
      if(tf.name == "qq")
      {
         if(tf.text == "")
         {
            tf.text = LangConfig.getWord("22731",2);
         }
         else
         {
            BangCGMessage.CG_BANG_CHANGED_ANNOUNCEMENT(2,this.partyId,this.QQ_text.text);
         }
      }
      else if(tf.name == "yy")
      {
         if(tf.text == "")
         {
            tf.text = "帮会QT频道";
         }
         else
         {
            BangCGMessage.CG_BANG_CHANGED_ANNOUNCEMENT(1,this.partyId,this.YYPinDao_text.text);
         }
      }
      else if(tf.name == "gonggao")
      {
         if(tf.text == "")
         {
            tf.text = LangConfig.getWord("22736",2);
         }
         if(this._xyStr != tf.text)
         {
            BangCGMessage.CG_BANG_CHANGED_ANNOUNCEMENT(4,this.partyId,tf.text);
         }
      }
      else if(tf.name == "xuanyan")
      {
         if(tf.text == "")
         {
            tf.text = LangConfig.getWord("22737",2);
         }
         if(this._ggStr != tf.text)
         {
            BangCGMessage.CG_BANG_CHANGED_ANNOUNCEMENT(3,this.partyId,tf.text);
         }
      }
   }
   
   public function invideHandle(e:MouseEvent) : void
   {
      if(Model_shenshou.challBoo == 3)
      {
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("30077",3));
         return;
      }
      if(!UIManager.invide_bang.visible)
      {
         UIManager.invide_bang.visible = true;
      }
      UIManager.invide_bang.partyId = this.partyId;
      UIManager.invide_bang.parent.setChildIndex(UIManager.invide_bang,UIManager.invide_bang.parent.numChildren - 1);
   }
}

class BangMembers extends Sprite
{
   
   private var Button_PageUp:Button;
   
   private var Button_PageDown:Button;
   
   private var Button_KaiChu:Button;
   
   private var Button_TuiWei:Button;
   
   private var Button_RenMing:Button;
   
   private var Button_ChanRang:Button;
   
   private var Page_text:MyTextField;
   
   public var bang_mem_item:View_bangMemberItems;
   
   public var item_arr:Array = [];
   
   private var posArr:Array = [64,155,234,314,381,478,613];
   
   public var _cur_page:int = 1;
   
   public var _total_page:int = 10;
   
   public var pos:int;
   
   public var roleId:Number = 0;
   
   public var role_name:String = "";
   
   private var nowItem:View_bangMemberItems;
   
   public var position_arr:Array = [];
   
   public var ChanRang_combobox:ComboBox;
   
   public var send_position:int;
   
   public var _position:int;
   
   public function BangMembers()
   {
      super();
      this.init();
   }
   
   public function init() : void
   {
      var back1:ScaleBitmap = ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
         "x":33,
         "y":71,
         "width":662,
         "height":342
      },Global.Img_Cdm);
      var back2:ScaleBitmap = ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
         "x":34,
         "y":72,
         "width":660,
         "height":20
      },Global.Img_Cdm);
      var back3:ScaleBitmap = ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
         "x":341,
         "y":386,
         "width":56,
         "height":20
      },Global.Img_Cdm);
      var back4:ScaleBitmap = ComponentUtil.getScaleBitmap("Back_Floating",[8,9,4,2],this,{
         "x":229,
         "y":419,
         "width":110,
         "height":24
      },Global.Img_Cdm);
      this.Button_PageDown = ComponentUtil.getButton("","Button_PageRight",this,{
         "x":397,
         "y":386,
         "textColor":16184781
      },Global.Img_Cdm);
      this.Button_PageUp = ComponentUtil.getButton("","Button_PageLeft",this,{
         "x":321,
         "y":386,
         "textColor":16184781
      },Global.Img_Cdm);
      this.Button_PageUp.name = "minus";
      this.Button_PageDown.name = "add";
      this.Button_ChanRang = ComponentUtil.getButton(LangConfig.getWord("22750",2),"Button_Four",this,{
         "x":43,
         "y":419,
         "textColor":16773818
      },Global.Img_Cdm);
      this.Button_RenMing = ComponentUtil.getButton(LangConfig.getWord("22751",2),"Button_Four",this,{
         "x":135,
         "y":419,
         "textColor":16184781
      },Global.Img_Cdm);
      this.Button_TuiWei = ComponentUtil.getButton(LangConfig.getWord("22752",2),"Button_Four",this,{
         "x":360,
         "y":419,
         "textColor":16184781
      },Global.Img_Cdm);
      this.Button_KaiChu = ComponentUtil.getButton(LangConfig.getWord("22753",2),"Button_Four",this,{
         "x":452,
         "y":419,
         "textColor":16184781
      },Global.Img_Cdm);
      this.Button_ChanRang.name = "4";
      this.Button_RenMing.name = "2";
      this.Button_TuiWei.name = "5";
      this.Button_KaiChu.name = "6";
      this.Button_ChanRang.callBack = this.leaderRightHandle;
      this.Button_RenMing.callBack = this.leaderRightHandle;
      this.Button_TuiWei.callBack = this.leaderRightHandle;
      this.Button_KaiChu.callBack = this.leaderRightHandle;
      this.Page_text = ComponentUtil.getTextField("00/00",this,{
         "x":350,
         "y":386,
         "color":11904647,
         "size":12,
         "leading":0,
         "realWidth":40
      });
      this.Page_text.autoSize = TextFieldAutoSize.CENTER;
      var i:int = 0;
      while(i < 7)
      {
         ComponentUtil.getTextField(LangConfig.getWord((29311 + i).toString(),2),this,{
            "x":this.posArr[i],
            "y":72
         });
         i++;
      }
      var j:int = 0;
      while(j < 10)
      {
         this.bang_mem_item = new View_bangMemberItems();
         addChild(this.bang_mem_item);
         this.bang_mem_item.x = 25.9;
         this.bang_mem_item.y = 103 + j * 28;
         this.bang_mem_item.addEventListener(MouseEvent.CLICK,this.cliHandle);
         this.item_arr.push(this.bang_mem_item);
         this.bang_mem_item.visible = false;
         this.bang_mem_item = null;
         j++;
      }
      this.Button_PageUp.addEventListener(MouseEvent.CLICK,this.pageChangedHandle);
      this.Button_PageDown.addEventListener(MouseEvent.CLICK,this.pageChangedHandle);
      this.addComboBox();
   }
   
   public function updateByModel() : void
   {
      if(!Model_bang.partyInfo)
      {
         return;
      }
      var pos:int = Model_bang.partyInfo.party_position;
      if(Boolean(Model_bang.partyInfo))
      {
         this.Button_ChanRang.enabled = pos <= Model_bang.LEADER;
         this.Button_KaiChu.enabled = pos <= Model_bang.FU_LEADER;
         this.Button_TuiWei.enabled = pos >= Model_bang.FU_LEADER && pos <= Model_bang.ZHANGLAO;
         this.Button_RenMing.enabled = pos <= Model_bang.FU_LEADER;
         this.updateCheckBox(pos);
      }
   }
   
   override public function set visible(value:Boolean) : void
   {
      if(value == true)
      {
         this.updateByModel();
      }
      if(Boolean(this.nowItem))
      {
         this.nowItem.select = false;
         this.nowItem = null;
      }
      super.visible = value;
   }
   
   public function pageChangedHandle(e:MouseEvent) : void
   {
      var _btn:Button = e.target as Button;
      if(_btn.name == "minus")
      {
         --this._cur_page;
         if(this._cur_page < 1)
         {
            this._cur_page = 1;
         }
      }
      else
      {
         ++this._cur_page;
         if(this._cur_page > this._total_page)
         {
            this._cur_page = this._total_page;
         }
      }
      BangCGMessage.CG_BANG_CHECK_SELF(2,this._cur_page);
   }
   
   private function leaderRightHandle(e:MouseEvent) : void
   {
      if(Model_shenshou.challBoo == 3)
      {
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("30077",3));
         return;
      }
      if(this.nowItem == null)
      {
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("22738",2));
         return;
      }
      trace("role name。。",this.role_name);
      var btn:Button = e.target as Button;
      if(btn.name == "4" || btn.name == "6" || btn.name == "2")
      {
         if(this.role_name == "")
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("22738",2));
            return;
         }
         if(this.roleId == GameUnitManager.hero.id)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("22739",2));
            return;
         }
      }
      var a:int = Model_bag.pwdLockState;
      if((btn.name == "4" || btn.name == "2" || btn.name == "6") && Model_bag.pwdLockState == Model_bag.PWD_STATE_LOCK_T)
      {
         UIManager.bagPwdPutIn.visible = true;
         return;
      }
      if(btn.name == "2")
      {
         if(this.pos <= Model_bang.partyInfo.party_position)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("22740",2));
            return;
         }
         if(this.nowItem.position == this.send_position)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("22754",2));
         }
         BangCGMessage.CG_BANG_RENMING(this.roleId,this.send_position);
      }
      else if(btn.name == "4" || btn.name == "5" || btn.name == "6")
      {
         if((btn.name == "4" || btn.name == "6") && this.nowItem == null)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("22738",2));
            return;
         }
         if(!UIManager.bang_prompt.visible)
         {
            UIManager.bang_prompt.visible = true;
         }
         UIManager.bang_prompt.heroName = this.role_name;
         UIManager.bang_prompt.updateText(int(btn.name));
         UIManager.bang_prompt.heroId = this.roleId;
         UIManager.bang_prompt._cur_page = this._cur_page;
         UIManager.bang_prompt.parent.setChildIndex(UIManager.bang_prompt,UIManager.bang_prompt.parent.numChildren - 1);
      }
   }
   
   public function update(cur_page:int, total_page:int, size:int, party_mem_arr:Array) : void
   {
      var mem_item:View_bangMemberItems = null;
      var vo_mem:Vo_bangMem = null;
      this.Page_text.text = String(cur_page) + "/" + String(total_page);
      this._total_page = total_page;
      this._cur_page = cur_page;
      var i:int = 0;
      while(i < 10)
      {
         this.item_arr[i].visible = false;
         i++;
      }
      i = 0;
      while(i < size)
      {
         mem_item = this.item_arr[i];
         vo_mem = party_mem_arr[i];
         mem_item.visible = true;
         mem_item.heroId = vo_mem.heroId;
         mem_item.name = vo_mem.name;
         mem_item.position = vo_mem.position;
         if(vo_mem.name == GameUnitManager.hero.name)
         {
            mem_item.enable = false;
         }
         else
         {
            mem_item.enable = true;
         }
         mem_item.ZhiWei_text.text = Model_bang.position_arr[vo_mem.position];
         mem_item.MenPai_text.htmlText = HtmlUtil.font(Model_bang.job_arr[Enum_job.getBaseJob(vo_mem.job) - 1],Model_shop.get_bangJob_color_arr[Enum_job.getBaseJob(vo_mem.job) - 1]);
         mem_item.Lever_text.text = String(vo_mem.lvl);
         mem_item.GRGongXian_text.text = String(vo_mem.self_gong) + "/" + String(vo_mem.mem_gong);
         if(vo_mem.is_online == 0)
         {
            mem_item.LastOnLine_text.text = LangConfig.getWord("22755",2);
            mem_item.LastOnLine_text.textColor = 6736896;
            mem_item.BangPai_text.textColor = 14013822;
            mem_item.ZhiWei_text.textColor = 11515029;
            mem_item.Lever_text.textColor = 11515029;
            mem_item.GRGongXian_text.textColor = 16383744;
         }
         else
         {
            mem_item.LastOnLine_text.text = DateUtil.getYearMonthDay(vo_mem.is_online);
            mem_item.LastOnLine_text.textColor = 13421772;
            mem_item.BangPai_text.textColor = 13421772;
            mem_item.ZhiWei_text.textColor = 13421772;
            mem_item.MenPai_text.textColor = 13421772;
            mem_item.Lever_text.textColor = 13421772;
            mem_item.GRGongXian_text.textColor = 13421772;
         }
         i++;
      }
      this.updateCheckBox(this._position);
      trace(this.position_arr);
      this.ChanRang_combobox.source = this.position_arr;
      this.un();
   }
   
   public function un() : void
   {
      if(!Model_bang.partyInfo)
      {
         return;
      }
      if(Boolean(this.nowItem))
      {
         this.nowItem.select = false;
         this.nowItem = null;
      }
      if(!Model_bang.partyInfo)
      {
         return;
      }
      var pos:int = Model_bang.partyInfo.party_position;
      if(Boolean(Model_bang.partyInfo))
      {
         this.Button_ChanRang.enabled = pos <= Model_bang.LEADER;
         this.updateCheckBox(pos);
      }
      this.Button_ChanRang.enabled = pos <= Model_bang.LEADER;
      this.Button_KaiChu.enabled = pos <= Model_bang.FU_LEADER;
      this.Button_TuiWei.enabled = pos >= Model_bang.FU_LEADER && pos <= Model_bang.ZHANGLAO;
      this.Button_RenMing.enabled = pos <= Model_bang.FU_LEADER;
      this.updateCheckBox(pos);
      this.updateCheckBox(0);
   }
   
   private function updateCheckBox(position:int) : void
   {
      if(position == 1)
      {
         this.position_arr = [[LangConfig.getWord("22801",2),2],[LangConfig.getWord("22802",2),3],[LangConfig.getWord("22803",2),4]];
      }
      else if(this._position == 2)
      {
         this.position_arr = [[LangConfig.getWord("22802",2),3],[LangConfig.getWord("22803",2),4]];
      }
      else
      {
         this.position_arr = [];
      }
   }
   
   private function cliHandle(e:MouseEvent) : void
   {
      if(!(e.target is View_bangMemberItems))
      {
         return;
      }
      var cliItem:View_bangMemberItems = e.target as View_bangMemberItems;
      if(this.nowItem == cliItem)
      {
         return;
      }
      if(Boolean(this.nowItem))
      {
         this.nowItem.select = false;
      }
      this.nowItem = cliItem;
      this.nowItem.select = true;
      this.roleId = this.nowItem.heroId;
      this.pos = this.nowItem.position;
      this.role_name = this.nowItem._name;
      trace("choose name....",this.role_name);
   }
   
   public function addComboBox() : void
   {
      this.ChanRang_combobox = new ComboBox(this.position_arr,function(value:Object):void
      {
         trace("value..",value);
         send_position = int(value);
      },96,"Button_PageDown","ComboBox_background");
      addChild(this.ChanRang_combobox);
      this.ChanRang_combobox.x = 113.05 + this.Button_RenMing.width + 51;
      this.ChanRang_combobox.y = 417.4 + 2;
      this.ChanRang_combobox.defaultText = LangConfig.getWord("22756",2);
   }
}

class bangZhenfa extends Sprite
{
   
   private var Button_XueXi:Button;
   
   private var Button_YanFa:Button;
   
   private var bangInfo:MyTextField;
   
   private var selfInfo:MyTextField;
   
   private var nowItem:View_bang_ZhenFa_Items;
   
   private var _itemVec:Vector.<View_bang_ZhenFa_Items>;
   
   public var bang_zhenfa_item:View_bang_ZhenFa_Items;
   
   public function bangZhenfa()
   {
      super();
      this.init();
   }
   
   public function init() : void
   {
      var j:int = 0;
      j = 0;
      while(j < 10)
      {
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":51 + j * 64,
            "y":127,
            "width":47,
            "height":20
         },Global.Img_Cdm);
         j++;
      }
      j = 0;
      while(j < 2)
      {
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":37 + j * 336,
            "y":160,
            "width":316,
            "height":244
         },Global.Img_Cdm);
         j++;
      }
      j = 0;
      while(j < 2)
      {
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":38 + j * 336,
            "y":161,
            "width":314,
            "height":20
         },Global.Img_Cdm);
         j++;
      }
      this.Button_YanFa = ComponentUtil.getButton(LangConfig.getWord("22758",2),"Button_Four",this,{
         "x":160,
         "y":413,
         "textColor":16184781
      },Global.Img_Cdm);
      this.Button_XueXi = ComponentUtil.getButton(LangConfig.getWord("22757",2),"Button_Four",this,{
         "x":500,
         "y":413,
         "textColor":16184781
      },Global.Img_Cdm);
      var tf1:MyTextField = ComponentUtil.getTextField(LangConfig.getWord("29318",2),this,{
         "x":170,
         "y":161,
         "color":16764206,
         "size":12,
         "leading":0
      });
      var tf2:MyTextField = ComponentUtil.getTextField(LangConfig.getWord("29319",2),this,{
         "x":500,
         "y":161,
         "color":16764206,
         "size":12,
         "leading":0
      });
      this.bangInfo = ComponentUtil.getTextField("",this,{
         "x":76,
         "y":200,
         "color":11904647,
         "size":12,
         "leading":8
      });
      this.selfInfo = ComponentUtil.getTextField("",this,{
         "x":412,
         "y":200,
         "color":11904647,
         "size":12,
         "leading":8
      });
      this._itemVec = new Vector.<View_bang_ZhenFa_Items>();
      var i:int = 0;
      while(i < 10)
      {
         this.bang_zhenfa_item = new View_bang_ZhenFa_Items();
         addChild(this.bang_zhenfa_item);
         this.bang_zhenfa_item.x = 55 + 64 * i;
         this.bang_zhenfa_item.y = 80;
         this.bang_zhenfa_item.addEventListener(MouseEvent.CLICK,this.cliHandle);
         this.bang_zhenfa_item.tabIndex = i;
         this.bang_zhenfa_item.setData(i + 1,0,false);
         this._itemVec.push(this.bang_zhenfa_item);
         i++;
      }
      this.Button_XueXi.callBack = this.learnClickHandle;
      this.Button_YanFa.callBack = this.researchClickHandle;
      this.changeFocus(this._itemVec[0]);
      Global.control.registerCallBack(Enum_MsgType.MSG_BANG_LEAVE,this.cleanData);
      Global.control.registerCallBack(Enum_MsgType.MSG_BANG_JOIN,this.joinBangEvt);
      this.hide();
   }
   
   private function hide() : void
   {
   }
   
   private function joinBangEvt(type:int) : void
   {
   }
   
   private function cleanData(leaveType:int) : void
   {
      GameUnitManager.hero.partyId = 0;
      GameUnitManager.hero.party = "";
      var arr:Array = Model_bang.bangZFLevelArr;
      var index:int = 0;
      while(index < 10)
      {
         Model_bang.bangZFLevelArr[index] = 0;
         Model_bang.selfZFLevelArr[index] = 0;
         index++;
      }
      GameUnitManager.hero.partyId = 0;
   }
   
   override public function set visible(value:Boolean) : void
   {
      if(value == true)
      {
         if(Model_bang.partyInfo.party_position > 2)
         {
            this.Button_YanFa.enabled = false;
         }
      }
      super.visible = value;
   }
   
   private function learnClickHandle(evt:MouseEvent) : void
   {
      var BANG_BASIC_ZF_ARR:Array = Model_bang.BANG_BASIC_ZF_ARR;
      var selfLevel:int = int(Model_bang.selfZFLevelArr[this.nowItem.tabIndex]);
      var bangLevel:int = int(Model_bang.bangZFLevelArr[this.nowItem.tabIndex]);
      var zfName:String = Data_lib.zhenfa[BANG_BASIC_ZF_ARR[this.nowItem.tabIndex] + 1][2];
      if(selfLevel >= 10)
      {
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("22759",2,zfName));
         return;
      }
      if(Model_bang.ZF_LEARN_COST[selfLevel] > Model_bang.partyInfo.party_self_gong)
      {
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("22760",2));
         return;
      }
      if(selfLevel >= this.nowItem.level)
      {
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("22761",2,(bangLevel + 1).toString(),zfName));
         return;
      }
      BangCGMessage.CG_RESEARCH_ZF(2,this.nowItem.tabIndex + 1);
   }
   
   private function researchClickHandle(evt:MouseEvent) : void
   {
      if(!Model_bang.partyInfo)
      {
         return;
      }
      if(this.nowItem.level >= 10)
      {
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("22762",2));
         return;
      }
      if(Model_bang.partyInfo.party_position > 2)
      {
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("22763",2));
         return;
      }
      if(Model_bang.ZF_RESEARCH_COST[this.nowItem.level] > Model_bang.partyInfo.party_forturn)
      {
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("22764",2));
         return;
      }
      if(Model_bang.bangBuildingLevel[0] <= this.nowItem.level)
      {
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("22765",2));
         return;
      }
      BangCGMessage.CG_RESEARCH_ZF(1,this.nowItem.tabIndex + 1);
   }
   
   private function selfLearnZFinfo(type:int, level:int) : void
   {
      var selfLevel:int = int(Model_bang.selfZFLevelArr[type - 1]);
      var BANG_BASIC_ZF_ARR:Array = Model_bang.BANG_BASIC_ZF_ARR;
      var ZF_LEARN_COST:Array = Model_bang.ZF_LEARN_COST;
      var ZF_RESEARCH_COST:Array = Model_bang.ZF_RESEARCH_COST;
      var levelStr:String = LangConfig.getWord("22766",2);
      var costStr:String = LangConfig.getWord("22767",2);
      var gxStr:String = LangConfig.getWord("22768",2);
      if(Boolean(Model_bang.partyInfo))
      {
         gxStr += HtmlUtil.font(Model_bang.partyInfo.party_self_gong.toString() + "/" + Model_bang.partyInfo.party_gong.toString(),"#ffcd2e");
      }
      var curEffStr:String = LangConfig.getWord("22769",2);
      var nxtEffStr:String = LangConfig.getWord("22770",2);
      if(level <= 0)
      {
         curEffStr += HtmlUtil.font(LangConfig.getWord("22771",2),"#ffcd2e");
         nxtEffStr += HtmlUtil.font(Data_lib.zhenfa[BANG_BASIC_ZF_ARR[type - 1] + level + 1][4],"#ffcd2e");
         costStr += HtmlUtil.font(ZF_LEARN_COST[level].toString(),"#ffcd2e");
      }
      else if(level < 10)
      {
         costStr += HtmlUtil.font(ZF_LEARN_COST[level].toString(),"#ffcd2e");
         nxtEffStr += HtmlUtil.font(Data_lib.zhenfa[BANG_BASIC_ZF_ARR[type - 1] + level + 1][4],"#ffcd2e");
         curEffStr += HtmlUtil.font(Data_lib.zhenfa[BANG_BASIC_ZF_ARR[type - 1] + level][4],"#ffcd2e");
      }
      else
      {
         costStr += HtmlUtil.font("--","#ffcd2e");
         nxtEffStr += "--";
         curEffStr += HtmlUtil.font(Data_lib.zhenfa[BANG_BASIC_ZF_ARR[type - 1] + level][4],"#ffcd2e");
      }
      var id:int = BANG_BASIC_ZF_ARR[type - 1] + level;
      levelStr += HtmlUtil.font(level.toString(),"#ffcd2e");
      this.selfInfo.htmlText = levelStr + "\n" + costStr + "\n" + gxStr + "\n\n" + curEffStr + "\n" + nxtEffStr;
   }
   
   public function updateByModel() : void
   {
      var i:int = Model_bang.partyInfo.party_self_gong;
      var arr:Array = Model_bang.bangZFLevelArr;
      var index:int = 0;
      while(index < 10)
      {
         this._itemVec[index].setData(index + 1,arr[index],true);
         index++;
      }
      this.changeFocus(this.nowItem);
   }
   
   private function bangResearchZFinfo(type:int, level:int) : void
   {
      var BANG_BASIC_ZF_ARR:Array = Model_bang.BANG_BASIC_ZF_ARR;
      var ZF_LEARN_COST:Array = Model_bang.ZF_LEARN_COST;
      var ZF_RESEARCH_COST:Array = Model_bang.ZF_RESEARCH_COST;
      var levelStr:String = LangConfig.getWord("22772",2);
      var costStr:String = LangConfig.getWord("22773",2);
      var extraStr:String = HtmlUtil.font(LangConfig.getWord("22774",2),"#DFBA60");
      var curEffStr:String = LangConfig.getWord("22775",2);
      var nxtEffStr:String = LangConfig.getWord("22776",2);
      if(level <= 0)
      {
         level = 1;
      }
      if(level < 10)
      {
         levelStr += HtmlUtil.font((level + 1).toString(),"#ffcd2e");
         costStr += HtmlUtil.font(ZF_RESEARCH_COST[level].toString(),"#ffcd2e");
         nxtEffStr += HtmlUtil.font(Data_lib.zhenfa[BANG_BASIC_ZF_ARR[type - 1] + level + 1][4],"#ffcd2e");
      }
      else
      {
         levelStr += "--";
         costStr += "--";
         nxtEffStr += "--";
      }
      var id:int = BANG_BASIC_ZF_ARR[type - 1] + level;
      curEffStr += HtmlUtil.font(Data_lib.zhenfa[BANG_BASIC_ZF_ARR[type - 1] + level][4],"#ffcd2e");
      this.bangInfo.htmlText = levelStr + "\n" + costStr + "\n" + extraStr + "\n\n" + curEffStr + "\n" + nxtEffStr;
   }
   
   public function resetChoose1() : void
   {
      this.changeFocus(this._itemVec[0]);
   }
   
   private function changeFocus(cliItem:View_bang_ZhenFa_Items) : void
   {
      if(Boolean(this.nowItem))
      {
         this.nowItem.select = false;
      }
      this.nowItem = cliItem;
      this.nowItem.select = true;
      this.bangResearchZFinfo(this.nowItem.zfType,this.nowItem.level);
      this.selfLearnZFinfo(this.nowItem.zfType,Model_bang.selfZFLevelArr[this.nowItem.tabIndex]);
   }
   
   private function cliHandle(e:MouseEvent) : void
   {
      var cliItem:View_bang_ZhenFa_Items = e.target as View_bang_ZhenFa_Items;
      this.changeFocus(cliItem);
   }
}

class ExtendBmp extends Sprite
{
   
   private static var partyId:int;
   
   private var bmp:Bitmap = new Bitmap();
   
   private var _type:int;
   
   private var _enabled:Boolean = true;
   
   private var url:String;
   
   public function ExtendBmp(url:String, type:int, id:int)
   {
      super();
      buttonMode = true;
      this._type = type;
      partyId = id;
      this.url = url;
      this.compHandle();
   }
   
   public function set enabled(v:Boolean) : void
   {
      if(v)
      {
         buttonMode = true;
         if(filters != Util.disabled)
         {
            filters = null;
         }
         buttonMode = Boolean(buttonMode) || true;
      }
      else
      {
         buttonMode = false;
         if(filters != Util.disabled)
         {
            filters = Util.disabled;
         }
         buttonMode = false;
      }
      this._enabled = v;
   }
   
   private function compHandle() : void
   {
      addEventListener(MouseEvent.CLICK,this.cliHandle);
   }
   
   public function init() : void
   {
      this.bmp = ComponentUtil.getBitmap(this.url,this,null,Global.Bang_Imgsdm);
   }
   
   private function cliHandle(e:MouseEvent) : void
   {
      if(!this._enabled)
      {
         return;
      }
      switch(this._type)
      {
         case 1:
            this.getFuli();
            break;
         case 2:
            UIManager.bangPlant.visible = !UIManager.bangPlant.visible;
            break;
         case 3:
            UIManager.bangMoneyTree.visible = !UIManager.bangMoneyTree.visible;
            break;
         case 4:
            BangCGMessage.CG_ENTER_BUILDING(3);
            UIManager.bang_store.visible = true;
      }
   }
   
   private function getFuli() : void
   {
      if(GameUnitManager.hero.vigor >= 1500)
      {
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("22733",2));
         return;
      }
      if(!UIManager.bang_prompt.visible)
      {
         UIManager.bang_prompt.visible = true;
      }
      UIManager.bang_prompt.updateText(2);
      UIManager.bang_prompt.partyId = partyId;
      UIManager.bang_prompt.parent.setChildIndex(UIManager.bang_prompt,UIManager.bang_prompt.parent.numChildren - 1);
   }
}
