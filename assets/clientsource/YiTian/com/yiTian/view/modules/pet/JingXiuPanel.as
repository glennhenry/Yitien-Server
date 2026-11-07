package com.yiTian.view.modules.pet
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.PetCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class JingXiuPanel extends Panel123
   {
      
      private var JJbm:Bitmap;
      
      private var MZStr:MyTextField;
      
      private var SBStr:MyTextField;
      
      private var BJStr:MyTextField;
      
      private var NewMZStr:MyTextField;
      
      private var NewSBStr:MyTextField;
      
      private var NewBJStr:MyTextField;
      
      private var QXbm:Bitmap;
      
      private var GJbm:Bitmap;
      
      private var FYbm:Bitmap;
      
      private var QXShangXia:Bitmap;
      
      private var GJShangXia:Bitmap;
      
      private var FYShangXia:Bitmap;
      
      private var JXFYStr:MyTextField;
      
      private var Shang:String = "LSeShang";
      
      private var Xia:String = "HSeXia";
      
      private var JingXiuFeiYong:String = "";
      
      private var QXWidth:int;
      
      private var FYWidth:int;
      
      private var GJWidth:int;
      
      private var JXbtn:Button;
      
      private var ZDJXbtn:Button;
      
      private var BaoCunbtn:Button;
      
      private var QuXiaobtn:Button;
      
      private var JJbtn:Button;
      
      private var QXmanStr:MyTextField;
      
      private var GJmanStr:MyTextField;
      
      private var FYmanStr:MyTextField;
      
      private var Width:int = 120;
      
      private var JJSprite:Sprite;
      
      private var boxIndex:int;
      
      private var gjzzStr:MyTextField;
      
      private var shzzStr:MyTextField;
      
      private var bszzStr:MyTextField;
      
      private var gjzzTip:String;
      
      private var shzzTip:String;
      
      private var bszzTip:String;
      
      private var JingXiuCaiLiaoSprite:Sprite;
      
      private var JinJieCaiLiaoSprite:Sprite;
      
      private var grid:View_Grid;
      
      private var grid2:View_Grid;
      
      private var grid3:View_Grid;
      
      private var gridIndex:int = 46576;
      
      private var grid4:View_Grid;
      
      public function JingXiuPanel()
      {
         super();
         regResource("lang/ch/Pet_Imgs.swf","Pet_Imgsdm");
      }
      
      override protected function initStaticView() : void
      {
         var back:DisplayObject = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":405,
            "height":304
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":357,
            "height":224
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":32,
            "y":83,
            "width":341,
            "height":103
         },Global.Img_Cdm);
         move = new Rectangle(0,0,back.width,35);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":371,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
      }
      
      override protected function initUI2() : void
      {
         this.JingXiuCaiLiaoSprite = new Sprite();
         addChild(this.JingXiuCaiLiaoSprite);
         this.JingXiuCaiLiaoSprite.x = 33;
         this.JingXiuCaiLiaoSprite.y = 190;
         this.JinJieCaiLiaoSprite = new Sprite();
         addChild(this.JinJieCaiLiaoSprite);
         this.JinJieCaiLiaoSprite.x = 33;
         this.JinJieCaiLiaoSprite.y = 190;
         ComponentUtil.getTextField(LangConfig.getWord("60422",6),this,{
            "x":34,
            "y":54,
            "color":15138469,
            "size":14,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60423",6),this,{
            "x":199,
            "y":57,
            "color":16743936,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60424",6),this,{
            "x":42,
            "y":89,
            "color":16755712,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60425",6),this,{
            "x":238,
            "y":89,
            "color":16755712,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("选择道具",this.JingXiuCaiLiaoSprite,{
            "x":4,
            "y":13,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("需要道具",this.JinJieCaiLiaoSprite,{
            "x":93,
            "y":26,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.gjzzStr = ComponentUtil.getTextField(LangConfig.getWord("60448",6),this,{
            "x":35,
            "y":110,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.shzzStr = ComponentUtil.getTextField(LangConfig.getWord("60449",6),this,{
            "x":35,
            "y":134,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.bszzStr = ComponentUtil.getTextField(LangConfig.getWord("60450",6),this,{
            "x":35,
            "y":158,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.gjzzStr.mouseEnabled = true;
         this.shzzStr.mouseEnabled = true;
         this.bszzStr.mouseEnabled = true;
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this.JingXiuCaiLiaoSprite,{
            "x":157,
            "y":47,
            "width":89,
            "height":17
         },Global.Img_Cdm);
         ComponentUtil.getTextField("精修费用",this.JingXiuCaiLiaoSprite,{
            "x":96,
            "y":45,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getBitmap("Txt_CWJingXiu",this,{
            "x":122,
            "y":5
         },Global.Pet_Imgsdm);
         ComponentUtil.getBitmap("JDuTiao",this,{
            "x":91,
            "y":111
         },Global.Pet_Imgsdm);
         ComponentUtil.getBitmap("JDuTiao",this,{
            "x":93,
            "y":157
         },Global.Pet_Imgsdm);
         ComponentUtil.getBitmap("JDuTiao",this,{
            "x":92,
            "y":134
         },Global.Pet_Imgsdm);
         ComponentUtil.getTextField(LangConfig.getWord("60411",6),this,{
            "x":252,
            "y":110,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60446",6),this,{
            "x":252,
            "y":134,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60447",6),this,{
            "x":252,
            "y":157,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":282,
            "y":135,
            "width":49,
            "height":17
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":282,
            "y":158,
            "width":49,
            "height":17
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":282,
            "y":112,
            "width":49,
            "height":17
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("ShuXian",this,{
            "x":227,
            "y":82
         },Global.Pet_Imgsdm);
         this.JXbtn = ComponentUtil.getButton(LangConfig.getWord("60427",6),"Button_Two64",this,{
            "x":121,
            "y":271,
            "textColor":16773818
         },Global.Img_Cdm);
         this.ZDJXbtn = ComponentUtil.getButton(LangConfig.getWord("60475",6),"Button_Two64",this,{
            "x":221,
            "y":271,
            "textColor":16773818
         },Global.Img_Cdm);
         this.JJbtn = ComponentUtil.getButton(LangConfig.getWord("60428",6),"Button_Two64",this,{
            "x":171,
            "y":271,
            "textColor":16773818
         },Global.Img_Cdm);
         this.BaoCunbtn = ComponentUtil.getButton(LangConfig.getWord("60429",6),"Button_Two64",this,{
            "x":121,
            "y":271,
            "textColor":16773818
         },Global.Img_Cdm);
         this.QuXiaobtn = ComponentUtil.getButton(LangConfig.getWord("60430",6),"Button_Two64",this,{
            "x":221,
            "y":271,
            "textColor":16773818
         },Global.Img_Cdm);
         this.QXbm = ComponentUtil.getBitmap("QiXue",this,{
            "x":95,
            "y":116,
            "width":this.QXWidth
         },Global.Pet_Imgsdm);
         this.GJbm = ComponentUtil.getBitmap("GongJi",this,{
            "x":96,
            "y":139,
            "width":this.GJWidth
         },Global.Pet_Imgsdm);
         this.FYbm = ComponentUtil.getBitmap("FangYu",this,{
            "x":97,
            "y":162,
            "width":this.FYWidth
         },Global.Pet_Imgsdm);
         this.NewMZStr = ComponentUtil.getTextField("",this,{
            "x":304,
            "y":111,
            "color":16777215,
            "size":12,
            "leading":0
         },"center");
         this.NewSBStr = ComponentUtil.getTextField("",this,{
            "x":304,
            "y":134,
            "color":16777215,
            "size":12,
            "leading":0
         },"center");
         this.NewBJStr = ComponentUtil.getTextField("",this,{
            "x":304,
            "y":157,
            "color":16777215,
            "size":12,
            "leading":0
         },"center");
         this.FYShangXia = ComponentUtil.getBitmap("",this,{
            "x":340,
            "y":159
         },Global.Pet_Imgsdm);
         this.GJShangXia = ComponentUtil.getBitmap("",this,{
            "x":340,
            "y":136
         },Global.Pet_Imgsdm);
         this.QXShangXia = ComponentUtil.getBitmap("",this,{
            "x":340,
            "y":114
         },Global.Pet_Imgsdm);
         this.JXFYStr = ComponentUtil.getTextField("",this.JingXiuCaiLiaoSprite,{
            "x":179,
            "y":46,
            "color":16743936,
            "size":12,
            "leading":0
         });
         this.MZStr = ComponentUtil.getTextField("",this,{
            "x":154,
            "y":111,
            "color":16777215,
            "size":12,
            "leading":0
         },"center");
         this.SBStr = ComponentUtil.getTextField("",this,{
            "x":154,
            "y":134,
            "color":16777215,
            "size":12,
            "leading":0
         },"center");
         this.BJStr = ComponentUtil.getTextField("",this,{
            "x":154,
            "y":157,
            "color":16777215,
            "size":12,
            "leading":0
         },"center");
         this.QXmanStr = ComponentUtil.getTextField("",this,{
            "x":333,
            "y":111,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.GJmanStr = ComponentUtil.getTextField("",this,{
            "x":333,
            "y":134,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.FYmanStr = ComponentUtil.getTextField("",this,{
            "x":333,
            "y":157,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.JXbtn.addEventListener(MouseEvent.CLICK,this.JXClick);
         this.ZDJXbtn.addEventListener(MouseEvent.CLICK,this.ZDJXClick);
         this.JJSprite = new Sprite();
         this.JJSprite.x = 114;
         this.JJSprite.y = 55;
         addChild(this.JJSprite);
         this.JJSprite.addChild(this.JJbm = new Bitmap());
         this.grid = new View_Grid();
         this.grid.type = Enum_type_grid.NO_DRAG;
         this.grid.set_tf_count(true);
         this.grid.set_bmp_bg();
         this.grid.set_bmp_select();
         this.grid.set_bmp_over();
         this.grid.bSelect = true;
         this.JingXiuCaiLiaoSprite.addChild(this.grid);
         this.grid.x = 67;
         this.grid.y = 5;
         var vo:Vo_item = new Vo_item();
         vo.id = 46576;
         vo.Init_lib();
         this.grid.vo = vo;
         this.grid2 = new View_Grid();
         this.grid2.type = Enum_type_grid.NO_DRAG;
         this.grid2.set_tf_count(true);
         this.grid2.set_bmp_bg();
         this.grid2.set_bmp_select();
         this.grid2.set_bmp_over();
         this.JingXiuCaiLiaoSprite.addChild(this.grid2);
         this.grid2.x = 167;
         this.grid2.y = 5;
         var vo2:Vo_item = new Vo_item();
         vo2.id = 46598;
         vo2.Init_lib();
         this.grid2.vo = vo2;
         this.grid3 = new View_Grid();
         this.grid3.type = Enum_type_grid.NO_DRAG;
         this.grid3.set_tf_count(true);
         this.grid3.set_bmp_bg();
         this.grid3.set_bmp_select();
         this.grid3.set_bmp_over();
         this.JingXiuCaiLiaoSprite.addChild(this.grid3);
         this.grid3.x = 267;
         this.grid3.y = 5;
         var vo3:Vo_item = new Vo_item();
         vo3.id = 46599;
         vo3.Init_lib();
         this.grid3.vo = vo3;
         this.grid4 = new View_Grid();
         this.grid4.set_bmp_bg();
         this.grid4.set_bmp_over();
         this.grid4.set_tf_count();
         this.JinJieCaiLiaoSprite.addChild(this.grid4);
         this.grid4.x = 152;
         this.grid4.y = 19;
         this.grid.addEventListener(MouseEvent.CLICK,this.onClickGrid);
         this.grid2.addEventListener(MouseEvent.CLICK,this.onClickGrid);
         this.grid3.addEventListener(MouseEvent.CLICK,this.onClickGrid);
         this.resetPosition();
      }
      
      private function onClickGrid(e:MouseEvent) : void
      {
         (e.target as View_Grid).bSelect = true;
         if(e.target == this.grid)
         {
            this.gridIndex = 46576;
            this.grid2.bSelect = false;
            this.grid3.bSelect = false;
         }
         else if(e.target == this.grid2)
         {
            this.gridIndex = 46598;
            this.grid.bSelect = false;
            this.grid3.bSelect = false;
         }
         else if(e.target == this.grid3)
         {
            this.gridIndex = 46599;
            this.grid.bSelect = false;
            this.grid2.bSelect = false;
         }
         this.getJXFY();
      }
      
      public function updata() : void
      {
         var startIndex:int = 0;
         var endIndex:int = 0;
         var tipstr:String = "";
         var tableLen:int = int(Data_lib.petjx.getLength());
         if(tableLen < 4)
         {
            throw new Error("Data_lib.petjx表少于4行！！！！");
         }
         var t_i:int = 2;
         while(HuaXingJingXiuVO.jingjie + t_i > 63001 + tableLen - 2)
         {
            t_i--;
         }
         startIndex = HuaXingJingXiuVO.jingjie - 1 >= 63001 ? int(HuaXingJingXiuVO.jingjie - 1) : 63001;
         startIndex -= 2 - t_i;
         endIndex = startIndex + 3;
         this.JJbm.bitmapData = ComponentUtil.getBitmapData("level" + HuaXingJingXiuVO.jingjie,Global.Pet_Imgsdm);
         var curIndex:int = startIndex;
         while(curIndex < endIndex + 1)
         {
            tipstr += HtmlUtil.fontNoSize(Data_lib.petjx[curIndex][0] + " （需宠物" + Data_lib.petjx[curIndex][3] + "级）宠物伤害减免" + Data_lib.petjx[curIndex][20 + HuaXingJingXiuVO.isyellow] + "%",curIndex > HuaXingJingXiuVO.jingjie ? ColorConstant.getColorStr(ColorConstant.GREY) : ColorConstant.getColorStr(Data_lib.petjx[curIndex][2])) + "<br>";
            curIndex++;
         }
         tipstr += HtmlUtil.fontNoSize(LangConfig.getWord("60419",6),"#FFA54F");
         if(Boolean(tipstr.length))
         {
            TipManager.bind(this.JJSprite,tipstr);
         }
         this.gjzzTip = LangConfig.getWord("60468",6) + "<font color = \'#76EE00\'>" + int(HuaXingJingXiuVO.Jx_hp * 0.005 * 100) / 100 + "%</font>";
         this.shzzTip = LangConfig.getWord("60469",6) + "<font color = \'#76EE00\'>" + int(HuaXingJingXiuVO.Jx_att * 0.005 * 100) / 100 + "%</font>";
         this.bszzTip = LangConfig.getWord("60470",6) + "<font color = \'#76EE00\'>" + int(HuaXingJingXiuVO.Jx_def * 0.02 * 100) / 100 + "%</font>";
         TipManager.bind(this.gjzzStr,this.gjzzTip);
         TipManager.bind(this.shzzStr,this.shzzTip);
         TipManager.bind(this.bszzStr,this.bszzTip);
         this.JJbtn.addEventListener(MouseEvent.CLICK,this.JJClick);
         this.BaoCunbtn.addEventListener(MouseEvent.CLICK,this.BCClick);
         this.QuXiaobtn.addEventListener(MouseEvent.CLICK,this.QXClick);
         this.grid.count = CommandManager.get_bag_count(46576,2);
         this.grid2.count = CommandManager.get_bag_count(46598,2);
         this.grid3.count = CommandManager.get_bag_count(46599,2);
      }
      
      public function OpenJingXiu() : void
      {
         var vo:Vo_item = null;
         this.JXbtn.visible = false;
         this.JJbtn.visible = false;
         this.QuXiaobtn.visible = false;
         this.BaoCunbtn.visible = false;
         this.ZDJXbtn.visible = false;
         this.JingXiuCaiLiaoSprite.visible = true;
         this.JinJieCaiLiaoSprite.visible = false;
         if(HuaXingJingXiuVO.getHuaxing == 1)
         {
            this.JXbtn.visible = true;
            this.ZDJXbtn.visible = true;
            this.JJbtn.visible = false;
            this.QuXiaobtn.visible = false;
            this.BaoCunbtn.visible = false;
         }
         else if(HuaXingJingXiuVO.getHuaxing == 2)
         {
            this.JXbtn.visible = false;
            this.ZDJXbtn.visible = false;
            this.JJbtn.visible = false;
            this.QuXiaobtn.visible = true;
            this.BaoCunbtn.visible = true;
         }
         else if(HuaXingJingXiuVO.getHuaxing == 3)
         {
            this.JXbtn.visible = false;
            this.ZDJXbtn.visible = false;
            this.JJbtn.visible = true;
            this.QuXiaobtn.visible = false;
            this.BaoCunbtn.visible = false;
            if(Boolean(Data_lib.petjx[HuaXingJingXiuVO.jingjie + 1]) && Data_lib.petjx[HuaXingJingXiuVO.jingjie + 1][22] != 0)
            {
               this.JingXiuCaiLiaoSprite.visible = false;
               vo = new Vo_item();
               vo.id = Data_lib.petjx[HuaXingJingXiuVO.jingjie + 1][22];
               vo.count = Data_lib.petjx[HuaXingJingXiuVO.jingjie + 1][23];
               vo.Init_lib();
               this.grid4.vo = vo;
               this.JinJieCaiLiaoSprite.visible = true;
            }
         }
         this.getvalue();
      }
      
      public function GCJingXiu() : void
      {
         var vo:Vo_item = null;
         this.JXbtn.visible = false;
         this.JJbtn.visible = false;
         this.QuXiaobtn.visible = false;
         this.BaoCunbtn.visible = false;
         this.JingXiuCaiLiaoSprite.visible = true;
         this.JinJieCaiLiaoSprite.visible = false;
         if(HuaXingJingXiuVO.type == 1)
         {
            this.JXbtn.visible = true;
            this.ZDJXbtn.visible = true;
            this.JJbtn.visible = false;
            this.QuXiaobtn.visible = false;
            this.BaoCunbtn.visible = false;
         }
         else if(HuaXingJingXiuVO.type == 2)
         {
            this.JXbtn.visible = false;
            this.ZDJXbtn.visible = false;
            this.JJbtn.visible = false;
            this.QuXiaobtn.visible = true;
            this.BaoCunbtn.visible = true;
         }
         else if(HuaXingJingXiuVO.type == 3)
         {
            this.JXbtn.visible = false;
            this.ZDJXbtn.visible = false;
            this.JJbtn.visible = true;
            this.QuXiaobtn.visible = false;
            this.BaoCunbtn.visible = false;
            if(Boolean(Data_lib.petjx[HuaXingJingXiuVO.jingjie + 1]) && Data_lib.petjx[HuaXingJingXiuVO.jingjie + 1][22] != 0)
            {
               this.JingXiuCaiLiaoSprite.visible = false;
               vo = new Vo_item();
               vo.id = Data_lib.petjx[HuaXingJingXiuVO.jingjie + 1][22];
               vo.count = Data_lib.petjx[HuaXingJingXiuVO.jingjie + 1][23];
               vo.Init_lib();
               this.grid4.vo = vo;
               this.JinJieCaiLiaoSprite.visible = true;
            }
         }
         this.getvalue();
      }
      
      public function getvalue() : void
      {
         this.QXmanStr.htmlText = "";
         this.GJmanStr.htmlText = "";
         this.FYmanStr.htmlText = "";
         if(HuaXingJingXiuVO.Jx_hp_value < 0)
         {
            this.QXShangXia.bitmapData = ComponentUtil.getBitmapData(this.Xia,Global.Pet_Imgsdm);
            this.NewMZStr.htmlText = "<font color =\'#FF0000\'>" + HuaXingJingXiuVO.Jx_hp_value.toString() + "</font>";
         }
         else if(HuaXingJingXiuVO.Jx_hp_value > 0)
         {
            this.QXShangXia.bitmapData = ComponentUtil.getBitmapData(this.Shang,Global.Pet_Imgsdm);
            this.NewMZStr.htmlText = "<font color =\'#00FF00\'>" + HuaXingJingXiuVO.Jx_hp_value.toString() + "</font>";
         }
         else if(HuaXingJingXiuVO.Jx_hp_value == 0)
         {
            this.QXShangXia.bitmapData = null;
            this.NewMZStr.htmlText = "<font color =\'#00FF00\'>" + HuaXingJingXiuVO.Jx_hp_value.toString() + "</font>";
            if(HuaXingJingXiuVO.Jx_hp == Data_lib.petjx[HuaXingJingXiuVO.jingjie][4])
            {
               this.QXmanStr.htmlText = "<font color = \'#00FF00\'>" + LangConfig.getWord("60431",6) + "</font>";
            }
         }
         trace(this.NewMZStr.text);
         if(HuaXingJingXiuVO.Jx_att_value < 0)
         {
            this.NewSBStr.htmlText = "<font color =\'#FF0000\'>" + HuaXingJingXiuVO.Jx_att_value.toString() + "</font>";
            this.GJShangXia.bitmapData = ComponentUtil.getBitmapData(this.Xia,Global.Pet_Imgsdm);
         }
         else if(HuaXingJingXiuVO.Jx_att_value > 0)
         {
            this.NewSBStr.htmlText = "<font color =\'#00FF00\'>" + HuaXingJingXiuVO.Jx_att_value.toString() + "</font>";
            this.GJShangXia.bitmapData = ComponentUtil.getBitmapData(this.Shang,Global.Pet_Imgsdm);
         }
         else if(HuaXingJingXiuVO.Jx_att_value == 0)
         {
            this.GJShangXia.bitmapData = null;
            this.NewSBStr.htmlText = "<font color =\'#00FF00\'>" + HuaXingJingXiuVO.Jx_att_value.toString() + "</font>";
            if(HuaXingJingXiuVO.Jx_att == Data_lib.petjx[HuaXingJingXiuVO.jingjie][4])
            {
               this.GJmanStr.htmlText = "<font color = \'#00FF00\'>" + LangConfig.getWord("60431",6) + "</font>";
            }
         }
         if(HuaXingJingXiuVO.Jx_def_value < 0)
         {
            this.FYShangXia.bitmapData = ComponentUtil.getBitmapData(this.Xia,Global.Pet_Imgsdm);
            this.NewBJStr.htmlText = "<font color =\'#FF0000\'>" + HuaXingJingXiuVO.Jx_def_value.toString() + "</font>";
         }
         else if(HuaXingJingXiuVO.Jx_def_value > 0)
         {
            this.NewBJStr.htmlText = "<font color =\'#00FF00\'>" + HuaXingJingXiuVO.Jx_def_value.toString() + "</font>";
            this.FYShangXia.bitmapData = ComponentUtil.getBitmapData(this.Shang,Global.Pet_Imgsdm);
         }
         else if(HuaXingJingXiuVO.Jx_def_value == 0)
         {
            this.FYShangXia.bitmapData = null;
            this.NewBJStr.htmlText = "<font color =\'#00FF00\'>" + HuaXingJingXiuVO.Jx_def_value.toString() + "</font>";
            if(HuaXingJingXiuVO.Jx_def == Data_lib.petjx[HuaXingJingXiuVO.jingjie][4])
            {
               this.FYmanStr.htmlText = "<font color = \'#00FF00\'>" + LangConfig.getWord("60431",6) + "</font>";
            }
         }
         this.QXWidth = HuaXingJingXiuVO.Jx_hp / Data_lib.petjx[HuaXingJingXiuVO.jingjie][4] * this.Width;
         this.GJWidth = HuaXingJingXiuVO.Jx_att / Data_lib.petjx[HuaXingJingXiuVO.jingjie][4] * this.Width;
         this.FYWidth = HuaXingJingXiuVO.Jx_def / Data_lib.petjx[HuaXingJingXiuVO.jingjie][4] * this.Width;
         this.QXbm.width = this.QXWidth;
         this.GJbm.width = this.GJWidth;
         this.FYbm.width = this.FYWidth;
         if(this.grid.bSelect)
         {
            this.JXFYStr.htmlText = Data_lib.petjx[HuaXingJingXiuVO.jingjie][5].toString();
         }
         else if(this.grid2.bSelect)
         {
            this.JXFYStr.htmlText = Data_lib.petjx[HuaXingJingXiuVO.jingjie][12].toString();
         }
         else if(this.grid3.bSelect)
         {
            this.JXFYStr.htmlText = Data_lib.petjx[HuaXingJingXiuVO.jingjie][18].toString();
         }
         this.MZStr.htmlText = HuaXingJingXiuVO.Jx_hp.toString() + "/" + Data_lib.petjx[HuaXingJingXiuVO.jingjie][4].toString();
         this.SBStr.htmlText = HuaXingJingXiuVO.Jx_att.toString() + "/" + Data_lib.petjx[HuaXingJingXiuVO.jingjie][4].toString();
         this.BJStr.htmlText = HuaXingJingXiuVO.Jx_def.toString() + "/" + Data_lib.petjx[HuaXingJingXiuVO.jingjie][4].toString();
         if(!this.JJbm)
         {
            this.JJbm = new Bitmap();
            ComponentUtil.setPropertie(this.JJbm,{
               "x":114,
               "y":55
            });
            addChild(this.JJbm);
         }
         this.JJbm.bitmapData = ComponentUtil.getBitmapData("level" + HuaXingJingXiuVO.jingjie,Global.Pet_Imgsdm);
      }
      
      private function getJXFY() : void
      {
         if(this.grid.bSelect)
         {
            this.JXFYStr.htmlText = Data_lib.petjx[HuaXingJingXiuVO.jingjie][5].toString();
         }
         else if(this.grid2.bSelect)
         {
            this.JXFYStr.htmlText = Data_lib.petjx[HuaXingJingXiuVO.jingjie][12].toString();
         }
         else if(this.grid3.bSelect)
         {
            this.JXFYStr.htmlText = Data_lib.petjx[HuaXingJingXiuVO.jingjie][18].toString();
         }
      }
      
      private function ZDJXClick(e:MouseEvent) : void
      {
         if(this.grid.bSelect == true)
         {
            Global.delegate.dosomething(UIManager.zdjx,UIManager.zdjx.show);
         }
         else if(this.grid2.bSelect == true)
         {
            UIManager.centerBroadcast.addMsg("超级精修石不能自动精修");
         }
         else if(this.grid3.bSelect == true)
         {
            UIManager.centerBroadcast.addMsg("祝福精修石不能自动精修");
         }
      }
      
      private function JXClick(e:MouseEvent) : void
      {
         if(this.grid.bSelect)
         {
            if(CommandManager.get_bag_count(46576,2) > 0)
            {
               if(GameUnitManager.hero.silver + GameUnitManager.hero.bingSilver >= Data_lib.petjx[HuaXingJingXiuVO.jingjie][5])
               {
                  PetCGMessage.CG_BT_JINGXIU(1,this.gridIndex);
               }
               else
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("60432",6));
               }
            }
            else
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("60433",6));
            }
         }
         if(this.grid2.bSelect)
         {
            if(CommandManager.get_bag_count(46598,2) > 0)
            {
               if(GameUnitManager.hero.silver + GameUnitManager.hero.bingSilver >= Data_lib.petjx[HuaXingJingXiuVO.jingjie][12])
               {
                  PetCGMessage.CG_BT_JINGXIU(1,this.gridIndex);
               }
               else
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("60432",6));
               }
            }
            else
            {
               UIManager.centerBroadcast.addMsg("没有超级精修石");
            }
         }
         if(this.grid3.bSelect)
         {
            if(CommandManager.get_bag_count(46599,2) > 0)
            {
               if(GameUnitManager.hero.silver + GameUnitManager.hero.bingSilver >= Data_lib.petjx[HuaXingJingXiuVO.jingjie][18])
               {
                  PetCGMessage.CG_BT_JINGXIU(1,this.gridIndex);
               }
               else
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("60432",6));
               }
            }
            else
            {
               UIManager.centerBroadcast.addMsg("没有祝福精修石");
            }
         }
      }
      
      private function JJClick(e:MouseEvent) : void
      {
         if(UIManager.petPanel.petVO.level >= Data_lib.petjx[HuaXingJingXiuVO.jingjie][3])
         {
            if(HuaXingJingXiuVO.jingjie >= Data_lib.petjx.getLength() - 1 + 63000)
            {
               UIManager.centerBroadcast.addMsg("宠物已经达到最高精修等级",1);
            }
            else if(UIManager.petPanel.petVO.level < Data_lib.petjx[HuaXingJingXiuVO.jingjie + 1][3])
            {
               UIManager.centerBroadcast.addMsg("宠物未达到" + Data_lib.petjx[HuaXingJingXiuVO.jingjie + 1][3] + "级",1);
            }
            else
            {
               PetCGMessage.CG_BT_JINGXIU(4,0);
            }
         }
      }
      
      private function BCClick(e:MouseEvent) : void
      {
         this.QXShangXia.bitmapData = null;
         this.GJShangXia.bitmapData = null;
         this.FYShangXia.bitmapData = null;
         PetCGMessage.CG_BT_JINGXIU(2,0);
      }
      
      private function QXClick(e:MouseEvent) : void
      {
         this.QXShangXia.bitmapData = null;
         this.GJShangXia.bitmapData = null;
         this.FYShangXia.bitmapData = null;
         PetCGMessage.CG_BT_JINGXIU(3,0);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            PetCGMessage.CG_OPEN_JINGXIU();
         }
      }
   }
}

