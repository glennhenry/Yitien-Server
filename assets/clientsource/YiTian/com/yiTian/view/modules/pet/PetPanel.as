package com.yiTian.view.modules.pet
{
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Const_png;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.Enum_quest_step_type;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.data.config.valuable.Enum_filter;
   import com.yiTian.data.model.Model_bag;
   import com.yiTian.data.model.Model_quest;
   import com.yiTian.data.vo.Vo_Buffer;
   import com.yiTian.data.vo.Vo_Skill;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.QuestGuiManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BagCGMessage;
   import com.yiTian.net.message.cg.PetCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Bitmap2;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.StrFilter;
   import com.yiTian.utils.Utils;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.guide.View_questGuiJian;
   import com.yiTian.view.modules.pet.petD.Model_pet;
   import com.yiTian.view.modules.roleHead.BuffterVO;
   import com.yiTian.view.modules.specialBtnDill.Model_specialD;
   import com.yiTian.view.modules.tip.tips.View_petTaoTip;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.ui.Mouse;
   import flash.ui.MouseCursor;
   
   public class PetPanel extends Panel
   {
      
      public static var curPanel:Panel;
      
      public static var _petVO:PetVO;
      
      public static var PETNAMES:Array;
      
      public static var isTuPo:int;
      
      public static const XIZI:String = "XIZI";
      
      public static const LIANHUA:String = "LIANHUA";
      
      public static const NEIDAN:String = "NEIDAN";
      
      public static const ZHUANGBEI:String = "ZHUANGBEI";
      
      public static const JINENG_LOCK:String = "JINENG_LOCK";
      
      public static const JINENG_NULL:String = "JINENG_NULL";
      
      public static const JINENG_HAVE:String = "JINENG_HAVE";
      
      public static var vecOldModelID:Vector.<int> = new <int>[20901,20902,20903,20904,20905,20906,20907,20908,20526,20527,20710];
      
      public static var vecNewModelID:Vector.<int> = new <int>[20801,20802,20803,20804,20805,20806,20807,20808,20526,20527,20710];
      
      private const WIDTH:int = 223;
      
      private const HEIGHT:int = 12;
      
      private var qiXueBM:Bitmap;
      
      private var qiXueMask:Shape;
      
      private var qiXueTxt:MyTextField;
      
      private var nameTxt:MyTextField;
      
      private var dengJiTxt:MyTextField;
      
      private var ziZhiTxt:MyTextField;
      
      private var zhanLiTxt:MyTextField;
      
      private var gongJiTxt:MyTextField;
      
      private var fangYuTxt:MyTextField;
      
      private var mingZhongTxt:MyTextField;
      
      private var shanBiTxt:MyTextField;
      
      private var baoJiTxt:MyTextField;
      
      private var suDuTxt:MyTextField;
      
      private var neiDanBtn:TabButton;
      
      private var xiZiBtn:TabButton;
      
      private var chengZhangBtn:TabButton;
      
      private var zhuangBeiBtn:TabButton;
      
      private var nowBtn:TabButton;
      
      public var btnVec:Vector.<TabButton>;
      
      private var neiDanView:NeiDanPanel;
      
      private var xiZiView:XiZiPanel;
      
      private var chengZhangView:LianHuaPanel;
      
      private var viewVec:Array;
      
      private var jiNengGridVec:Vector.<View_Grid>;
      
      private var jiNengBtnVec:Vector.<Button>;
      
      private var spBianSheng:Sprite;
      
      private var cbShow:CheckBox;
      
      public var btnHuaXing:Button;
      
      public var btnJingxXiu:Button;
      
      private var defaultTxt:Array;
      
      private var tf:TextFormat;
      
      private var back:DisplayObject;
      
      private var spr:View_petTaoTip;
      
      private var curSelect:int = 1;
      
      private var jiNengOnArr:Array = [2,5,7,10,15,20];
      
      private var effArr:Vector.<Effect> = new Vector.<Effect>();
      
      public const SKILLARR:Array = [36301,36302,36303,36304,36305,36306,36307,36308,36310,36311,36313,36314,36315,36316,36317,36318,36319];
      
      private const petBGW:int = 156;
      
      private const petBGH:int = 99;
      
      private var curW:int;
      
      private var curH:int;
      
      private var petBGBM:Bitmap;
      
      private var imgBM:Bitmap;
      
      private var totalFram:int;
      
      private const INTERVALFRAM:int = 5;
      
      private var imgList:Vector.<BitmapData>;
      
      private var playIndex:int = 0;
      
      private var spImg:Sprite;
      
      private var _info:Object;
      
      private var qiXueBG:Bitmap;
      
      private var myTF:MyTextField;
      
      private var isFirstOpen:Boolean = true;
      
      private var effBianSheng:Effect;
      
      public function PetPanel()
      {
         super();
      }
      
      public static function transtPetModelID(modelID:int) : int
      {
         var newID:int = 0;
         if(HuaXingPanel.spePetModelIdVec.indexOf(modelID) >= 0)
         {
            return modelID;
         }
         if(vecOldModelID.indexOf(modelID) >= 0)
         {
            return vecNewModelID[vecOldModelID.indexOf(modelID)];
         }
         return modelID;
      }
      
      public function set petVO(value:PetVO) : void
      {
         if(Boolean(GameUnitManager.pet) && Boolean(_petVO) && _petVO.img != value.img)
         {
            GameUnitManager.pet.addEffect("35088",false,0,0,800);
         }
         _petVO = value;
      }
      
      public function get petVO() : PetVO
      {
         return _petVO;
      }
      
      override protected function initStaticView() : void
      {
         var j:int;
         var st:String;
         var bm:Bitmap2;
         var grid:View_Grid = null;
         var btn:Button = null;
         var i:uint = 0;
         var s:Sprite = null;
         var b:TabButton = null;
         var str:String = null;
         var petTao:Sprite = null;
         var t:MyTextField = null;
         this.defaultTxt = [{
            "txt":LangConfig.getWord("10053",1),
            "x":182,
            "y":59
         },{
            "txt":Data_lib.attribute[23][0],
            "x":182,
            "y":87
         },{
            "txt":LangConfig.getWord("10105",1),
            "x":182,
            "y":115
         },{
            "txt":LangConfig.getWord("10104",1),
            "x":182,
            "y":143
         }];
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":594,
            "height":451
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":68,
            "width":546,
            "height":373
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":29,
            "y":73,
            "width":286,
            "height":283
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":211,
            "y":322,
            "width":90,
            "height":22
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":69,
            "y":322,
            "width":90,
            "height":22
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":211,
            "y":258,
            "width":90,
            "height":22
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":69,
            "y":290,
            "width":90,
            "height":22
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":211,
            "y":290,
            "width":90,
            "height":22
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":69,
            "y":258,
            "width":90,
            "height":22
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":214,
            "y":170,
            "width":90,
            "height":24
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":214,
            "y":142,
            "width":90,
            "height":24
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":215,
            "y":86,
            "width":90,
            "height":24
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":214,
            "y":114,
            "width":90,
            "height":24
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":29,
            "y":360,
            "width":536,
            "height":75
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60253",6),this,{
            "x":40,
            "y":201 + 28,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60254",6),this,{
            "x":40,
            "y":230 + 28,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60255",6),this,{
            "x":40,
            "y":262 + 28,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60256",6),this,{
            "x":40,
            "y":294 + 28,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60257",6),this,{
            "x":175,
            "y":230 + 28,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60258",6),this,{
            "x":175,
            "y":262 + 28,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60259",6),this,{
            "x":175,
            "y":294 + 28,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.petBGBM = new Bitmap();
         addChild(this.petBGBM);
         this.petBGBM.x = 29;
         this.petBGBM.y = 45 + 28;
         j = 0;
         while(j < this.defaultTxt.length)
         {
            t = ComponentUtil.getTextField(this.defaultTxt[j].txt,this,{
               "x":this.defaultTxt[j].x,
               "y":this.defaultTxt[j].y + 28,
               "color":11904647
            });
            j++;
         }
         this.qiXueBG = new Bitmap();
         this.qiXueBG.x = 76;
         this.qiXueBG.y = 204 + 28;
         addChild(this.qiXueBG);
         this.qiXueBM = new Bitmap();
         this.qiXueBM.x = 77;
         this.qiXueBM.y = 205 + 28;
         addChild(this.qiXueBM);
         this.qiXueMask = new Shape();
         this.draw(this.qiXueMask,this.WIDTH);
         addChild(this.qiXueMask);
         this.qiXueMask.x = this.qiXueBM.x;
         this.qiXueMask.y = this.qiXueBM.y;
         this.qiXueBM.mask = this.qiXueMask;
         this.qiXueTxt = ComponentUtil.getTextField("400000/500000",this,{
            "x":this.qiXueBM.x,
            "y":this.qiXueBM.y - 4,
            "color":16777215
         });
         this.qiXueTxt.realWidth = 221;
         this.tf = new TextFormat();
         this.tf.align = TextFormatAlign.CENTER;
         this.qiXueTxt.setTextFormat(this.tf);
         move = new Rectangle(0,0,this.back.width,35);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":560,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         CloseButton.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
         {
            playImg();
         });
         this.nameTxt = ComponentUtil.getTextField("",this,{
            "x":215,
            "y":this.defaultTxt[0].y + 28,
            "color":12877056
         });
         this.nameTxt.restrict = "^_|,";
         this.nameTxt.realWidth = 80;
         this.nameTxt.type = TextFieldType.INPUT;
         this.nameTxt.addEventListener(MouseEvent.ROLL_OUT,this.txtOnRollOut);
         this.nameTxt.addEventListener(MouseEvent.ROLL_OVER,this.txtOnRollOver);
         this.nameTxt.addEventListener(FocusEvent.FOCUS_OUT,this.txtOnFocusOut);
         this.nameTxt.addEventListener(FocusEvent.FOCUS_IN,this.txtOnFocusIn);
         this.nameTxt.addEventListener(Event.CHANGE,this.txtOnChange);
         this.dengJiTxt = ComponentUtil.getTextField("000",this,{
            "x":215,
            "y":this.defaultTxt[1].y + 28,
            "color":12877056
         });
         this.ziZhiTxt = ComponentUtil.getTextField("000/000",this,{
            "x":215,
            "y":this.defaultTxt[2].y + 28,
            "color":12877056
         });
         this.zhanLiTxt = ComponentUtil.getTextField("000/000",this,{
            "x":215,
            "y":this.defaultTxt[3].y + 28,
            "color":12877056
         });
         this.gongJiTxt = ComponentUtil.getTextField("0000000000",this,{
            "x":79,
            "y":230 + 28,
            "color":12877056
         });
         this.fangYuTxt = ComponentUtil.getTextField("0000000000",this,{
            "x":214,
            "y":230 + 28,
            "color":12877056
         });
         this.mingZhongTxt = ComponentUtil.getTextField("0000000000",this,{
            "x":79,
            "y":262 + 28,
            "color":12877056
         });
         this.shanBiTxt = ComponentUtil.getTextField("0000000000",this,{
            "x":214,
            "y":262 + 28,
            "color":12877056
         });
         this.baoJiTxt = ComponentUtil.getTextField("0000000000",this,{
            "x":79,
            "y":294 + 28,
            "color":12877056
         });
         this.suDuTxt = ComponentUtil.getTextField("0000000000",this,{
            "x":214,
            "y":294 + 28,
            "color":12877056
         });
         this.jiNengGridVec = new Vector.<View_Grid>();
         this.jiNengBtnVec = new Vector.<Button>();
         i = 0;
         while(i < 8)
         {
            grid = new View_Grid();
            grid.type = Enum_type_grid.PET;
            grid.set_bmp_bg();
            grid.set_bmp_select();
            grid.set_bmp_over();
            grid.x = 49 + (Const_png.SIZE_GRID + 26) * i;
            grid.y = 339 + 28;
            addChild(grid);
            this.jiNengGridVec.push(grid);
            if(i < 7)
            {
               btn = ComponentUtil.getButton(LangConfig.getWord("10106",1),"Button_Two",this,{
                  "x":grid.x - 6,
                  "y":grid.y + 39
               },Global.Img_Cdm);
               btn.name = "btn_" + i;
               btn.textColor = 13434624;
               btn.textOverColor = 13434624;
               btn.enabled = false;
               btn.mouseEnabled = false;
               this.jiNengBtnVec.push(btn);
               btn.addEventListener(MouseEvent.CLICK,this.xiLianHandler);
            }
            else
            {
               ComponentUtil.getTextField(LangConfig.getWord("60260",6),this,{
                  "color":16449280,
                  "x":grid.x + 3,
                  "y":grid.y + 42
               });
            }
            i++;
         }
         this.viewVec = [];
         this.btnVec = new Vector.<TabButton>();
         i = 0;
         while(i < 4)
         {
            if(i == 0)
            {
               s = new XiZiPanel();
               str = LangConfig.getWord("10086",1);
            }
            else if(i == 1)
            {
               s = LianHuaPanel.instance;
               str = LangConfig.getWord("10107",1);
            }
            else if(i == 2)
            {
               s = new NeiDanPanel();
               str = LangConfig.getWord("10108",1);
            }
            else if(i == 3)
            {
               s = ZhuangBeiPanel.instance;
               str = "宠物装备";
            }
            s.visible = false;
            addChild(s);
            s.x = 321;
            s.y = 72;
            this.viewVec.push(s);
            b = ComponentUtil.getTabButton(str,"TabButton_Four",this,{"y":45},Global.Img_Cdm);
            b.x = 327 + (b.width + 5) * i - 290;
            b.textColor = 12232795;
            b.chooseColor = 16773818;
            b.name = "TabButton_" + i;
            this.btnVec.push(b);
            b.addEventListener(MouseEvent.CLICK,this.tabButtonOnClick);
            i++;
         }
         this.spBianSheng = new Sprite();
         addChild(this.spBianSheng);
         this.spBianSheng.x = 32;
         this.spBianSheng.y = 50 + 28;
         this.spBianSheng.buttonMode = true;
         this.spBianSheng.addEventListener(MouseEvent.CLICK,this.BSHandler);
         TipManager.bind(this.spBianSheng,LangConfig.getWord("10109",1));
         this.cbShow = new CheckBox("","CheckBox01",Global.Img_Cdm);
         this.cbShow.x = 185;
         this.cbShow.y = 173 + 28;
         this.cbShow.htmlText = "显示宠物时装模型";
         this.cbShow.selected = true;
         addChild(this.cbShow);
         this.cbShow.addEventListener(MouseEvent.CLICK,this.cbShowOnClick,false,1);
         st = Global.pf == "qqgame" ? "CardBule" : "Button_Card";
         if(Global.pf == "qqgame" || Global.pf == "3366")
         {
            st = "CardBule";
         }
         else if(Global.pf == "qplus" || Global.pf == Enum_SPStr.GUANWANG)
         {
            st = "VipPet";
         }
         else
         {
            st = "Button_Card";
         }
         petTao = new Sprite();
         petTao.graphics.beginFill(0,0);
         petTao.graphics.drawRect(0,0,30,30);
         petTao.graphics.endFill();
         petTao.x = 140;
         petTao.y = 195;
         petTao.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         petTao.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         bm = new Bitmap2();
         bm.load("resource/image/petTao/30.png");
         if(!this.spr)
         {
            this.spr = new View_petTaoTip();
         }
      }
      
      private function onRollOut(e:MouseEvent) : void
      {
         if(Boolean(this.spr))
         {
            this.spr.visible = false;
         }
      }
      
      private function onRollOver(e:MouseEvent) : void
      {
         this.spr.x = mouseX;
         this.spr.y = mouseY;
         this.spr.visible = true;
         addChild(this.spr);
      }
      
      private function setBtn() : void
      {
         if(!this.btnHuaXing)
         {
            this.btnHuaXing = ComponentUtil.getButton("","Bt_HuaXing",this,{
               "x":140,
               "y":54 + 28,
               "name":"btnHuaXing"
            },Utils.swfPool["lang/ch/Pet_Imgs.swf"]);
            this.btnJingxXiu = ComponentUtil.getButton("","Bt_JingXiu",this,{
               "x":140,
               "y":54 + 28,
               "name":"btnJingxXiu"
            },Utils.swfPool["lang/ch/Pet_Imgs.swf"]);
            this.btnHuaXing.addEventListener(MouseEvent.CLICK,this.btnOnClick);
            this.btnJingxXiu.addEventListener(MouseEvent.CLICK,this.btnOnClick);
         }
         this.updateBtn();
      }
      
      private function updateBtn() : void
      {
         if(Boolean(this.btnHuaXing))
         {
            var _temp_1:* = this.btnHuaXing;
            this.btnJingxXiu.visible = false;
            _temp_1.visible = false;
            if(_petVO.hxjx == 0)
            {
               this.btnHuaXing.visible = true;
            }
            else if(_petVO.hxjx > 0)
            {
               this.btnJingxXiu.visible = true;
            }
         }
      }
      
      public function setxx() : void
      {
         (this.viewVec[3] as ZhuangBeiPanel).istype((this.viewVec[3] as ZhuangBeiPanel).type);
         (this.viewVec[3] as ZhuangBeiPanel).getnewvalue();
         (this.viewVec[3] as ZhuangBeiPanel).getGrid((this.viewVec[3] as ZhuangBeiPanel).type);
      }
      
      private function btnOnClick(e:MouseEvent) : void
      {
         var pnl:HuaXingPanel = null;
         var pnl2:JingXiuPanel = null;
         if(e.target.name == "btnHuaXing")
         {
            pnl = UIManager.huaxing;
            (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pnl,function():void
            {
               pnl.visible = true;
            });
         }
         else if(e.target.name == "btnJingxXiu")
         {
            pnl2 = UIManager.jingxiu;
            (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pnl2,function():void
            {
               pnl2.visible = true;
            });
         }
      }
      
      public function updateSelect(type:int) : void
      {
         this.curSelect = type;
         if(Boolean(type))
         {
            this.cbShow.selected = true;
         }
         else
         {
            this.cbShow.selected = false;
         }
      }
      
      protected function cbShowOnClick(e:MouseEvent) : void
      {
         e.stopImmediatePropagation();
         if(Boolean(this.curSelect))
         {
            PetCGMessage.CG_PET_SHOW_FASHION(0);
         }
         else
         {
            PetCGMessage.CG_PET_SHOW_FASHION(1);
         }
      }
      
      protected function BSHandler(e:MouseEvent) : void
      {
         UIManager.bianShengKa.visible = true;
         UIManager.bianShengKa.resetP();
      }
      
      protected function xiLianHandler(e:MouseEvent) : void
      {
         var index:int = int(e.target.name.split("_")[1]);
         UIManager.xiLianJiNengPanel.visible = true;
         UIManager.xiLianJiNengPanel.show(this.jiNengGridVec[index].vo,index);
         PetCGMessage.CG_PET_XILIAN(index);
      }
      
      private function draw(shape:Shape, width:int) : void
      {
         shape.graphics.beginFill(0,1);
         shape.graphics.drawRect(0,0,this.WIDTH,this.HEIGHT);
         shape.graphics.endFill();
      }
      
      protected function txtOnChange(e:Event) : void
      {
         var str:String = this.nameTxt.text;
         if(str.length > 5)
         {
            this.nameTxt.text = str.substr(0,5);
         }
      }
      
      protected function txtOnFocusIn(event:FocusEvent) : void
      {
         Mouse.cursor = MouseCursor.AUTO;
         this.nameTxt.removeEventListener(MouseEvent.ROLL_OUT,this.txtOnRollOut);
         this.nameTxt.removeEventListener(MouseEvent.ROLL_OVER,this.txtOnRollOver);
      }
      
      protected function txtOnFocusOut(e:FocusEvent) : void
      {
         this.nameTxt.addEventListener(MouseEvent.ROLL_OUT,this.txtOnRollOut);
         this.nameTxt.addEventListener(MouseEvent.ROLL_OVER,this.txtOnRollOver);
         if(this.nameTxt.text == "")
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10110",1) + "</font>");
            this.nameTxt.text = _petVO.name;
            return;
         }
         if(this.nameTxt.text == _petVO.name)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10111",1) + "</font>");
            return;
         }
         if(this.nameTxt.text.length > 5)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10112",1) + "</font>");
            return;
         }
         StrFilter.load(this.nameTxt.text,function(text:String):void
         {
            if(StrFilter.hasUnRegisterString(text))
            {
               UIManager.centerBroadcast.addMsg("<font color=\'#ff0000\'>" + LangConfig.getWord("10113",1) + "</font>");
            }
            else
            {
               PetCGMessage.CG_PET_RENAMED(nameTxt.text);
            }
         });
      }
      
      protected function txtOnRollOut(e:MouseEvent) : void
      {
         Mouse.cursor = MouseCursor.AUTO;
      }
      
      protected function txtOnRollOver(e:MouseEvent) : void
      {
         Mouse.cursor = MouseCursor.BUTTON;
      }
      
      protected function tabButtonOnClick(event:MouseEvent) : void
      {
         var tbtn:TabButton = event.target as TabButton;
         if(this.nowBtn == tbtn)
         {
            return;
         }
         if(int(tbtn.name.split("_")[1]) == 3)
         {
            if(GameUnitManager.hero.level < 50)
            {
               UIManager.centerBroadcast.addMsg("人物等级50级开启");
               return;
            }
         }
         if(this.nowBtn != null)
         {
            this.viewVec[int(this.nowBtn.name.split("_")[1])].visible = false;
            this.nowBtn.choose = false;
         }
         tbtn.choose = true;
         this.nowBtn = tbtn;
         this.viewVec[int(tbtn.name.split("_")[1])].visible = true;
         if(int(tbtn.name.split("_")[1]) == 0)
         {
            (this.viewVec[0] as XiZiPanel).update();
         }
         else if(int(tbtn.name.split("_")[1]) == 1)
         {
            (this.viewVec[1] as LianHuaPanel).update();
         }
         else if(int(tbtn.name.split("_")[1]) == 2)
         {
            PetCGMessage.CG_PET_DANQI_ICON();
            (this.viewVec[2] as NeiDanPanel).update();
         }
         else if(int(tbtn.name.split("_")[1]) == 3)
         {
            if(PetzbVO.isover == false)
            {
               UIManager.centerBroadcast.addMsg("操作频繁，请稍后点击");
               return;
            }
            (this.viewVec[3] as ZhuangBeiPanel).update();
         }
      }
      
      public function jiaQiXueClick(event:MouseEvent = null) : void
      {
         var vec:Vector.<Vo_valuable> = null;
         if(_petVO.curQiXue < _petVO.maxQiXue)
         {
            vec = CommandManager.get_bag_vec(Enum_filter.ITEM_DRUG_LIFE);
            if(vec.length > 0)
            {
               PetCGMessage.CG_PET_ADD_QIXUE();
            }
            else
            {
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10114",1) + "</font>");
            }
         }
         else
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10115",1) + "</font>");
         }
      }
      
      private function getSprite() : Sprite
      {
         var temp:Sprite = new Sprite();
         var g:Graphics = temp.graphics;
         g.beginFill(16777215,0);
         g.drawRect(0,0,160,10);
         g.endFill();
         return temp;
      }
      
      public function update(res:int = 0) : void
      {
         var vo:Vo_Skill = null;
         var eff:Effect = null;
         if(!_petVO || !visible)
         {
            return;
         }
         if(!PETNAMES)
         {
            PETNAMES = [LangConfig.getWord("60249",6),LangConfig.getWord("60250",6),LangConfig.getWord("60251",6),LangConfig.getWord("60252",6)];
         }
         if(_petVO.img == 20907)
         {
            if(PETNAMES.indexOf(_petVO.name) != -1)
            {
               _petVO.name = LangConfig.getWord("60250",6);
            }
         }
         else if(_petVO.img == 20906)
         {
            if(PETNAMES.indexOf(_petVO.name) != -1)
            {
               _petVO.name = LangConfig.getWord("60251",6);
            }
         }
         else if(_petVO.img == 20901)
         {
            if(PETNAMES.indexOf(_petVO.name) != -1)
            {
               _petVO.name = LangConfig.getWord("60249",6);
            }
         }
         else if(_petVO.img == 20908)
         {
            if(PETNAMES.indexOf(_petVO.name) != -1)
            {
               _petVO.name = LangConfig.getWord("60252",6);
            }
         }
         this.nameTxt.text = _petVO.name;
         this.dengJiTxt.text = _petVO.level.toString();
         this.qiXueTxt.text = _petVO.curQiXue + "/" + _petVO.maxQiXue;
         this.qiXueTxt.setTextFormat(this.tf);
         this.gongJiTxt.text = _petVO.gongJi.toString();
         this.fangYuTxt.text = _petVO.fangYu.toString();
         this.mingZhongTxt.text = _petVO.mingZhong.toString();
         this.shanBiTxt.text = _petVO.shanBi.toString();
         this.baoJiTxt.text = _petVO.baoJi.toString();
         this.suDuTxt.text = _petVO.suDu.toString();
         isTuPo = _petVO.isTuPo;
         var w:int = _petVO.curQiXue > _petVO.maxQiXue ? this.WIDTH : int(_petVO.curQiXue / _petVO.maxQiXue * this.WIDTH);
         this.qiXueMask.width = w;
         this.ziZhiTxt.text = _petVO.ziZhi.toString();
         this.zhanLiTxt.text = _petVO.zhanLi.toString();
         while(Boolean(this.effArr.length))
         {
            EffectManager.removeEffect(this.effArr[0]);
            this.effArr[0] = null;
            this.effArr.shift();
         }
         var i:uint = 0;
         while(i < 7)
         {
            if(_petVO.jiNengArr[i] == -1)
            {
               this.jiNengGridVec[i].set_bmp_bg(View_Grid.GRID_LOCK);
               TipManager.bind(this.jiNengGridVec[i],LangConfig.getWord("10116",1,this.jiNengOnArr[i - 1]));
               this.jiNengBtnVec[i].enabled = false;
               this.jiNengBtnVec[i].mouseEnabled = false;
            }
            else if(_petVO.jiNengArr[i] == 0)
            {
               this.jiNengGridVec[i].set_bmp_bg(View_Grid.GRID_OPEN);
               TipManager.bind(this.jiNengGridVec[i],LangConfig.getWord("10117",1));
               this.jiNengBtnVec[i].enabled = true;
               this.jiNengBtnVec[i].mouseEnabled = true;
            }
            else if(_petVO.jiNengArr[i] > 0)
            {
               this.jiNengGridVec[i].set_bmp_bg(View_Grid.GRID_OPEN);
               vo = new Vo_Skill(_petVO.jiNengArr[i]);
               this.jiNengGridVec[i].vo = vo;
               TipManager.bind(this.jiNengGridVec[i],"<b><font color=\'#ffff00\'>" + vo.str_name + "</font></b><br />" + vo.effect_description);
               this.jiNengBtnVec[i].enabled = true;
               this.jiNengBtnVec[i].mouseEnabled = true;
            }
            if(Boolean(this.jiNengGridVec[i].vo) && this.SKILLARR.indexOf(this.jiNengGridVec[i].vo.id) != -1)
            {
               eff = EffectManager.addEffect("35205",this,800,this.jiNengGridVec[i].x + 13,this.jiNengGridVec[i].y + 17,true);
               this.effArr.push(eff);
            }
            i++;
         }
         vo = new Vo_Skill(_petVO.jiNengArr[7]);
         this.jiNengGridVec[7].vo = vo;
         var s:String = "<b><font color=\'#ffff00\'>" + vo.str_name + "</font></b><br />" + vo.effect_description;
         if(_petVO.jingNeng9 > 0)
         {
            vo = new Vo_Skill(_petVO.jingNeng9);
            s += "<br /><b><font color=\'#ffff00\'>" + vo.str_name + "</font></b><br />" + vo.effect_description;
         }
         if(_petVO.jingNeng10 > 0)
         {
            vo = new Vo_Skill(_petVO.jingNeng10);
            s += "<br /><b><font color=\'#ffff00\'>" + vo.str_name + "</font></b><br />" + vo.effect_description;
         }
         TipManager.bind(this.jiNengGridVec[i],s);
         this.playImg();
         (this.viewVec[0] as XiZiPanel).update(res);
         (this.viewVec[1] as LianHuaPanel).update();
         (this.viewVec[2] as NeiDanPanel).neiDanVO = _petVO.neiDanVO;
         (this.viewVec[2] as NeiDanPanel).update();
         this.updateBtn();
      }
      
      private function onComplete(info:Object) : void
      {
         var c:Class = null;
         var d:BitmapData = null;
         if(!this.spImg)
         {
            this.spImg = new Sprite();
            this.spImg.mouseEnabled = false;
            addChild(this.spImg);
            this.imgBM = new Bitmap();
            this.spImg.addChild(this.imgBM);
            this.spImg.x = this.petBGW / 2 + this.petBGBM.x - 2;
            this.spImg.y = this.petBGBM.y + 135;
         }
         this._info = info;
         this._info.content.init();
         this.imgList = new Vector.<BitmapData>(this.INTERVALFRAM * this._info.content.actionFrame,true);
         var i:int = 0;
         var j:int = 0;
         while(i < this.INTERVALFRAM * this._info.content.actionFrame)
         {
            if(i % this.INTERVALFRAM == 0)
            {
               c = info.applicationDomain.getDefinition("_" + (4 * this._info.content.actionFrame + j++)) as Class;
               d = new c();
               this.imgList[i] = d;
            }
            i++;
         }
         GameScene.instance.addFrameCallBack(this.play);
      }
      
      private function play(interval:int) : void
      {
         if(!visible)
         {
            GameScene.instance.removeFrameCallBack(this.play);
         }
         if(this.playIndex < this.imgList.length)
         {
            if(this.imgList[this.playIndex] != null)
            {
               this.imgBM.x = this._info.content.rect[this._info.content.actionFrame * 4 + this.playIndex / this.INTERVALFRAM][0];
               this.imgBM.y = this._info.content.rect[this._info.content.actionFrame * 4 + this.playIndex / this.INTERVALFRAM][1];
               this.imgBM.bitmapData = this.imgList[this.playIndex];
            }
            ++this.playIndex;
         }
         else
         {
            this.playIndex = 0;
         }
      }
      
      private function playImg() : void
      {
         MassLoader.add("modelRes/role/body/run/" + _petVO.img + ".swf",this.onComplete,null,MassLoader.LEVEL2,null,Enum_resType.MODEL_URL);
      }
      
      public function playEff(type:String) : void
      {
         if(type == XIZI)
         {
            (this.viewVec[0] as XiZiPanel).playEff();
         }
         else if(type == LIANHUA)
         {
            (this.viewVec[1] as LianHuaPanel).playEff();
         }
         else if(type == NEIDAN)
         {
            (this.viewVec[2] as NeiDanPanel).playEff();
         }
      }
      
      public function petSkillBook(vo:Vo_valuable) : void
      {
         if(Boolean(_petVO))
         {
            if(this.indexOfJiNeng(vo.id) >= 0)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("10118",1));
            }
            else if(_petVO.jiNengArr.some(function(element:int, index:int, arr:Array):Boolean
            {
               return element == 0;
            }))
            {
               View_Alert.show(LangConfig.getWord("10119",1),View_Alert.OK_CANCAL,function():void
               {
                  BagCGMessage.CG_BAG_REDUCE(BagCGMessage.USE_ITEM,vo.gridId,1);
               },function():void
               {
               });
            }
            else
            {
               View_Alert.show(LangConfig.getWord("10120",1),View_Alert.OK_CANCAL,function():void
               {
                  BagCGMessage.CG_BAG_REDUCE(BagCGMessage.USE_ITEM,vo.gridId,1);
               },function():void
               {
               });
            }
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10121",1));
         }
      }
      
      private function indexOfJiNeng(id:int) : int
      {
         var skillVO:Vo_Skill = null;
         var index:int = -1;
         var i:uint = 0;
         while(i < _petVO.jiNengArr.length)
         {
            if(_petVO.jiNengArr[i] > 0)
            {
               skillVO = new Vo_Skill(_petVO.jiNengArr[i]);
               if(id == skillVO.required_prop)
               {
                  index = int(i);
                  break;
               }
            }
            i++;
         }
         return index;
      }
      
      public function petChangeCard(vo:Vo_valuable) : void
      {
         var petBuffVOVec:Vector.<Vo_Buffer> = null;
         if(Boolean(_petVO))
         {
            petBuffVOVec = BuffterVO.petBuffVOVec;
            if(Boolean(petBuffVOVec.length) && petBuffVOVec[0].propsId != vo.id)
            {
               View_Alert.show(LangConfig.getWord("10122",1),View_Alert.OK_CANCAL,function():void
               {
                  BagCGMessage.CG_BAG_REDUCE(BagCGMessage.USE_ITEM,vo.gridId,1);
               });
            }
            else
            {
               BagCGMessage.CG_BAG_REDUCE(BagCGMessage.USE_ITEM,vo.gridId,1);
            }
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10123",1));
         }
      }
      
      public function openView(type:String, id:int) : void
      {
         if(!_petVO)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10124",1));
            return;
         }
         if(!visible)
         {
            this.visible = true;
         }
         if(type == XIZI)
         {
            this.btnVec[0].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            (this.viewVec[0] as XiZiPanel).selectItem(id);
         }
         else if(type == LIANHUA)
         {
            this.btnVec[1].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            (this.viewVec[1] as LianHuaPanel).selectItem(id);
         }
         else if(type == NEIDAN)
         {
            this.btnVec[2].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
         else if(type == ZHUANGBEI)
         {
            this.btnVec[3].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
      
      public function showXiZhi() : void
      {
         var b:Button = (this.viewVec[0] as XiZiPanel).xiZiBtn;
         var _x:int = (this.viewVec[0] as XiZiPanel).x + (this.viewVec[0] as XiZiPanel).xiZiBtn.x;
         var _y:int = (this.viewVec[0] as XiZiPanel).y + (this.viewVec[0] as XiZiPanel).xiZiBtn.y;
         if(Model_quest.checkCurMainQStepType(Enum_quest_step_type.PET_XI))
         {
            this.openView(XIZI,0);
            QuestGuiManager.addKuang(this,_x - 5,_y - 5,b.width + 11,b.height + 9);
            QuestGuiManager.addJian(this,_x + b.width + 20,_y + b.height / 2,180);
         }
      }
      
      public function showChengZhang() : void
      {
         var b:Button = (this.viewVec[1] as LianHuaPanel).lianHuaBtn;
         var _x:int = (this.viewVec[1] as LianHuaPanel).x + (this.viewVec[1] as LianHuaPanel).lianHuaBtn.x;
         var _y:int = (this.viewVec[1] as LianHuaPanel).y + (this.viewVec[1] as LianHuaPanel).lianHuaBtn.y;
         if(Model_quest.checkCurMainQStepType(Enum_quest_step_type.PET_CHENGZHANG))
         {
            this.openView(LIANHUA,0);
            QuestGuiManager.addKuang(this,_x - 5,_y - 5,b.width + 11,b.height + 9);
            QuestGuiManager.addJian(this,_x + b.width + 20,_y + b.height / 2,180);
         }
      }
      
      public function showCloseGuide() : void
      {
         QuestGuiManager.addKuang(this,CloseButton.x - 5,CloseButton.y - 5,CloseButton.width + 10,CloseButton.height + 10);
         QuestGuiManager.addJian(this,CloseButton.width + CloseButton.x + 3,CloseButton.height / 2 + CloseButton.y,180);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.back.width) / 2;
         y = (Global.stage.stageHeight - this.back.height) / 2;
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(Model_bag.pwdLockState == Model_bag.PWD_STATE_LOCK_T)
         {
            UIManager.bagPwdPutIn.visible = true;
            return;
         }
         if(value)
         {
            super.visible = value;
            this.update();
            this.btnVec[0].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            (this.viewVec[0] as XiZiPanel).visible = true;
            this.showXiZhi();
            this.showChengZhang();
            if(this.isFirstOpen)
            {
               PetEffect.getInstance().load();
               this.isFirstOpen = false;
               Utils.loadTitle("lang/ch/Pet_Imgs.swf","Pet_ProgressHP_board",this.qiXueBG,null,null,this.setBtn);
               Utils.loadTitle("lang/ch/Pet_Imgs.swf","Pet_ProgressHP",this.qiXueBM);
               Utils.loadTitle("lang/ch/Pet_Imgs.swf","Title_Pet",new Bitmap(),{
                  "x":217,
                  "y":5
               },this);
               Utils.loadTitle("lang/ch/Pet_Imgs.swf","Pet_BG",this.petBGBM);
               Utils.loadTitle("lang/ch/Pet_Imgs.swf","Bi",new Bitmap(),{
                  "x":292,
                  "y":62 + 28
               },this);
               Model_pet.addMoveTips(this.jiNengGridVec);
            }
            this.addEff();
            if(!Global.wordEffect)
            {
               UIManager.castPanel.downLoadEffect();
            }
         }
         else
         {
            this.removeEff();
            Model_pet.moveTipsRemove();
            Model_specialD.visFalseComp(this,UIManager.special_btn.petBtn,this.superHide);
            if(View_questGuiJian.instance.bindSpr == this)
            {
               UIManager.questTraceView.showMainQGuide();
            }
         }
      }
      
      private function superHide() : void
      {
         super.visible = false;
      }
      
      private function addEff() : void
      {
         if(!this.effBianSheng)
         {
            this.effBianSheng = EffectManager.addEffect("35160",this.spBianSheng,2000,20,15,true);
         }
      }
      
      public function showND() : void
      {
         var value:Boolean = !visible;
         if(Model_bag.pwdLockState == Model_bag.PWD_STATE_LOCK_T)
         {
            UIManager.bagPwdPutIn.visible = true;
            return;
         }
         if(value)
         {
            super.visible = value;
            this.update();
            this.btnVec[2].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            (this.viewVec[2] as NeiDanPanel).visible = true;
            this.showXiZhi();
            this.showChengZhang();
            if(this.isFirstOpen)
            {
               PetEffect.getInstance().load();
               this.isFirstOpen = false;
               Utils.loadTitle("lang/ch/Pet_Imgs.swf","Pet_ProgressHP_board",this.qiXueBG,null,null,this.setBtn);
               Utils.loadTitle("lang/ch/Pet_Imgs.swf","Pet_ProgressHP",this.qiXueBM);
               Utils.loadTitle("lang/ch/Pet_Imgs.swf","Title_Pet",new Bitmap(),{
                  "x":217,
                  "y":5
               },this);
               Utils.loadTitle("lang/ch/Pet_Imgs.swf","Pet_BG",this.petBGBM);
               Utils.loadTitle("lang/ch/Pet_Imgs.swf","Bi",new Bitmap(),{
                  "x":292,
                  "y":62 + 28
               },this);
               Model_pet.addMoveTips(this.jiNengGridVec);
            }
            this.addEff();
            if(!Global.wordEffect)
            {
               UIManager.castPanel.downLoadEffect();
            }
         }
         else
         {
            this.removeEff();
            Model_pet.moveTipsRemove();
            Model_specialD.visFalseComp(this,UIManager.special_btn.petBtn,this.superHide);
            if(View_questGuiJian.instance.bindSpr == this)
            {
               UIManager.questTraceView.showMainQGuide();
            }
         }
      }
      
      private function removeEff() : void
      {
         if(Boolean(this.effBianSheng))
         {
            EffectManager.removeEffect(this.effBianSheng);
            this.effBianSheng = null;
         }
      }
   }
}

