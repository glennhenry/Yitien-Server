package com.yiTian.view.modules.jingJiChang
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class View_awardItem extends Sprite
   {
      
      private var txtArr:Array = [LangConfig.getWord("279",0) + "\n" + LangConfig.getWord("280",0) + "\n" + LangConfig.getWord("281",0),LangConfig.getWord("282",0) + "\n" + LangConfig.getWord("283",0) + "\n" + LangConfig.getWord("281",0),LangConfig.getWord("282",0) + "\n" + LangConfig.getWord("284",0) + "\n" + LangConfig.getWord("283",0),LangConfig.getWord("285",0) + "\n" + LangConfig.getWord("281",0) + "\n" + LangConfig.getWord("286",0)];
      
      private var urlStr:Array = ["Box_Jin","Box_Zi","Box_Lan","Box_Lv"];
      
      private var tf:MyTextField;
      
      private var grid:View_Grid;
      
      private var _type:int;
      
      private var colorArr:Array = ["#FF9966","#ff00ff","#33ccff","#04ff00"];
      
      private var awardArr:Array = [LangConfig.getWord("287",0) + "\n" + LangConfig.getWord("291",0) + "\n" + LangConfig.getWord("293",0) + "\n" + LangConfig.getWord("292",0) + "\n" + LangConfig.getWord("297",0) + "\n" + LangConfig.getWord("298",0) + "\n" + LangConfig.getWord("299",0),LangConfig.getWord("288",0) + "\n" + LangConfig.getWord("291",0) + "\n" + LangConfig.getWord("294",0) + "\n" + LangConfig.getWord("292",0) + "\n" + LangConfig.getWord("297",0) + "\n" + LangConfig.getWord("298",0) + "\n" + LangConfig.getWord("299",0),LangConfig.getWord("289",0) + "\n" + LangConfig.getWord("291",0) + "\n" + LangConfig.getWord("295",0) + "\n" + LangConfig.getWord("292",0) + "\n" + LangConfig.getWord("297",0) + "\n" + LangConfig.getWord("298",0) + "\n" + LangConfig.getWord("299",0),LangConfig.getWord("290",0) + "\n" + LangConfig.getWord("291",0) + "\n" + LangConfig.getWord("296",0) + "\n" + LangConfig.getWord("292",0) + "\n" + LangConfig.getWord("297",0) + "\n" + LangConfig.getWord("298",0) + "\n" + LangConfig
      .getWord("299",0)];
      
      private var bmp:Bitmap = new Bitmap();
      
      public function View_awardItem(_type:int)
      {
         super();
         ComponentUtil.getBitmap("grid_ShangCheng",this,null,Global.Img_Cdm);
         this.tf = ComponentUtil.getTextField("",this,{"y":9});
         var temStr:String = HtmlUtil.font(this.txtArr[_type],this.colorArr[_type]);
         this.tf.htmlText = temStr;
         this.tf.visible = false;
         this.getType(_type);
         TipManager.bind(this,"     " + Data_lib.xuanfu[_type][0] + "\n" + LangConfig.getWord("291",0) + "\n" + "           " + Data_lib.xuanfu[_type][1] + "\n" + LangConfig.getWord("300",0) + "\n" + "          " + Data_lib.xuanfu[_type][2]);
      }
      
      private function getType(type:int) : void
      {
         this.bmp = Utils.getLoadBitmap("resource/image/jjc/" + this.urlStr[type] + ".png",this.bmp,null,this.compleHandle);
         addChild(this.bmp);
      }
      
      private function compleHandle() : void
      {
         this.bmp.x = 0;
      }
   }
}

