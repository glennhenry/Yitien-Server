package com.yiTian.view.modules.WulinDaHui
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.view.Panel;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class View_wulinIntro extends Panel
   {
      
      private var tf:MyTextField;
      
      private var str1:String;
      
      private var str2:String;
      
      private var titleBack:Bitmap;
      
      private var backPanel:Sprite;
      
      public function View_wulinIntro()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         this.backPanel = new Sprite();
         addChild(this.backPanel);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.backPanel,{
            "x":0,
            "y":0,
            "width":523,
            "height":480
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.backPanel,{
            "x":24,
            "y":40,
            "width":475,
            "height":430
         },Global.Img_Cdm);
         this.str1 = LangConfig.getWord("879",0);
         this.str2 = LangConfig.getWord("880",0);
         this.tf = ComponentUtil.getTextField("",this,{
            "x":23.85,
            "y":48.3,
            "realWidth":293.3
         });
         this.tf.wordWrap = true;
         this.tf.multiline = true;
         this.tf.leading = 4;
         this.tf.htmlText = this.str1;
         this.tf.textColor = 14013822;
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":499,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
      }
      
      public function setTile(_type:int) : void
      {
         if(Boolean(this.titleBack))
         {
            removeChild(this.titleBack);
            this.titleBack.bitmapData = null;
            this.titleBack = null;
         }
         if(_type == 1)
         {
            move = new Rectangle(0,0,463,38);
            this.backPanel.width = 495 - 48;
            this.backPanel.height = 480 - 40;
            this.tf.realWidth = 458;
            this.setTxt(this.str2);
            CloseButton.x = 463 - 58;
            CloseButton.y = 6;
            setChildIndex(CloseButton,numChildren - 1);
         }
         else if(_type == 2)
         {
            this.backPanel.width = 332;
            this.backPanel.height = 313;
            move = new Rectangle(0,0,323,38);
            this.tf.realWidth = 293.3;
            this.setTxt(this.str1);
            this.tf.x = 23;
            CloseButton.x = 310;
            CloseButton.y = 3;
            setChildIndex(CloseButton,numChildren - 1);
         }
         if(!Global.WLDaHui_Imgsdm)
         {
            SingleLoader.add("lang/ch/WLDaHui_Imgs.swf",function(info:Object):void
            {
               Global.WLDaHui_Imgsdm = info.applicationDomain;
               showB(_type);
            });
         }
         else
         {
            this.showB(_type);
         }
      }
      
      private function showB(_type:int) : void
      {
         if(_type == 1)
         {
            this.titleBack = ComponentUtil.getBitmap("Title_WLDHJieShao",this,{
               "x":67.75 + 21 + 60,
               "y":4
            },Global.WLDaHui_Imgsdm);
         }
         else if(_type == 2)
         {
            this.titleBack = ComponentUtil.getBitmap("wulindahui",this,{
               "x":67.75 + 21,
               "y":1
            },Global.WLDaHui_Imgsdm);
         }
      }
      
      private function setTxt(str:String) : void
      {
         this.tf.htmlText = str;
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2 + 100;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

