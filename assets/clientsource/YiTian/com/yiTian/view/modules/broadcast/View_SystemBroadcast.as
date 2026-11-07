package com.yiTian.view.modules.broadcast
{
   import com.ui.controls.MyTextField;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.scene.GameScene;
   import com.yiTian.view.UIBase;
   import flash.display.Sprite;
   
   public class View_SystemBroadcast extends UIBase
   {
      
      private const Y:Number = 130;
      
      private const MASK_HEIGHT:Number = 30;
      
      private const MASK_WIDTH:Number = 500;
      
      private const MASK_X:Number = 0;
      
      private const MASK_Y:Number = 0;
      
      private const OFFSET:Number = 100;
      
      private var counter:int = 0;
      
      private var curIndex:int = 0;
      
      private var _mask:Sprite;
      
      private const DELAY:Number = 0;
      
      private const _color:int = 16776960;
      
      private const _fontSize:int = 18;
      
      private var itemVec:Vector.<item>;
      
      private var enabledVec:Vector.<MyTextField>;
      
      private var itempool:Vector.<item>;
      
      public function View_SystemBroadcast()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         this._mask = new Sprite();
         this.itemVec = new Vector.<item>();
         this.enabledVec = new Vector.<MyTextField>();
         this.itempool = new Vector.<item>();
      }
      
      override protected function initDynamicView() : void
      {
         this._mask.graphics.beginFill(3355443,0.4);
         this._mask.graphics.drawRect(0,0,this.MASK_WIDTH,this.MASK_HEIGHT);
         this._mask.graphics.endFill();
         this._mask.x = this.MASK_X;
         this._mask.y = this.MASK_Y;
         addChild(this._mask);
         mask = this._mask;
         y = this.Y;
         this.visible = true;
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(!value)
         {
            return;
         }
         GameScene.upUILayer.addChild(this);
         super.visible = value;
      }
      
      public function addMsg(htmlText:String, round:int = 1, nextTime:int = 0, speed:Number = 0.5) : void
      {
         var it:item = this.getFreeItem();
         it.text = htmlText;
         it.round = round;
         this.itemVec.push(it);
         this.start();
      }
      
      public function start() : void
      {
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.frameHandle);
      }
      
      public function stop() : void
      {
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.frameHandle);
      }
      
      private function showMsg(index:int) : void
      {
         var it:item = null;
         var tf:MyTextField = null;
         if(this.itemVec.length == 0)
         {
            return;
         }
         if(index >= this.itemVec.length)
         {
            index = 0;
         }
         this.curIndex = index;
         it = this.itemVec[index];
         tf = TFPool.instance.getTF();
         tf.x = this.MASK_WIDTH;
         tf.size = this._fontSize;
         tf.color = this._color;
         tf.htmlText = it.text;
         this.enabledVec.push(tf);
         addChild(tf);
         this.start();
         it.finnishTimes += 1;
         if(it.round >= 1 && it.finnishTimes >= it.round)
         {
            this.itemVec.splice(index,1);
            this.freeItem(it);
         }
      }
      
      private function removeViewer(tf:MyTextField) : void
      {
         removeChild(tf);
         this.enabledVec.splice(this.enabledVec.indexOf(tf),1);
         TFPool.instance.addTF(tf);
      }
      
      private function getFreeItem() : item
      {
         var it:item = null;
         if(Boolean(this.itempool.length))
         {
            it = this.itempool.pop();
         }
         else
         {
            it = new item();
         }
         return it;
      }
      
      private function freeItem(it:item) : void
      {
         it.dispose();
         this.itemVec.splice(this.itemVec.indexOf(it),1);
         this.itempool.push(it);
      }
      
      private function frameHandle(interval:int) : void
      {
         var index:int = 0;
         var tf:MyTextField = null;
         var lastTf:MyTextField = null;
         var endPosX:Number = NaN;
         var updatePos:Number = NaN;
         if(this.enabledVec.length == 0 && this.itemVec.length > 0)
         {
            this.showMsg(0);
            this.curIndex = 0;
         }
         this.counter += interval;
         if(this.counter > this.DELAY)
         {
            this.counter = 0;
            index = 0;
            while(index < this.enabledVec.length)
            {
               tf = this.enabledVec[index];
               tf.x -= 3;
               lastTf = this.enabledVec[this.enabledVec.length - 1];
               endPosX = lastTf.x + lastTf.width;
               updatePos = this.MASK_WIDTH - this.OFFSET;
               if(this.itemVec.length > 0 && endPosX < updatePos)
               {
                  this.showMsg(this.curIndex + 1);
               }
               if(tf.x <= -tf.width)
               {
                  this.removeViewer(tf);
               }
               index++;
            }
         }
         if(this.enabledVec.length == 0 && this.itemVec.length == 0)
         {
            this.stop();
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.MASK_WIDTH) / 2;
      }
   }
}

class item
{
   
   public var text:String;
   
   public var speed:Number;
   
   public var round:int;
   
   public var finnishTimes:int;
   
   public function item()
   {
      super();
   }
   
   public function dispose() : void
   {
      this.text = "";
      this.speed = 0;
      this.round = 0;
      this.finnishTimes = 0;
   }
}
