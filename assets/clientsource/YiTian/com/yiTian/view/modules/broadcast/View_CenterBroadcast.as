package com.yiTian.view.modules.broadcast
{
   import com.ui.controls.MyTextField;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.GuideManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.UIBase;
   
   public class View_CenterBroadcast extends UIBase
   {
      
      protected var viewerVec:Vector.<item>;
      
      protected var dieVec:Vector.<item>;
      
      protected const dieTime:Number = 4;
      
      protected var OFFSETY:Number = 30;
      
      protected var OFFSETX:Number = 130;
      
      protected var _color:int = 16776960;
      
      protected const _fontSize:Number = 14;
      
      protected const OFFSET:int = 20;
      
      protected const POSY:int = 28;
      
      protected var stepCounter:int = 0;
      
      protected const UPDATEDELAY:int = 30;
      
      protected const DIEDELAY:int = 3500;
      
      protected const OUTTIME:int = 2000;
      
      protected var OUTSPEED:Number = 6;
      
      protected var OUTALPHA:Number = 0.02;
      
      protected var pool:Vector.<item>;
      
      protected var maxItem:int;
      
      private var _isInit:Boolean = false;
      
      private var runingTime:int = 0;
      
      private var _isWatchMovie:Boolean = false;
      
      private var _sleepCounter:int = 0;
      
      public function View_CenterBroadcast(maxItem:int = 4, outSpeed:Number = 2, outAlpha:Number = 0.05)
      {
         this.OUTALPHA = outAlpha;
         this.OUTSPEED = outSpeed;
         this.maxItem = maxItem;
         super();
         this.resetPosition();
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
         GameScene.upUILayer.addChild(this);
         this.visible = true;
         this._isInit = true;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
      }
      
      override public function resetPosition() : void
      {
         y = Global.stage.stageHeight / 2 - this.OFFSETY;
         x = Global.stage.stageWidth / 2 + this.OFFSETX;
      }
      
      private function onMoviePlay(obj:Object) : void
      {
         this._isWatchMovie = true;
         this.visible = false;
         this.stop();
      }
      
      private function onMovieEnd(obj:Object) : void
      {
         this._isWatchMovie = false;
         this.visible = true;
         this.start();
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
         if(GuideManager.isPlaying == true)
         {
            this.visible = false;
            return;
         }
         this.visible = true;
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
               this.visible = false;
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
      
      public function addGirdMsg(htmlText:String, px:int = 0, py:int = 0, type:int = 1) : void
      {
         this.addMsg(htmlText,type,px,py);
      }
      
      public function addMsg(htmlText:String, type:int = 0, px:int = 0, py:int = 0) : void
      {
         var it:item = null;
         var tf:MyTextField = null;
         var br:View_CenterBroadcast2 = null;
         if(!this._isInit)
         {
            return;
         }
         if(type == 1)
         {
            br = Singleton.getInstance(View_CenterBroadcast2);
            br.x = px;
            br.y = py;
            br.visible = true;
            br.addMsg(htmlText);
            return;
         }
         if(htmlText == null || htmlText == "")
         {
            return;
         }
         it = this.getFreeItem();
         it.updateTime = this.runingTime;
         tf = TFPool.instance.getTF();
         tf.color = this._color;
         tf.size = this._fontSize;
         tf.htmlText = htmlText;
         tf.x = -tf.width / 2;
         tf.y = this.POSY;
         it.tf = tf;
         this.viewerVec.unshift(it);
         addChild(tf);
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
