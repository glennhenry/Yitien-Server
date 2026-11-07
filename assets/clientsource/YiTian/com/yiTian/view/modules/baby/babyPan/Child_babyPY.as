package com.yiTian.view.modules.baby.babyPan
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.modules.baby.Ibaby;
   import com.yiTian.view.modules.baby.babyManager.Model_baby;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.PerspectiveProjection;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class Child_babyPY extends Ibaby
   {
      
      public static var nowCheck:InerMod;
      
      private static var idArr:Array = [45269,45270];
      
      private static var dicArr:Array = ["attStrength","attIntel","attLucky"];
      
      private static var expArr:Array = ["baby_strength_exp","baby_zhiHui_exp","baby_lucky_exp"];
      
      private static var lvlArr:Array = ["baby_strength_lvl","baby_zhiHui_lvl","baby_lucky_lvl"];
      
      private static var isFirstShow:Boolean = true;
      
      private var itemVec:Vector.<InerMod> = new Vector.<InerMod>(3);
      
      private var promItemVec:Vector.<PromItem> = new Vector.<PromItem>();
      
      private var super_container:Sprite = new Sprite();
      
      private var fullYearTxt:MyTextField;
      
      private var func:Function;
      
      private var bb:Bitmap;
      
      private var conBB:Sprite;
      
      public function Child_babyPY()
      {
         addChild(this.super_container);
         super(this.super_container);
         this.initB();
      }
      
      public static function get instance() : Child_babyPY
      {
         return Singleton.getInstance(Child_babyPY) as Child_babyPY;
      }
      
      private function initB() : void
      {
         var item:InerMod = null;
         var promItem:PromItem = null;
         var i:uint = 0;
         while(i < this.itemVec.length)
         {
            item = new InerMod();
            item.initMod(i);
            this.super_container.addChild(item);
            ComponentUtil.setPropertie(item,{
               "x":12 + tiaoZheng,
               "y":21 + 61 * i
            });
            this.itemVec[i] = item;
            i++;
         }
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.super_container,{
            "x":13 + tiaoZheng,
            "y":199,
            "width":232,
            "height":107
         },Global.Img_Cdm);
         var j:uint = 0;
         while(j < 2)
         {
            promItem = new PromItem(0);
            promItem.init(idArr[j]);
            promItem.tabIndex = j + 1;
            this.promItemVec.push(promItem);
            this.super_container.addChild(promItem);
            ComponentUtil.setPropertie(promItem,{
               "x":10 + tiaoZheng,
               "y":208 + j * 48
            });
            j++;
         }
      }
      
      override public function update(obj:* = null) : void
      {
         var pItem:PromItem = null;
         var item:InerMod = null;
         var temObj:Object = null;
         var i:uint = 0;
         while(i < this.itemVec.length)
         {
            item = this.itemVec[i];
            temObj = new Object();
            temObj.lvl = Model_baby[lvlArr[i]];
            temObj.exp = Model_baby[expArr[i]];
            item.update(i,temObj,Data_lib[dicArr[i]]);
            i++;
         }
         for each(pItem in this.promItemVec)
         {
            pItem.updateLeftTimes();
         }
         this.fullYear();
      }
      
      public function fullYear() : void
      {
         this.promItemVec[0].visible = !Model_baby.is18;
         this.promItemVec[1].visible = !Model_baby.is18;
         if(!this.fullYearTxt)
         {
            this.fullYearTxt = ComponentUtil.getTextField("子女已成年，无法培养！",this.super_container,{
               "x":40 + tiaoZheng,
               "y":245,
               "size":16,
               "color":16383744
            });
         }
         this.fullYearTxt.visible = Model_baby.is18;
      }
      
      override public function show(obj:* = null) : void
      {
         this.visible = visible || true;
      }
      
      override public function hide(obj:* = null) : void
      {
         this.visible = visible && false;
         if(Boolean(obj) && obj is Function)
         {
            this.func = obj;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         var p:PerspectiveProjection;
         var nn:int = 0;
         var bmd:BitmapData = new BitmapData(258,this.super_container.height,true,0);
         bmd.draw(this.super_container);
         if(!this.bb)
         {
            this.bb = new Bitmap();
            this.conBB = new Sprite();
            addChild(this.conBB);
            this.conBB.addChild(this.bb);
            ComponentUtil.setPropertie(this.bb,{"x":-258 / 2});
            ComponentUtil.setPropertie(this.conBB,{"x":258 / 2});
         }
         p = new PerspectiveProjection();
         p.projectionCenter = new Point(this.conBB.x,this.conBB.y);
         p.fieldOfView = 45;
         this.conBB.transform.perspectiveProjection = p;
         this.conBB.transform.perspectiveProjection = p;
         this.bb.bitmapData = bmd;
         nn = int(setTimeout(function():void
         {
            clearTimeout(nn);
            super_container.visible = false;
         },50));
         this.conBB.visible = true;
         if(value)
         {
            super.visible = value;
            this.conBB.rotationY = -90;
            Tween.to(this.conBB,100,{"rotationY":[this.conBB.rotationY,0]},this.superShow);
         }
         else
         {
            Tween.to(this.conBB,100,{"rotationY":[0,90]},this.superHide);
         }
      }
      
      private function superShow() : void
      {
         this.super_container.visible = true;
         this.conBB.visible = false;
      }
      
      private function superHide() : void
      {
         this.super_container.visible = false;
         super.visible = false;
         if(this.func != null)
         {
            this.func();
         }
      }
   }
}

import com.ui.controls.CheckBox;
import com.ui.controls.MyTextField;
import com.utils.ColorConstant;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.data.config.DictionaryTabel;
import com.yiTian.manager.TipManager;
import com.yiTian.utils.HtmlUtil;
import com.yiTian.view.modules.baby.babyManager.Enum_baby;
import com.yiTian.view.modules.baby.babyPan.Child_babyPY;
import flash.display.Bitmap;
import flash.display.Shape;
import flash.display.Sprite;
import flash.text.TextFieldAutoSize;

class InerMod extends Sprite
{
   
   private static var bitmapDataArr:Array = ["Icon_WuBai","Icon_ZhiBai1","Icon_TiBai"];
   
   private static const arrAttDes:Array = [["攻击","命中"],["防御","躲避"],["气血","暴击"]];
   
   public static var list:Array = [];
   
   public static var colorArr:Array = ["WHITE","GREEN","BLUE","PURPLE","ORANGE"];
   
   private static var sourceOfPeiYangIcon:Array = [["Icon_WuBai","Icon_WuLv","Icon_WuLan","Icon_WuZi","Icon_WuJin"],["Icon_ZhiBai1","Icon_ZhiLv","Icon_ZhiLan","Icon_ZhiZi","Icon_ZhiJin"],["Icon_TiBai","Icon_TiLv","Icon_TiLan","Icon_TiZi","Icon_TiJin"]];
   
   public var checkBox:CheckBox;
   
   private var tfInfo:MyTextField;
   
   private var backPro:Bitmap;
   
   private var proBar:Bitmap;
   
   private var tfPer:MyTextField;
   
   private var tipCon:Sprite;
   
   private var mskSp:Shape;
   
   public var type:uint;
   
   private var iconBm:Bitmap;
   
   private var info1:MyTextField;
   
   private var info2:MyTextField;
   
   public var isFull_lvl:Boolean = false;
   
   public function InerMod()
   {
      super();
   }
   
   public function initMod(_type:uint) : void
   {
      list.push(this);
      this.type = _type;
      this.checkBox = ComponentUtil.getCheckBox("","CheckBox01",this,{"color":16772287},Global.Img_Cdm);
      this.tfInfo = ComponentUtil.getTextField("力量已级",this,{
         "x":19,
         "y":-2,
         "color":16777215,
         "size":12,
         "leading":0
      },TextFieldAutoSize.LEFT);
      this.tfInfo.align = TextFieldAutoSize.LEFT;
      this.info1 = ComponentUtil.getTextField("防御:1000%",this,{
         "x":75,
         "y":-2,
         "color":16777215,
         "size":12,
         "leading":0
      },TextFieldAutoSize.LEFT);
      this.info1.align = TextFieldAutoSize.LEFT;
      this.info2 = ComponentUtil.getTextField("防御:1000%",this,{
         "x":142,
         "y":-2,
         "color":16777215,
         "size":12,
         "leading":0
      },TextFieldAutoSize.LEFT);
      this.info2.align = TextFieldAutoSize.LEFT;
      this.backPro = ComponentUtil.getBitmap("Line_ZNJDTD",this,{
         "x":-3,
         "y":25
      },Global.ZNdm);
      this.proBar = ComponentUtil.getBitmap("Line_ZNJDT",this,{
         "x":15,
         "y":28
      },Global.ZNdm);
      this.mskSp = ComponentUtil.getShape(206,11,0,0);
      ComponentUtil.setPropertie(this.mskSp,{
         "x":15,
         "y":28
      });
      addChild(this.mskSp);
      this.proBar.mask = this.mskSp;
      this.tfPer = ComponentUtil.getTextField("88/100",this,{
         "x":101,
         "y":24,
         "color":16777215,
         "size":12,
         "leading":0
      });
      this.tipCon = new Sprite();
      addChild(this.tipCon);
      ComponentUtil.setPropertie(this.tipCon,{
         "x":208,
         "y":-8
      });
      this.iconBm = ComponentUtil.getBitmap(bitmapDataArr[_type],this.tipCon,null,Global.ZNdm);
      this.checkBox.clickFun = this.checkBoxEvent;
      if(this.type == 0)
      {
         this.checkBox.selected = true;
         Child_babyPY.nowCheck = this;
      }
      this.info2.mouseEnabled = this.info1.mouseEnabled = this.tfInfo.mouseEnabled = true;
      TipManager.bind(this.info2,"在战斗时,增加宠物基础属性的百分比");
      TipManager.bind(this.info1,"在战斗时,增加宠物基础属性的百分比");
      TipManager.bind(this.tfInfo,"在战斗时,增加宠物基础属性的百分比");
   }
   
   private function checkBoxEvent(e:CheckBox) : void
   {
      if(Boolean(Child_babyPY.nowCheck) && Child_babyPY.nowCheck.checkBox == e)
      {
         return;
      }
      if(Boolean(Child_babyPY.nowCheck))
      {
         Child_babyPY.nowCheck.checkBox.selected = false;
      }
      this.checkBox.selected = true;
      Child_babyPY.nowCheck = this;
   }
   
   public function update(_type:uint, value:Object, dic:DictionaryTabel) : void
   {
      var arr:Array = null;
      var color:String = null;
      var nameLvl:String = null;
      var ss1:String = null;
      var ss2:String = null;
      var isMax:Boolean = value.lvl == Enum_baby.MAXLVL;
      var typeStr1:String = arrAttDes[_type][0];
      var typeStr2:String = arrAttDes[_type][1];
      var nn1:int = dic[value.lvl][1] * 1000 / 10;
      var nn2:int = dic[value.lvl][2] * 1000 / 10;
      var typeVul1:String = nn1.toFixed(0) + "%";
      var typeVul2:String = nn2.toFixed(0) + "%";
      this.tfInfo.htmlText = HtmlUtil.font(dic[value.lvl][3],"#f9ff00");
      this.info1.htmlText = typeStr1 + ":" + HtmlUtil.font(typeVul1,"#04ff00");
      this.info2.htmlText = typeStr2 + ":" + HtmlUtil.font(typeVul2,"#04ff00");
      if(dic[value.lvl][0] == 0)
      {
         this.tfPer.htmlText = "满级";
         this.isFull_lvl = true;
      }
      else
      {
         this.tfPer.htmlText = value.exp + "/" + dic[value.lvl][0];
      }
      this.mskSp.width = isMax ? Number(this.proBar.width) : this.proBar.width * value.exp / dic[value.lvl][0];
      var len:uint = dic.getLength();
      arr = [];
      var startLvl:uint = len - value.lvl < 2 ? uint(len - 2) : uint(value.lvl);
      var i:uint = startLvl;
      while(i <= startLvl + 2)
      {
         if(value.lvl < i)
         {
            color = "#999999";
         }
         else
         {
            color = ColorConstant.getColorStr(ColorConstant[colorArr[i - 1 > 4 ? 4 : i - 1]]);
         }
         nameLvl = HtmlUtil.font(dic[i][3],color);
         nn1 = dic[i][1] * 1000 / 10;
         nn2 = dic[i][2] * 1000 / 10;
         ss1 = HtmlUtil.font("宠物基础" + typeStr1 + "加成" + nn1 + "%",color);
         ss2 = HtmlUtil.font("基础" + typeStr2 + "加成" + nn2 + "%",color);
         arr.push([nameLvl,ss1,ss2]);
         i++;
      }
      this.iconBm.bitmapData = ComponentUtil.getBitmapData(sourceOfPeiYangIcon[_type][value.lvl - 1 > 4 ? 4 : value.lvl - 1],Global.ZNdm);
      TipManager.bind(this.tipCon,arr,[0,60,95]);
   }
}
