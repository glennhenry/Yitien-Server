package com.yiTian.view.modules.bag
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_bag;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_bagPwdAdSetting extends Panel123
   {
      
      private var titleBg:Bitmap;
      
      private var backBitmap:ScaleBitmap;
      
      private var backLayer:Sprite;
      
      private var txtLayer:Sprite;
      
      private var dymLayer:Sprite;
      
      private var btn1:Button;
      
      private var btn2:Button;
      
      private var btn3:Button;
      
      private var dymBtn:Button;
      
      private var msgTxt:MyTextField;
      
      private var type:int = 1;
      
      public function View_bagPwdAdSetting()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         this.backLayer = new Sprite();
         addChild(this.backLayer);
         this.txtLayer = new Sprite();
         addChild(this.txtLayer);
         this.dymLayer = new Sprite();
         addChild(this.dymLayer);
         this.backBitmap = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.backLayer,{
            "x":0,
            "y":0,
            "width":388,
            "height":261
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.backLayer,{
            "x":24,
            "y":67,
            "width":340,
            "height":185
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this.backLayer,{
            "x":29,
            "y":72,
            "width":330,
            "height":175
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this.backLayer,{
            "x":39,
            "y":82,
            "width":310,
            "height":110
         },Global.Img_Cdm);
         move = new Rectangle(0,0,808,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":354,
            "y":6,
            "textColor":16771436,
            "callBack":function():void
            {
               visible = false;
            }
         },Global.Img_Cdm);
         this.msgTxt = ComponentUtil.getTextField("    " + LangConfig.getWord("20038",11),this.txtLayer,{
            "x":60,
            "y":100,
            "color":13424242,
            "realWidth":270,
            "size":12,
            "leading":5,
            "wordWrap":true
         });
      }
      
      override protected function initDynamicView() : void
      {
         this.btn1 = ComponentUtil.getButton(LangConfig.getWord("20026",11),"TabButton_Six",this.dymLayer,{
            "x":37,
            "y":45,
            "textColor":16773818,
            "callBack":this.onClickHandler
         },Global.Img_Cdm);
         this.btn2 = ComponentUtil.getButton(LangConfig.getWord("20027",11),"TabButton_Six",this.dymLayer,{
            "x":241,
            "y":45,
            "textColor":16773818,
            "callBack":this.onClickHandler
         },Global.Img_Cdm);
         this.btn3 = ComponentUtil.getButton(LangConfig.getWord("20028",11),"TabButton_Six",this.dymLayer,{
            "x":139,
            "y":45,
            "textColor":16773818,
            "callBack":this.onClickHandler
         },Global.Img_Cdm);
         this.dymBtn = ComponentUtil.getButton(LangConfig.getWord("20026",11),"Button_Five",this.dymLayer,{
            "x":145,
            "y":208,
            "textColor":16184781,
            "callBack":this.onChangeHandler
         },Global.Img_Cdm);
      }
      
      override protected function initUI2() : void
      {
         this.titleBg = ComponentUtil.getBitmap("Title_GJSheZhi",this,{
            "x":114,
            "y":5
         },Global.EJiMiMa_Imgsdm);
      }
      
      private function onClickHandler(e:MouseEvent) : void
      {
         var btn:Button = e.target as Button;
         switch(btn)
         {
            case this.btn1:
               this.type = Model_bag.PWD_TYPE_SETTING_1;
               this.msgTxt.text = "    " + LangConfig.getWord("20038",11);
               this.dymBtn.label = this.btn1.label;
               break;
            case this.btn2:
               this.type = Model_bag.PWD_TYPE_SETTING_2;
               this.msgTxt.text = "    " + LangConfig.getWord("20039",11);
               this.dymBtn.label = this.btn2.label;
               break;
            case this.btn3:
               this.type = Model_bag.PWD_TYPE_SETTING_3;
               this.msgTxt.text = "    " + LangConfig.getWord("20040",11);
               this.dymBtn.label = this.btn3.label;
         }
      }
      
      private function onChangeHandler(e:MouseEvent) : void
      {
         var btn:Button = e.target as Button;
         switch(this.type)
         {
            case Model_bag.PWD_TYPE_SETTING_1:
               UIManager.bagModifyPwd.visible = true;
               break;
            case Model_bag.PWD_TYPE_SETTING_2:
               UIManager.bagClearPwd.visible = true;
               break;
            case Model_bag.PWD_TYPE_SETTING_3:
               if(Model_bag.pwdResetLeftDays > 0)
               {
                  UIManager.bagCancelApply.visible = true;
                  UIManager.bagCancelApply.updateDaysInfo();
                  break;
               }
               UIManager.bagCancelApply.visible = false;
               UIManager.bagResetPwd.visible = true;
         }
         this.visible = false;
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
            this.type = 1;
            if(Boolean(this.msgTxt) && Boolean(this.dymBtn))
            {
               this.msgTxt.text = "    " + LangConfig.getWord("20038",11);
               this.dymBtn.label = this.btn1.label;
            }
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
         return 200;
      }
   }
}

