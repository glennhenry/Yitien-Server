package com.yiTian.view.modules.baby.babyPan
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.TipManager;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.baby.Ibaby;
   import com.yiTian.view.modules.baby.babyManager.Model_baby;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.PerspectiveProjection;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class Child_babyMeili extends Ibaby
   {
      
      private static var space:String = "              ";
      
      private static const desArr:Array = ["气血：","攻击：","防御：","伤害：","伤免："];
      
      private static const dataLen:uint = 5;
      
      private static var metialId:uint = 45268;
      
      public static var colorArr:Array = ["WHITE","GREEN","BLUE","PURPLE","ORANGE"];
      
      private static var sourceOfMLIcon:Array = ["Icon_MeiBai","Icon_MeiLv","Icon_MeiLan","Icon_MeiZi","Icon_MeiJin"];
      
      private static var isFirstOpen:Boolean = true;
      
      private var progressBar:Bitmap;
      
      private var progressBarMask:Shape;
      
      private var meiLiLvlTf:MyTextField;
      
      private var conSp:Sprite;
      
      private var tfAttArr:Array = [];
      
      private var nextTfAttArr:Array = [];
      
      private var grid:View_Grid;
      
      private var btnUse:Button;
      
      private var iconMeiLi:Bitmap;
      
      private var super_container:Sprite = new Sprite();
      
      private var promItem:PromItem;
      
      private var tfPer:MyTextField;
      
      private var func:Function;
      
      private var bb:Bitmap;
      
      private var conBB:Sprite;
      
      public function Child_babyMeili()
      {
         addChild(this.super_container);
         super(this.super_container);
         this.initB();
      }
      
      public static function get instance() : Child_babyMeili
      {
         return Singleton.getInstance(Child_babyMeili) as Child_babyMeili;
      }
      
      private function initB() : void
      {
         var tfCur:MyTextField = null;
         var tfNext:MyTextField = null;
         addChild(this.super_container);
         ComponentUtil.getBitmap("Line_ZNJDTD",this.super_container,{
            "x":9 + tiaoZheng,
            "y":51
         },Global.ZNdm);
         this.progressBar = ComponentUtil.getBitmap("Line_ZNJDT",this.super_container,{
            "x":27 + tiaoZheng,
            "y":54
         },Global.ZNdm);
         this.progressBarMask = ComponentUtil.getShape(this.progressBar.width,this.progressBar.height,0,0);
         this.super_container.addChild(this.progressBarMask);
         ComponentUtil.setPropertie(this.progressBarMask,{
            "x":this.progressBar.x,
            "y":this.progressBar.y
         });
         this.progressBar.mask = this.progressBarMask;
         this.meiLiLvlTf = ComponentUtil.getTextField("等级：魅力一星",this.super_container,{
            "x":17 + tiaoZheng,
            "y":22,
            "color":16768256,
            "size":12,
            "leading":0
         });
         this.conSp = new Sprite();
         this.super_container.addChild(this.conSp);
         ComponentUtil.setPropertie(this.conSp,{
            "x":this.meiLiLvlTf.x + this.meiLiLvlTf.width + 20,
            "y":this.meiLiLvlTf.y - 5
         });
         this.iconMeiLi = ComponentUtil.getBitmap("Icon_MeiBai",this.conSp,null,Global.ZNdm);
         ComponentUtil.getBitmap("Text_ZJSX",this.super_container,{
            "x":9 + tiaoZheng,
            "y":80
         },Global.ZNdm);
         ComponentUtil.getTextField("当前等级属性       下级等级属性",this.super_container,{
            "x":43 + tiaoZheng,
            "y":110,
            "color":16772287,
            "size":12,
            "leading":0
         });
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.super_container,{
            "x":13 + tiaoZheng,
            "y":232,
            "width":232,
            "height":54
         },Global.Img_Cdm);
         this.promItem = new PromItem(-1);
         this.promItem.init(metialId);
         this.super_container.addChild(this.promItem);
         ComponentUtil.setPropertie(this.promItem,{
            "x":8 + tiaoZheng,
            "y":238
         });
         var i:int = 0;
         while(i < dataLen)
         {
            tfCur = ComponentUtil.getTextField("",this.super_container,{
               "x":43 + tiaoZheng,
               "y":130 + 19 * i,
               "color":16772287,
               "size":12,
               "leading":5
            });
            tfNext = ComponentUtil.getTextField("",this.super_container,{
               "x":165 + tiaoZheng,
               "y":130 + 19 * i,
               "color":327424,
               "size":12,
               "leading":5
            });
            ComponentUtil.getBitmap("Icon_SXTS",this.super_container,{
               "x":150 + tiaoZheng,
               "y":132 + 19 * i
            },Global.ZNdm);
            this.tfAttArr.push(tfCur);
            this.nextTfAttArr.push(tfNext);
            i++;
         }
         ComponentUtil.getTextField("注：崽崽每天魅力值会下降5%",this.super_container,{
            "x":44 + tiaoZheng,
            "y":291,
            "color":16768256,
            "size":12,
            "leading":0
         });
         this.tfPer = ComponentUtil.getTextField("88/100",this.super_container,{
            "x":113 + tiaoZheng,
            "y":50,
            "color":16777215,
            "size":12,
            "leading":0
         });
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
      
      override public function update(obj:* = null) : void
      {
         var i:uint = 0;
         var arr:Array = null;
         var colorStr:String = null;
         var des:String = null;
         var s1:String = null;
         var s2:String = null;
         var s3:String = null;
         var s4:String = null;
         var s5:String = null;
         var nextTemArr:Array = null;
         var curObj:String = null;
         var nextObj:String = null;
         var _curObj:String = null;
         if(Model_baby.baby_meiLi_lvl == 0)
         {
            Model_baby.baby_meiLi_lvl = 1;
         }
         this.progressBarMask.width = int(this.progressBar.width * Model_baby.baby_meiLi_value / Data_lib.meiLiValue[Model_baby.baby_meiLi_lvl][0]);
         this.meiLiLvlTf.htmlText = "等级：" + Data_lib.meiLiValue[Model_baby.baby_meiLi_lvl][6];
         var len:uint = Data_lib.meiLiValue.getLength();
         arr = [];
         var startLvl:uint = len - Model_baby.baby_meiLi_lvl < 2 ? uint(len - 2) : uint(Model_baby.baby_meiLi_lvl);
         i = startLvl;
         while(i <= startLvl + 2)
         {
            if(Model_baby.baby_meiLi_lvl < i)
            {
               colorStr = "#999999";
            }
            else
            {
               colorStr = ColorConstant.getColorStr(ColorConstant[colorArr[i - 1 > 4 ? 4 : i - 1]]);
            }
            des = HtmlUtil.font(Data_lib.meiLiValue[i][6] + ": ",colorStr);
            s1 = HtmlUtil.font("气血+" + Data_lib.meiLiValue[i][1],colorStr);
            s2 = HtmlUtil.font("攻击+" + Data_lib.meiLiValue[i][2],colorStr);
            s3 = HtmlUtil.font("防御+" + Data_lib.meiLiValue[i][3],colorStr);
            s4 = HtmlUtil.font("伤害+" + int(Data_lib.meiLiValue[i][4] * 100) + "%",colorStr);
            s5 = HtmlUtil.font("伤免+" + int(Data_lib.meiLiValue[i][5] * 100) + "%",colorStr);
            arr.push([des,s1,s2,s3,s4,s5]);
            i++;
         }
         var temArr:Array = Data_lib.meiLiValue[Model_baby.baby_meiLi_lvl];
         if(Model_baby.baby_meiLi_lvl < len)
         {
            this.tfPer.htmlText = Model_baby.baby_meiLi_value + "/" + Data_lib.meiLiValue[Model_baby.baby_meiLi_lvl][0];
            nextTemArr = Data_lib.meiLiValue[Model_baby.baby_meiLi_lvl + 1];
            i = 0;
            while(i < dataLen)
            {
               if(i >= 3)
               {
                  curObj = int(temArr[i + 1] * 100) + "%";
                  nextObj = int(nextTemArr[i + 1] * 100) + "%";
               }
               else
               {
                  curObj = temArr[i + 1].toString();
                  nextObj = nextTemArr[i + 1].toString();
               }
               this.tfAttArr[i].htmlText = desArr[i] + curObj;
               this.nextTfAttArr[i].htmlText = nextObj;
               i++;
            }
         }
         else
         {
            this.tfPer.htmlText = Model_baby.baby_meiLi_value + "/" + Data_lib.meiLiValue[Model_baby.baby_meiLi_lvl - 1][0];
            i = 0;
            while(i < dataLen)
            {
               if(i >= 3)
               {
                  _curObj = int(temArr[i + 1] * 100) + "%";
               }
               else
               {
                  _curObj = temArr[i + 1].toString();
               }
               this.tfAttArr[i].htmlText = desArr[i] + _curObj;
               this.nextTfAttArr[i].htmlText = "0";
               i++;
            }
         }
         ComponentUtil.setPropertie(this.conSp,{"x":this.meiLiLvlTf.x + this.meiLiLvlTf.width + 20});
         this.iconMeiLi.bitmapData = ComponentUtil.getBitmapData(sourceOfMLIcon[Model_baby.baby_meiLi_lvl - 1 > 4 ? 4 : Model_baby.baby_meiLi_lvl - 1],Global.ZNdm);
         TipManager.bind(this.conSp,arr,[0,70,75,76,77,75]);
      }
      
      override public function set visible(value:Boolean) : void
      {
         var bmd:BitmapData;
         var p:PerspectiveProjection;
         var nn:int = 0;
         if(isFirstOpen)
         {
            isFirstOpen = false;
            super.visible = value;
            return;
         }
         bmd = new BitmapData(258,this.super_container.height,true,0);
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

