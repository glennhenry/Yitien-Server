package com.yiTian.view.modules.goldLottery
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.valuable.Enum_color;
   import com.yiTian.data.model.Model_GoldCJ;
   import com.yiTian.data.vo.Vo_GoldCJ;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flashx.textLayout.formats.TextAlign;
   
   public class Child_GoldCJRewardList extends Panel123
   {
      
      private var titleBg:Bitmap;
      
      private var sureBtn:Button;
      
      private var infoTF:MyTextField;
      
      private var sbm1:ScaleBitmap;
      
      private var sbm2:ScaleBitmap;
      
      private var min_bm_1_height:int = 130;
      
      private var min_bm_2_height:int = 75;
      
      private var min_btn_y:int = 90;
      
      public function Child_GoldCJRewardList()
      {
         super();
      }
      
      override protected function initUI2() : void
      {
         this.sbm1 = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":310,
            "height":211 + 150
         },Global.Img_Cdm);
         this.sbm2 = ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":28,
            "y":45,
            "width":253,
            "height":155 + 150
         },Global.Img_Cdm);
         move = new Rectangle(0,0,310,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":704 - 426,
            "y":6,
            "textColor":16184781,
            "callBack":function():void
            {
               visible = false;
            }
         },Global.Img_Cdm);
         this.titleBg = ComponentUtil.getBitmap("Title_YuanBaoCJ",this,{
            "x":289 - 204,
            "y":5
         },Global.YuanBaoCJ_Imgsdm);
         this.infoTF = ComponentUtil.getTextField("物品名字六个*999",this,{
            "x":90,
            "y":70,
            "color":3461909,
            "size":13,
            "leading":4,
            "realWidth":124,
            "align":TextAlign.CENTER,
            "multiline":true,
            "wordWrap":true
         });
         this.sureBtn = ComponentUtil.getButton("确定","Button_Four",this,{
            "x":118,
            "y":172 + 135,
            "textColor":16771436,
            "callBack":function():void
            {
               visible = false;
            }
         },Global.Img_Cdm);
      }
      
      public function update(arr:Array) : void
      {
         var lenHeight:int = 0;
         var obj:Object = null;
         var vo:Vo_GoldCJ = null;
         var index:String = null;
         var str:String = null;
         this.visible = true;
         var len:int = int(arr.length);
         var temDic:Dictionary = new Dictionary();
         var i:int = 0;
         while(i < len)
         {
            obj = arr[i] as Object;
            vo = Model_GoldCJ.voArr[obj.index - 1];
            if(vo)
            {
               if(Boolean(temDic[obj.index]))
               {
                  temDic[obj.index] += vo.vo.count;
               }
               else
               {
                  temDic[obj.index] = vo.vo.count;
                  lenHeight++;
               }
            }
            i++;
         }
         this.infoTF.htmlText = "";
         for(index in temDic)
         {
            vo = Model_GoldCJ.voArr[int(index) - 1];
            if(vo.vo.color == Enum_color.WHITE)
            {
               str = ColorConstant.getColorStr(ColorConstant.WHITE);
            }
            else if(vo.vo.color == Enum_color.GREEN)
            {
               str = ColorConstant.getColorStr(ColorConstant.GREEN);
            }
            else if(vo.vo.color == Enum_color.BLUE)
            {
               str = ColorConstant.getColorStr(ColorConstant.BLUE);
            }
            else if(vo.vo.color == Enum_color.PURPLE)
            {
               str = ColorConstant.getColorStr(ColorConstant.PURPLE);
            }
            else if(vo.vo.color == Enum_color.ORANGE)
            {
               str = ColorConstant.getColorStr(ColorConstant.ORANGE);
            }
            str = HtmlUtil.font(vo.vo.str_name + " x " + temDic[index] + "<br>",str,14);
            this.infoTF.htmlText += str;
         }
         this.infoTF.realHeight = 24 + lenHeight * 24;
         this.sbm1.height = this.min_bm_1_height + lenHeight * 24;
         this.sbm2.height = this.min_bm_2_height + lenHeight * 24;
         this.sureBtn.y = this.min_btn_y + lenHeight * 24;
         resetPosition();
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!this.titleBg)
            {
               this.initUI2();
            }
            pop();
         }
      }
   }
}

