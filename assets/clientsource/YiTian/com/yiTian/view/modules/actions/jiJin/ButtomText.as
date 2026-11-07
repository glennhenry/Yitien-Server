package com.yiTian.view.modules.actions.jiJin
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.utils.HtmlUtil;
   import flash.display.Sprite;
   
   public class ButtomText extends Sprite
   {
      
      private var jjTf:MyTextField;
      
      public function ButtomText()
      {
         super();
         ComponentUtil.getTextField("累计总返利：",this,{
            "x":40,
            "y":0,
            "color":11523767,
            "size":12,
            "leading":0,
            "visible":false
         });
         this.jjTf = ComponentUtil.getTextField("00000基金",this,{
            "x":117,
            "y":0,
            "color":13424242,
            "size":12,
            "leading":0,
            "visible":false
         });
         ComponentUtil.getTextField("注：领取完一份基金的所有返利后可购买新的基金",this,{
            "x":9,
            "y":0,
            "color":14662240,
            "size":12,
            "leading":0
         });
      }
      
      public function update(_type:int, _lvl:int) : void
      {
         var jjPer:int = 0;
         var jj:int = int(FundMter.fanLiArr[_type - 1][1]);
         if(_lvl == 0)
         {
            jjPer = 0;
         }
         else
         {
            jjPer = 5 * int(FundMter.getDicItem(jj,_type,_lvl));
         }
         this.jjTf.htmlText = jj + "基金 + " + HtmlUtil.font(jjPer.toString(),FundMter.colorArr[_lvl]);
      }
   }
}

