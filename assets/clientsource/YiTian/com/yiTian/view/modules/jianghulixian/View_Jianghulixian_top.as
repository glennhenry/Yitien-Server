package com.yiTian.view.modules.jianghulixian
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_Jianghulixian;
   import flash.display.Sprite;
   
   public class View_Jianghulixian_top extends Sprite
   {
      
      private var totalMoneyTxt:MyTextField;
      
      private var totalYueliTxt:MyTextField;
      
      private var prizeTxt_1:MyTextField;
      
      private var prizeTxt_2:MyTextField;
      
      private var prizeTxt_3:MyTextField;
      
      private var moneyTxt_1:MyTextField;
      
      private var moneyTxt_2:MyTextField;
      
      private var moneyTxt_3:MyTextField;
      
      private var yueliTxt_1:MyTextField;
      
      private var yueliTxt_2:MyTextField;
      
      private var yueliTxt_3:MyTextField;
      
      private var bangyinTxt_1:MyTextField;
      
      private var bangyinTxt_2:MyTextField;
      
      private var bangyinTxt_3:MyTextField;
      
      private var yueliTxt1:MyTextField;
      
      private var yueliTxt2:MyTextField;
      
      private var yueliTxt3:MyTextField;
      
      public function View_Jianghulixian_top()
      {
         super();
         ComponentUtil.getBitmap("Back_Inf",this,{
            "x":0,
            "y":0
         },Global.LiXian_Imgsdm);
         ComponentUtil.getTextField("当前手牌总奖励",this,{
            "x":126,
            "y":15,
            "color":11523767,
            "size":16,
            "leading":0
         });
         this.prizeTxt_1 = ComponentUtil.getTextField("",this,{
            "x":151,
            "y":45,
            "color":11523767,
            "size":12,
            "leading":0
         });
         this.prizeTxt_2 = ComponentUtil.getTextField("",this,{
            "x":151,
            "y":67,
            "color":11523767,
            "size":12,
            "leading":0
         });
         this.prizeTxt_3 = ComponentUtil.getTextField("",this,{
            "x":151,
            "y":89,
            "color":11523767,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("绑银",this,{
            "x":274,
            "y":17,
            "color":13424242,
            "size":12,
            "leading":0
         });
         this.totalMoneyTxt = ComponentUtil.getTextField("0",this,{
            "x":303,
            "y":17,
            "color":52224,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("阅历",this,{
            "x":379,
            "y":17,
            "color":13424242,
            "size":12,
            "leading":0
         });
         this.totalYueliTxt = ComponentUtil.getTextField("0",this,{
            "x":408,
            "y":17,
            "color":11363483,
            "size":12,
            "leading":0
         });
         this.bangyinTxt_1 = ComponentUtil.getTextField("绑银",this,{
            "x":274,
            "y":45,
            "color":13424242,
            "size":12,
            "leading":0
         });
         this.bangyinTxt_2 = ComponentUtil.getTextField("绑银",this,{
            "x":274,
            "y":67,
            "color":13424242,
            "size":12,
            "leading":0
         });
         this.bangyinTxt_3 = ComponentUtil.getTextField("绑银",this,{
            "x":274,
            "y":89,
            "color":13424242,
            "size":12,
            "leading":0
         });
         this.yueliTxt1 = ComponentUtil.getTextField("阅历",this,{
            "x":379,
            "y":43,
            "color":13424242,
            "size":12,
            "leading":0
         });
         this.yueliTxt2 = ComponentUtil.getTextField("阅历",this,{
            "x":379,
            "y":65,
            "color":13424242,
            "size":12,
            "leading":0
         });
         this.yueliTxt3 = ComponentUtil.getTextField("阅历",this,{
            "x":379,
            "y":87,
            "color":13424242,
            "size":12,
            "leading":0
         });
         this.moneyTxt_1 = ComponentUtil.getTextField("0",this,{
            "x":303,
            "y":45,
            "color":52224,
            "size":12,
            "leading":0
         });
         this.moneyTxt_2 = ComponentUtil.getTextField("0",this,{
            "x":303,
            "y":67,
            "color":52224,
            "size":12,
            "leading":0
         });
         this.moneyTxt_3 = ComponentUtil.getTextField("0",this,{
            "x":303,
            "y":89,
            "color":52224,
            "size":12,
            "leading":0
         });
         this.yueliTxt_1 = ComponentUtil.getTextField("0",this,{
            "x":408,
            "y":43,
            "color":11363483,
            "size":12,
            "leading":0
         });
         this.yueliTxt_2 = ComponentUtil.getTextField("0",this,{
            "x":408,
            "y":65,
            "color":11363483,
            "size":12,
            "leading":0
         });
         this.yueliTxt_3 = ComponentUtil.getTextField("0",this,{
            "x":408,
            "y":87,
            "color":11363483,
            "size":12,
            "leading":0
         });
      }
      
      public function setPrizeText(_arr:Array = null) : void
      {
         var j:int = 0;
         var totalMoney:int = 0;
         var totalYueli:int = 0;
         var i:int = 0;
         if(!_arr || _arr.length == 0)
         {
            this.totalMoneyTxt.text = "0";
            this.totalYueliTxt.text = "0";
            j = 0;
            while(j < 3)
            {
               this["prizeTxt_" + (j + 1)].text = "";
               this["moneyTxt_" + (j + 1)].text = "";
               this["yueliTxt_" + (j + 1)].text = "";
               this["bangyinTxt_" + (j + 1)].visible = false;
               this["yueliTxt" + (j + 1)].visible = false;
               j++;
            }
         }
         else
         {
            totalMoney = 0;
            totalYueli = 0;
            i = 0;
            while(i < 3)
            {
               if(Boolean(_arr[i]))
               {
                  this["bangyinTxt_" + (i + 1)].visible = true;
                  this["yueliTxt" + (i + 1)].visible = true;
                  this["prizeTxt_" + (i + 1)].visible = true;
                  this["moneyTxt_" + (i + 1)].visible = true;
                  this["yueliTxt_" + (i + 1)].visible = true;
                  this["prizeTxt_" + (i + 1)].text = Enum_Jianghulixian.NamePrizeArray[int(_arr[i]) - 1];
                  this["moneyTxt_" + (i + 1)].text = String(Enum_Jianghulixian.MoneyPrizeArray[int(_arr[i]) - 1]);
                  this["yueliTxt_" + (i + 1)].text = String(Enum_Jianghulixian.YueliPrizeArrar[int(_arr[i]) - 1]);
                  totalMoney += Enum_Jianghulixian.MoneyPrizeArray[int(_arr[i]) - 1];
                  totalYueli += Enum_Jianghulixian.YueliPrizeArrar[int(_arr[i]) - 1];
               }
               else
               {
                  this["prizeTxt_" + (i + 1)].text = "";
                  this["moneyTxt_" + (i + 1)].text = "";
                  this["yueliTxt_" + (i + 1)].text = "";
                  this["bangyinTxt_" + (i + 1)].visible = false;
                  this["yueliTxt" + (i + 1)].visible = false;
               }
               this.totalMoneyTxt.text = String(totalMoney);
               this.totalYueliTxt.text = String(totalYueli);
               i++;
            }
         }
      }
   }
}

