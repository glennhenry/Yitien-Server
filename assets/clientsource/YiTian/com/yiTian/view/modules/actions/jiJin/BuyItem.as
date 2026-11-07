package com.yiTian.view.modules.actions.jiJin
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.utils.HtmlUtil;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class BuyItem extends Sprite
   {
      
      private var ybTf:MyTextField;
      
      private var jjTf:MyTextField;
      
      private var jjBm:Bitmap;
      
      private var typeJJTf:MyTextField;
      
      public function BuyItem()
      {
         super();
         this.jjBm = ComponentUtil.getBitmap("Icon_JiJin_L3",this,{
            "x":15,
            "y":10
         },Global.JiJin_Imgsdm);
         ComponentUtil.getTextField("售价：",this,{
            "x":100,
            "y":20,
            "color":11523767,
            "size":12,
            "leading":0
         });
         this.ybTf = ComponentUtil.getTextField("0000元宝",this,{
            "x":141,
            "y":20,
            "color":13424242,
            "size":12,
            "leading":0
         });
         this.jjTf = ComponentUtil.getTextField("0000基金",this,{
            "x":100,
            "y":42,
            "color":13424242,
            "size":12,
            "leading":0
         });
         this.typeJJTf = ComponentUtil.getTextField("高级基金",this,{
            "x":30,
            "y":48,
            "color":16711935,
            "size":12,
            "leading":0
         });
      }
      
      public function update(_type:int, lvl:int) : void
      {
         var ssJiaCheng:String = null;
         var yb:int = int(FundMter.fanLiArr[_type - 1][0]);
         var jj:int = int(FundMter.fanLiArr[_type - 1][1]);
         this.ybTf.text = yb + "元宝";
         if(lvl == 0)
         {
            ssJiaCheng = "0";
         }
         else
         {
            ssJiaCheng = HtmlUtil.font((5 * int(FundMter.getDicItem(jj,_type,lvl))).toString(),FundMter.colorArr[lvl]);
         }
         this.jjTf.htmlText = "福利：总返利 " + HtmlUtil.font(jj + "基金","#f9ff00") + " + 白金武魂 " + ssJiaCheng + "";
         var ss:String = "Icon_JiJin_L" + _type;
         this.jjBm.bitmapData = ComponentUtil.getBitmapData(ss,Global.JiJin_Imgsdm);
         this.typeJJTf.htmlText = HtmlUtil.font(FundMter.jiJinArr[_type - 1],FundMter.colorArr[_type]);
      }
   }
}

