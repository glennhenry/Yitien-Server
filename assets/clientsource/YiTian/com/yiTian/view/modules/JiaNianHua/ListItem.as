package com.yiTian.view.modules.JiaNianHua
{
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.utils.HtmlUtil;
   import flash.display.Sprite;
   
   public class ListItem extends Sprite
   {
      
      private var titleTxt:MyTextField;
      
      private var ChongZhiTxt:MyTextField;
      
      private const numArr:Array = ["JNHNO_Ling","JNHNO_Yi","JNHNO_Er","JNHNO_San","JNHNO_Si","JNHNO_Wu","JNHNO_Liu","JNHNO_Qi","JNHNO_Ba","JNHNO_Jiu"];
      
      private var numArr_1:Array = [];
      
      private var numArr_2:Array = [];
      
      private var numArr_3:Array = [];
      
      public function ListItem()
      {
         super();
         ComponentUtil.getBitmap("Icon_YBYB",this,{
            "x":157,
            "y":0
         },Global.JNHdm);
         ComponentUtil.getBitmap("Icon_YBYB",this,{
            "x":338,
            "y":0
         },Global.JNHdm);
         ComponentUtil.getBitmap("Icon_YBYB",this,{
            "x":519,
            "y":0
         },Global.JNHdm);
         ComponentUtil.getBitmap("JNHNO_ChenHao",this,{
            "x":210,
            "y":20
         },Global.JNHdm);
         ComponentUtil.getBitmap("JNHNO_ChenHao",this,{
            "x":391,
            "y":20
         },Global.JNHdm);
         ComponentUtil.getBitmap("JNHNO_ChenHao",this,{
            "x":572,
            "y":20
         },Global.JNHdm);
         this.titleTxt = ComponentUtil.getTextField("500元宝（3倍返利）",this,{
            "x":52,
            "y":0,
            "color":14013809,
            "size":12,
            "leading":3
         },"center");
         this.ChongZhiTxt = ComponentUtil.getTextField("已充值0元宝",this,{
            "x":52,
            "y":18,
            "color":14013809,
            "size":12,
            "leading":3
         },"center");
      }
      
      public function setTitleTxt(money:int) : void
      {
         this.titleTxt.text = money + "元宝";
      }
      
      public function setChongZhiTxt(ChongZhi:int) : void
      {
         this.ChongZhiTxt.htmlText = "已充值" + HtmlUtil.font(ChongZhi.toString(),ColorConstant.getColorStr(ColorConstant.GREEN)) + "元宝";
      }
      
      public function setFanLi(FanLi_1:int, FanLi_2:int, FanLi_3:int) : void
      {
         var strArr:Array = null;
         var len:int = 0;
         var j:int = 0;
         var i:int = 0;
         while(i < arguments.length)
         {
            strArr = arguments[i].toString().split("");
            len = int(strArr.length);
            j = 0;
            while(j < len)
            {
               ComponentUtil.getBitmap(this.numArr[int(strArr[j])],this,{
                  "x":226 + i * 181 + j * 20,
                  "y":10
               },Global.JNHdm);
               j++;
            }
            i++;
         }
      }
   }
}

