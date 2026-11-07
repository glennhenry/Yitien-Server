package com.yiTian.view.modules.bag
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_bag;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.message.cg.BagCGMessage;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   
   public class View_bagCancelResetApply extends Panel123
   {
      
      private var titleBg:Bitmap;
      
      private var backBitmap:ScaleBitmap;
      
      private var backLayer:Sprite;
      
      private var txtLayer:Sprite;
      
      private var dymLayer:Sprite;
      
      private var msgTxt:MyTextField;
      
      private var inputTxt:MyTextField;
      
      private var yesBtn:Button;
      
      private var noBtn:Button;
      
      public function View_bagCancelResetApply()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var txt:MyTextField = null;
         this.backLayer = new Sprite();
         addChild(this.backLayer);
         this.txtLayer = new Sprite();
         addChild(this.txtLayer);
         this.dymLayer = new Sprite();
         addChild(this.dymLayer);
         this.backBitmap = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.backLayer,{
            "x":0,
            "y":0,
            "width":328,
            "height":240
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this.backLayer,{
            "x":24,
            "y":40,
            "width":280,
            "height":190
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this.backLayer,{
            "x":34,
            "y":50,
            "width":260,
            "height":135
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this.backLayer,{
            "x":150,
            "y":147,
            "width":120,
            "height":24
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this.backLayer,{
            "x":39,
            "y":110,
            "width":250,
            "height":2
         },Global.Img_Cdm);
         move = new Rectangle(0,0,808,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":292,
            "y":6,
            "textColor":16184781,
            "callBack":function():void
            {
               visible = false;
            }
         },Global.Img_Cdm);
         this.msgTxt = ComponentUtil.getTextField("    " + LangConfig.getWord("20033",11,0),this.txtLayer,{
            "x":55,
            "y":63,
            "color":13424242,
            "realWidth":220,
            "size":12,
            "wordWrap":true,
            "leading":6
         });
         txt = ComponentUtil.getTextField(LangConfig.getWord("20034",11),this.txtLayer,{
            "x":51,
            "y":120,
            "color":16318464,
            "realWidth":165,
            "realHeight":18,
            "size":12
         });
         txt = ComponentUtil.getTextField(LangConfig.getWord("20035",11) + "：",this.txtLayer,{
            "x":85,
            "y":150,
            "color":13424242,
            "realWidth":80,
            "realHeight":18,
            "size":12
         });
         this.inputTxt = ComponentUtil.getTextField("",this.txtLayer,{
            "x":155,
            "y":150,
            "color":16777215,
            "realWidth":120,
            "realHeight":18,
            "size":12,
            "wordWrap":false
         });
         this.inputTxt.type = TextFieldType.INPUT;
         this.inputTxt.maxChars = 12;
         this.inputTxt.displayAsPassword = true;
         this.inputTxt.restrict = "0-9a-zA-Z\\`\\~\\!\\@\\#\\$\\%\\^\\&\\*\\(\\)\\-\\_\\=\\+\\|\\\\{\\}\\[\\]\\:\"\\:\\;\\\'\\<\\>\\,\\.\\?\\/";
      }
      
      override protected function initDynamicView() : void
      {
         this.yesBtn = ComponentUtil.getButton(LangConfig.getWord("20036",11),"Button_Four",this.dymLayer,{
            "x":65,
            "y":195,
            "textColor":16184781,
            "callBack":this.onClickHandler
         },Global.Img_Cdm);
         this.noBtn = ComponentUtil.getButton(LangConfig.getWord("20037",11),"Button_Four",this.dymLayer,{
            "x":189,
            "y":195,
            "textColor":16184781,
            "callBack":this.onClickHandler
         },Global.Img_Cdm);
      }
      
      override protected function initUI2() : void
      {
         this.titleBg = ComponentUtil.getBitmap("Title_ChongZhiSuo",this,{
            "x":84,
            "y":5
         },Global.EJiMiMa_Imgsdm);
      }
      
      private function onClickHandler(e:MouseEvent) : void
      {
         var btn:Button = e.target as Button;
         switch(btn)
         {
            case this.yesBtn:
               BagCGMessage.CG_BAG_PWD_TYPE_SETTING(Model_bag.PWD_TYPE_SETTING_4,this.inputTxt.text,"","");
               break;
            case this.noBtn:
               this.visible = false;
         }
      }
      
      public function updateDaysInfo() : void
      {
         this.msgTxt.text = "    " + LangConfig.getWord("20033",11,Model_bag.pwdResetLeftDays);
         this.inputTxt.text = "";
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!Global.EJiMiMa_Imgsdm)
            {
               regResource(Model_bag.EJiMiMaSOURCE_URL,"EJiMiMa_Imgsdm");
               preFun();
            }
            else if(!this.titleBg)
            {
               this.initUI2();
            }
         }
         else if(Boolean(this.inputTxt))
         {
            this.inputTxt.text = "";
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.width) / 2;
         y = (Global.stage.stageHeight - this.height) / 2;
      }
      
      override public function get width() : Number
      {
         return 328;
      }
      
      override public function get height() : Number
      {
         return 240;
      }
   }
}

