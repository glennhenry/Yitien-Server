package com.yiTian.view.modules.actions.jiJin
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.net.message.cg.FundCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import flash.display.Sprite;
   
   public class StoreItem extends Sprite
   {
      
      private var tf:MyTextField;
      
      public function StoreItem()
      {
         super();
         ComponentUtil.getTextField("春后送大礼，基金大返利！",this,{
            "x":32 - 20,
            "y":12 - 4,
            "color":13424242,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("1基金价值等于1元宝！",this,{
            "x":181 - 20,
            "y":12 - 4,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.tf = ComponentUtil.getTextField("您还没购买基金：同时只能购买一份基金",this,{
            "x":32 - 20,
            "y":35 - 4,
            "color":13424242,
            "size":12,
            "leading":0
         });
         ComponentUtil.getButton("","Button_Store",this,{
            "x":398,
            "y":16,
            "textColor":16184781,
            "callBack":function():void
            {
               FundMter.isOpenFundStore = true;
               FundCGMessage.CG_FUND_MALL();
            }
         },Global.JiJin_Imgsdm);
      }
      
      public function update(_typeFund:int) : void
      {
         this.tf.htmlText = "您已购买了" + HtmlUtil.font(FundMter.jiJinArr[_typeFund - 1],FundMter.colorArr[_typeFund]);
      }
   }
}

