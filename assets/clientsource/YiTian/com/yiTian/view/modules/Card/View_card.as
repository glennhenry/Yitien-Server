package com.yiTian.view.modules.Card
{
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.TipManager;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   
   public class View_card extends Sprite
   {
      
      public static const boderArray:Array = [[new GlowFilter(ColorConstant.getColorInt(ColorConstant.WHITE),1,5,5,10)],[new GlowFilter(ColorConstant.getColorInt(ColorConstant.GREEN),1,5,5,10)],[new GlowFilter(ColorConstant.getColorInt(ColorConstant.BLUE),1,5,5,10)],[new GlowFilter(ColorConstant.getColorInt(ColorConstant.PURPLE),1,5,5,10)],[new GlowFilter(ColorConstant.getColorInt(ColorConstant.ORANGE),1,5,5,10)]];
      
      private var _vo:Vo_card;
      
      private var backSpr:Sprite;
      
      private var roleBm:Bitmap;
      
      private var bigBorderBm:Bitmap;
      
      private var borderBm:Bitmap;
      
      private var pointBm:Bitmap;
      
      private var starBmArr:Array = [];
      
      private var levelTxt:MyTextField;
      
      private var attributeTxt:MyTextField;
      
      private var skillTxt:MyTextField;
      
      public function View_card()
      {
         super();
         this.backSpr = new Sprite();
         addChild(this.backSpr);
         this.bigBorderBm = ComponentUtil.getBitmap("",this.backSpr,{
            "x":0,
            "y":0
         });
         this.borderBm = ComponentUtil.getBitmap("",this.backSpr,{
            "x":12,
            "y":12
         });
         this.roleBm = ComponentUtil.getBitmap("",this.backSpr,{
            "x":12,
            "y":12
         });
         this.pointBm = ComponentUtil.getBitmap("",this.backSpr,{
            "x":124,
            "y":141
         });
         ComponentUtil.getBitmap("Back_KPXJ",this.backSpr,{
            "x":11,
            "y":147
         },Global.KaPaidm);
         var starId:int = 0;
         while(starId < 5)
         {
            this.starBmArr.push(ComponentUtil.getBitmap("",this.backSpr,{
               "x":16 + starId * 18,
               "y":148
            }));
            starId++;
         }
         ComponentUtil.getBitmap("Back_ShuXing",this.backSpr,{
            "x":11,
            "y":168
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Back_JiNeng",this.backSpr,{
            "x":11,
            "y":189
         },Global.KaPaidm);
         this.attributeTxt = ComponentUtil.getTextField("攻击+?暴击+?",this.backSpr,{
            "x":43,
            "y":170,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.attributeTxt.wordWrap = true;
         this.attributeTxt.multiline = true;
         this.attributeTxt.width = 120;
         this.skillTxt = ComponentUtil.getTextField("??拳",this.backSpr,{
            "x":43,
            "y":191,
            "color":10092288,
            "size":12,
            "leading":0
         });
         this.skillTxt.wordWrap = true;
         this.skillTxt.width = 120;
         this.levelTxt = ComponentUtil.getTextField("LV.?",this.backSpr,{
            "x":139,
            "y":146,
            "color":16777215,
            "size":12,
            "leading":0
         },"center");
         this._vo = new Vo_card();
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverCard);
         addEventListener(MouseEvent.MOUSE_MOVE,this.onRollOverCard);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutCard);
      }
      
      public function set vo(value:Vo_card) : void
      {
         if(Boolean(value))
         {
            this.id = value.id;
            this.star = value.star;
            this.level = value.level;
            this.exp = value.exp;
            this.backSpr.visible = true;
         }
         else
         {
            this.id = 0;
            this.star = -1;
            this.level = 0;
            this.exp = 0;
            this.backSpr.visible = false;
         }
      }
      
      public function get vo() : Vo_card
      {
         return this._vo;
      }
      
      public function get color() : int
      {
         return this.vo.color;
      }
      
      public function get level() : int
      {
         return this.vo.level;
      }
      
      public function set level(value:int) : void
      {
         var ShuXingArr:Array = null;
         var str:String = null;
         var i:* = undefined;
         var t_ShuXing:Array = null;
         var name:String = null;
         var num:Number = NaN;
         this.vo.level = value;
         if(value > 0)
         {
            this.levelTxt.text = "LV." + this.level;
            ShuXingArr = Data_lib.card[this.id][5].split(",");
            str = "";
            for(i in ShuXingArr)
            {
               t_ShuXing = ShuXingArr[i].split("_");
               name = Data_lib.attribute[t_ShuXing[0]][0];
               num = int(t_ShuXing[1]) * Number(Data_lib.cardLevel[this.level][5]);
               str += HtmlUtil.fontNoSize(name,ColorConstant.getColorStr(ColorConstant.GREEN)) + HtmlUtil.fontNoSize("+" + num.toFixed(1) + "‰",ColorConstant.getColorStr(ColorConstant.YELLOW));
               if(i < ShuXingArr.length - 1)
               {
                  str += "<br/>";
               }
            }
            this.attributeTxt.htmlText = str;
            this.attributeTxt.y = 179 - this.attributeTxt.height / 2;
         }
         else
         {
            this.levelTxt.text = "";
            this.attributeTxt.htmlText = "";
         }
      }
      
      public function get star() : int
      {
         return this.vo.star;
      }
      
      public function set star(value:int) : void
      {
         var starNum:* = undefined;
         var i:* = undefined;
         this.vo.star = value;
         if(value >= 0)
         {
            for(starNum in this.starBmArr)
            {
               if(starNum < this.star)
               {
                  this.starBmArr[starNum].bitmapData = ComponentUtil.getBitmapData("Icon_LXX",Global.KaPaidm);
               }
               else
               {
                  this.starBmArr[starNum].bitmapData = ComponentUtil.getBitmapData("Icon_AXX",Global.KaPaidm);
               }
            }
            this.skillTxt.htmlText = Data_lib.cardStar[this.id][18] + (Data_lib.cardStar[this.id][19] == 0 ? "" : "  " + Data_lib.cardStar[this.id][19]);
         }
         else
         {
            for(i in this.starBmArr)
            {
               this.starBmArr[i].bitmapData = null;
            }
            this.skillTxt.htmlText = "";
         }
      }
      
      public function set id(value:int) : void
      {
         this.vo.id = value;
         if(value > 0)
         {
            Utils.getLoadBitmap("resource/image/card/card/" + Data_lib.card[this.id][0] + ".png",this.roleBm);
            this.borderBm.bitmapData = ComponentUtil.getBitmapData("Light_Da" + this.color,Global.KaPaidm);
            this.bigBorderBm.bitmapData = ComponentUtil.getBitmapData("Back_Da" + this.color,Global.KaPaidm);
            this.pointBm.bitmapData = ComponentUtil.getBitmapData("Back_KP" + this.color,Global.KaPaidm);
         }
         else
         {
            this.roleBm.bitmapData = null;
            this.borderBm.bitmapData = null;
            this.bigBorderBm.bitmapData = null;
            this.pointBm.bitmapData = null;
         }
      }
      
      public function get id() : int
      {
         return this.vo.id;
      }
      
      public function get exp() : int
      {
         return this.vo.exp;
      }
      
      public function set exp(value:int) : void
      {
         this.vo.exp = value;
      }
      
      private function onRollOverCard(e:MouseEvent) : void
      {
         TipManager.update(this.vo);
         filters = boderArray[this.vo.color - 1];
      }
      
      private function onRollOutCard(e:MouseEvent) : void
      {
         TipManager.hide();
         filters = null;
      }
   }
}

