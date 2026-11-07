package com.yiTian.view.modules.tip.tips
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.utils.HtmlUtil;
   import flash.display.Sprite;
   
   public class View_petTaoTip extends Sprite
   {
      
      private static var txtFoot:MyTextField;
      
      private static var nextTxt:MyTextField;
      
      private static var lvlTao:String;
      
      private static var shuXing:String;
      
      private static var shuXingValue:int;
      
      private static var nextTao:String;
      
      private static var nextShuXing:String;
      
      private static var nextShuXingValue:int;
      
      private static var _txt:String = "";
      
      private static var _txt2:String = "";
      
      public function View_petTaoTip()
      {
         super();
         ComponentUtil.getScaleBitmap("Back_Floating",[8,9,4,2],this,{
            "width":160,
            "height":170
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":15,
            "y":37,
            "width":130,
            "width":4
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":15,
            "y":100,
            "width":130,
            "width":4
         },Global.Img_Cdm);
         txtFoot = ComponentUtil.getTextField("",this,{
            "x":20,
            "y":5,
            "leading":5,
            "color":11515029
         });
         txtFoot.multiline = true;
         txtFoot.htmlText = _txt;
         nextTxt = ComponentUtil.getTextField("",this,{
            "x":20,
            "y":115,
            "leading":5,
            "color":11515029
         });
         nextTxt.multiline = true;
         nextTxt.htmlText = _txt2;
      }
      
      public static function getTao(lvl:int) : void
      {
         var str2:String = null;
         var arr2:Array = null;
         var str:String = null;
         var arr:Array = null;
         if(lvl < 11)
         {
            str2 = Data_lib.chongwutaozhuang[lvl + 1][1];
            arr2 = str2.split("_");
            nextTao = Data_lib.chongwutaozhuang[lvl + 1][2];
            nextShuXing = Data_lib.attribute[arr2[1]][0];
            nextShuXingValue = arr2[2];
            _txt2 = nextTao + "</font>" + "  待激活" + "\n" + "4件：" + nextShuXing + nextShuXingValue + "%";
         }
         else
         {
            _txt2 = "130级套装属性  待激活\n敬请期待";
         }
         if(Boolean(lvl))
         {
            str = Data_lib.chongwutaozhuang[lvl][1];
            arr = str.split("_");
            lvlTao = Data_lib.chongwutaozhuang[lvl][2];
            shuXing = Data_lib.attribute[arr[1]][0];
            shuXingValue = arr[2];
            _txt = HtmlUtil.font("套装效果\n\n","#ffff00",14) + "<font color = \'#ffff00\'>" + lvlTao + "</font>" + "<font color =\'#6495ED\'>" + "  已激活" + "</font>" + "\n" + "<font color = \'#00ff00\'>" + "4件：" + shuXing + shuXingValue + "%</font>";
         }
         else
         {
            _txt = HtmlUtil.font("套装效果\n\n","#ffff00",14) + "10级套装属性" + "\n" + "无";
         }
         if(Boolean(txtFoot))
         {
            txtFoot.htmlText = _txt;
         }
         if(Boolean(nextTxt))
         {
            nextTxt.htmlText = _txt2;
         }
      }
   }
}

