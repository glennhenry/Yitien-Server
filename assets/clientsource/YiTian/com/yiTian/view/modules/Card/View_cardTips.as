package com.yiTian.view.modules.Card
{
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.tip.tips.View_tip;
   import flash.display.Bitmap;
   
   public class View_cardTips extends View_tip
   {
      
      private var roleBm:Bitmap;
      
      private var nameTxt:MyTextField;
      
      private var borderBm:Bitmap;
      
      private var bigBorderBm:Bitmap;
      
      private var levelTxt:MyTextField;
      
      private var expTxt:MyTextField;
      
      private var attributeTxt:MyTextField;
      
      private var skillTxt:MyTextField;
      
      private var starBmArr:Array = [];
      
      private var DengJiBm:Bitmap;
      
      private var JingYanBm:Bitmap;
      
      private var ShuXingBm:Bitmap;
      
      private var JiNengBm:Bitmap;
      
      public function View_cardTips()
      {
         super();
      }
      
      override public function Init() : void
      {
         border = ComponentUtil.getScaleBitmap("Back_Floating",[8,9,4,2],this,{
            "x":0,
            "y":0,
            "width":255,
            "height":100
         },Global.Img_Cdm);
         this.bigBorderBm = ComponentUtil.getBitmap("",this,{
            "x":145,
            "y":10
         });
         this.roleBm = ComponentUtil.getBitmap("",this,{
            "x":153,
            "y":18
         });
         this.borderBm = ComponentUtil.getBitmap("",this,{
            "x":153,
            "y":18
         });
         this.nameTxt = ComponentUtil.getTextField("名字",this,{
            "x":81,
            "y":10,
            "color":3407667,
            "size":16,
            "leading":0
         },"center");
         var starId:int = 0;
         while(starId < 5)
         {
            this.starBmArr.push(ComponentUtil.getBitmap("",this,{
               "x":33 + starId * 18,
               "y":35
            }));
            starId++;
         }
         this.DengJiBm = ComponentUtil.getBitmap("",this,{
            "x":10,
            "y":54
         });
         this.levelTxt = ComponentUtil.getTextField("??/??",this,{
            "x":45,
            "y":55,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.JingYanBm = ComponentUtil.getBitmap("",this,{
            "x":10,
            "y":84
         });
         this.expTxt = ComponentUtil.getTextField("??/??",this,{
            "x":45,
            "y":85,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.ShuXingBm = ComponentUtil.getBitmap("",this,{
            "x":10,
            "y":114
         });
         this.attributeTxt = ComponentUtil.getTextField("??/??",this,{
            "x":45,
            "y":115,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.attributeTxt.multiline = true;
         this.JiNengBm = ComponentUtil.getBitmap("",this,{
            "x":10,
            "y":144
         });
         this.skillTxt = ComponentUtil.getTextField("??/??",this,{
            "x":45,
            "y":145,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.skillTxt.multiline = true;
         this.skillTxt.width = 230;
         this.skillTxt.wordWrap = true;
         border.width = 292;
      }
      
      override public function Show(obj:Object, type:int = 1, stoneLvl:int = 0) : void
      {
         var vo:Vo_card = null;
         var starNum:* = undefined;
         var skillStr:String = null;
         var ShuXingArr:Array = null;
         var str:String = null;
         var i:* = undefined;
         var t_ShuXing:Array = null;
         var name:String = null;
         var num:Number = NaN;
         if(obj is Vo_card)
         {
            vo = obj as Vo_card;
            this.DengJiBm.bitmapData = ComponentUtil.getBitmapData("Back_DengJi",Global.KaPaidm);
            this.JingYanBm.bitmapData = ComponentUtil.getBitmapData("Back_JingYan",Global.KaPaidm);
            this.ShuXingBm.bitmapData = ComponentUtil.getBitmapData("Back_ShuXing",Global.KaPaidm);
            this.JiNengBm.bitmapData = ComponentUtil.getBitmapData("Back_JiNeng",Global.KaPaidm);
            Utils.getLoadBitmap("resource/image/card/card_small/" + Data_lib.card[vo.id][0] + ".png",this.roleBm);
            this.bigBorderBm.bitmapData = ComponentUtil.getBitmapData("Back_Xiao" + vo.color,Global.KaPaidm);
            this.borderBm.bitmapData = ComponentUtil.getBitmapData("Light_Xiao" + vo.color,Global.KaPaidm);
            this.nameTxt.htmlText = HtmlUtil.fontNoSize(Data_lib.card[vo.id][2],ColorConstant.getItemColorStr(Data_lib.card[vo.id][4]));
            for(starNum in this.starBmArr)
            {
               if(starNum < vo.star)
               {
                  this.starBmArr[starNum].bitmapData = ComponentUtil.getBitmapData("Icon_LXX",Global.KaPaidm);
               }
               else
               {
                  this.starBmArr[starNum].bitmapData = ComponentUtil.getBitmapData("Icon_AXX",Global.KaPaidm);
               }
            }
            this.levelTxt.htmlText = vo.level + "/" + Data_lib.cardStar[vo.id][vo.star + 4];
            this.expTxt.htmlText = vo.exp + "/" + Data_lib.cardLevel[vo.level][vo.color - 1];
            skillStr = "";
            if(Data_lib.cardStar[vo.id][18] != 0)
            {
               skillStr += Data_lib.cardStar[vo.id][18] + "：" + Data_lib.skill[int(String(Data_lib.cardStar[vo.id][vo.star - 1]).split(",")[0])][20];
            }
            if(Data_lib.cardStar[vo.id][19] != 0)
            {
               skillStr += "<br/><br/>" + Data_lib.cardStar[vo.id][19] + "：" + Data_lib.skill[int(String(Data_lib.cardStar[vo.id][vo.star - 1]).split(",")[1])][20];
            }
            this.skillTxt.htmlText = HtmlUtil.fontNoSize(skillStr,ColorConstant.getColorStr(ColorConstant.YELLOW));
            ShuXingArr = Data_lib.card[vo.id][5].split(",");
            str = "";
            for(i in ShuXingArr)
            {
               t_ShuXing = ShuXingArr[i].split("_");
               name = Data_lib.attribute[t_ShuXing[0]][0];
               num = int(t_ShuXing[1]) * Number(Data_lib.cardLevel[vo.level][5]);
               str += name + HtmlUtil.fontNoSize("+" + num.toFixed(1) + "‰",ColorConstant.getColorStr(ColorConstant.YELLOW)) + "<br/>";
            }
            this.attributeTxt.htmlText = str;
            this.attributeTxt.y = 125 - this.attributeTxt.height / 2;
            border.height = this.skillTxt.y + this.skillTxt.height + 5;
         }
      }
   }
}

