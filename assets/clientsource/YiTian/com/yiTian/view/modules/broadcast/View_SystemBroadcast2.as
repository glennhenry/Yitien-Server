package com.yiTian.view.modules.broadcast
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.view.UIBase;
   import flash.display.DisplayObject;
   
   public class View_SystemBroadcast2 extends UIBase
   {
      
      private var queuePool:Vector.<item>;
      
      private var UPDATEDELAY:int = 300;
      
      private const Y:Number = 70;
      
      private var counter:int = 0;
      
      private var runningTime:int = 0;
      
      private var timePara:int;
      
      private var tf:MyTextField;
      
      private const _fontSize:Number = 18;
      
      private const _color:int = 16776960;
      
      private var effect:Effect;
      
      private var bg:DisplayObject;
      
      private var delete_pool:Vector.<item>;
      
      private var lastUpdateTime:int;
      
      private var curLevel:int;
      
      public function View_SystemBroadcast2()
      {
         super();
         mouseEnabled = false;
         mouseChildren = false;
         bindParent = GameScene.upUILayer;
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            if(!this.effect)
            {
               this.effect = EffectManager.addEffect("35016",null,1500,0,0,true);
               addChildAt(this.effect,0);
            }
         }
         else if(Boolean(this.effect))
         {
            EffectManager.removeEffect(this.effect);
            this.effect = null;
         }
         super.visible = value;
      }
      
      override protected function initStaticView() : void
      {
         this.tf = ComponentUtil.getTextField("",this,{"y":-10});
         this.tf.color = this._color;
         this.tf.size = this._fontSize;
         this.tf.bold = true;
         this.tf.filters = Util.glowBig000000;
      }
      
      override protected function initDynamicView() : void
      {
         this.queuePool = new Vector.<item>();
         this.delete_pool = new Vector.<item>();
         GameScene.upUILayer.addChild(this);
         this.visible = false;
         this.resetPosition();
      }
      
      public function stop() : void
      {
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.step);
         UIManager.systemBroadcast.resume();
      }
      
      private function step(interval:int) : void
      {
         var it:item = null;
         var dit:item = null;
         this.runningTime += interval;
         this.counter += interval;
         if(this.counter >= this.UPDATEDELAY)
         {
            this.counter = 0;
            if(this.queuePool.length > 0)
            {
               if(this.queuePool[0].level > this.curLevel || this.tf.text == "")
               {
                  it = this.queuePool[0];
                  this.resetView(it);
                  it.dispose();
                  this.addFreeItem(it);
                  this.queuePool.shift();
               }
               if(this.runningTime - this.lastUpdateTime >= this.timePara)
               {
                  dit = this.queuePool[0];
                  this.resetView(this.queuePool[0]);
                  dit.dispose();
                  this.addFreeItem(dit);
                  this.queuePool.shift();
               }
            }
            else if(this.runningTime - this.lastUpdateTime >= this.timePara)
            {
               this.tf.htmlText = "";
               this.curLevel = -1;
               this.lastUpdateTime = 0;
               this.stop();
               this.visible = false;
            }
         }
      }
      
      private function resetView(it:item) : void
      {
         this.lastUpdateTime = this.runningTime;
         this.tf.htmlText = it.text;
         this.tf.x = -this.tf.width / 2;
         this.curLevel = it.level;
         this.timePara = it.duration;
      }
      
      override public function resetPosition() : void
      {
         y = this.Y;
         x = Global.stage.stageWidth / 2;
      }
      
      public function addMsg(htmlText:String, level:uint = 0, duration:int = 10000) : void
      {
         this.resetPosition();
         var it:item = this.getItem();
         it.text = htmlText;
         it.level = level;
         it.duration = duration;
         this.queuePool.push(it);
         this.sort();
         this.start();
         this.visible = true;
      }
      
      private function sort() : void
      {
         var j:int = 0;
         var temp:item = null;
         var length:int = int(this.queuePool.length);
         var i:int = 0;
         while(i < length)
         {
            j = 0;
            while(j < length - 1)
            {
               if(this.queuePool[j].level < this.queuePool[j + 1].level)
               {
                  temp = this.queuePool[j];
                  this.queuePool[j] = this.queuePool[j + 1];
                  this.queuePool[j + 1] = temp;
               }
               j++;
            }
            i++;
         }
      }
      
      public function start() : void
      {
         UIManager.systemBroadcast.sleep();
         this.visible = true;
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.step);
      }
      
      private function getItem() : item
      {
         var it:item = null;
         if(this.delete_pool.length > 0)
         {
            it = this.delete_pool.pop();
         }
         else
         {
            it = new item();
         }
         return it;
      }
      
      private function addFreeItem(it:item) : void
      {
         this.delete_pool.push(it);
      }
   }
}

class item
{
   
   public var text:String;
   
   public var level:uint;
   
   public var duration:int;
   
   public function item()
   {
      super();
   }
   
   public function dispose() : void
   {
      this.text = "";
      this.level = 0;
   }
}
