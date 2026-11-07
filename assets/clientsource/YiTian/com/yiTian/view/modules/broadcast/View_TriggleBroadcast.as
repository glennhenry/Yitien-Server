package com.yiTian.view.modules.broadcast
{
   import com.ui.controls.MyTextField;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.view.UIBase;
   
   public class View_TriggleBroadcast extends UIBase
   {
      
      protected var viewerVec:Vector.<item>;
      
      protected var dieVec:Vector.<item>;
      
      protected const dieTime:Number = 4;
      
      protected var Y:Number = 170;
      
      protected var _color:int = 16776960;
      
      protected const _fontSize:Number = 18;
      
      protected const OFFSET:int = 20;
      
      protected const POSY:int = 28;
      
      protected var stepCounter:int = 0;
      
      protected const UPDATEDELAY:int = 30;
      
      protected const DIEDELAY:int = 5500;
      
      protected const OUTTIME:int = 2000;
      
      protected var OUTSPEED:Number = 6;
      
      protected var OUTALPHA:Number = 0.03;
      
      protected var MAX:int = 3;
      
      protected var pool:Vector.<item>;
      
      protected var maxItem:int;
      
      private var runingTime:int = 0;
      
      public function View_TriggleBroadcast(maxItem:int = 3, outSpeed:Number = 7, outAlpha:Number = 0.05, Y:Number = 100)
      {
         this.OUTALPHA = outAlpha;
         this.OUTSPEED = outSpeed;
         this.maxItem = maxItem;
         this.Y = Y;
         super();
      }
      
      override protected function initStaticView() : void
      {
         this.resetPosition();
      }
      
      override protected function initDynamicView() : void
      {
         this.viewerVec = new Vector.<item>();
         this.dieVec = new Vector.<item>();
         this.pool = new Vector.<item>();
         this.visible = true;
         Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_START,this.bpsHd);
         Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_END,this.bpeHd);
      }
      
      private function bpsHd() : void
      {
         alpha = 0.5;
      }
      
      private function bpeHd() : void
      {
         alpha = 1;
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            GameScene.upUILayer.addChildAt(this,0);
         }
         super.visible = value;
      }
      
      override public function resetPosition() : void
      {
         y = this.Y;
         x = Global.stage.stageWidth / 2;
      }
      
      public function start() : void
      {
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.step);
      }
      
      public function stop() : void
      {
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.step);
      }
      
      protected function step(interval:int) : void
      {
         var i:int = 0;
         var index:int = 0;
         var dit:item = null;
         var tf:MyTextField = null;
         var dis:Number = NaN;
         var temp:Number = NaN;
         var speed:Number = NaN;
         var ctf:MyTextField = null;
         this.visible = !UIManager.actBroadcast.visible;
         this.runingTime += interval;
         this.stepCounter += interval;
         if(this.viewerVec.length > this.maxItem)
         {
            i = this.viewerVec.length - 1;
            while(i >= this.maxItem)
            {
               this.viewerVec[i].updateTime = this.runingTime;
               this.dieVec.push(this.viewerVec[i]);
               this.viewerVec.splice(i,1);
               i--;
            }
         }
         if(this.stepCounter >= this.UPDATEDELAY)
         {
            this.stepCounter = 0;
            index = this.viewerVec.length - 1;
            while(index >= 0)
            {
               if(this.runingTime - this.viewerVec[index].updateTime >= this.DIEDELAY)
               {
                  this.viewerVec[index].updateTime = this.runingTime;
                  this.dieVec.push(this.viewerVec[index]);
                  this.viewerVec.splice(index,1);
               }
               else
               {
                  tf = this.viewerVec[index].tf;
                  dis = -this.OFFSET * index - this.POSY;
                  if(tf.y > dis)
                  {
                     temp = dis - tf.y;
                     speed = int(temp / 10) + 1;
                     tf.y += speed;
                  }
               }
               index--;
            }
            for each(dit in this.dieVec)
            {
               ctf = dit.tf;
               ctf.alpha -= this.OUTALPHA;
               ctf.y -= this.OUTSPEED;
               if(ctf.alpha <= 0)
               {
                  this.dieVec.splice(this.dieVec.indexOf(dit),1);
                  removeChild(ctf);
                  dit.dispose();
                  this.saveFreeItem(dit);
                  TFPool.instance.addTF(ctf);
               }
            }
            if(this.viewerVec.length == 0 && this.dieVec.length == 0)
            {
               this.stop();
            }
         }
      }
      
      protected function saveFreeItem(it:item) : void
      {
         this.pool.push(it);
      }
      
      protected function getFreeItem() : item
      {
         var it:item = null;
         if(Boolean(this.pool.length))
         {
            it = this.pool.pop();
         }
         else
         {
            it = new item();
         }
         return it;
      }
      
      public function addMsg(htmlText:String) : void
      {
         var it:item = null;
         var tf:MyTextField = null;
         var i:int = 0;
         var dit:item = null;
         if(UIManager.actBroadcast.visible)
         {
            return;
         }
         if(this.viewerVec.length > this.maxItem)
         {
            i = this.viewerVec.length - 1;
            while(i >= this.maxItem)
            {
               this.viewerVec[i].updateTime = this.runingTime;
               this.dieVec.push(this.viewerVec[i]);
               this.viewerVec.splice(i,1);
               i--;
            }
         }
         it = this.getFreeItem();
         it.updateTime = this.runingTime;
         tf = TFPool.instance.getTF();
         tf.bold = true;
         tf.color = this._color;
         tf.size = this._fontSize;
         tf.htmlText = htmlText;
         tf.x = -tf.width / 2;
         tf.y = this.POSY;
         it.tf = tf;
         this.viewerVec.unshift(it);
         addChild(tf);
         while(this.dieVec.length >= this.MAX)
         {
            dit = this.dieVec.shift();
            removeChild(dit.tf);
            TFPool.instance.addTF(dit.tf);
            dit.dispose();
            this.saveFreeItem(dit);
         }
         this.start();
      }
   }
}

import com.ui.controls.MyTextField;

class item
{
   
   public var updateTime:int;
   
   public var tf:MyTextField;
   
   public function item()
   {
      super();
   }
   
   public function dispose() : void
   {
      this.updateTime = 0;
      this.tf = null;
   }
}
