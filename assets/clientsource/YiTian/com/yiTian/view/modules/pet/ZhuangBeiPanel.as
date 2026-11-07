package com.yiTian.view.modules.pet
{
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_petEquip;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.ModelManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.PetCGMessage;
   import com.yiTian.utils.Bitmap2;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.pet.petD.EffectPan;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class ZhuangBeiPanel extends EffectPan
   {
      
      private static var _instance:ZhuangBeiPanel;
      
      private static const MAXLEVEL:int = 160;
      
      private static var isFirstOpen:Boolean = true;
      
      private var sj:Boolean;
      
      private var zb:Boolean;
      
      private var tfCaiLiao:MyTextField;
      
      private var leftShuXing:MyTextField;
      
      private var rightShuXing:MyTextField;
      
      private var qhBtn:Button;
      
      private var sjBtn:Button;
      
      private var zbqhBtn:Button;
      
      private var leftShuXing2:MyTextField;
      
      private var rightShuXing2:MyTextField;
      
      private var zbSilver:MyTextField;
      
      private var qhBox:CheckBox;
      
      public var zdgmBox:CheckBox;
      
      private var tfChengGongLv:MyTextField;
      
      public var GridVec:Vector.<PetZBGrid> = new Vector.<PetZBGrid>();
      
      private var nowGrid:PetZBGrid;
      
      private var newGrid:PetZBGrid;
      
      private var vo1:Vo_petEquip;
      
      private var vo2:Vo_petEquip;
      
      private var Vo_itemGridVec:Vector.<Vo_petEquip> = new Vector.<Vo_petEquip>();
      
      public var type:int;
      
      private var yuanbao:int;
      
      private var clGrid:Vector.<View_Grid> = new Vector.<View_Grid>();
      
      private var clGridVec:Vector.<Vo_item> = new Vector.<Vo_item>();
      
      private var bmVec:Vector.<Bitmap2> = new Vector.<Bitmap2>();
      
      private var tfVec:Vector.<MyTextField> = new Vector.<MyTextField>();
      
      private var qhYuanBaotf:MyTextField;
      
      private var nowLvltf:MyTextField;
      
      private var nextLvltf:MyTextField;
      
      private var nowLvltf2:MyTextField;
      
      private var nextLvltf2:MyTextField;
      
      private var nowLevel:int;
      
      private var str:String;
      
      private var str2:String;
      
      private var a:Array;
      
      private var b:Array;
      
      private var c:Array;
      
      private var d:Array;
      
      private var dd:Array;
      
      private var ddd:Array;
      
      private var maxLevel:int;
      
      private var colorArr2:Array = ["#ffffff","#04ff00","#33ccff","#ff00ff","#ff7700"];
      
      private var colorArr:Array = ["白装","绿装","蓝装","紫装","橙装"];
      
      private var tf2:MyTextField;
      
      private var vv:Vo_item;
      
      private var qhclGrid:View_Grid;
      
      private var bm2:Bitmap2;
      
      private var bm3:Bitmap2;
      
      private var voi:int;
      
      private var zbspr:Sprite = new Sprite();
      
      private var sjspr:Sprite = new Sprite();
      
      private var num:int;
      
      private var last:int;
      
      private var now:int;
      
      public function ZhuangBeiPanel()
      {
         super();
         this.initUI2();
      }
      
      public static function get instance() : ZhuangBeiPanel
      {
         if(!_instance)
         {
            _instance = new ZhuangBeiPanel();
         }
         return _instance;
      }
      
      protected function initUI2() : void
      {
         var i:int = 0;
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":-2,
            "y":0,
            "width":245,
            "height":283
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Title_Back2",[29,2,2,16],this.zbspr,{
            "x":10,
            "y":123,
            "width":110,
            "height":21
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Title_Back2",[29,2,2,16],this.zbspr,{
            "x":124,
            "y":123,
            "width":110,
            "height":21
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Diamond02",[3,3,1,1],this.sjspr,{
            "x":15,
            "y":132,
            "width":100,
            "height":22
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Diamond02",[3,3,1,1],this.sjspr,{
            "x":129,
            "y":132,
            "width":100,
            "height":22
         },Global.Img_Cdm);
         var b:Bitmap = new Bitmap();
         var b1:Bitmap = new Bitmap();
         var b2:Bitmap = new Bitmap();
         var b3:Bitmap = new Bitmap();
         var b4:Bitmap = new Bitmap();
         var b5:Bitmap = new Bitmap();
         Utils.loadTitle("lang/ch/Pet_Imgs.swf","ZBBack",b,{
            "x":-3,
            "y":2
         });
         Utils.loadTitle("lang/ch/Pet_Imgs.swf","Grid_40C",b1,{
            "x":3 + 1,
            "y":5
         });
         Utils.loadTitle("lang/ch/Pet_Imgs.swf","Grid_40C",b2,{
            "x":63 + 1,
            "y":5
         });
         Utils.loadTitle("lang/ch/Pet_Imgs.swf","Grid_40C",b3,{
            "x":123 + 1,
            "y":5
         });
         Utils.loadTitle("lang/ch/Pet_Imgs.swf","Grid_40C",b4,{
            "x":183 + 1,
            "y":5
         });
         Utils.loadTitle("lang/ch/Pet_Imgs.swf","Text_Need",b5,{
            "x":0,
            "y":165
         });
         addChild(b);
         addChild(b1);
         addChild(b2);
         addChild(b3);
         addChild(b4);
         addChild(b5);
         i = 0;
         while(i < 4)
         {
            this.GridVec[i] = new PetZBGrid(false,".jpg");
            this.GridVec[i].type = Enum_type_grid.PET_ZB;
            this.GridVec[i].set_bmp_select("resource/image/iconBg/grid_Skill_Choose.png");
            this.GridVec[i].set_bmp_bg("resource/image/team/zxBg.png");
            this.GridVec[i].set_bmp_over(true,"resource/image/team/grid_Skill_over.png");
            this.GridVec[i].set_tf_count(true,false,true);
            this.GridVec[i].x = 5 + 5 + i * 60;
            this.GridVec[i].y = 7 + 4;
            addChild(this.GridVec[i]);
            this.Vo_itemGridVec[i] = new Vo_petEquip();
            this.Vo_itemGridVec[i].id = 46011 + i;
            if(Boolean(PetzbVO.voArr[i] as Vo_petEquip))
            {
               this.Vo_itemGridVec[i].init((PetzbVO.voArr[i] as Vo_petEquip).level,(PetzbVO.voArr[i] as Vo_petEquip).type,(PetzbVO.voArr[i] as Vo_petEquip).maxLevel,(PetzbVO.voArr[i] as Vo_petEquip).strength);
            }
            this.GridVec[i].vo = this.Vo_itemGridVec[i];
            this.GridVec[i].addEventListener(MouseEvent.CLICK,this.gridClick);
            this.bmVec[i] = new Bitmap2();
            this.bmVec[i].x = 10 + i * 60;
            this.bmVec[i].y = 11;
            this.bmVec[i].load(this.Vo_itemGridVec[i].iconUrl);
            addChild(this.bmVec[i]);
            i++;
         }
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this.zbspr,{
            "x":10,
            "y":148,
            "width":110,
            "height":52
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this.zbspr,{
            "x":124,
            "y":148,
            "width":110,
            "height":52
         },Global.Img_Cdm);
         this.nowLvltf2 = ComponentUtil.getTextField("阶星",this.zbspr,{
            "x":27 + 12,
            "y":125,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.nextLvltf2 = ComponentUtil.getTextField("阶星",this.zbspr,{
            "x":142 + 12,
            "y":125,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.leftShuXing = ComponentUtil.getTextField("",this.zbspr,{
            "x":20,
            "y":154,
            "color":11523767,
            "size":12,
            "leading":4
         });
         this.leftShuXing.multiline = true;
         this.rightShuXing = ComponentUtil.getTextField("",this.zbspr,{
            "x":134,
            "y":154,
            "color":11523767,
            "size":12,
            "leading":4
         });
         this.rightShuXing.multiline = true;
         this.leftShuXing2 = ComponentUtil.getTextField("",this.zbspr,{
            "x":59,
            "y":154,
            "color":16383744,
            "size":12,
            "leading":4
         });
         this.leftShuXing2.multiline = true;
         this.rightShuXing2 = ComponentUtil.getTextField("",this.zbspr,{
            "x":173,
            "y":154,
            "color":16383744,
            "size":12,
            "leading":4
         });
         this.rightShuXing2.multiline = true;
         this.zbqhBtn = ComponentUtil.getButton("强化","Button_Orange",this.zbspr,{
            "x":140 - 55,
            "y":248 + 5,
            "textColor":16184781
         },Global.Img_Cdm);
         Utils.loadTitle("lang/ch/Pet_Imgs.swf","Grid_40C",new Bitmap(),{
            "x":37 + 6,
            "y":68 + 1
         },this.zbspr);
         Utils.loadTitle("lang/ch/Pet_Imgs.swf","Grid_40C",new Bitmap(),{
            "x":149 + 6,
            "y":68 + 1
         },this.zbspr);
         ComponentUtil.getBitmap("Grid_Open",this.zbspr,{
            "x":71 - 57,
            "y":197 + 10
         },Global.Img_Cdm);
         Utils.loadTitle("lang/ch/Pet_Imgs.swf","JianTou",new Bitmap(),{
            "x":81 + 3,
            "y":69
         },this.zbspr);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this.zbspr,{
            "x":162,
            "y":196 + 28,
            "width":70,
            "height":21
         },Global.Img_Cdm);
         ComponentUtil.getTextField("强化费用：",this.zbspr,{
            "x":90,
            "y":249 - 25,
            "color":11523767,
            "size":12,
            "leading":0
         });
         this.zdgmBox = ComponentUtil.getCheckBox("自动花费元宝购买材料","CheckBox01",this.zbspr,{
            "x":90,
            "y":203,
            "color":11523767
         },Global.Img_Cdm);
         this.zdgmBox.addEventListener(MouseEvent.CLICK,this.zdgmClick);
         this.zbSilver = ComponentUtil.getTextField("",this.zbspr,{
            "x":70 + 110,
            "y":249 - 25,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.qhYuanBaotf = ComponentUtil.getTextField("花费2元宝100%",this.zbspr,{
            "x":143,
            "y":223,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.qhYuanBaotf.visible = false;
         this.qhBox = ComponentUtil.getCheckBox("","CheckBox01",this.zbspr,{
            "x":120,
            "y":223,
            "color":16777215
         },Global.Img_Cdm);
         this.qhBox.visible = false;
         this.tfChengGongLv = ComponentUtil.getTextField("",this.zbspr,{
            "x":172,
            "y":197,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.zbqhBtn.addEventListener(MouseEvent.CLICK,this.zbqhClick);
         addChild(this.zbspr);
         this.zbspr.visible = false;
         Utils.loadTitle("lang/ch/Pet_Imgs.swf","Grid_40C",new Bitmap(),{
            "x":37 + 6,
            "y":68 + 1
         },this.sjspr);
         Utils.loadTitle("lang/ch/Pet_Imgs.swf","Grid_40C",new Bitmap(),{
            "x":149 + 6,
            "y":68 + 1
         },this.sjspr);
         Utils.loadTitle("lang/ch/Pet_Imgs.swf","JianTou",new Bitmap(),{
            "x":85,
            "y":71
         },this.sjspr);
         this.nowLvltf = ComponentUtil.getTextField("",this.sjspr,{
            "x":27 + 9,
            "y":109 + 25,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.nextLvltf = ComponentUtil.getTextField("",this.sjspr,{
            "x":142 + 9,
            "y":109 + 25,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.sjBtn = ComponentUtil.getButton("升级","Button_Orange",this.sjspr,{
            "x":85,
            "y":245 + 5,
            "textColor":16184781
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Grid_Open",this.sjspr,{
            "x":31,
            "y":156 + 45
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Grid_Open",this.sjspr,{
            "x":101,
            "y":156 + 45
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Grid_Open",this.sjspr,{
            "x":171,
            "y":156 + 45
         },Global.Img_Cdm);
         this.sjBtn.addEventListener(MouseEvent.CLICK,this.sjClick);
         addChild(this.sjspr);
         this.sjspr.visible = false;
      }
      
      public function eff() : void
      {
         EffectManager.addEffect("35197",this.nowGrid,1000,20,20,false);
         EffectManager.addEffect("35197",this.newGrid,1000,20,20,false);
      }
      
      private function shuxingtf() : void
      {
         if(this.GridVec[0].bSelect)
         {
            this.nowLevel = (PetzbVO.voArr[0] as Vo_petEquip).level;
            this.maxLevel = (PetzbVO.voArr[0] as Vo_petEquip).maxLevel;
            this.str = Data_lib.chongwuqianghua[this.nowLevel][0];
            if(this.nowLevel < MAXLEVEL)
            {
               this.str2 = Data_lib.chongwuqianghua[this.nowLevel + 1][0];
            }
         }
         else if(this.GridVec[1].bSelect)
         {
            this.nowLevel = (PetzbVO.voArr[1] as Vo_petEquip).level;
            this.maxLevel = (PetzbVO.voArr[1] as Vo_petEquip).maxLevel;
            this.str = Data_lib.chongwuqianghua[this.nowLevel][1];
            if(this.nowLevel < MAXLEVEL)
            {
               this.str2 = Data_lib.chongwuqianghua[this.nowLevel + 1][1];
            }
         }
         else if(this.GridVec[2].bSelect)
         {
            this.nowLevel = (PetzbVO.voArr[2] as Vo_petEquip).level;
            this.maxLevel = (PetzbVO.voArr[2] as Vo_petEquip).maxLevel;
            this.str = Data_lib.chongwuqianghua[this.nowLevel][2];
            if(this.nowLevel < MAXLEVEL)
            {
               this.str2 = Data_lib.chongwuqianghua[this.nowLevel + 1][2];
            }
         }
         else if(this.GridVec[3].bSelect)
         {
            this.nowLevel = (PetzbVO.voArr[3] as Vo_petEquip).level;
            this.maxLevel = (PetzbVO.voArr[3] as Vo_petEquip).maxLevel;
            this.str = Data_lib.chongwuqianghua[this.nowLevel][3];
            if(this.nowLevel < MAXLEVEL)
            {
               this.str2 = Data_lib.chongwuqianghua[this.nowLevel + 1][3];
            }
         }
         this.a = this.str.split(",");
         this.b = this.a[0].split("_");
         this.c = this.a[1].split("_");
         this.leftShuXing.htmlText = this.rightShuXing.htmlText = Data_lib.attribute[int(this.b[0])][0] + "<br>" + Data_lib.attribute[int(this.c[0])][0];
         this.leftShuXing2.htmlText = "+" + this.b[1] + "<br>" + "+" + this.c[1];
         if(this.nowLevel < MAXLEVEL)
         {
            this.d = this.str2.split(",");
            this.dd = this.d[0].split("_");
            this.ddd = this.d[1].split("_");
            this.rightShuXing2.htmlText = "+" + this.dd[1] + "<br>" + "+" + this.ddd[1];
         }
         this.nowLvltf.htmlText = this.maxLevel + "级" + this.colorArr[this.getColor(this.maxLevel) - 1];
         this.nowLvltf.color = parseInt((this.colorArr2[this.getColor(this.maxLevel) - 1] as String).replace("#","0x"));
         this.nextLvltf.htmlText = (this.maxLevel + 10).toString() + "级" + this.colorArr[this.getColor(this.maxLevel + 10) - 1];
         this.nextLvltf.color = parseInt((this.colorArr2[this.getColor(this.maxLevel + 10) - 1] as String).replace("#","0x"));
         this.nowLvltf2.htmlText = this.getStr(this.nowLevel);
         this.nextLvltf2.htmlText = this.getStr(this.nowLevel + 1);
      }
      
      private function getStr(level:int) : String
      {
         var num:int = 0;
         var num2:int = 0;
         var str:String = "";
         if(level == 0)
         {
            num = 1;
            num2 = 0;
            str += this.getjiexing(num) + "阶" + this.getjiexing(num2) + "星";
         }
         else if(level % 10 == 0)
         {
            num = level / 10;
            num2 = 10;
            str += this.getjiexing(num) + "阶" + this.getjiexing(num2) + "星";
         }
         else
         {
            num = int(level / 10 + 1);
            num2 = int(level % 10);
            str += this.getjiexing(num) + "阶" + this.getjiexing(num2) + "星";
         }
         return str;
      }
      
      private function getjiexing(num:int) : String
      {
         switch(num)
         {
            case 0:
               this.str = "零";
               break;
            case 1:
               this.str = "一";
               break;
            case 2:
               this.str = "二";
               break;
            case 3:
               this.str = "三";
               break;
            case 4:
               this.str = "四";
               break;
            case 5:
               this.str = "五";
               break;
            case 6:
               this.str = "六";
               break;
            case 7:
               this.str = "七";
               break;
            case 8:
               this.str = "八";
               break;
            case 9:
               this.str = "九";
               break;
            case 10:
               this.str = "十";
               break;
            case 11:
               this.str = "十一";
               break;
            case 12:
               this.str = "十二";
               break;
            case 13:
               this.str = "十三";
               break;
            case 14:
               this.str = "十四";
               break;
            case 15:
               this.str = "十五";
               break;
            case 16:
               this.str = "十六";
               break;
            case 17:
               this.str = "十七";
         }
         return this.str;
      }
      
      private function getColor(lvl:int) : int
      {
         if(lvl > 120)
         {
            lvl = 120;
         }
         return int(Data_lib.chongwushengji[lvl][0]);
      }
      
      private function getCaiLiao2() : void
      {
         var num:int = 0;
         var sjarr:String = Data_lib.chongwuqianghua[this.nowLevel][4];
         var sjarr2:Array = sjarr.split("_");
         if(!this.qhclGrid)
         {
            this.qhclGrid = new View_Grid();
            this.qhclGrid.type = Enum_type_grid.NO_DRAG;
            this.qhclGrid.set_tf_count(true);
            this.qhclGrid.set_bmp_bg();
            this.qhclGrid.set_bmp_select();
            this.qhclGrid.set_bmp_over();
            this.qhclGrid.x = 73 - 57;
            this.qhclGrid.y = 199 + 10;
            this.zbspr.addChild(this.qhclGrid);
         }
         if(!this.vv)
         {
            this.vv = new Vo_item();
         }
         this.vv.id = sjarr2[1];
         var num2:int = int(sjarr2[2]);
         num = ModelManager.bag.get_count(this.vv.id);
         var xx:int = 0;
         var a:int = num2;
         var b:int = num;
         while(Boolean(int(a = a / 10)))
         {
            xx += 3;
         }
         while(Boolean(int(b = b / 10)))
         {
            xx += 3;
         }
         if(!this.tf2)
         {
            this.tf2 = ComponentUtil.getTextField("",this.zbspr,{
               "x":79 - xx - 57,
               "y":219 + 10,
               "color":16764206,
               "size":12,
               "leading":0
            });
         }
         this.tf2.text = num + "/" + num2;
         this.tf2.x = 79 - xx - 57;
         if(num < num2)
         {
            this.tf2.color = 16711680;
         }
         else
         {
            this.tf2.color = 16764206;
         }
         this.tfChengGongLv.text = Data_lib.chongwuqianghua[this.nowLevel][6] + "%";
         this.tfChengGongLv.visible = false;
         this.zbSilver.text = Data_lib.chongwuqianghua[this.nowLevel][5];
         this.vv.Init_lib();
         this.qhclGrid.vo = this.vv;
         var sss:String = Data_lib.chongwuqianghua[this.nowLevel][7];
         this.qhYuanBaotf.htmlText = "花费" + "<font color =\'#ffff00\'>" + sss + "</font>" + "元宝" + "<font color = \'#00ff00\'>" + "100%" + "</font>";
      }
      
      private function getCaiLiao() : void
      {
         var sjarr3:Array = null;
         var num2:int = 0;
         var num:int = 0;
         var a:int = 0;
         var b:int = 0;
         var xx:int = 0;
         var sjarr:String = Data_lib.chongwushengji[this.maxLevel][1];
         var sjarr2:Array = sjarr.split(",");
         sjarr3 = [];
         var j:int = 0;
         while(j < sjarr2.length)
         {
            sjarr3[j] = sjarr2[j].split("_");
            j++;
         }
         var i:int = 0;
         while(i < 3)
         {
            this.clGrid[i] = new View_Grid();
            this.clGrid[i].type = Enum_type_grid.NO_DRAG;
            this.clGrid[i].set_tf_count(true);
            this.clGrid[i].set_bmp_bg();
            this.clGrid[i].set_bmp_select();
            this.clGrid[i].set_bmp_over();
            this.clGrid[i].x = 33 + i * 70;
            this.clGrid[i].y = 158 + 45;
            this.sjspr.addChild(this.clGrid[i]);
            this.clGridVec[i] = new Vo_item();
            if(sjarr3.length > i)
            {
               this.clGridVec[i].id = sjarr3[i][1];
               num2 = int(sjarr3[i][2]);
               num = ModelManager.bag.get_count(this.clGridVec[i].id);
               a = num2;
               b = num;
               xx = 0;
               while(Boolean(int(a = a / 10)))
               {
                  xx += 3;
               }
               while(Boolean(int(b = b / 10)))
               {
                  xx += 3;
               }
               this.tfVec[i] = ComponentUtil.getTextField("",this.sjspr,{
                  "y":178 + 45,
                  "color":16764206,
                  "size":12,
                  "leading":0
               });
               this.tfVec[i].text = num + "/" + num2;
               this.tfVec[i].x = 38 + i * 70 - xx;
               if(num < num2)
               {
                  this.tfVec[i].color = 16711680;
               }
               else
               {
                  this.tfVec[i].color = 16764206;
               }
            }
            this.clGridVec[i].Init_lib();
            this.clGrid[i].vo = this.clGridVec[i];
            i++;
         }
      }
      
      public function getGrid(type:int) : void
      {
         if(!this.nowGrid)
         {
            this.nowGrid = new PetZBGrid(false,".jpg");
            this.nowGrid.type = Enum_type_grid.PET_ZB;
            this.nowGrid.set_bmp_select();
            this.nowGrid.set_bmp_bg("resource/image/team/zxBg.png");
            this.nowGrid.set_bmp_over(true,"resource/image/team/grid_Skill_over.png");
            this.nowGrid.set_tf_count(true,false,true);
            this.nowGrid.x = 40 + 10;
            this.nowGrid.y = 65 + 10;
            addChild(this.nowGrid);
            this.vo1 = new Vo_petEquip();
            this.vo1.id = this.voi;
         }
         if(!this.newGrid)
         {
            this.newGrid = new PetZBGrid(false,".jpg");
            this.newGrid.type = Enum_type_grid.PET_ZB;
            this.newGrid.set_bmp_select();
            this.newGrid.set_bmp_bg("resource/image/team/zxBg.png");
            this.newGrid.set_bmp_over(true,"resource/image/team/grid_Skill_over.png");
            this.newGrid.set_tf_count(true,false,true);
            this.newGrid.x = 152 + 10;
            this.newGrid.y = 65 + 10;
            addChild(this.newGrid);
            this.vo2 = new Vo_petEquip();
            this.vo2.id = this.voi;
         }
         var i:int = 0;
         while(i < 4)
         {
            this.Vo_itemGridVec[i].init((PetzbVO.voArr[i] as Vo_petEquip).level,(PetzbVO.voArr[i] as Vo_petEquip).type,(PetzbVO.voArr[i] as Vo_petEquip).maxLevel,(PetzbVO.voArr[i] as Vo_petEquip).strength);
            this.GridVec[i].vo = this.Vo_itemGridVec[i];
            this.bmVec[i].load(this.Vo_itemGridVec[i].iconUrl);
            addChild(this.bmVec[i]);
            i++;
         }
         if(this.zb)
         {
            this.vo1.init((PetzbVO.voArr[type - 1] as Vo_petEquip).level,(PetzbVO.voArr[type - 1] as Vo_petEquip).type,(PetzbVO.voArr[type - 1] as Vo_petEquip).maxLevel,(PetzbVO.voArr[type - 1] as Vo_petEquip).strength);
            this.nowGrid.vo = this.vo1;
            if(!this.bm2)
            {
               this.bm2 = new Bitmap2();
            }
            this.bm2.x = 39 + 12 - 1;
            this.bm2.y = 63 + 15 - 3;
            this.bm2.load(this.Vo_itemGridVec[type - 1].iconUrl);
            addChild(this.bm2);
            this.vo2.init((PetzbVO.voArr[type - 1] as Vo_petEquip).level + 1,(PetzbVO.voArr[type - 1] as Vo_petEquip).type,(PetzbVO.voArr[type - 1] as Vo_petEquip).maxLevel,(PetzbVO.voArr[type - 1] as Vo_petEquip).strength,(PetzbVO.voArr[type - 1] as Vo_petEquip).nextstrength);
            this.newGrid.vo = this.vo2;
            if(!this.bm3)
            {
               this.bm3 = new Bitmap2();
            }
            this.bm3.x = 151 + 12 - 1;
            this.bm3.y = 63 + 15 - 3;
            this.bm3.load(this.Vo_itemGridVec[type - 1].iconUrl);
            addChild(this.bm3);
         }
         else if(this.sj)
         {
            this.vo1.init((PetzbVO.voArr[type - 1] as Vo_petEquip).level,(PetzbVO.voArr[type - 1] as Vo_petEquip).type,(PetzbVO.voArr[type - 1] as Vo_petEquip).maxLevel,(PetzbVO.voArr[type - 1] as Vo_petEquip).strength);
            this.nowGrid.vo = this.vo1;
            if(!this.bm2)
            {
               this.bm2 = new Bitmap2();
            }
            this.bm2.x = 39 + 12 - 1;
            this.bm2.y = 63 + 15 - 3;
            this.bm2.load(this.Vo_itemGridVec[type - 1].iconUrl);
            addChild(this.bm2);
            this.vo2.init((PetzbVO.voArr[type - 1] as Vo_petEquip).level,(PetzbVO.voArr[type - 1] as Vo_petEquip).type,(PetzbVO.voArr[type - 1] as Vo_petEquip).maxLevel + 10,(PetzbVO.voArr[type - 1] as Vo_petEquip).strength);
            this.newGrid.vo = this.vo2;
            if(!this.bm3)
            {
               this.bm3 = new Bitmap2();
            }
            this.bm3.x = 151 + 12 - 1;
            this.bm3.y = 63 + 15 - 3;
            this.bm3.load(this.Vo_itemGridVec[type - 1].nexticonUrl);
            addChild(this.bm3);
         }
      }
      
      private function zdgmClick(e:MouseEvent) : void
      {
         if(this.zdgmBox.selected)
         {
            TiShiPanel.instance.show();
         }
      }
      
      public function getnewvalue() : void
      {
         var i:int = 0;
         i = 0;
         while(i < 4)
         {
            this.Vo_itemGridVec[i].init((PetzbVO.voArr[i] as Vo_petEquip).level,(PetzbVO.voArr[i] as Vo_petEquip).type,(PetzbVO.voArr[i] as Vo_petEquip).maxLevel,(PetzbVO.voArr[i] as Vo_petEquip).strength);
            this.GridVec[i].vo = this.Vo_itemGridVec[i];
            this.bmVec[i].x = 10 + i * 60;
            this.bmVec[i].y = 11;
            this.bmVec[i].load(this.Vo_itemGridVec[i].iconUrl);
            addChild(this.bmVec[i]);
            i++;
         }
      }
      
      private function gridClick(e:MouseEvent) : void
      {
         var i:int = 0;
         while(i < this.GridVec.length)
         {
            this.GridVec[i].bSelect = false;
            i++;
         }
         switch(e.target)
         {
            case this.GridVec[0]:
               this.type = 1;
               this.voi = this.Vo_itemGridVec[0].id;
               break;
            case this.GridVec[1]:
               this.type = 2;
               this.voi = this.Vo_itemGridVec[1].id;
               break;
            case this.GridVec[2]:
               this.type = 3;
               this.voi = this.Vo_itemGridVec[2].id;
               break;
            case this.GridVec[3]:
               this.type = 4;
               this.voi = this.Vo_itemGridVec[3].id;
         }
         (e.target as PetZBGrid).bSelect = true;
         this.shuxingtf();
         this.istype(this.type);
         this.getGrid(this.type);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(isFirstOpen)
            {
               this.GridVec[0].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
               isFirstOpen = false;
            }
            Global.control.registerCallBack(Enum_MsgType.BAG_UPDATE,this.handleBagUpdate);
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.BAG_UPDATE,this.handleBagUpdate);
         }
      }
      
      private function handleBagUpdate() : void
      {
         this.getCaiLiao();
         this.getCaiLiao2();
      }
      
      private function sjClick(e:MouseEvent) : void
      {
         if(this.type == 0)
         {
            UIManager.centerBroadcast.addMsg("请选择装备");
            return;
         }
         PetCGMessage.CG_PET_SHENGJIE(this.type);
      }
      
      private function zbqhClick(e:MouseEvent) : void
      {
         this.last = getTimer();
         this.num = 1;
         this.zbqhBtn.enabled = false;
         if(this.zdgmBox.selected)
         {
            this.yuanbao = 1;
         }
         else
         {
            this.yuanbao = 2;
         }
         addEventListener(Event.ENTER_FRAME,this.en);
         PetCGMessage.CG_PET_QIANGHUA(this.type,this.yuanbao);
      }
      
      private function en(e:Event) : void
      {
         this.now = getTimer();
         if(this.now - this.last >= 1000)
         {
            --this.num;
            this.zbqhBtn.label = this.num.toString();
            this.last = this.now;
         }
         if(this.num < 1)
         {
            removeEventListener(Event.ENTER_FRAME,this.en);
            this.zbqhBtn.enabled = true;
            this.zbqhBtn.label = "强化";
         }
      }
      
      private function ispanel() : void
      {
         if(this.zb)
         {
            this.zbspr.visible = true;
            this.sjspr.visible = false;
         }
         if(this.sj)
         {
            this.zbspr.visible = false;
            this.sjspr.visible = true;
         }
      }
      
      public function istype(type:int) : void
      {
         if((PetzbVO.voArr[type - 1] as Vo_petEquip).level == (PetzbVO.voArr[type - 1] as Vo_petEquip).maxLevel)
         {
            this.sj = true;
            this.zb = false;
         }
         else
         {
            this.sj = false;
            this.zb = true;
         }
         this.shuxingtf();
         if(this.sj)
         {
            this.getCaiLiao();
         }
         if(this.zb)
         {
            this.getCaiLiao2();
         }
         this.ispanel();
      }
      
      public function update() : void
      {
         this.zb = true;
         this.ispanel();
      }
   }
}

import com.yiTian.view.comp.View_Grid;

class PetZBGrid extends View_Grid
{
   
   public var posStr:String;
   
   public var _enabled:Boolean = true;
   
   public function PetZBGrid($bBigIcon:Boolean = false, str_extend_name:String = ".png")
   {
      super($bBigIcon,str_extend_name);
   }
   
   public function get enable() : Boolean
   {
      return this._enabled;
   }
   
   public function set enable(v:Boolean) : void
   {
      if(!v)
      {
         set_grey(true);
      }
      else
      {
         set_grey(false);
      }
      this._enabled = v;
   }
}
