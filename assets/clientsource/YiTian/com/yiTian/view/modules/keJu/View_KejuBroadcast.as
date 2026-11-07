package com.yiTian.view.modules.keJu
{
   import com.ui.controls.MyTextField;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.view.modules.broadcast.TFPool;
   import flash.display.Sprite;
   
   public class View_KejuBroadcast extends Sprite
   {
      
      private static var _instance:View_KejuBroadcast;
      
      protected var _color:int = 16776960;
      
      protected const _fontSize:Number = 14;
      
      protected var OFFSETY:Number = 30;
      
      protected var OFFSETX:Number = 130;
      
      protected var OUTSPEED:Number = 6;
      
      protected var OUTALPHA:Number = 0.02;
      
      protected const OFFSET:int = 20;
      
      protected const POSY:int = 28;
      
      protected var pool:Vector.<item>;
      
      protected var viewerVec:Vector.<item>;
      
      protected var dieVec:Vector.<item>;
      
      private var runingTime:int = 0;
      
      protected var stepCounter:int = 0;
      
      protected const UPDATEDELAY:int = 30;
      
      protected const DIEDELAY:int = 1500;
      
      protected var maxItem:int;
      
      public function View_KejuBroadcast(maxItem:int = 4, outSpeed:Number = 2, outAlpha:Number = 0.05)
      {
         this.OUTALPHA = outAlpha;
         this.OUTSPEED = outSpeed;
         this.maxItem = maxItem;
         super();
         this.init();
      }
      
      public static function get instance() : View_KejuBroadcast
      {
         if(!_instance)
         {
            _instance = new View_KejuBroadcast();
         }
         return _instance;
      }
      
      private function init() : void
      {
         this.viewerVec = new Vector.<item>();
         this.dieVec = new Vector.<item>();
         this.pool = new Vector.<item>();
         visible = true;
      }
      
      private function getFreeItem() : item
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
      
      public function start() : void
      {
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.step);
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
         visible = true;
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
               visible = false;
            }
         }
      }
      
      public function stop() : void
      {
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.step);
      }
      
      protected function saveFreeItem(it:item) : void
      {
         this.pool.push(it);
      }
      
      public function addMsg(htmlText:String) : void
      {
         var it:item = null;
         var tf:MyTextField = null;
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
