package com.yiTian.view.modules.actions.qifu
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.view.Panel123;
   import flash.geom.Rectangle;
   import flashx.textLayout.formats.TextAlign;
   
   public class QifuXinxi extends Panel123
   {
      
      private var scal1:ScaleBitmap;
      
      private var scal2:ScaleBitmap;
      
      private var tfInfo:MyTextField;
      
      private var sureBtn:Button;
      
      public function QifuXinxi()
      {
         super();
         regResource("lang/ch/QiFu.swf","QiFudm");
      }
      
      override protected function initUI2() : void
      {
         this.scal1 = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":310,
            "height":211
         },Global.Img_Cdm);
         this.scal2 = ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":28,
            "y":45,
            "width":253,
            "height":155
         },Global.Img_Cdm);
         move = new Rectangle(0,0,310,38);
         ComponentUtil.getBitmap("Title_QFXinXi",this,{
            "x":75,
            "y":5
         },Global.QiFudm);
         ComponentUtil.getTextField("祈福获得:",this,{
            "x":103,
            "y":51,
            "color":16776960,
            "size":14,
            "leading":0,
            "bold":true,
            "realWidth":103,
            "align":TextAlign.CENTER
         });
         this.tfInfo = ComponentUtil.getTextField("物品名字六个*999",this,{
            "x":103,
            "y":72,
            "color":3461909,
            "size":13,
            "leading":4,
            "realWidth":103,
            "align":TextAlign.CENTER,
            "multiline":true
         });
         this.sureBtn = ComponentUtil.getButton("确定","Button_Four",this,{
            "x":118,
            "y":172,
            "textColor":16771436
         },Global.Img_Cdm);
         this.sureBtn.callBack = function():void
         {
            visible = false;
         };
         initDynamicView();
      }
      
      public function update(_arr:Array) : void
      {
         var str:String = null;
         this.tfInfo.text = "";
         this.visible = true;
         if(!_arr || !_arr.length)
         {
            return;
         }
         var i:int = 0;
         while(i < _arr.length)
         {
            str = _arr[i][0] + "\n";
            this.tfInfo.htmlText += str;
            i++;
         }
         var hei:int = this.tfInfo.y + this.tfInfo.height;
         this.scal2.height = hei + 23 - 20;
         this.scal1.height = hei + 23 + 55 - 20;
         this.sureBtn.y = hei + 3;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            pop();
         }
      }
   }
}

