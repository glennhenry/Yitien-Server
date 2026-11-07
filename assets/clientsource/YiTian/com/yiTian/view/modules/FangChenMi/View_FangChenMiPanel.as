package com.yiTian.view.modules.FangChenMi
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextFieldType;
   import flash.utils.clearInterval;
   import flash.utils.clearTimeout;
   import flash.utils.setInterval;
   import flash.utils.setTimeout;
   
   public class View_FangChenMiPanel extends Panel123
   {
      
      public static var SOURCE_URL:String = "lang/ch/FCMPrompt.swf";
      
      private static var INPUT_NAME:String = "输入姓名";
      
      private static var INPUT_ID_NUM:String = "输入身份证号码";
      
      private static var PLEASE_INPUT_CORRECT_INFO:String = "请输入正确信息";
      
      public const txURL:String = "http://jkyx.qq.com/";
      
      private const COLOR_1:uint = 12832673;
      
      private const COLOR_2:uint = 15914100;
      
      private var backBitmap:ScaleBitmap;
      
      private var titleBg:Bitmap;
      
      private var backLayer:Sprite;
      
      public var optionLayer:Sprite;
      
      public var fillInLayer:Sprite;
      
      public var singleTxtlayer:Sprite;
      
      private var gotoCheckBtn:Button;
      
      private var cancelBtn:Button;
      
      private var nameInputTF:MyTextField;
      
      private var idInputTF:MyTextField;
      
      private var checkBtn:Button;
      
      private var msgTF:MyTextField;
      
      private var testingNum:int = 0;
      
      private var intervalID:uint;
      
      private var temType:int = 3;
      
      public function View_FangChenMiPanel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         this.backLayer = new Sprite();
         addChild(this.backLayer);
         this.optionLayer = new Sprite();
         addChild(this.optionLayer);
         this.fillInLayer = new Sprite();
         addChild(this.fillInLayer);
         this.singleTxtlayer = new Sprite();
         addChild(this.singleTxtlayer);
         this.backBitmap = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.backLayer,{
            "x":0,
            "y":0,
            "width":348,
            "height":210
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this.backLayer,{
            "x":24,
            "y":40,
            "width":300,
            "height":160
         },Global.Img_Cdm);
         move = new Rectangle(0,0,348,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":314,
            "y":6
         },Global.Img_Cdm);
         var tf1:MyTextField = ComponentUtil.getTextField("",this.optionLayer,{
            "x":59,
            "y":60,
            "color":this.COLOR_1,
            "size":12,
            "leading":0,
            "realWidth":260
         });
         tf1.wordWrap = true;
         tf1.htmlText = "\t  由于您未进行身份实名认证，将被纳入防沉迷系统，" + "<font color=\'#F2D474\'>3小时</font>内收益正常，<font color=\'#F2D474\'>3-5小时</font>经验收益减少<font color=\'#F2D474\'>50%</font>，" + "<font color=\'#F2D474\'>5小时</font>后经验收益将为<font color=\'#F2D474\'>0</font>！";
         tf1.width = 240;
         this.optionLayer.addChild(tf1);
         var tf2:MyTextField = ComponentUtil.getTextField("你是否需要进行身份证信息认证？",this.optionLayer,{
            "x":82,
            "y":122,
            "color":this.COLOR_2,
            "size":12,
            "leading":0
         });
         this.optionLayer.addChild(tf2);
         this.gotoCheckBtn = ComponentUtil.getButton("立即认证","Button_Four",this.optionLayer,{
            "x":70,
            "y":158
         },Global.Img_Cdm);
         this.cancelBtn = ComponentUtil.getButton("稍后认证","Button_Four",this.optionLayer,{
            "x":204,
            "y":158
         },Global.Img_Cdm);
         ComponentUtil.getTextField("姓  名",this.fillInLayer,{
            "x":65,
            "y":70,
            "color":this.COLOR_2,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("身份证号",this.fillInLayer,{
            "x":65,
            "y":109,
            "color":this.COLOR_2,
            "size":12,
            "leading":0
         });
         var scBm1:ScaleBitmap = ComponentUtil.getScaleBitmap("Back_Green_List",[5,5,1,1],this.fillInLayer,{
            "x":122,
            "y":67,
            "width":160,
            "height":24
         },Global.Img_Cdm);
         var scBm2:ScaleBitmap = ComponentUtil.getScaleBitmap("Back_Green_List",[5,5,1,1],this.fillInLayer,{
            "x":122,
            "y":106,
            "width":160,
            "height":24
         },Global.Img_Cdm);
         this.nameInputTF = ComponentUtil.getTextField("输入姓名",this.fillInLayer,{
            "x":132,
            "y":70,
            "color":this.COLOR_1,
            "size":12,
            "leading":0,
            "wordWrap":false,
            "realWidth":scBm1.width
         });
         this.nameInputTF.type = TextFieldType.INPUT;
         this.nameInputTF.maxChars = 5;
         this.nameInputTF.addEventListener(MouseEvent.CLICK,this.textHandler);
         this.idInputTF = ComponentUtil.getTextField("输入身份证号码",this.fillInLayer,{
            "x":132,
            "y":109,
            "color":this.COLOR_1,
            "size":12,
            "leading":0,
            "wordWrap":false,
            "realWidth":scBm1.width
         });
         this.idInputTF.type = TextFieldType.INPUT;
         this.idInputTF.maxChars = 18;
         this.idInputTF.restrict = "0-9a-zA-Z";
         this.idInputTF.addEventListener(MouseEvent.CLICK,this.textHandler);
         this.checkBtn = ComponentUtil.getButton("认证","Button_Four",this.fillInLayer,{
            "x":143,
            "y":158
         },Global.Img_Cdm);
         this.fillInLayer.visible = false;
         this.msgTF = ComponentUtil.getTextField("",this.singleTxtlayer,{
            "x":65,
            "y":109,
            "color":this.COLOR_2,
            "size":12,
            "leading":0
         });
         this.singleTxtlayer.visible = false;
         this.gotoCheckBtn.addEventListener(MouseEvent.CLICK,this.onClickHandler);
         this.cancelBtn.addEventListener(MouseEvent.CLICK,this.onClickHandler);
         this.checkBtn.addEventListener(MouseEvent.CLICK,this.onClickHandler);
      }
      
      private function textHandler(e:MouseEvent) : void
      {
         var target:MyTextField = e.target as MyTextField;
         if(target == this.nameInputTF && target.text == INPUT_NAME)
         {
            target.text = "";
         }
         else if(target == this.idInputTF && target.text == INPUT_ID_NUM)
         {
            target.text = "";
         }
      }
      
      private function onClickHandler(evt:MouseEvent) : void
      {
         var req:URLRequest = null;
         var target:Button = evt.target as Button;
         switch(target)
         {
            case this.gotoCheckBtn:
               req = new URLRequest(this.txURL);
               navigateToURL(req);
               break;
            case this.cancelBtn:
               this.visible = false;
               break;
            case this.checkBtn:
               this.checkBtn.enabled = false;
               this.intervalID = setInterval(this.testing,1000);
         }
      }
      
      private function testing() : void
      {
         var isIDCard_15:RegExp = null;
         var isIDCard_18:RegExp = null;
         var isName:RegExp = null;
         var str:String = null;
         var i:int = 0;
         var temContent:String = null;
         if(this.nameInputTF.text == "" || this.nameInputTF.text == INPUT_NAME || (this.idInputTF.text == "" || this.idInputTF.text == INPUT_ID_NUM))
         {
            clearInterval(this.intervalID);
            UIManager.centerBroadcast.addMsg(PLEASE_INPUT_CORRECT_INFO);
            this.checkBtn.enabled = true;
            return;
         }
         isIDCard_15 = /^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$/;
         isIDCard_18 = /^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])((\d{4})|\d{3}[X])$/;
         isName = /[一-龥]/;
         if(this.idInputTF.length == 15)
         {
            if(!isName.test(this.nameInputTF.text) || !isIDCard_15.test(this.idInputTF.text))
            {
               clearInterval(this.intervalID);
               UIManager.centerBroadcast.addMsg(PLEASE_INPUT_CORRECT_INFO);
               this.checkBtn.enabled = true;
               return;
            }
         }
         else if(this.idInputTF.length == 18)
         {
            if(!isName.test(this.nameInputTF.text) || !isIDCard_18.test(this.idInputTF.text))
            {
               clearInterval(this.intervalID);
               UIManager.centerBroadcast.addMsg(PLEASE_INPUT_CORRECT_INFO);
               this.checkBtn.enabled = true;
               return;
            }
         }
         else if(this.idInputTF.length < 15)
         {
            clearInterval(this.intervalID);
            UIManager.centerBroadcast.addMsg(PLEASE_INPUT_CORRECT_INFO);
            this.checkBtn.enabled = true;
            return;
         }
         this.optionLayer.visible = false;
         this.fillInLayer.visible = false;
         this.singleTxtlayer.visible = true;
         if(this.testingNum == 3)
         {
            clearInterval(this.intervalID);
         }
         ++this.testingNum;
         str = "";
         i = 0;
         while(i < this.testingNum)
         {
            str += ".";
            i++;
         }
         temContent = "身份证信息验证中" + str;
         this.msgTF.text = temContent;
      }
      
      public function showMsg(type:int) : void
      {
         var timeoutId:uint = 0;
         var delay:uint = 3000;
         switch(type)
         {
            case 0:
               this.msgTF.text = "身份证号码有误！";
               break;
            case 1:
               this.msgTF.text = "您已通过防沉迷认证，可正常进行游戏！";
               break;
            case 2:
               this.msgTF.text = "您未满18岁，已被纳入防沉迷系统！";
         }
         this.checkBtn.enabled = true;
         if(type != this.temType)
         {
            timeoutId = setTimeout(function():void
            {
               clearTimeout(timeoutId);
               visible = false;
            },delay);
         }
      }
      
      override protected function initUI2() : void
      {
         this.titleBg = ComponentUtil.getBitmap("Title_CMPrompt",this,{
            "x":200,
            "y":6
         },Global.FCMPromptdm);
         ComponentUtil.setPropertie(this.titleBg,{
            "x":(this.width - this.titleBg.width) / 2,
            "y":6
         });
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!Global.FCMPromptdm)
            {
               regResource(SOURCE_URL,"FCMPromptdm");
               preFun();
            }
            else if(!this.titleBg)
            {
               this.initUI2();
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
         return 348;
      }
      
      override public function get height() : Number
      {
         return 210;
      }
   }
}

