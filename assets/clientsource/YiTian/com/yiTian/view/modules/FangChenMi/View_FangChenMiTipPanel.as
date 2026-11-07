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
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class View_FangChenMiTipPanel extends Panel123
   {
      
      private const COLOR_1:uint = 12832673;
      
      private const COLOR_2:uint = 15914100;
      
      private var backBitmap:ScaleBitmap;
      
      private var gotoCheckBtn:Button;
      
      private var cancelBtn:Button;
      
      private var titleBg:Bitmap;
      
      private var timeoutID:uint;
      
      private var delay:uint = 10000;
      
      private var tf1:MyTextField;
      
      public function View_FangChenMiTipPanel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         this.backBitmap = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":348,
            "height":210
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":24,
            "y":40,
            "width":300,
            "height":160
         },Global.Img_Cdm);
         move = new Rectangle(0,0,348,38);
         this.tf1 = ComponentUtil.getTextField("",this,{
            "x":59,
            "y":60,
            "color":this.COLOR_1,
            "size":12,
            "leading":0,
            "realWidth":260
         });
         this.tf1.wordWrap = true;
         this.tf1.width = 240;
         addChild(this.tf1);
         var tf2:MyTextField = ComponentUtil.getTextField("你是否需要进行身份证信息认证？",this,{
            "x":82,
            "y":122,
            "color":this.COLOR_2,
            "size":12,
            "leading":0
         });
         addChild(tf2);
         this.gotoCheckBtn = ComponentUtil.getButton("立即认证","Button_Four",this,{
            "x":70,
            "y":158
         },Global.Img_Cdm);
         this.cancelBtn = ComponentUtil.getButton("稍后认证","Button_Four",this,{
            "x":204,
            "y":158
         },Global.Img_Cdm);
         this.gotoCheckBtn.addEventListener(MouseEvent.CLICK,this.onClickHandler);
         this.cancelBtn.addEventListener(MouseEvent.CLICK,this.onClickHandler);
      }
      
      private function onClickHandler(evt:MouseEvent) : void
      {
         var req:URLRequest = null;
         var target:Button = evt.target as Button;
         switch(target)
         {
            case this.gotoCheckBtn:
               UIManager.fangChenMiPanel.visible = true;
               UIManager.fangChenMiPanel.optionLayer.visible = false;
               UIManager.fangChenMiPanel.singleTxtlayer.visible = false;
               req = new URLRequest(UIManager.fangChenMiPanel.txURL);
               navigateToURL(req);
         }
         this.visible = false;
      }
      
      public function warnByType(hour:Number) : void
      {
         if(UIManager.fangChenMiPanel.visible)
         {
            UIManager.fangChenMiPanel.visible = false;
         }
         if(hour >= 1 && hour < 3)
         {
            if(hour >= 1 && hour < 2)
            {
               hour = 1;
            }
            else if(hour >= 2 && hour < 3)
            {
               hour = 2;
            }
            this.tf1.htmlText = "\n您已累计在线<font color=\'#F2D474\'>" + hour + "小时</font>，请合理安排游戏时间。";
         }
         else if(hour >= 5)
         {
            hour = 5;
            this.tf1.htmlText = "您已累计在线<font color=\'#F2D474\'>5小时</font>，您已进入不健康游戏时间，游戏经验收益变为<font color=\'#F2D474\'>0</font>，请您下线休息。";
         }
         else
         {
            if(hour >= 3 && hour < 3.5 || hour >= 4 && hour < 4.5)
            {
               hour = int(hour);
            }
            else if(hour >= 3.5 && hour < 4)
            {
               hour = 3.5;
            }
            else if(hour >= 4.5 && hour < 5)
            {
               hour = 4.5;
            }
            this.tf1.htmlText = "您已累计在线<font color=\'#F2D474\'>" + hour + "小时</font>，您已进入疲劳游戏时间，" + "游戏收益变为经验正常的<font color=\'#F2D474\'>50%</font>，请您下线休息。";
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
               regResource(View_FangChenMiPanel.SOURCE_URL,"FCMPromptdm");
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

