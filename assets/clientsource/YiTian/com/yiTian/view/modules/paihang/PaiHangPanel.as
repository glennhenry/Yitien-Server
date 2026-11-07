package com.yiTian.view.modules.paihang
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Const_strImg;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.model.Model_worldLevel;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.PaiHangCGMessage;
   import com.yiTian.net.message.cg.RoleCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Enum_explor;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.marriage.VO_MarriageAttribute;
   import com.yiTian.view.modules.newRolePan.PaiHangRolePan;
   import com.yiTian.view.modules.role.RolePanelTip;
   import com.yiTian.view.modules.yellowDiamond.Model_init;
   import com.yiTian.view.modules.zhuanZhi.View_ZhuanZhiAtbSp;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFieldType;
   import flash.text.TextFormatAlign;
   import flash.utils.Dictionary;
   
   public class PaiHangPanel extends Panel
   {
      
      public static const GRID_LEN:int = 11;
      
      public static const KUNLUN_ADD_NUM:int = 2;
      
      private static const MAX_GRID:int = 12;
      
      public static const V1:int = 5;
      
      public static const V2:int = 7;
      
      public static const V3:int = 9;
      
      public static const V4:int = 11;
      
      public static const EFF:int = 3;
      
      private var _paiHangVO:PaiHangVO;
      
      private var vecTB:Vector.<TabButton>;
      
      private var vecTBStr:Vector.<String>;
      
      private var tbtn_now:TabButton;
      
      private var myRankingBtn:Button;
      
      private var prevPageBtn:Button;
      
      private var nextPageBtn:Button;
      
      private var jumpPageBtn:Button;
      
      private var pageTxt:MyTextField;
      
      private var enterPageTxt:MyTextField;
      
      private var zhiYeTxtStatic:MyTextField;
      
      private var zhiYeArr:Array;
      
      private var kunLunClass:Array;
      
      private var wuLinDaHuiClass:Array;
      
      private var meiLiClass:Array;
      
      private var flowersClass:Array;
      
      private var zhiYeTTBVec:Vector.<TxtTabButton>;
      
      private var titleArr:Array;
      
      private var titleArr2:Array;
      
      private var meiLiArr:Array;
      
      private var FlowersArr:Array;
      
      private var endTitleArr:Array;
      
      private var vecPetTitle:Vector.<String>;
      
      private var vecBangTitle:Vector.<String>;
      
      private var titleVec:Vector.<MyTextField>;
      
      private var paiHangItemVec:Vector.<PaiHangItem>;
      
      private var rightContainer:Sprite;
      
      private var CBButton:Button;
      
      private var BSButton:Button;
      
      private var CBvalue:MyTextField;
      
      private var BSvalue:MyTextField;
      
      private var nameTxt:MyTextField;
      
      private var levelTxt:MyTextField;
      
      private var menPaiTxt:MyTextField;
      
      private var playerBM:Bitmap;
      
      private var arr_str:Array;
      
      private var zhanLi:MyTextField;
      
      private var arr_gridPosition:Array = [[256,145],[37,145],[37,241],[37,289],[37,97],[37,193],[256,193],[256,97],[256,241],[256,289],[37,337],[256,337]];
      
      private var vec_grids:Vector.<View_Grid>;
      
      private var worldLvlContainer:Sprite;
      
      private var worldLvlTF:MyTextField;
      
      private var leftBack:DisplayObject;
      
      private var rightBack:DisplayObject;
      
      private var kfBtn:Button;
      
      private var zzAttSP:View_ZhuanZhiAtbSp;
      
      private var hlSP:ringSP;
      
      private var otherRolePan:PaiHangRolePan;
      
      private var isFirstOpen:Boolean = true;
      
      private var effVec:Vector.<Effect> = new Vector.<Effect>();
      
      private var myMove:Sprite;
      
      private var curPHI:PaiHangItem;
      
      private var curTTB:TxtTabButton;
      
      private var curPage:int;
      
      private var curZhiType:int;
      
      private var curPaiHangType:int = 0;
      
      public var vec_Vo_equip_cache:Vector.<Vo_equip>;
      
      private var sp:Sprite;
      
      private var effIcon:Bitmap;
      
      private var effLevel:Sprite;
      
      private var _levelTen:int;
      
      private var _levelSix:int;
      
      private var _levelSixNums:int;
      
      private var _level:int;
      
      private var _nums:int;
      
      private var vecEffId:Vector.<String> = new <String>["35083","35084","35085"];
      
      private var _tip:RolePanelTip;
      
      public function PaiHangPanel()
      {
         super();
      }
      
      public static function GC_JIANGHU_CHUANWEN(CBvalue:int, CBname:String, roleId:Number, CBorBS:int) : void
      {
         if(CBorBS == 1)
         {
            if(CBvalue == 5000)
            {
               UIManager.chatPanel.add(LangConfig.getWord("60441",6,CBname),roleId,101,CBname);
            }
            else
            {
               UIManager.chatPanel.add(LangConfig.getWord("60440",6,CBname,CBvalue),roleId,101,CBname);
            }
         }
         else if(CBorBS == 2)
         {
            if(CBvalue == 5000)
            {
               UIManager.chatPanel.add(LangConfig.getWord("60443",6,CBname),roleId,101,CBname);
            }
            else
            {
               UIManager.chatPanel.add(LangConfig.getWord("60442",6,CBname,CBvalue),roleId,101,CBname);
            }
         }
      }
      
      public static function GC_STRENGTHEN_SET(levelTen:int, levelSix:int, levelSixNums:int, level:int, nums:int) : void
      {
         UIManager.paiHangPanel.strengthenSet(levelTen,levelSix,levelSixNums,level,nums);
      }
      
      public function get paiHangVO() : PaiHangVO
      {
         return this._paiHangVO;
      }
      
      public function set paiHangVO(value:PaiHangVO) : void
      {
         this._paiHangVO = value;
      }
      
      private function initVar() : void
      {
         this.zhiYeArr = [{
            "txt":LangConfig.getWord("10262",1),
            "x":78 + 20 + 100,
            "y":47
         },{
            "txt":LangConfig.getWord("10659",1),
            "x":120 + 20 + 110 - 10,
            "y":47
         },{
            "txt":LangConfig.getWord("10662",1),
            "x":305 + 20 + 110 - 40,
            "y":47
         },{
            "txt":LangConfig.getWord("10661",1),
            "x":240 + 20 + 110 - 30,
            "y":47
         },{
            "txt":LangConfig.getWord("10660",1),
            "x":176 + 20 + 110 - 20,
            "y":47
         }];
         this.kunLunClass = [{
            "txt":LangConfig.getWord("10263",1),
            "x":90 + 120,
            "y":47
         },{
            "txt":LangConfig.getWord("10264",1),
            "x":165 + 120,
            "y":47
         }];
         this.wuLinDaHuiClass = [{
            "txt":LangConfig.getWord("10265",1),
            "x":90,
            "y":47
         },{
            "txt":LangConfig.getWord("10266",1),
            "x":170,
            "y":47
         },{
            "txt":LangConfig.getWord("10267",1),
            "x":252,
            "y":47
         }];
         this.meiLiClass = [{
            "txt":LangConfig.getWord("60223",6),
            "x":90 + 120,
            "y":47
         },{
            "txt":LangConfig.getWord("60224",6),
            "x":170 + 120,
            "y":47
         }];
         this.flowersClass = [{
            "txt":LangConfig.getWord("60225",6),
            "x":90 + 120,
            "y":47
         },{
            "txt":LangConfig.getWord("60226",6),
            "x":170 + 120,
            "y":47
         }];
         this.titleArr = [{
            "txt":LangConfig.getWord("10268",1),
            "x":160,
            "y":73.05,
            "realWidth":26
         },{
            "txt":LangConfig.getWord("10269",1),
            "x":232,
            "y":73.05,
            "realWidth":76.2
         },{
            "txt":LangConfig.getWord("10270",1),
            "x":325,
            "y":73.05,
            "realWidth":85
         },{
            "txt":Data_lib.attribute[24][0],
            "x":402,
            "y":73.05,
            "realWidth":76.2
         },{
            "txt":Data_lib.attribute[23][0],
            "x":483,
            "y":73.05,
            "realWidth":78
         }];
         this.titleArr2 = [{"x":160},{"x":202},{"x":290},{"x":412},{"x":483}];
         this.meiLiArr = [{
            "txt":LangConfig.getWord("10268",1),
            "x":169,
            "y":73.05,
            "realWidth":26
         },{
            "txt":LangConfig.getWord("10269",1),
            "x":222,
            "y":73.05,
            "realWidth":76.2
         },{
            "txt":LangConfig.getWord("60227",6),
            "x":330,
            "y":73.05,
            "realWidth":100
         },{
            "txt":LangConfig.getWord("60158",6),
            "x":468,
            "y":73.05,
            "realWidth":76.2
         }];
         this.FlowersArr = [{
            "txt":LangConfig.getWord("10268",1),
            "x":169,
            "y":73.05,
            "realWidth":26
         },{
            "txt":LangConfig.getWord("10269",1),
            "x":222,
            "y":73.05,
            "realWidth":76.2
         },{
            "txt":LangConfig.getWord("60228",6),
            "x":330,
            "y":73.05,
            "realWidth":100
         },{
            "txt":LangConfig.getWord("60158",6),
            "x":468,
            "y":73.05,
            "realWidth":76.2
         }];
         this.endTitleArr = [{
            "txt":Data_lib.attribute[23][0],
            "x":435,
            "y":73.05
         },{
            "txt":Data_lib.attribute[28][0],
            "x":456.2,
            "y":73.05
         },{
            "txt":LangConfig.getWord("10271",1),
            "x":456.2,
            "y":73.05
         },{
            "txt":LangConfig.getWord("10272",1),
            "x":456.2,
            "y":73.05
         },{
            "txt":LangConfig.getWord("10273",1),
            "x":456.2,
            "y":73.05
         }];
         this.vecPetTitle = new <String>[LangConfig.getWord("10268",1),LangConfig.getWord("10269",1),LangConfig.getWord("10274",1),LangConfig.getWord("10087",1),LangConfig.getWord("10104",1)];
         this.vecBangTitle = new <String>[LangConfig.getWord("10268",1),LangConfig.getWord("10275",1),LangConfig.getWord("10276",1),LangConfig.getWord("10277",1),LangConfig.getWord("10278",1)];
         this.arr_str = [LangConfig.getWord("10279",1),LangConfig.getWord("10280",1),LangConfig.getWord("10281",1),LangConfig.getWord("10282",1),LangConfig.getWord("10283",1),LangConfig.getWord("10284",1),LangConfig.getWord("10290",1),LangConfig.getWord("10286",1),LangConfig.getWord("10291",1),LangConfig.getWord("10292",1),LangConfig.getWord("10289",1),LangConfig.getWord("10288",1)];
      }
      
      override protected function initStaticView() : void
      {
         var ttb:TxtTabButton = null;
         var i:uint = 0;
         var tb:TabButton = null;
         var txt:MyTextField = null;
         var phi:PaiHangItem = null;
         var grid:View_Grid = null;
         this.initVar();
         this.leftBack = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":584,
            "height":435
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":536,
            "height":385
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":34,
            "y":72,
            "width":110,
            "height":315
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":150,
            "y":72,
            "width":400,
            "height":315
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":152,
            "y":74,
            "width":396,
            "height":20
         },Global.Img_Cdm);
         this.zhiYeTxtStatic = ComponentUtil.getTextField(LangConfig.getWord("10293",1),this,{
            "x":50 + 100,
            "y":47,
            "color":11904647
         });
         this.zhiYeTTBVec = new Vector.<TxtTabButton>();
         i = 0;
         while(i < 5)
         {
            ttb = new TxtTabButton(this.zhiYeArr[i].txt);
            ttb.index = i;
            ttb.x = this.zhiYeArr[i].x;
            ttb.y = this.zhiYeArr[i].y;
            addChild(ttb);
            this.zhiYeTTBVec.push(ttb);
            ttb.addEventListener(MouseEvent.CLICK,this.TTBClickHandler);
            i++;
         }
         this.worldLvlContainer = new Sprite();
         addChild(this.worldLvlContainer);
         this.worldLvlTF = ComponentUtil.getTextField(LangConfig.getWord("60229",6),this.worldLvlContainer,{
            "x":440,
            "y":47
         });
         this.worldLvlTF.visible = false;
         this.vecTBStr = new <String>[LangConfig.getWord("10294",1),LangConfig.getWord("10295",1),LangConfig.getWord("10296",1),LangConfig.getWord("10297",1),LangConfig.getWord("10299",1),LangConfig.getWord("10300",1),LangConfig.getWord("60230",6),LangConfig.getWord("60231",6)];
         this.vecTB = new Vector.<TabButton>();
         i = 0;
         while(i < this.vecTBStr.length)
         {
            tb = ComponentUtil.getTabButton(this.vecTBStr[i],"ClassButton",this,{
               "x":43,
               "y":79 + i * 34,
               "textColor":12232795,
               "chooseColor":16773818
            },Global.Img_Cdm);
            tb.addEventListener(MouseEvent.CLICK,this.tabButtonClickHandler);
            this.vecTB.push(tb);
            i++;
         }
         this.kfBtn = ComponentUtil.getButton("","Button_KFML",this,{
            "x":43,
            "y":79 - 34,
            "textColor":12232795
         },Global.Img_Cdm);
         this.kfBtn.addEventListener(MouseEvent.CLICK,this.kfmlOpen);
         this.tbtn_now = this.vecTB[0];
         this.tbtn_now.choose = true;
         this.myRankingBtn = ComponentUtil.getButton(LangConfig.getWord("10301",1),"Button_Four",this,{
            "x":54,
            "y":393,
            "textColor":16184781
         },Global.Img_Cdm);
         this.myRankingBtn.textColor = 10148472;
         this.myRankingBtn.textOverColor = 10148472;
         this.myRankingBtn.addEventListener(MouseEvent.CLICK,this.btnClickHandler);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":291,
            "y":394,
            "width":60,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":440,
            "y":394,
            "width":35,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60232",6),this,{
            "x":409,
            "y":395,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.prevPageBtn = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":268,
            "y":394,
            "textColor":16184781
         },Global.Img_Cdm);
         this.prevPageBtn.name = "prevPage";
         this.pageTxt = ComponentUtil.getTextField("00/00",this,{
            "x":302,
            "y":395,
            "color":14662240,
            "size":12,
            "leading":0
         });
         this.pageTxt.realWidth = 37;
         this.pageTxt.align = TextFormatAlign.CENTER;
         this.nextPageBtn = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":353,
            "y":394,
            "textColor":16184781
         },Global.Img_Cdm);
         this.nextPageBtn.name = "nextPage";
         this.enterPageTxt = ComponentUtil.getTextField("1",this,{
            "x":440,
            "y":395,
            "color":14662240,
            "size":12,
            "leading":0
         });
         this.enterPageTxt.type = TextFieldType.INPUT;
         this.enterPageTxt.align = TextFormatAlign.CENTER;
         this.enterPageTxt.realWidth = 35;
         this.enterPageTxt.restrict = "0-9";
         this.jumpPageBtn = ComponentUtil.getButton(LangConfig.getWord("10302",1),"Button_Two",this,{
            "x":500,
            "y":393,
            "textColor":16184781
         },Global.Img_Cdm);
         this.jumpPageBtn.textColor = 10148472;
         this.jumpPageBtn.textOverColor = 10148472;
         this.prevPageBtn.addEventListener(MouseEvent.CLICK,this.pageHandler);
         this.nextPageBtn.addEventListener(MouseEvent.CLICK,this.pageHandler);
         this.enterPageTxt.addEventListener(Event.CHANGE,this.txtChangeHandler);
         this.jumpPageBtn.addEventListener(MouseEvent.CLICK,this.btnClickHandler);
         this.titleVec = new Vector.<MyTextField>();
         i = 0;
         while(i < 5)
         {
            txt = ComponentUtil.getTextField("",this,{
               "x":this.titleArr[i].x,
               "y":this.titleArr[i].y,
               "color":16764206
            });
            txt.realWidth = this.titleArr[i].realWidth;
            txt.align = TextFormatAlign.CENTER;
            this.titleVec.push(txt);
            txt.text = this.titleArr[i].txt;
            i++;
         }
         this.paiHangItemVec = new Vector.<PaiHangItem>();
         i = 0;
         while(i < 10)
         {
            phi = new PaiHangItem();
            phi.x = 158;
            phi.y = 97 + (27 + 2) * i;
            phi.index = i;
            phi.reset();
            addChild(phi);
            this.paiHangItemVec.push(phi);
            i++;
         }
         this.otherRolePan = new PaiHangRolePan();
         ComponentUtil.setPropertie(this.otherRolePan,{"x":this.leftBack.width + 10});
         addChild(this.otherRolePan);
         this.rightContainer = new Sprite();
         addChild(this.rightContainer);
         this.rightContainer.visible = false;
         var bitmap:Bitmap = new Bitmap();
         this.rightBack = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.rightContainer,{
            "x":this.leftBack.width + 10,
            "width":327,
            "height":450
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this.rightContainer,{
            "x":this.rightBack.x + 24,
            "y":38,
            "width":279,
            "height":405
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this.rightContainer,{
            "x":this.rightBack.x + 40,
            "y":385,
            "width":250,
            "height":2
         },Global.Img_Cdm);
         this.playerBM = ComponentUtil.getBitmap("",this.rightContainer,{
            "x":this.rightBack.x + 45,
            "y":70
         });
         var tempDJ:MyTextField = ComponentUtil.getTextField(LangConfig.getWord("10303",1),this.rightContainer,{
            "x":this.rightBack.x + 60,
            "y":75,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.nameTxt = ComponentUtil.getTextField("",this.rightContainer,{
            "x":this.rightBack.x + 94,
            "y":47,
            "color":3644132,
            "size":16,
            "leading":0
         });
         this.nameTxt.size = 16;
         this.nameTxt.realWidth = 150;
         this.nameTxt.align = TextFormatAlign.CENTER;
         this.levelTxt = ComponentUtil.getTextField("",this.rightContainer,{
            "x":this.rightBack.x + 101,
            "y":75,
            "color":14662240
         });
         this.menPaiTxt = ComponentUtil.getTextField("",this.rightContainer,{
            "x":this.rightBack.x + 216,
            "y":75,
            "color":14662240,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60482",6),this.rightContainer,{
            "x":this.rightBack.x + 175,
            "y":75,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.CBvalue = ComponentUtil.getTextField("0",this.rightContainer,{
            "x":this.rightBack.x + 111,
            "y":395,
            "color":14662240,
            "size":12,
            "leading":0
         });
         this.BSvalue = ComponentUtil.getTextField("0",this.rightContainer,{
            "x":this.rightBack.x + 256,
            "y":395,
            "color":14662240,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60483",6),this.rightContainer,{
            "x":this.rightBack.x + 41,
            "y":395,
            "color":14662240,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60484",6),this.rightContainer,{
            "x":this.rightBack.x + 186,
            "y":395,
            "color":14662240,
            "size":12,
            "leading":0
         });
         this.CBButton = ComponentUtil.getButton(LangConfig.getWord("60485",6),"Button_Two64",this.rightContainer,{
            "x":this.rightBack.x + 63,
            "y":415,
            "textColor":16773818
         },Global.Img_Cdm);
         this.BSButton = ComponentUtil.getButton(LangConfig.getWord("60486",6),"Button_Two64",this.rightContainer,{
            "x":this.rightBack.x + 201,
            "y":415,
            "textColor":16773818
         },Global.Img_Cdm);
         this.rightContainer.addChild(bitmap);
         Utils.loadTitle("lang/ch/Rank_Imgs.swf","Back_Power",bitmap,{
            "x":this.rightBack.x + 95,
            "y":345
         });
         this.zhanLi = ComponentUtil.getTextField("",this.rightContainer,{
            "x":this.rightBack.x + 115,
            "y":350,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.zhanLi.realWidth = 100;
         this.zhanLi.align = TextFormatAlign.CENTER;
         this.CBButton.addEventListener(MouseEvent.CLICK,this.CBClick);
         this.BSButton.addEventListener(MouseEvent.CLICK,this.BSClick);
         this.vec_grids = new Vector.<View_Grid>(GRID_LEN,true);
         i = 0;
         while(i < this.vec_grids.length)
         {
            grid = new View_Grid();
            grid.type = Enum_type_grid.ROLE_PAIHANG;
            grid.set_bmp_bg();
            grid.set_bmp_over();
            grid.set_tf_info(this.arr_str[i]);
            grid.index = i + 1;
            grid.x = this.rightBack.x + this.arr_gridPosition[i][0];
            grid.y = this.arr_gridPosition[i][1];
            this.rightContainer.addChild(grid);
            this.vec_grids[i] = grid;
            this.effVec.push(new Effect());
            i++;
         }
         this.hlSP = new ringSP();
         ComponentUtil.setPropertie(this.hlSP,{
            "x":this.rightBack.x + 200,
            "y":105
         });
         this.rightContainer.addChild(this.hlSP);
         this.myMove = new Sprite();
         this.myMove.graphics.beginFill(0,0);
         this.myMove.graphics.drawRect(0,0,this.leftBack.width,35);
         this.myMove.graphics.endFill();
         addChild(this.myMove);
         this.myMove.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         this.myMove.addEventListener(MouseEvent.MOUSE_UP,this.stopMove);
         this.myMove.addEventListener(MouseEvent.ROLL_OUT,this.stopMove);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":544,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         CloseButton.x = this.leftBack.width - CloseButton.width - 8;
         this.zzAttSP = new View_ZhuanZhiAtbSp();
         this.zzAttSP.enableLoad();
         ComponentUtil.setPropertie(this.zzAttSP,{
            "x":685,
            "y":96
         });
         this.rightContainer.addChild(this.zzAttSP);
      }
      
      public function updateRing(ringID:int, qmd:int) : void
      {
         this.hlSP.visible = ringID > 0;
         if(ringID <= 0)
         {
            return;
         }
         var vo:VO_MarriageAttribute = new VO_MarriageAttribute();
         vo.ringId = ringID;
         vo.qmd = qmd;
         this.hlSP.setInfo(vo);
      }
      
      private function kfmlOpen(e:MouseEvent) : void
      {
         this.visible = false;
         PaiHangCGMessage.CG_KUAFU_FLOWERS(1);
      }
      
      public function open() : void
      {
         this.otherRolePan.open(this._paiHangVO.paiHangItemArr[this.curPHI.index][1],PaiHangVO.index);
      }
      
      public function isBtn() : void
      {
         switch(PaiHangVO.isButton)
         {
            case 1:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("60492",6));
               break;
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("60493",6));
               break;
            case 3:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("60494",6));
               break;
            case 4:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("60495",6));
               break;
            case 5:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("60496",6));
               break;
            case 6:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("60497",6));
         }
      }
      
      private function CBClick(e:MouseEvent) : void
      {
         RoleCGMessage.CG_PAIHANG_CLICK(Model_heFu.repName(this._paiHangVO.paiHangItemArr[this.curPHI.index][1]),1);
      }
      
      private function BSClick(e:MouseEvent) : void
      {
         RoleCGMessage.CG_PAIHANG_CLICK(Model_heFu.repName(this._paiHangVO.paiHangItemArr[this.curPHI.index][1]),2);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.hlSP.isAutoLoad = true;
            if(this.isFirstOpen)
            {
               this.isFirstOpen = false;
               bind_target = Enum_explor.bind(Enum_explor.BTN_BANG);
               Utils.loadTitle("lang/ch/Rank_Imgs.swf","Title_Rank",new Bitmap(),{
                  "x":212,
                  "y":5
               },this);
               Utils.loadTitle("lang/ch/Rank_Imgs.swf","Title_RoleInf",new Bitmap(),{
                  "x":this.rightBack.x + 84,
                  "y":5
               },this.rightContainer);
            }
         }
         else
         {
            if(!this.isFirstOpen)
            {
               this.removeGridEff();
            }
            if(Boolean(this.tbtn_now))
            {
               this.tbtn_now.choose = false;
            }
            this.vecTB[0].choose = true;
            this.tbtn_now = this.vecTB[0];
         }
      }
      
      private function showGridEff() : void
      {
         if(Model_init.isChangeEff)
         {
            return;
         }
         this.removeGridEff();
         var i:int = 0;
         while(i < GRID_LEN)
         {
            if(Boolean(this.vec_grids[i].vo))
            {
               if((this.vec_grids[i].vo as Vo_equip).color == 5 && (this.vec_grids[i].vo as Vo_equip).lv == 10)
               {
                  this.effVec[i] = EffectManager.addEffect("35064",this.vec_grids[i],1000,14.5,16,true);
               }
            }
            i++;
         }
      }
      
      public function get paiHangVecG() : Vector.<View_Grid>
      {
         return this.vec_grids;
      }
      
      private function removeGridEff() : void
      {
         if(Model_init.isChangeEff)
         {
            return;
         }
         var i:int = 0;
         while(i < GRID_LEN)
         {
            if(Boolean(this.effVec[i]))
            {
               EffectManager.removeEffect(this.effVec[i]);
               this.effVec[i] = null;
            }
            i++;
         }
      }
      
      protected function onMouseDown(e:MouseEvent) : void
      {
         startDrag();
      }
      
      protected function stopMove(e:MouseEvent) : void
      {
         stopDrag();
      }
      
      protected function tabButtonClickHandler(event:MouseEvent) : void
      {
         var type:int = 0;
         var tbtn:TabButton = event.target as TabButton;
         if(this.tbtn_now == tbtn)
         {
            return;
         }
         if(this.tbtn_now != null)
         {
            this.tbtn_now.choose = false;
         }
         tbtn.choose = true;
         this.tbtn_now = tbtn;
         switch(tbtn.text)
         {
            case LangConfig.getWord("10294",1):
               PaiHangCGMessage.CG_PAIHANG_DENGJI(0,1);
               break;
            case LangConfig.getWord("10295",1):
               PaiHangCGMessage.CG_PAIHANG_ZHANLI(0,1);
               break;
            case LangConfig.getWord("10296",1):
               PaiHangCGMessage.CG_PAIHANG_CAIFU(1);
               break;
            case LangConfig.getWord("10297",1):
               PaiHangCGMessage.CG_PAIHANG_KUNLUN(1 + KUNLUN_ADD_NUM,1);
               break;
            case LangConfig.getWord("10298",1):
               if(GameUnitManager.hero.level < 50)
               {
                  type = 1;
               }
               else if(GameUnitManager.hero.level < 70)
               {
                  type = 2;
               }
               else
               {
                  type = 3;
               }
               PaiHangCGMessage.CG_PAIHANG_WULINDAHUI(type,1);
               break;
            case LangConfig.getWord("10299",1):
               PaiHangCGMessage.CG_PAIHANG_PET(1);
               break;
            case LangConfig.getWord("10300",1):
               PaiHangCGMessage.CG_PAIHANG_BANGHUI(1);
               break;
            case LangConfig.getWord("60230",6):
               PaiHangCGMessage.CG_PAIHANG_MEILI(1,1);
               break;
            case LangConfig.getWord("60231",6):
               PaiHangCGMessage.CG_PAIHANG_FLOWERS(3,1);
         }
      }
      
      private function isShowRight(b:Boolean) : void
      {
         this.rightContainer.visible = b;
         this.otherRolePan.isShow = b;
         if(b)
         {
            this.myMove.width = this.rightBack.x + this.rightBack.width;
         }
         else
         {
            this.rightContainer.visible = false;
            this.myMove.width = this.leftBack.width;
         }
         this.rightContainer.visible = false;
      }
      
      protected function btnClickHandler(event:MouseEvent) : void
      {
         var btn:Button = event.target as Button;
         switch(btn.label)
         {
            case LangConfig.getWord("10301",1):
               if(this.curPaiHangType == 4)
               {
                  PaiHangCGMessage.CG_PAIHANG_MY(this.curZhiType + 11);
                  break;
               }
               if(this.curPaiHangType == 5)
               {
                  PaiHangCGMessage.CG_PAIHANG_MY(this.curZhiType + 5);
                  break;
               }
               if(this.curPaiHangType == 6)
               {
                  PaiHangCGMessage.CG_PAIHANG_MY(9);
                  break;
               }
               if(this.curPaiHangType == 8)
               {
                  PaiHangCGMessage.CG_PAIHANG_MY(this.curZhiType + 9);
                  break;
               }
               if(this.curPaiHangType == 9)
               {
                  PaiHangCGMessage.CG_PAIHANG_MY(this.curZhiType + 9);
                  break;
               }
               PaiHangCGMessage.CG_PAIHANG_MY(this.curPaiHangType);
               break;
            case LangConfig.getWord("10302",1):
               if(!this.enterPageTxt.text)
               {
                  UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10304",1) + "</font>");
                  return;
               }
               if(this.curPage == int(this.enterPageTxt.text))
               {
                  UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10305",1) + "</font>");
                  return;
               }
               if(this._paiHangVO.curPaiHangType == 1)
               {
                  PaiHangCGMessage.CG_PAIHANG_DENGJI(this._paiHangVO.curZhiYeType,int(this.enterPageTxt.text));
                  break;
               }
               if(this._paiHangVO.curPaiHangType == 2)
               {
                  PaiHangCGMessage.CG_PAIHANG_ZHANLI(this._paiHangVO.curZhiYeType,int(this.enterPageTxt.text));
                  break;
               }
               if(this._paiHangVO.curPaiHangType == 3)
               {
                  PaiHangCGMessage.CG_PAIHANG_CAIFU(int(this.enterPageTxt.text));
                  break;
               }
               if(this._paiHangVO.curPaiHangType == 4)
               {
                  PaiHangCGMessage.CG_PAIHANG_KUNLUN(this._paiHangVO.curZhiYeType + KUNLUN_ADD_NUM,int(this.enterPageTxt.text));
                  break;
               }
               if(this._paiHangVO.curPaiHangType == 5)
               {
                  PaiHangCGMessage.CG_PAIHANG_WULINDAHUI(this._paiHangVO.curZhiYeType,int(this.enterPageTxt.text));
                  break;
               }
               if(this._paiHangVO.curPaiHangType == 6)
               {
                  PaiHangCGMessage.CG_PAIHANG_PET(int(this.enterPageTxt.text));
                  break;
               }
               if(this._paiHangVO.curPaiHangType == 7)
               {
                  PaiHangCGMessage.CG_PAIHANG_BANGHUI(int(this.enterPageTxt.text));
                  break;
               }
               if(this._paiHangVO.curPaiHangType == 8)
               {
                  PaiHangCGMessage.CG_PAIHANG_MEILI(this._paiHangVO.curZhiYeType,int(this.enterPageTxt.text));
                  break;
               }
               if(this._paiHangVO.curPaiHangType == 9)
               {
                  PaiHangCGMessage.CG_PAIHANG_FLOWERS(this._paiHangVO.curZhiYeType,int(this.enterPageTxt.text));
               }
         }
      }
      
      protected function pageHandler(event:MouseEvent) : void
      {
         var str:String = event.target.name;
         if(str == "prevPage")
         {
            if(this.curPage > 1)
            {
               --this.curPage;
               this.goToPage();
            }
         }
         else if(str == "nextPage")
         {
            if(this.curPage < this._paiHangVO.totalPage)
            {
               ++this.curPage;
               this.goToPage();
            }
         }
      }
      
      private function goToPage() : void
      {
         switch(this.curPaiHangType)
         {
            case 1:
               PaiHangCGMessage.CG_PAIHANG_DENGJI(this.curZhiType,this.curPage);
               break;
            case 2:
               PaiHangCGMessage.CG_PAIHANG_ZHANLI(this.curZhiType,this.curPage);
               break;
            case 3:
               PaiHangCGMessage.CG_PAIHANG_CAIFU(this.curPage);
               break;
            case 4:
               PaiHangCGMessage.CG_PAIHANG_KUNLUN(this.curZhiType,this.curPage);
               break;
            case 5:
               PaiHangCGMessage.CG_PAIHANG_WULINDAHUI(this.curZhiType,this.curPage);
               break;
            case 6:
               PaiHangCGMessage.CG_PAIHANG_PET(this.curPage);
               break;
            case 7:
               PaiHangCGMessage.CG_PAIHANG_BANGHUI(this.curPage);
               break;
            case 8:
               PaiHangCGMessage.CG_PAIHANG_MEILI(this.curZhiType,this.curPage);
               break;
            case 9:
               PaiHangCGMessage.CG_PAIHANG_FLOWERS(this.curZhiType,this.curPage);
         }
      }
      
      protected function txtChangeHandler(event:Event) : void
      {
         if(this.enterPageTxt.text == "")
         {
            return;
         }
         var val:int = int(this.enterPageTxt.text);
         if(val > this._paiHangVO.totalPage || val < 1)
         {
            this.enterPageTxt.text = this._paiHangVO.totalPage.toString();
         }
      }
      
      protected function PHIClickHandler(event:MouseEvent) : void
      {
         var phi:PaiHangItem = event.currentTarget as PaiHangItem;
         if(this.curPHI == phi)
         {
            return;
         }
         if(Boolean(this.curPHI))
         {
            this.curPHI.choose = false;
         }
         phi.choose = true;
         this.curPHI = phi;
         this.updateRing(0,0);
         var i:int = 0;
         while(i < GRID_LEN)
         {
            this.vec_grids[i].stoneLvl = 0;
            i++;
         }
         if(this._paiHangVO.curPaiHangType == 6 || this._paiHangVO.curPaiHangType == 7)
         {
            return;
         }
         this.nameTxt.text = this._paiHangVO.paiHangItemArr[phi.index][1];
         this.levelTxt.text = this._paiHangVO.paiHangItemArr[phi.index][4];
         Utils.getLoadBitmap(Const_strImg.getPlayerHead(this._paiHangVO.paiHangItemArr[phi.index][2],this._paiHangVO.paiHangItemArr[phi.index][this._paiHangVO.curPaiHangType == 1 ? 6 : 7],5),this.playerBM);
         this.zzAttSP.setJob(this._paiHangVO.paiHangItemArr[phi.index][2]);
         this.updateOtherRoleInfo(phi.index);
         RoleCGMessage.CG_NAME_CLICK(this.nameTxt.text);
      }
      
      protected function TTBClickHandler(event:MouseEvent) : void
      {
         var ttb:TxtTabButton = event.target as TxtTabButton;
         if(this.curTTB == ttb)
         {
            return;
         }
         if(Boolean(this.curTTB))
         {
            this.curTTB.choose = false;
         }
         ttb.choose = true;
         this.curTTB = ttb;
         this.curZhiType = ttb.index;
         if(this.curPaiHangType == 1)
         {
            PaiHangCGMessage.CG_PAIHANG_DENGJI(this.curZhiType,1);
         }
         else if(this.curPaiHangType == 2)
         {
            PaiHangCGMessage.CG_PAIHANG_ZHANLI(this.curZhiType,1);
         }
         else if(this.curPaiHangType == 4)
         {
            PaiHangCGMessage.CG_PAIHANG_KUNLUN(this.curZhiType + 1 + KUNLUN_ADD_NUM,1);
         }
         else if(this.curPaiHangType == 5)
         {
            PaiHangCGMessage.CG_PAIHANG_WULINDAHUI(this.curZhiType + 1,1);
         }
         else if(this.curPaiHangType == 8)
         {
            PaiHangCGMessage.CG_PAIHANG_MEILI(this.curZhiType + 1,1);
         }
         else if(this.curPaiHangType == 9)
         {
            PaiHangCGMessage.CG_PAIHANG_FLOWERS(this.curZhiType + 3,1);
         }
      }
      
      public function update() : void
      {
         var equipIndex:uint;
         var i:int = 0;
         this.enterPageTxt.text = this._paiHangVO.curPage.toString();
         this.curPage = this._paiHangVO.curPage;
         this.curZhiType = this._paiHangVO.curZhiYeType;
         this.curPaiHangType = this._paiHangVO.curPaiHangType;
         if(this._paiHangVO.totalPage == 0)
         {
            this._paiHangVO.totalPage = 1;
         }
         this.pageTxt.text = this._paiHangVO.curPage + "/" + this._paiHangVO.totalPage;
         if(this._paiHangVO.isShowZhiYe)
         {
            this.zhiYeTxtStatic.visible = true;
            this.zhiYeTxtStatic.text = LangConfig.getWord("10293",1);
            this.zhiYeTTBVec.forEach(function(item:TxtTabButton, index:int, vec:Vector.<TxtTabButton>):void
            {
               item.visible = true;
               item.x = zhiYeArr[index].x;
               item.y = zhiYeArr[index].y;
               item.label = zhiYeArr[index].txt;
            });
            if(Boolean(this.curTTB))
            {
               this.curTTB.choose = false;
               this.curTTB = null;
            }
            this.zhiYeTTBVec[this._paiHangVO.curZhiYeType].choose = true;
            this.curTTB = this.zhiYeTTBVec[this._paiHangVO.curZhiYeType];
         }
         else if(this._paiHangVO.isShowKunLunClass)
         {
            this.zhiYeTxtStatic.visible = true;
            this.zhiYeTxtStatic.text = LangConfig.getWord("10306",1);
            this.zhiYeTTBVec.forEach(function(item:TxtTabButton, index:int, vec:Vector.<TxtTabButton>):void
            {
               if(index < 2)
               {
                  item.visible = true;
                  item.x = kunLunClass[index].x;
                  item.y = kunLunClass[index].y;
                  item.label = kunLunClass[index].txt;
               }
               else
               {
                  item.visible = false;
               }
            });
         }
         else if(this._paiHangVO.isShowWuLinDaHuiClass)
         {
            this.zhiYeTxtStatic.visible = true;
            this.zhiYeTxtStatic.text = LangConfig.getWord("10306",1);
            this.zhiYeTTBVec.forEach(function(item:TxtTabButton, index:int, vec:Vector.<TxtTabButton>):void
            {
               if(index < 3)
               {
                  item.visible = true;
                  item.x = wuLinDaHuiClass[index].x;
                  item.y = wuLinDaHuiClass[index].y;
                  item.label = wuLinDaHuiClass[index].txt;
               }
               else
               {
                  item.visible = false;
               }
            });
            if(Boolean(this.curTTB))
            {
               this.curTTB.choose = false;
               this.curTTB = null;
            }
            this.zhiYeTTBVec[this._paiHangVO.curZhiYeType - 1].choose = true;
            this.curTTB = this.zhiYeTTBVec[this._paiHangVO.curZhiYeType - 1];
         }
         else if(this._paiHangVO.isShowMeiLiClass)
         {
            this.zhiYeTxtStatic.visible = true;
            this.zhiYeTxtStatic.text = LangConfig.getWord("10306",1);
            this.zhiYeTTBVec.forEach(function(item:TxtTabButton, index:int, vec:Vector.<TxtTabButton>):void
            {
               if(index < 2)
               {
                  item.visible = true;
                  item.x = meiLiClass[index].x;
                  item.y = meiLiClass[index].y;
                  item.label = meiLiClass[index].txt;
               }
               else
               {
                  item.visible = false;
               }
            });
            if(Boolean(this.curTTB))
            {
               this.curTTB.choose = false;
               this.curTTB = null;
            }
            this.zhiYeTTBVec[this._paiHangVO.curZhiYeType - 1].choose = true;
            this.curTTB = this.zhiYeTTBVec[this._paiHangVO.curZhiYeType - 1];
         }
         else if(this._paiHangVO.isShowFlowersClass)
         {
            this.zhiYeTxtStatic.visible = true;
            this.zhiYeTxtStatic.text = LangConfig.getWord("10306",1);
            this.zhiYeTTBVec.forEach(function(item:TxtTabButton, index:int, vec:Vector.<TxtTabButton>):void
            {
               if(index < 2)
               {
                  item.visible = true;
                  item.x = flowersClass[index].x;
                  item.y = flowersClass[index].y;
                  item.label = flowersClass[index].txt;
               }
               else
               {
                  item.visible = false;
               }
            });
            if(Boolean(this.curTTB))
            {
               this.curTTB.choose = false;
               this.curTTB = null;
            }
            this.zhiYeTTBVec[this._paiHangVO.curZhiYeType - 3].choose = true;
            this.curTTB = this.zhiYeTTBVec[this._paiHangVO.curZhiYeType - 3];
         }
         else
         {
            this.zhiYeTxtStatic.visible = false;
            this.zhiYeTTBVec.forEach(function(item:TxtTabButton, index:int, vec:Vector.<TxtTabButton>):void
            {
               item.visible = false;
            });
         }
         if(this._paiHangVO.curPaiHangType == 1 || this._paiHangVO.curPaiHangType == 2 || this._paiHangVO.curPaiHangType == 3 || this._paiHangVO.curPaiHangType == 4 || this._paiHangVO.curPaiHangType == 5)
         {
            this.titleVec.forEach(function(item:MyTextField, index:int, vec:Vector.<MyTextField>):void
            {
               item.text = titleArr[index].txt;
               item.x = titleArr[index].x;
               item.realWidth = titleArr[index].realWidth;
            });
            this.titleVec[4].text = this.endTitleArr[this._paiHangVO.curPaiHangType - 1].txt;
            if((this._paiHangVO.curPaiHangType == 4 || this._paiHangVO.curPaiHangType == 5) && !this._paiHangVO.paiHangItemArr.length)
            {
               this.isShowRight(false);
            }
            else
            {
               this.isShowRight(true);
            }
         }
         else if(this._paiHangVO.curPaiHangType == 6)
         {
            this.titleVec.forEach(function(item:MyTextField, index:int, vec:Vector.<MyTextField>):void
            {
               item.text = vecPetTitle[index];
               item.x = titleArr[index].x;
               item.realWidth = titleArr[index].realWidth;
            });
            this.isShowRight(false);
         }
         else if(this._paiHangVO.curPaiHangType == 7)
         {
            this.titleVec.forEach(function(item:MyTextField, index:int, vec:Vector.<MyTextField>):void
            {
               item.text = vecBangTitle[index];
               item.x = titleArr2[index].x;
               item.realWidth = titleArr[index].realWidth;
            });
            this.isShowRight(false);
         }
         else if(this._paiHangVO.curPaiHangType == 8)
         {
            i = 0;
            while(i < this.meiLiArr.length)
            {
               this.titleVec[i].text = this.meiLiArr[i].txt;
               this.titleVec[i].x = this.meiLiArr[i].x;
               this.titleVec[i].realWidth = this.meiLiArr[i].realWidth;
               i++;
            }
            if(!this._paiHangVO.paiHangItemArr.length)
            {
               this.isShowRight(false);
            }
            else
            {
               this.isShowRight(true);
            }
         }
         else if(this._paiHangVO.curPaiHangType == 9)
         {
            i = 0;
            while(i < this.FlowersArr.length)
            {
               this.titleVec[i].text = this.FlowersArr[i].txt;
               this.titleVec[i].x = this.FlowersArr[i].x;
               this.titleVec[i].realWidth = this.FlowersArr[i].realWidth;
               i++;
            }
            if(!this._paiHangVO.paiHangItemArr.length)
            {
               this.isShowRight(false);
            }
            else
            {
               this.isShowRight(true);
            }
         }
         if(this._paiHangVO.curPaiHangType == 8 || this._paiHangVO.curPaiHangType == 9)
         {
            this.titleVec[4].visible = false;
         }
         else
         {
            this.titleVec[4].visible = true;
         }
         if(this._paiHangVO.curPaiHangType == 7)
         {
            this.myRankingBtn.visible = false;
         }
         else
         {
            this.myRankingBtn.visible = true;
         }
         if(Boolean(this.curPHI))
         {
            this.curPHI.choose = false;
            this.curPHI = null;
         }
         this.paiHangItemVec.forEach(function(item:PaiHangItem, index:int, vec:Vector.<PaiHangItem>):void
         {
            item.reset();
            if(item.hasEventListener(MouseEvent.CLICK))
            {
               item.removeEventListener(MouseEvent.CLICK,PHIClickHandler);
            }
         });
         equipIndex = 0;
         this._paiHangVO.paiHangItemArr.forEach(function(item:Array, index:int, arr:Array):void
         {
            var _name:String = null;
            var _matchName:String = null;
            paiHangItemVec[index].update(item);
            paiHangItemVec[index].addEventListener(MouseEvent.CLICK,PHIClickHandler);
            if(_paiHangVO.isMyFlat)
            {
               if(_paiHangVO.curPaiHangType == 7)
               {
                  if(item[1] == GameUnitManager.hero.party)
                  {
                     equipIndex = index;
                  }
               }
               else
               {
                  _name = Model_heFu.repNameByHero(GameUnitManager.hero.name);
                  _matchName = Model_heFu.repNameByHero(item[1]);
                  if(_matchName == _name)
                  {
                     equipIndex = index;
                  }
               }
            }
         });
         if(this._paiHangVO.paiHangItemArr.length > 0)
         {
            this.paiHangItemVec[equipIndex].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
      
      public function updateOtherRoleInfo(index:int) : void
      {
         var ind:int = this._paiHangVO.curPaiHangType == 1 ? 5 : 6;
         this.vec_Vo_equip_cache = this.get_role_vec_equip(this._paiHangVO.paiHangItemArr[index][ind]);
         var i:int = 0;
         while(i < GRID_LEN)
         {
            this.vec_grids[i].stoneLvl = this._paiHangVO.paiHangItemArr[index][this._paiHangVO.paiHangItemArr[index].length - 4];
            i++;
         }
         this.Show();
         this.otherRolePan.showData(this.vec_Vo_equip_cache,this._paiHangVO.paiHangItemArr[index]);
         this.updateRing(this._paiHangVO.paiHangItemArr[index][this._paiHangVO.paiHangItemArr[index].length - 5][0],this._paiHangVO.paiHangItemArr[index][this._paiHangVO.paiHangItemArr[index].length - 5][1]);
      }
      
      public function getEuqipSingle(enum_pos:int) : Vo_equip
      {
         if(Boolean(this.vec_grids[enum_pos].vo))
         {
            return this.vec_grids[enum_pos].vo as Vo_equip;
         }
         return null;
      }
      
      private function Show() : void
      {
         var i:int = 0;
         while(i < GRID_LEN)
         {
            this.vec_grids[i].vo = this.vec_Vo_equip_cache[i];
            i++;
         }
      }
      
      private function get_role_vec_equip(equips:Array) : Vector.<Vo_equip>
      {
         var equip_t:Vo_equip = null;
         var vec_equip:Vector.<Vo_equip> = new Vector.<Vo_equip>(MAX_GRID,true);
         var i:int = 0;
         while(i < equips.length)
         {
            equip_t = new Vo_equip();
            equip_t.Init_sever_bag(equips[i]);
            equip_t.bDress = true;
            if(equip_t.gridId != 13)
            {
               vec_equip[equip_t.gridId - 1] = equip_t;
            }
            i++;
         }
         return vec_equip;
      }
      
      public function strengthenSet(levelTen:int, levelSix:int, levelSixNums:int, level:int, nums:int) : void
      {
         this._levelTen = levelTen;
         this._levelSix = levelSix;
         this._levelSixNums = levelSixNums;
         this._level = level;
         this._nums = nums;
      }
      
      public function getData(type:int, level:int) : Array
      {
         var key:* = undefined;
         var data:Dictionary = Data_lib.equipStrongAddAward;
         for(key in data)
         {
            if(data[key][0] == type && data[key][1] == level)
            {
               return data[key];
            }
         }
         return [];
      }
      
      public function get tip() : RolePanelTip
      {
         if(!this._tip)
         {
            this._tip = new RolePanelTip();
         }
         return this._tip;
      }
      
      protected function onRollOver(event:MouseEvent) : void
      {
         GameScene.upUILayer.addChild(UIManager.rolePanel.tip);
         this.sp.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         this.sp.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_MOVE));
      }
      
      private function onRollOut(e:MouseEvent) : void
      {
         this.sp.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         GameScene.upUILayer.removeChild(UIManager.rolePanel.tip);
      }
      
      private function onMouseMove(e:MouseEvent) : void
      {
         var data1:Array = null;
         var data2:Array = null;
         var str1:String = null;
         var str2:String = null;
         var color:String = null;
         var strVec:Vector.<String> = new Vector.<String>();
         if(this._levelTen == 0 && this._levelSix == 0)
         {
            data1 = this.getData(6,this._level);
            data2 = this.getData(10,this._level);
            strVec.push("<font color=\'#F4CD31\' size=\'12\'>" + LangConfig.getWord("10010",1,this._level) + "</font><font color=\'#7CCCF2\' size=\'12\'>(" + this._nums + "/10)</font>\n" + "<font color=\'#999999\' size=\'12\'>6 " + LangConfig.getWord("10011",1) + "：" + Data_lib.attribute[3][0] + "+" + data1[V1] + "   " + Data_lib.attribute[1][0] + "+" + data1[V2] + "   " + Data_lib.attribute[2][0] + "+" + data1[V3] + "</font>\n" + "<font color=\'#999999\' size=\'12\'>" + LangConfig.getWord("10012",1) + "：" + Data_lib.attribute[3][0] + "+" + data2[V1] + "   " + Data_lib.attribute[1][0] + "+" + data2[V2] + "   " + Data_lib.attribute[2][0] + "+" + data2[V3] + "</font>\n" + "<font color=\'#999999\' size=\'12\'>　　　" + LangConfig.getWord("10013",1) + "+" + data2[V4] + "%</font>");
         }
         else if(this._levelTen == 10)
         {
            data1 = this.getData(10,10);
            strVec.push("<font color=\'#F4CD31\' size=\'12\'>" + LangConfig.getWord("10010",1,10) + "(10/10)</font><font color=\'#7CCCF2\' size=\'12\'>   " + LangConfig.getWord("10014",1) + "</font>\n" + "<font color=\'#9ADA78\' size=\'12\'>" + LangConfig.getWord("10012",1) + "：" + Data_lib.attribute[3][0] + "+" + data1[V1] + "   " + Data_lib.attribute[1][0] + "+" + data1[V2] + "   " + Data_lib.attribute[2][0] + "+" + data1[V3] + "</font>\n" + "<font color=\'#9ADA78\' size=\'12\'>　　　" + LangConfig.getWord("10013",1) + "+" + data1[V4] + "%</font>");
         }
         else
         {
            str1 = "";
            if(Boolean(this._levelTen))
            {
               data1 = this.getData(10,this._levelTen);
               str1 = "<font color=\'#F4CD31\' size=\'12\'>" + LangConfig.getWord("10010",1,this._levelTen) + "</font><font color=\'#7CCCF2\' size=\'12\'>   " + LangConfig.getWord("10014",1) + "</font>\n" + "<font color=\'#9ADA78\' size=\'12\'>" + LangConfig.getWord("10012",1) + "：" + Data_lib.attribute[3][0] + "+" + data1[V1] + "   " + Data_lib.attribute[1][0] + "+" + data1[V2] + "   " + Data_lib.attribute[2][0] + "+" + data1[V3] + "</font>\n" + "<font color=\'#9ADA78\' size=\'12\'>　　　" + LangConfig.getWord("10013",1) + "+" + data1[V4] + "%</font>";
            }
            str2 = "";
            color = "";
            if(Boolean(this._levelSix))
            {
               color = "9ADA78";
               data1 = this.getData(6,this._levelSix);
               data2 = this.getData(10,this._levelSix);
            }
            else
            {
               color = "999999";
               data1 = this.getData(6,this._levelTen + 2);
               data2 = this.getData(10,this._levelTen + 2);
            }
            str2 = "<font color=\'#F4CD31\' size=\'12\'>" + LangConfig.getWord("10010",1,Boolean(this._levelSix) ? this._levelSix : this._levelTen + 2) + "</font><font color=\'#7CCCF2\' size=\'12\'>   (" + this._levelSixNums + "/10)</font>\n" + "<font color=\'#" + color + "\'>6 " + LangConfig.getWord("10011",1) + "：" + Data_lib.attribute[3][0] + "+" + data1[V1] + "   " + Data_lib.attribute[1][0] + "+" + data1[V2] + "   " + Data_lib.attribute[2][0] + "+" + data1[V3] + "</font>\n" + "<font color=\'#999999\'>" + LangConfig.getWord("10012",1) + "：" + Data_lib.attribute[3][0] + "+" + data2[V1] + "   " + Data_lib.attribute[1][0] + "+" + data2[V2] + "   " + Data_lib.attribute[2][0] + "+" + data2[V3] + "</font>\n" + "<font color=\'#999999\'>　　　" + LangConfig.getWord("10013",1) + "+" + data2[V4] + "%</font>";
            if(Boolean(str2))
            {
               strVec.push(str2);
            }
            if(Boolean(str1))
            {
               strVec.push(str1);
            }
         }
         var stage:Stage = Global.stage;
         if(stage.mouseX + UIManager.rolePanel.tip.width > stage.stageWidth)
         {
            UIManager.rolePanel.tip.x = stage.mouseX - UIManager.rolePanel.tip.width - 10;
         }
         else
         {
            UIManager.rolePanel.tip.x = stage.mouseX + 10;
         }
         if(stage.mouseY + UIManager.rolePanel.tip.height > stage.stageHeight)
         {
            UIManager.rolePanel.tip.y = stage.stageHeight - UIManager.rolePanel.tip.height;
         }
         else
         {
            UIManager.rolePanel.tip.y = stage.mouseY;
         }
      }
      
      public function updateWorldLev() : void
      {
         this.worldLvlTF.htmlText = HtmlUtil.fontNoSize(LangConfig.getWord("60233",6),"#aff93f") + HtmlUtil.fontNoSize(Model_worldLevel.worldLev.toString(),"#ffff00");
         this.worldLvlTF.visible = Model_worldLevel.worldLev >= 30;
         TipManager.bind(this.worldLvlContainer,LangConfig.getWord("50068",5,Model_worldLevel.worldLev));
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

import com.yiTian.manager.TipManager;
import com.yiTian.utils.Utils;
import com.yiTian.view.modules.marriage.MarriageGetWord;
import com.yiTian.view.modules.marriage.VO_MarriageAttribute;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.GlowFilter;

class ringSP extends Sprite
{
   
   private var bm_icon:Bitmap;
   
   private var qinmiLv:int;
   
   private var _vo:VO_MarriageAttribute;
   
   private var bm_url:String = "";
   
   private var _isAutoLoad:Boolean = false;
   
   public function ringSP()
   {
      super();
      this.bm_icon = new Bitmap();
      addChild(this.bm_icon);
   }
   
   public function setInfo(vo:VO_MarriageAttribute) : void
   {
      var rId:int = vo.ringId;
      var qmd:int = vo.qmd;
      this._vo = vo;
      var lv:int = rId - 46440;
      this.qinmiLv = MarriageGetWord.getQMDIndex(qmd);
      this._vo.qmdLv = this.qinmiLv;
      addEventListener(MouseEvent.ROLL_OVER,this.rollOverHd);
      addEventListener(MouseEvent.ROLL_OUT,this.rollOutHd);
      var effLv:int = this.qinmiLv / 2;
      var effArr:Array = [16777215,65280,54783,16711935,16744192];
      if(effArr[effLv] > 0)
      {
         filters = [new GlowFilter(effArr[effLv],0.8,25,25,2,1)];
      }
      this.bm_url = "resource/image/ringBM/lv" + lv.toString() + ".png";
      if(this._isAutoLoad)
      {
         Utils.getLoadBitmap(this.bm_url,this.bm_icon);
         this.bm_url = "";
      }
   }
   
   private function rollOverHd(evt:MouseEvent) : void
   {
      TipManager.update(this._vo);
   }
   
   private function rollOutHd(evt:MouseEvent) : void
   {
      TipManager.hide();
   }
   
   public function set isAutoLoad(b:Boolean) : void
   {
      if(!this._isAutoLoad && b && this.bm_url != "")
      {
         Utils.getLoadBitmap(this.bm_url,this.bm_icon);
         this.bm_url = "";
      }
      this._isAutoLoad = b;
   }
}
