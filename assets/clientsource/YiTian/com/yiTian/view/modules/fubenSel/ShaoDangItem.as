package com.yiTian.view.modules.fubenSel
{
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.HtmlUtil;
   import flash.display.Sprite;
   
   public class ShaoDangItem extends Sprite
   {
      
      private static var pool:Array = [];
      
      private var timesTxt:MyTextField;
      
      private var jingYanTxt:MyTextField;
      
      private var jingYanDanTxt:MyTextField;
      
      private var bingSilverTxt:MyTextField;
      
      private var dropTxt:MyTextField;
      
      private var back:ScaleBitmap;
      
      private var expDanArr:Array = new Array();
      
      private var expDanAddArr:Array = [125,150,175,200];
      
      public function ShaoDangItem()
      {
         super();
         this.timesTxt = ComponentUtil.getTextField("",this,{
            "x":10,
            "y":0,
            "textColor":14013822
         });
         this.jingYanTxt = ComponentUtil.getTextField("",this,{
            "x":36,
            "y":20,
            "textColor":8437092
         });
         this.jingYanDanTxt = ComponentUtil.getTextField("",this,{
            "x":123,
            "y":20
         });
         this.bingSilverTxt = ComponentUtil.getTextField("",this,{
            "x":36,
            "y":40,
            "textColor":16383744
         });
         this.dropTxt = ComponentUtil.getTextField("",this,{
            "x":36,
            "y":60,
            "realWidth":272,
            "wordWrap":true,
            "multiline":true,
            "leading":4,
            "textColor":14013822
         });
         this.back = ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":2,
            "y":83,
            "width":315,
            "height":2
         },Global.Img_Cdm);
      }
      
      public static function getItem() : ShaoDangItem
      {
         if(Boolean(pool.length))
         {
            return pool.pop();
         }
         return new ShaoDangItem();
      }
      
      public function init(data:Array) : void
      {
         this.expDanArr = [LangConfig.getWord("831",0),LangConfig.getWord("832",0),LangConfig.getWord("833",0),LangConfig.getWord("834",0)];
         this.timesTxt.text = LangConfig.getWord("279",0) + String(data[0]) + LangConfig.getWord("835",0);
         this.jingYanTxt.text = LangConfig.getWord("979",0) + String(data[1]);
         if(data[2] != 0)
         {
            this.jingYanDanTxt.htmlText = HtmlUtil.font("（" + this.expDanArr[data[2] - 1] + LangConfig.getWord("837",0) + String(this.expDanAddArr[data[2] - 1]) + "%）",Model_shop.get_color_arr[data[2] - 1]);
         }
         else if(data[2] == 0)
         {
            this.jingYanDanTxt.text = LangConfig.getWord("838",0);
         }
         this.bingSilverTxt.text = LangConfig.getWord("839",0) + String(data[3]);
         var temStr:String = LangConfig.getWord("840",0);
         var i:int = 0;
         while(i < data[4].length)
         {
            temStr += this.getStr(data[4][i]);
            i++;
         }
         this.dropTxt.textColor = 14013822;
         this.dropTxt.htmlText = temStr;
         this.rePos();
      }
      
      public function rePos() : void
      {
         this.back.y = this.dropTxt.y + this.dropTxt.height + 3;
      }
      
      private function getStr(_arr:Array) : String
      {
         var temStr:String = null;
         var temVo:Vo_valuable = null;
         var temVoI:Vo_item = null;
         var temVoE:Vo_equip = null;
         if(_arr[0] == 1)
         {
            temVoI = new Vo_item();
            temVoI.id = _arr[1];
            temVoI.Init_lib();
            temVo = temVoI;
         }
         else if(_arr[0] == 2)
         {
            temVoE = new Vo_equip();
            temVoE.id = _arr[1];
            temVoE.Init_lib();
            temVo = temVoE;
         }
         else if(_arr[0] == 0)
         {
            return LangConfig.getWord("841",0);
         }
         return HtmlUtil.font(temVo.str_name + "x" + _arr[2] + "   ",Model_shop.get_color_arr[temVo.color - 1]);
      }
      
      public function dispose() : void
      {
         pool.push(this);
      }
      
      override public function get height() : Number
      {
         return 100;
      }
   }
}

