package com.yiTian.view.modules.awardOnline
{
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.UIBase;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   import flash.utils.getTimer;
   
   public class View_AwardWaitTip extends UIBase
   {
      
      private static var instance:View_AwardWaitTip;
      
      private var bm_icon:Bitmap;
      
      private var tf:MyTextField;
      
      private var startTime:int = 0;
      
      private var countTime:int = 0;
      
      private var _state:int = 1;
      
      private var aniFrameInterval:uint = 25;
      
      private var aniFrameCount:uint;
      
      private var currentIconIndex:uint;
      
      public function View_AwardWaitTip()
      {
         super();
         bindParent = GameScene.uiLayer;
         if(instance != null)
         {
            throw new Error("singlon error");
         }
         this.bm_icon = new Bitmap();
         addChild(this.bm_icon);
         buttonMode = true;
         this.tf = ComponentUtil.getTextField("",this,{
            "y":52,
            "realWidth":65,
            "color":16776960,
            "bold":true
         });
         this.tf.autoSize = TextFieldAutoSize.CENTER;
         addChild(this.tf);
         resetPosition();
         addEventListener(MouseEvent.CLICK,this.clickHandle);
      }
      
      public static function getInstance() : View_AwardWaitTip
      {
         if(instance == null)
         {
            instance = new View_AwardWaitTip();
         }
         return instance;
      }
      
      public function set state(value:int) : void
      {
         this._state = value;
         switch(value)
         {
            case 1:
               GameScene.instance.addFrameCallBack(this.updateTime);
               GameScene.instance.removeFrameCallBack(this.enterFrameHandle);
               this.bm_icon = Utils.getLoadBitmap("resource/image/myPath/box1.png",this.bm_icon);
               break;
            case 2:
               this.currentIconIndex = 1;
               GameScene.instance.removeFrameCallBack(this.updateTime);
               GameScene.instance.addFrameCallBack(this.enterFrameHandle);
               this.tf.htmlText = HtmlUtil.font(LangConfig.getWord("29073",2),ColorConstant.getColorStr(ColorConstant.ITEM_YELLOW),12);
         }
      }
      
      public function resetTime(time:int) : void
      {
         this.countTime = time;
         this.startTime = getTimer();
      }
      
      private function updateTime(interval:int) : void
      {
         var str:String = null;
         var currentTime:int = getTimer();
         var escapeTime:int = (currentTime - this.startTime) / 1000;
         var remainTime:int = this.countTime - escapeTime;
         if(remainTime > 0)
         {
            str = this.formToTimeString(remainTime);
            this.tf.htmlText = HtmlUtil.font(str,ColorConstant.getColorStr(ColorConstant.ITEM_YELLOW),12);
            View_PreviewAwardPanel.getInstance().timeString = str;
         }
         else
         {
            this.tf.htmlText = HtmlUtil.font("00:00",ColorConstant.getColorStr(ColorConstant.ITEM_YELLOW),12);
            View_PreviewAwardPanel.getInstance().visible = false;
            this.state = 2;
         }
      }
      
      private function clickHandle(evt:MouseEvent) : void
      {
         switch(this._state)
         {
            case 1:
               GameScene.uiLayer.addChild(View_PreviewAwardPanel.getInstance());
               View_PreviewAwardPanel.getInstance().visible = !View_PreviewAwardPanel.getInstance().visible;
               break;
            case 2:
               GameScene.uiLayer.addChild(View_GetAwardPanel.getInstance());
               View_GetAwardPanel.getInstance().visible = !View_GetAwardPanel.getInstance().visible;
         }
      }
      
      public function get state() : int
      {
         return this._state;
      }
      
      private function enterFrameHandle(interval:int) : void
      {
         this.aniFrameCount += 1;
         if(this.aniFrameCount >= this.aniFrameInterval)
         {
            this.aniFrameCount = 0;
            this.stepAni();
         }
      }
      
      private function stepAni() : void
      {
         this.currentIconIndex += 1;
         this.currentIconIndex = this.currentIconIndex > 3 ? 1 : this.currentIconIndex;
         this.bm_icon = Utils.getLoadBitmap("resource/image/myPath/box" + this.currentIconIndex.toString() + ".png",this.bm_icon);
      }
      
      private function formToTimeString(__time:Number, __insertHout:String = ":", __insertMinute:String = ":") : String
      {
         var __hour:uint = uint(__time / 60 / 60 >> 0);
         var __minute:uint = __time / 60 % 60;
         var __second:uint = __time % 60;
         var __timeTxt:String = " ";
         __timeTxt += (__minute < 10 ? "0" + __minute.toString() : __minute.toString()) + __insertMinute;
         return __timeTxt + (__second < 10 ? "0" + __second.toString() : __second.toString());
      }
   }
}

