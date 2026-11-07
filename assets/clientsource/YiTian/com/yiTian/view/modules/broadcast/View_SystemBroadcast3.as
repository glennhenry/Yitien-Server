package com.yiTian.view.modules.broadcast
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.UIBase;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class View_SystemBroadcast3 extends UIBase
   {
      
      private var queueVec:Vector.<String>;
      
      private var UPDATEDELAY:int = 100;
      
      private const Y:Number = 75;
      
      private var counter:int = 0;
      
      private var runningTime:int = 0;
      
      private var tf:MyTextField;
      
      private const _fontSize:Number = 14;
      
      private const _color:int = 16776960;
      
      private const _time:int = 15000;
      
      private var updateTime:int;
      
      private var bg:Sprite;
      
      private var icon:DisplayObject;
      
      private var closeBtn:Button;
      
      private var _isSleep:Boolean = false;
      
      public function View_SystemBroadcast3()
      {
         super();
         bindParent = GameScene.sysLayer;
      }
      
      override protected function initStaticView() : void
      {
         this.bg = new Sprite();
         addChild(this.bg);
         this.bg.graphics.beginFill(0,0);
         this.bg.graphics.drawRect(0,0,40,40);
         this.bg.graphics.endFill();
         this.bg.visible = false;
         this.icon = ComponentUtil.getBitmap("Bulletin_LaBa",this,null,Global.New_Imgsdm);
         this.closeBtn = ComponentUtil.getButton("","Bulletin_Close",this,null,Global.New_Imgsdm);
         this.tf = ComponentUtil.getTextField("",this);
         this.tf.mouseEnabled = true;
         this.tf.addEventListener(TextEvent.LINK,this.linkHd);
         this.tf.size = this._fontSize;
         this.tf.color = this._color;
         this.tf.bold = true;
      }
      
      public function sleep() : void
      {
         if(this.tf.text == "" && this.queueVec.length == 0)
         {
            return;
         }
         this._isSleep = true;
         this.stop();
         this.visible = false;
      }
      
      public function resume() : void
      {
         if(this._isSleep == true || this.queueVec.length > 0)
         {
            this.visible = true;
            this.fillUpdateTime();
            this.start();
            this._isSleep = false;
         }
      }
      
      override protected function initDynamicView() : void
      {
         this.closeBtn.callBack = this.close;
         this.queueVec = new Vector.<String>();
         GameScene.sysLayer.addChild(this);
         this.visible = false;
      }
      
      private function close(evt:MouseEvent) : void
      {
         this.tf.text = "";
         this.queueVec.shift();
         if(Boolean(this.queueVec.length))
         {
            this.updateTime = this.runningTime;
            this.msg(this.queueVec.shift());
         }
         else
         {
            this.stop();
            this.updateTime = this.runningTime;
         }
      }
      
      private function msg(str:String) : void
      {
         var reg:RegExp = /event/;
         if(reg.test(str))
         {
            str = HtmlUtil.underLine(str);
         }
         this.tf.htmlText = str;
         this.tf.x = -this.tf.width / 2;
         this.bg.width = this.tf.width + 74;
         this.bg.x = -this.bg.width / 2;
         this.bg.height = this.tf.height + 4;
         this.bg.y = this.tf.y - 2;
         this.icon.x = -this.bg.width / 2 + 7;
         this.icon.y = this.bg.y + (this.bg.height - this.icon.height) / 2;
         this.closeBtn.y = this.bg.y + (this.bg.height - this.closeBtn.height) / 2;
         this.closeBtn.x = this.bg.width / 2 - 26;
      }
      
      private function linkHd(evt:TextEvent) : void
      {
         var str:String = evt.text;
         navigateToURL(new URLRequest(str),"_blank");
      }
      
      public function addMsg(htmlText:String) : void
      {
         this.queueVec.push(htmlText);
         if(this.tf.text == "")
         {
            this.msg(htmlText);
         }
         if(UIManager.actBroadcast.visible == true)
         {
            return;
         }
         this.visible = true;
         this.start();
      }
      
      override public function set visible(value:Boolean) : void
      {
         this.resetPosition();
         super.visible = value;
      }
      
      public function stop() : void
      {
         this.visible = false;
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.step);
      }
      
      public function start() : void
      {
         if(this.runningTime - this.updateTime < this._time || this.queueVec.length > 0)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.step);
            this.visible = true;
         }
      }
      
      public function fillUpdateTime() : void
      {
         this.updateTime = this.runningTime;
      }
      
      private function update() : void
      {
         this.updateTime = this.runningTime;
         this.msg(this.queueVec.shift());
      }
      
      private function hide() : void
      {
         this.stop();
         this.updateTime = 0;
         this.tf.text = "";
         this.visible = false;
      }
      
      private function step(interval:int) : void
      {
         this.runningTime += interval;
         this.counter += interval;
         if(this.counter >= this.UPDATEDELAY)
         {
            this.counter = 0;
            if(this.updateTime == 0 || this.runningTime - this.updateTime >= this._time)
            {
               if(this.queueVec.length > 0)
               {
                  this.update();
               }
               else
               {
                  this.hide();
               }
            }
         }
      }
      
      override public function resetPosition() : void
      {
         y = this.Y;
         x = Global.stage.stageWidth / 2;
      }
   }
}

