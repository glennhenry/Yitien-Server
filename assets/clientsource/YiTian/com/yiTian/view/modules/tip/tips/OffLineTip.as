package com.yiTian.view.modules.tip.tips
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.model.Model_initStr;
   import com.yiTian.manager.KeyboardManager;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.TextEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class OffLineTip extends Sprite
   {
      
      public static var isFengHao:Boolean;
      
      private static var _instance:OffLineTip;
      
      private var txt:TextField;
      
      private var back:Shape;
      
      private var bmBack:Shape;
      
      private var bm:Bitmap;
      
      private var str:String;
      
      private const W:int = 560;
      
      private const H:int = 288;
      
      public function OffLineTip()
      {
         super();
      }
      
      public static function getInstance() : OffLineTip
      {
         if(!_instance)
         {
            _instance = new OffLineTip();
            _instance.init();
         }
         return _instance;
      }
      
      public function init() : void
      {
         this.str = Model_initStr.OFFLINETIP;
         Utils.print(this.str);
         this.back = new Shape();
         this.back.graphics.beginFill(0,0.5);
         this.back.graphics.drawRect(0,0,Global.stage.stageWidth,Global.stage.stageHeight);
         this.back.graphics.endFill();
         addChild(this.back);
         if(Boolean(Global.guideMM))
         {
            this.bm = ComponentUtil.getBitmap("guideBg",this,null,Global.guideMM);
         }
         else
         {
            this.bmBack = new Shape();
            this.bmBack.graphics.beginFill(0,0.8);
            this.bmBack.graphics.drawRect(0,0,this.W,this.H);
            this.bmBack.graphics.endFill();
            addChild(this.bmBack);
         }
         Global.control.registerCallBack(Enum_MsgType.STAGE_RESIZE,this.resize);
      }
      
      protected function linkEvent(e:TextEvent) : void
      {
      }
      
      public function show() : void
      {
         if(OffLineTip.isFengHao)
         {
            return;
         }
         KeyboardManager.isEnabled = false;
         Global.stage.addChild(_instance);
         stopDrag();
         this.resize();
      }
      
      private function resize() : void
      {
         this.back.width = Global.stage.stageWidth;
         this.back.height = Global.stage.stageHeight;
         if(!this.txt)
         {
            this.txt = new TextField();
            this.txt.autoSize = TextFieldAutoSize.LEFT;
            this.txt.multiline = true;
            this.txt.htmlText = this.str;
            this.txt.addEventListener(TextEvent.LINK,this.linkEvent);
            addChild(this.txt);
         }
         if(Boolean(this.bm))
         {
            this.bm.x = (Global.stage.stageWidth - this.W) / 2;
            this.bm.y = (Global.stage.stageHeight - this.H) / 2;
            this.txt.x = this.bm.x + 255;
            this.txt.y = this.bm.y + 145;
         }
         else
         {
            this.bmBack.x = (Global.stage.stageWidth - this.W) / 2;
            this.bmBack.y = (Global.stage.stageHeight - this.H) / 2;
            this.txt.x = this.bmBack.x + 255;
            this.txt.y = this.bmBack.y + 145;
         }
      }
   }
}

