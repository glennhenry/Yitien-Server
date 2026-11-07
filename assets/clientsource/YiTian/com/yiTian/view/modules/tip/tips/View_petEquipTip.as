package com.yiTian.view.modules.tip.tips
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.data.vo.Vo_petEquip;
   import com.yiTian.utils.Bitmap2;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.modules.pet.PetzbVO;
   
   public class View_petEquipTip extends View_tip
   {
      
      private static const MAXLEVEL:int = 15;
      
      private var tfDescrip:MyTextField;
      
      private var _tfName:String;
      
      private var _bmIcon:Bitmap2;
      
      private var _tfLevel:String;
      
      private var _tfMaxLevel:String;
      
      private var _tfStrength:String;
      
      private var _tfshuxing:String;
      
      private var kongge:String = "       ";
      
      private var lvltao:int;
      
      private var nextNum:int;
      
      private var TaoLevel:int;
      
      private var nowLvltf:String;
      
      private var nowLvljc:String;
      
      private var nextLvltf:String;
      
      public function View_petEquipTip()
      {
         super();
      }
      
      override public function Init() : void
      {
         addBorder();
         this.tfDescrip = ComponentUtil.getTextField("",this,{
            "x":10,
            "y":10,
            "multiline":true,
            "wordWrap":true,
            "leading":5,
            "realWidth":200,
            "color":11527396
         });
      }
      
      private function resizeBorder() : void
      {
         border.width = 170;
         border.height = 190;
      }
      
      override public function Show(obj:Object, type:int = 1, stoneLvl:int = 0) : void
      {
         var v:Vo_petEquip = null;
         var num:int = 0;
         var str:String = null;
         var arr:Array = null;
         var shuXing:String = null;
         var shuXingValue:int = 0;
         var str2:String = null;
         var arr2:Array = null;
         var nextShuXing:String = null;
         var nextShuXingValue:String = null;
         var mxtstr:String = null;
         if(obj is Vo_petEquip)
         {
            v = obj as Vo_petEquip;
            PetzbVO.arr.sortOn("maxLevel",Array.NUMERIC);
            this.TaoLevel = PetzbVO.arr[0].maxLevel / 10 - 1;
            if(PetzbVO.arr[0].maxLevel == PetzbVO.arr[3].maxLevel)
            {
               num = 4;
            }
            else if(PetzbVO.arr[0].maxLevel == PetzbVO.arr[2].maxLevel)
            {
               num = 3;
            }
            else if(PetzbVO.arr[0].maxLevel == PetzbVO.arr[1].maxLevel)
            {
               num = 2;
            }
            else
            {
               num = 1;
            }
            this.nextNum = 4 - num;
            if(this.TaoLevel > 0 && this.TaoLevel != MAXLEVEL)
            {
               str = Data_lib.chongwutaozhuang[this.TaoLevel][1];
               arr = str.split("_");
               shuXing = Data_lib.attribute[arr[1]][0];
               shuXingValue = int(arr[2]);
               this.nowLvltf = "<font color = \'#FF7F00\'>" + PetzbVO.arr[0].maxLevel + "级套装：" + "</font>" + "<font color = \'#6495ED\'>" + "(4/4) 已激活" + "</font>" + "\n" + "<font color = \'#00ff00\'>" + "         " + shuXing + shuXingValue + "%</font>" + "\n";
               str2 = Data_lib.chongwutaozhuang[this.TaoLevel + 1][1];
               arr2 = str2.split("_");
               nextShuXing = Data_lib.attribute[arr2[1]][0];
               nextShuXingValue = arr2[2];
               this.nextLvltf = "<font color = \'#FF7F00\'>" + (PetzbVO.arr[0].maxLevel + 10) + "级套装：" + "</font>" + "<font color = \'#AFB495\'>" + "(" + this.nextNum + "/4) 未激活" + "\n" + "<font color = \'#AFB495\'>" + "         " + nextShuXing + nextShuXingValue + "%</font>";
            }
            else if(this.TaoLevel == 0)
            {
               this.nowLvltf = "";
               str2 = Data_lib.chongwutaozhuang[this.TaoLevel + 1][1];
               arr2 = str2.split("_");
               nextShuXing = Data_lib.attribute[arr2[1]][0];
               nextShuXingValue = arr2[2];
               this.nextLvltf = "<font color = \'#FF7F00\'>" + (PetzbVO.arr[0].maxLevel + 10) + "级套装：" + "</font>" + "<font color = \'#AFB495\'>" + "(" + this.nextNum + "/4) 未激活" + "\n" + "<font color = \'#AFB495\'>" + "         " + nextShuXing + nextShuXingValue + "%</font>";
            }
            else if(this.TaoLevel == MAXLEVEL)
            {
               str = Data_lib.chongwutaozhuang[this.TaoLevel][1];
               arr = str.split("_");
               shuXing = Data_lib.attribute[arr[1]][0];
               shuXingValue = int(arr[2]);
               this.nowLvltf = "<font color = \'#FF7F00\'>" + PetzbVO.arr[0].maxLevel + "级套装：" + "</font>" + "<font color = \'#6495ED\'>" + "(4/4) 已激活" + "</font>" + "\n" + "<font color = \'#00ff00\'>" + "         " + shuXing + shuXingValue + "%</font>" + "\n";
               this.nextLvltf = "170级套装属性" + "\n" + "敬请期待" + "\n";
            }
            this._tfName = HtmlUtil.font(v.str_name,Model_shop.get_color_arr[v.isColor - 1],14);
            ComponentUtil.getBitmap("Grid_Open",this,{
               "x":13,
               "y":58 - 25
            },Global.Img_Cdm);
            this._bmIcon = new Bitmap2();
            this._bmIcon.x = 15;
            this._bmIcon.y = 60 - 25;
            this._bmIcon.load(v.iconUrl);
            addChild(this._bmIcon);
            this._tfLevel = this.kongge + this.kongge + "<font color = \'#ffffff\'>" + "等级: " + "</font>" + "<font color = \'#ffff00\'>" + v.jiexing + "</font>" + "\n";
            mxtstr = "(" + v.maxLevel + "级)\n";
            this._tfMaxLevel = HtmlUtil.font(mxtstr,Model_shop.get_color_arr[v.isColor - 1]);
            if(v.nextstrength == 0)
            {
               this._tfStrength = this.kongge + this.kongge + "<font color = \'#ffffff\'>" + "战力: " + "</font>" + "<font color = \'#ffff00\'>" + v.strength + "</font>" + "\n";
            }
            else
            {
               this._tfStrength = this.kongge + this.kongge + "<font color = \'#ffffff\'>" + "战力: " + "</font>" + "<font color = \'#ffff00\'>" + v.nextstrength + "</font>" + "\n";
            }
            this._tfshuxing = "<font color = \'#ffffff\'>" + "基础属性: " + v.shuxing1 + " + " + v.shuxingvalue1 + "</font>" + "\n" + this.kongge + this.kongge + "<font color = \'#ffffff\'>" + v.shuxing2 + " + " + v.shuxingvalue2 + "</font>" + "\n";
            this.tfDescrip.htmlText = this._tfName + this._tfMaxLevel + this._tfStrength + this._tfLevel + this._tfshuxing + this.nowLvltf + this.nextLvltf;
         }
         this.resizeBorder();
      }
   }
}

