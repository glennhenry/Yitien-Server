package com.yiTian.view.modules.pet
{
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.valuable.Enum_filter;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.PetCGMessage;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.pet.petD.EffectPan;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextFormatAlign;
   
   public class NeiDanPanel extends EffectPan
   {
      
      public static var neiDan_Type:int;
      
      public static var eff_nd1:Effect;
      
      public static var eff_nd_sp1:Sprite;
      
      public static var eff_nd2:Effect;
      
      public static var eff_nd_sp2:Sprite;
      
      public static var eff_nd3:Effect;
      
      public static var eff_nd_sp3:Sprite;
      
      public static const idArr:Array = [46306,46307,46308,46309,46309,46309,46309,46309,46309,46309];
      
      private const WIDTH:int = 218;
      
      private const HEIGHT:int = 10;
      
      private var nameArr:Array = [Data_lib.attribute[1][0],Data_lib.attribute[2][0],Data_lib.attribute[3][0]];
      
      private var nameTypeArr:Array = [LangConfig.getWord("10067",1),LangConfig.getWord("10068",1),LangConfig.getWord("10069",1),LangConfig.getWord("10070",1),LangConfig.getWord("10071",1),LangConfig.getWord("10653",1),LangConfig.getWord("10654",1),"冥","始","祖","魔","天","皇","帝","劫"];
      
      private var checkBoxVec:Vector.<CheckBox>;
      
      private var barBackVec:Vector.<Bitmap>;
      
      private var barBMVec:Vector.<Bitmap>;
      
      private var barMaskVec:Vector.<Shape>;
      
      private var barTxtVec:Vector.<MyTextField>;
      
      private var neiDanBMVec:Vector.<Bitmap>;
      
      private var neiDanSPVec:Vector.<Sprite>;
      
      private var checkXY:Array = [new Point(8,12),new Point(8,55),new Point(8,98)];
      
      private var btn:Button;
      
      private var gridInfo:MyTextField;
      
      private var grid:View_Grid;
      
      private var danQiTF:MyTextField;
      
      private var _neiDanVO:NeiDanVO;
      
      private var curCheckBox:CheckBox;
      
      private var jinJiePan:JinJiePan;
      
      private var jinJie_Type:int;
      
      private var jinJie_Type1:int;
      
      private var jinJie_Type2:int;
      
      private var jinJie_Type3:int;
      
      private var ind:int;
      
      private var data:Array = [];
      
      private var levelArr:Array = [30,50,60,70,80,80,90,100,110,115,120,125,130,135];
      
      private var danQiArr:Array = [1000,1000,1000,1500,1500,2000,2000,3000];
      
      private var curJieDanType:int;
      
      private var eff:Effect;
      
      private var effSp:Sprite;
      
      private var cureType:int;
      
      private var typeArr:Array = [100,200,300,400,1000,2000,3260,5056,7680];
      
      private var firstTime:Boolean = false;
      
      private var w:int;
      
      private var curValue:int;
      
      private var maxValue:int;
      
      private var isFirstOpen:Boolean = true;
      
      public var isShow:int;
      
      private var bmp:Bitmap;
      
      private var str1:String = "三种内丹进阶为冥丹 伤害加成3%";
      
      private var str2:String = "三种内丹进阶为始丹 伤害加成5%";
      
      private var str3:String = "三种内丹进阶为祖丹 伤害加成7%";
      
      public function NeiDanPanel()
      {
         var barBack:Bitmap = null;
         var barBM:Bitmap = null;
         var barMask:Shape = null;
         var barTxt:MyTextField = null;
         var checkBox:CheckBox = null;
         var neiDanBM:Bitmap = null;
         var neiDanSP:Sprite = null;
         var i:uint = 0;
         super();
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":-2,
            "y":0,
            "width":245,
            "height":283
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":8,
            "y":163,
            "width":220,
            "height":50
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60247",6),this,{
            "x":45,
            "y":143,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.btn = ComponentUtil.getButton(LangConfig.getWord("10072",1),"Button_Orange",this,{
            "x":82,
            "y":235,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn.textColor = 16383744;
         this.btn.textOverColor = 16383744;
         this.btn.addEventListener(MouseEvent.CLICK,this.btnHandler);
         this.barBackVec = new Vector.<Bitmap>();
         this.barBMVec = new Vector.<Bitmap>();
         this.barTxtVec = new Vector.<MyTextField>();
         this.barMaskVec = new Vector.<Shape>();
         this.checkBoxVec = new Vector.<CheckBox>();
         this.neiDanBMVec = new Vector.<Bitmap>();
         this.neiDanSPVec = new Vector.<Sprite>();
         i = 0;
         while(i < 3)
         {
            checkBox = new CheckBox(LangConfig.getWord("10073",1),"CheckBox01",Global.Img_Cdm);
            checkBox.x = this.checkXY[i].x;
            checkBox.y = this.checkXY[i].y;
            checkBox.name = "CheckBox_" + i;
            checkBox.htmlText = "<font color=\'#9DC282\'>" + this.nameArr[i] + this.nameTypeArr[0] + LangConfig.getWord("10073",1) + "</font>";
            this.checkBoxVec.push(checkBox);
            checkBox.addEventListener(MouseEvent.CLICK,this.checkBoxOnClick);
            barBack = new Bitmap();
            barBack.x = checkBox.x + 3;
            barBack.y = checkBox.y + 20;
            addChild(barBack);
            this.barBackVec.push(barBack);
            barBM = new Bitmap();
            barBM.x = checkBox.x + 3 + 1;
            barBM.y = checkBox.y + 20 + 1;
            addChild(barBM);
            this.barBMVec.push(barBM);
            barMask = new Shape();
            this.draw(barMask,this.WIDTH);
            addChild(barMask);
            barMask.x = barBM.x;
            barMask.y = barBM.y;
            barBM.mask = barMask;
            this.barMaskVec.push(barMask);
            barTxt = ComponentUtil.getTextField("100/100",this);
            barTxt.x = barBM.x;
            barTxt.y = barBM.y - 4;
            barTxt.realWidth = this.WIDTH;
            barTxt.align = TextFormatAlign.CENTER;
            this.barTxtVec.push(barTxt);
            neiDanBM = new Bitmap();
            neiDanBM.x = checkBox.x + 90;
            neiDanBM.y = checkBox.y - 5;
            addChild(neiDanBM);
            this.neiDanBMVec.push(neiDanBM);
            neiDanSP = new Sprite();
            neiDanSP.graphics.beginFill(0,0);
            neiDanSP.graphics.drawRect(0,0,20,20);
            neiDanSP.graphics.endFill();
            addChild(neiDanSP);
            neiDanSP.x = neiDanBM.x;
            neiDanSP.y = neiDanBM.y;
            this.neiDanSPVec.push(neiDanSP);
            addChild(checkBox);
            i++;
         }
         this.checkBoxVec[0].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         this.gridInfo = ComponentUtil.getTextField("",this,{
            "x":67.95,
            "y":183.75,
            "color":16777215
         });
         this.grid = new View_Grid();
         this.grid.type = Enum_type_grid.PET;
         this.grid.set_tf_count(false);
         this.grid.set_bmp_bg();
         this.grid.set_bmp_select();
         this.grid.set_bmp_over();
         this.grid.isAutoLoad = false;
         addChild(this.grid);
         this.grid.x = 18;
         this.grid.y = 171;
      }
      
      public static function removeEff(type:int) : void
      {
         if(type == 1)
         {
            if(Boolean(eff_nd1))
            {
               EffectManager.removeEffect(eff_nd1);
            }
            eff_nd1 = null;
         }
         else if(type == 2)
         {
            if(Boolean(eff_nd2))
            {
               EffectManager.removeEffect(eff_nd2);
            }
            eff_nd2 = null;
         }
         else if(type == 3)
         {
            if(Boolean(eff_nd3))
            {
               EffectManager.removeEffect(eff_nd3);
            }
            eff_nd3 = null;
         }
      }
      
      public static function getColor(type:int) : String
      {
         if(type == 1)
         {
            return ColorConstant.getColorStr(ColorConstant.WHITE);
         }
         if(type == 2)
         {
            return ColorConstant.getColorStr(ColorConstant.GREEN);
         }
         if(type == 3)
         {
            return ColorConstant.getColorStr(ColorConstant.BLUE);
         }
         if(type == 4)
         {
            return ColorConstant.getColorStr(ColorConstant.PURPLE);
         }
         if(type == 5)
         {
            return ColorConstant.getColorStr(ColorConstant.YELLOW);
         }
         if(type == 6)
         {
            return ColorConstant.getColorStr(ColorConstant.ORANGE);
         }
         return ColorConstant.getColorStr(ColorConstant.GREY);
      }
      
      public function set neiDanVO(value:NeiDanVO) : void
      {
         this._neiDanVO = value;
      }
      
      public function get neiDanVO() : NeiDanVO
      {
         return this._neiDanVO;
      }
      
      private function draw(shape:Shape, width:int) : void
      {
         shape.graphics.beginFill(0,1);
         shape.graphics.drawRect(0,0,this.WIDTH,this.HEIGHT);
         shape.graphics.endFill();
      }
      
      protected function checkBoxOnClick(event:MouseEvent) : void
      {
         var checkBox:CheckBox = event.currentTarget as CheckBox;
         if(this.curCheckBox == checkBox)
         {
            this.curCheckBox.selected = true;
            return;
         }
         if(Boolean(this.curCheckBox))
         {
            this.curCheckBox.selected = false;
         }
         checkBox.selected = true;
         this.curCheckBox = checkBox;
         this.updateInfo();
      }
      
      private function updateInfo() : void
      {
         var _tempA:Array = null;
         var i:int = 0;
         var j:uint = 0;
         var vo:Vo_item = null;
         if(!this._neiDanVO)
         {
            return;
         }
         this.ind = int(this.curCheckBox.name.split("CheckBox_")[1]);
         var value:int = int(this._neiDanVO.listArr[this.ind][1]);
         var lvl:int = int(this._neiDanVO.listArr[this.ind][0]);
         var arr:Array = [idArr[lvl]];
         if(lvl > 6)
         {
            arr = [Data_lib.petNeiDan[lvl][7]];
         }
         var vec:Vector.<Vo_valuable> = CommandManager.get_bag_vec(Enum_filter.ID,null,arr);
         var t:int = 0;
         if(Boolean(vec))
         {
            j = 0;
            while(j < vec.length)
            {
               t += vec[j].count;
               j++;
            }
         }
         this.showIcon();
         this.setBarMask();
         if(!this.jinJiePan)
         {
            this.jinJiePan = new JinJiePan();
            addChild(this.jinJiePan);
            this.jinJiePan.x = 8;
            this.jinJiePan.y = 140;
         }
         _tempA = ["攻击","防御","气血"];
         i = 0;
         while(i < 3)
         {
            if(PetVO.arr[i] == 1 && this.curCheckBox.name == "CheckBox_" + i)
            {
               this.jinJiePan.visible = true;
               this.jinJie_Type = this["jinJie_Type" + (i + 1)];
               NeiDanPanel["neiDan_Type"] = i + 1;
               this.jinJiePan.showJJPan(this.jinJie_Type);
               this.btn.label = "进阶";
               this.btn.name = _tempA[i];
               this.btn.filters = [];
               break;
            }
            if(i == 2)
            {
               if(Boolean(this.jinJiePan))
               {
                  this.jinJiePan.visible = false;
               }
               vo = new Vo_item();
               vo.id = idArr[this._neiDanVO.listArr[this.ind][0] > 5 ? 5 : this._neiDanVO.listArr[this.ind][0]];
               vo.Init_lib();
               this.grid.vo = vo;
               this.gridInfo.htmlText = "<font color=\'" + getColor(vo.color) + "\'>" + vo.str_name + " X " + t + "</font>";
               if(this._neiDanVO.listArr[this.ind][0] >= 13 && this._neiDanVO.listArr[this.ind][1] >= Data_lib.petNeiDan[this._neiDanVO.listArr[this.ind][0]][5])
               {
                  this.btn.filters = Util.disabled;
                  this.btn.label = LangConfig.getWord("10072",1);
               }
               else
               {
                  this.btn.filters = [];
                  if(this._neiDanVO.listArr[this.ind][0] > 5)
                  {
                     this.btn.filters = [];
                     this.btn.label = LangConfig.getWord("10072",1);
                  }
                  else if(value >= this.typeArr[this._neiDanVO.listArr[this.ind][0]])
                  {
                     if(UIManager.petPanel.petVO.level < this.levelArr[this._neiDanVO.listArr[this.ind][0] > 5 ? 5 : this._neiDanVO.listArr[this.ind][0]])
                     {
                        this.btn.filters = Util.disabled;
                     }
                     this.btn.label = LangConfig.getWord("10074",1);
                  }
                  else
                  {
                     this.btn.label = LangConfig.getWord("10072",1);
                  }
               }
            }
            i++;
         }
      }
      
      private function setBarMask() : void
      {
         var cI:int = 0;
         var chck:CheckBox = null;
         var index:int = 0;
         if(Boolean(this.checkBoxVec) && Boolean(this.checkBoxVec.length))
         {
            cI = 1;
            while(cI <= 3)
            {
               chck = this.checkBoxVec[cI - 1];
               if(Boolean(chck) && Boolean(chck.parent))
               {
                  index = chck.parent.getChildIndex(chck);
                  if(!NeiDanPanel["eff_nd_sp" + cI])
                  {
                     NeiDanPanel["eff_nd_sp" + cI] = new Sprite();
                     addChildAt(NeiDanPanel["eff_nd_sp" + cI],index - cI);
                  }
               }
               cI++;
            }
         }
         var i:int = 0;
         while(i < 3)
         {
            if(PetVO.arr[i] == 1 && this._neiDanVO.listArr[i][0] >= 6)
            {
               this["jinJie_Type" + (i + 1)] = this._neiDanVO.listArr[i][0] - 5;
               this.barMaskVec[i].width = this.WIDTH;
               NeiDanPanel["eff_nd_sp" + (i + 1)].x = this.barMaskVec[i].x;
               NeiDanPanel["eff_nd_sp" + (i + 1)].y = this.barMaskVec[i].y;
               if(!NeiDanPanel["eff_nd" + (i + 1)])
               {
                  NeiDanPanel["eff_nd" + (i + 1)] = EffectManager.addEffect("35271",NeiDanPanel["eff_nd_sp" + (i + 1)],1000,110,2,true);
               }
            }
            i++;
         }
      }
      
      protected function btnHandler(event:MouseEvent) : void
      {
         var p:PetVO = null;
         var vec:Vector.<Vo_valuable> = null;
         var isHave:Boolean = false;
         var counts:int = 0;
         var ss:String = null;
         var str:String = null;
         var btnIndex:int = int(this.curCheckBox.name.split("CheckBox_")[1]);
         var checkBoxType:Array = [1,2,0];
         var tunShiType:int = checkBoxType[btnIndex] + 1;
         var jieDanType:int = checkBoxType[btnIndex] + 5;
         if(event.target.label == LangConfig.getWord("10074",1))
         {
            p = UIManager.petPanel.petVO;
            if(this._neiDanVO.listArr[btnIndex][0] > 8)
            {
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10075",1) + "</font>");
            }
            else if(UIManager.petPanel.petVO.level < this.levelArr[this._neiDanVO.listArr[btnIndex][0] > 5 ? 5 : this._neiDanVO.listArr[btnIndex][0]])
            {
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10076",1,this.levelArr[this._neiDanVO.listArr[btnIndex][0] > 5 ? 5 : this._neiDanVO.listArr[btnIndex][0]]) + "</font>");
            }
            else
            {
               PetCGMessage.CG_PET_NEIDAN(jieDanType);
               this.curJieDanType = jieDanType;
               NeiDanVO.effType = 2;
            }
         }
         else if(event.target.label == LangConfig.getWord("10072",1))
         {
            if(this._neiDanVO.listArr[btnIndex][0] > 14)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("60248",6));
               return;
            }
            vec = CommandManager.get_bag_vec(Enum_filter.ITEM_PET_NEIDAN);
            isHave = vec.some(function(item:Vo_valuable, ind:int, v:Vector.<Vo_valuable>):Boolean
            {
               return grid.vo.id == item.id;
            });
            if(isHave)
            {
               PetCGMessage.CG_PET_NEIDAN(tunShiType,this.grid.vo.id);
               this.curJieDanType = tunShiType;
               NeiDanVO.isTunShi = true;
               NeiDanVO.effType = 1;
            }
            else
            {
               View_Alert.show("<font color=\'#ffffff\'>背包没有该品阶的内丹,是否前往<font color=\'#f9ff00\'>秘境</font>获取？</font>",2,function():void
               {
                  if(GameUnitManager.hero.level < 30)
                  {
                     UIManager.centerBroadcast.addMsg(LangConfig.getWord("904",0));
                     return;
                  }
                  UIManager.sm_shop.visible = !UIManager.sm_shop.visible;
               },null,null,null,340);
            }
         }
         else if(event.target.label == "进阶")
         {
            if(this.jinJie_Type == 0)
            {
               if(btnIndex == 0)
               {
                  this.jinJie_Type = 3;
               }
               else
               {
                  this.jinJie_Type = btnIndex;
               }
            }
            else if(this.jinJie_Type < 4)
            {
               counts = int(this.danQiArr[this.jinJie_Type - 1]);
            }
            else
            {
               counts = int(Data_lib.petNeiDan[this.jinJie_Type + 5][0]);
            }
            if(PetVO.danQiCount < counts)
            {
               UIManager.centerBroadcast.addMsg("亲~你的丹气值不足");
               return;
            }
            if(neiDan_Type == 1)
            {
               ss = "攻击内丹";
            }
            else if(neiDan_Type == 2)
            {
               ss = "防御内丹";
            }
            else if(neiDan_Type == 3)
            {
               ss = "气血内丹";
            }
            str = "<font color=\'#ffffff\'>" + "是否使用" + "</font>" + counts.toString() + "丹气值" + "<font color=\'#ffffff\'>" + "进阶宠物" + "</font>" + ss;
            View_Alert.show(str,View_Alert.OK_CANCAL,function():void
            {
               PetCGMessage.CG_PET_SURE_NEIDAN_JINJIE(neiDan_Type);
               NeiDanVO.effType = 3;
            });
         }
      }
      
      public function playEff() : void
      {
         if(!this.effSp)
         {
            this.effSp = new Sprite();
            addChild(this.effSp);
            this.effSp.scaleX = 0.6;
            this.effSp.scaleY = 0.6;
         }
         if(this.curJieDanType == 5 || this.curJieDanType == 1)
         {
            this.eff = EffectManager.addEffect("56918",this.effSp,600,200,215);
         }
         else if(this.curJieDanType == 6 || this.curJieDanType == 2)
         {
            this.eff = EffectManager.addEffect("56918",this.effSp,600,200,70);
         }
         else if(this.curJieDanType == 7 || this.curJieDanType == 3)
         {
            this.eff = EffectManager.addEffect("56918",this.effSp,600,200,140);
         }
      }
      
      public function update() : void
      {
         var type:int = 0;
         var tem_ss:String = null;
         var addStr:String = null;
         var _dataJJLvArr:Array = PetVO.jinJieLvArr;
         var i:uint = 0;
         while(i < 3)
         {
            type = int(this._neiDanVO.listArr[i][0]);
            this.curValue = this._neiDanVO.listArr[i][1];
            if(type < 6)
            {
               this.maxValue = this.typeArr[type];
            }
            else
            {
               this.maxValue = Data_lib.petNeiDan[type][5];
            }
            this.w = this.curValue > this.maxValue ? this.WIDTH : int(this.curValue / this.maxValue * this.WIDTH);
            this.barMaskVec[i].width = this.w;
            this.barTxtVec[i].text = this.curValue + "/" + this.maxValue;
            if(this._neiDanVO.listArr[i][0] >= 6 && PetVO.arr[i] == 1)
            {
               this.barTxtVec[i].text = "";
            }
            if(_dataJJLvArr[i] >= 1 && PetVO.arr[i] != 1)
            {
               type += 1;
            }
            tem_ss = "";
            if(type > 6)
            {
               tem_ss = Data_lib.petNeiDan[type - 1][2];
            }
            else
            {
               tem_ss = this.nameTypeArr[type] + LangConfig.getWord("10073",1);
            }
            this.checkBoxVec[i].htmlText = "<font color=\'#9DC282\'>" + this.nameArr[i] + tem_ss + "</font>";
            Utils.loadTitle("lang/ch/Pet_Imgs.swf","ND_L" + (type + 1),this.neiDanBMVec[i]);
            addStr = "";
            if(type >= 9)
            {
               addStr = Model_neiDan.add_str(type - 8);
            }
            TipManager.bind(this.neiDanSPVec[i],"<font color=\'" + (type > 0 ? getColor(1) : getColor(-1)) + "\'>" + LangConfig.getWord("10078",1) + "</font>\n" + "<font color=\'" + (type > 1 ? getColor(2) : getColor(-1)) + "\'>" + LangConfig.getWord("10079",1) + "</font>\n" + "<font color=\'" + (type > 2 ? getColor(3) : getColor(-1)) + "\'>" + LangConfig.getWord("10080",1) + "</font>\n" + "<font color=\'" + (type > 3 ? getColor(4) : getColor(-1)) + "\'>" + LangConfig.getWord("10081",1) + "</font>\n" + "<font color=\'" + (type > 4 ? getColor(5) : getColor(-1)) + "\'>" + LangConfig.getWord("10651",1) + "</font>\n" + "<font color=\'" + (type > 5 ? getColor(6) : getColor(-1)) + "\'>" + LangConfig.getWord("10652",1) + "</font>\n" + "<font color=\'" + (type > 6 ? Model_neiDan.getColor(7) : getColor(-1)) + "\'>" + this.str1 + "</font>\n" + "<font color=\'" + (type > 7 ? Model_neiDan.getColor(8) : getColor(-1)) + "\'>" + this.str2 + "</font>\n" + "<font color=\'" + (type > 8 ? Model_neiDan.getColor(9) : getColor(-1)) + "\'>" + this
            .str3 + "</font>\n" + addStr);
            i++;
         }
         this.updateInfo();
      }
      
      override public function set visible(value:Boolean) : void
      {
         var i:uint = 0;
         super.visible = value;
         if(value)
         {
            this.checkBoxVec[0].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            i = 0;
            while(i < 3)
            {
               if(!this.barBackVec[i].bitmapData)
               {
                  Utils.loadTitle("lang/ch/Pet_Imgs.swf","Pet_ProgressLoading_board",this.barBackVec[i]);
               }
               if(!this.barBMVec[i].bitmapData)
               {
                  Utils.loadTitle("lang/ch/Pet_Imgs.swf","Pet_ProgressLoading",this.barBMVec[i]);
               }
               i++;
            }
            if(this.isFirstOpen)
            {
               this.setGridLoad();
               this.isFirstOpen = false;
            }
         }
      }
      
      public function setGridLoad() : void
      {
         this.grid.isAutoLoad = true;
         this.grid.beginLoad();
      }
      
      public function showIcon() : void
      {
         this.isShow = PetVO.danQiCount;
         if(PetVO.danQiCount == -1)
         {
            return;
         }
         if(!Global.Pet_Imgsdm)
         {
            SingleLoader.add("lang/ch/Pet_Imgs.swf",function(info:Object):void
            {
               Global.Pet_Imgsdm = info.applicationDomain;
               initSource();
            });
         }
         else
         {
            this.initSource();
         }
      }
      
      private function initSource() : void
      {
         var sp:Sprite = null;
         if(!sp)
         {
            sp = new Sprite();
         }
         sp.x = 175;
         sp.y = 2;
         addChild(sp);
         if(!this.bmp)
         {
            this.bmp = ComponentUtil.getBitmap("Icon_DanQi",sp,{
               "x":0,
               "y":0
            },Global.Pet_Imgsdm);
         }
         TipManager.bind(sp,"<font color=\'" + getColor(5) + "\'>" + "丹气来源于家园" + "</font>");
         if(!this.danQiTF)
         {
            this.danQiTF = ComponentUtil.getTextField("12345",this,{
               "x":200,
               "y":10,
               "color":16383744,
               "size":12,
               "leading":0
            });
         }
         this.danQiTF.text = PetVO.danQiCount.toString();
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.data.Data_lib;
import com.yiTian.utils.SingleLoader;
import flash.display.Bitmap;
import flash.display.Sprite;

class JinJiePan extends Sprite
{
   
   private var needCount:Array = [];
   
   public function JinJiePan()
   {
      super();
   }
   
   public function showJJPan(type:int) : void
   {
      if(!Global.Pet_Imgsdm)
      {
         SingleLoader.add("lang/ch/Pet_Imgs.swf",function(info:Object):void
         {
            Global.Pet_Imgsdm = info.applicationDomain;
            show(type);
         });
      }
      else
      {
         this.show(type);
      }
   }
   
   public function show(type:int) : void
   {
      var _type:int = type;
      ComponentUtil.getBitmap("Back_NDTZ",this,{
         "x":0,
         "y":0
      },Global.Pet_Imgsdm);
      var tf:MyTextField = ComponentUtil.getTextField("丹气 1000",this,{
         "x":104,
         "y":70,
         "color":16383744,
         "size":12,
         "leading":0
      });
      ComponentUtil.getTextField("进阶所需",this,{
         "x":85,
         "y":45,
         "color":11904647,
         "size":12,
         "leading":0
      });
      ComponentUtil.getBitmap("Icon_DanQi",this,{
         "x":70,
         "y":65
      },Global.Pet_Imgsdm);
      ComponentUtil.getTextField("内丹进阶",this,{
         "x":85,
         "y":0,
         "color":11904647,
         "size":12,
         "leading":0
      });
      ComponentUtil.getBitmap("Icon_JianTou",this,{
         "x":105,
         "y":25
      },Global.Pet_Imgsdm);
      var bmp1:Bitmap = ComponentUtil.getBitmap("",this,{
         "x":56,
         "y":25
      },Global.Pet_Imgsdm);
      var bmp2:Bitmap = ComponentUtil.getBitmap("",this,{
         "x":161,
         "y":25
      },Global.Pet_Imgsdm);
      if(type == 1)
      {
         bmp1.bitmapData = ComponentUtil.getBitmapData("ND_L7",Global.Pet_Imgsdm);
         bmp2.bitmapData = ComponentUtil.getBitmapData("ND_L8",Global.Pet_Imgsdm);
         tf.text = "丹气 1000";
      }
      else if(type == 2)
      {
         bmp1.bitmapData = ComponentUtil.getBitmapData("ND_L8",Global.Pet_Imgsdm);
         bmp2.bitmapData = ComponentUtil.getBitmapData("ND_L9",Global.Pet_Imgsdm);
         tf.text = "丹气 1000";
      }
      else if(type == 3)
      {
         bmp1.bitmapData = ComponentUtil.getBitmapData("ND_L9",Global.Pet_Imgsdm);
         bmp2.bitmapData = ComponentUtil.getBitmapData("ND_L10",Global.Pet_Imgsdm);
         tf.text = "丹气 1000";
      }
      else if(type > 3)
      {
         bmp1.bitmapData = ComponentUtil.getBitmapData("ND_L" + (Data_lib.petNeiDan[type + 5][8] + 6),Global.Pet_Imgsdm);
         bmp2.bitmapData = ComponentUtil.getBitmapData("ND_L" + (Data_lib.petNeiDan[type + 5][8] + 7),Global.Pet_Imgsdm);
         tf.text = "丹气 " + Data_lib.petNeiDan[type + 5][0];
      }
   }
}
