package com.yiTian.view.modules.broadcast
{
   import Layout.ILayout;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Pool;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.UIBase;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class View_CenterBroadcast2 extends UIBase
   {
      
      private var l:ILayout;
      
      private var timer:Timer;
      
      private var curItems:Array = [];
      
      public var maxItem:int = 3;
      
      private var _isAddStageEvent:Boolean = false;
      
      private var rato:int = 3;
      
      private var power:Number = 0.8;
      
      private var counter:int;
      
      public function View_CenterBroadcast2()
      {
         super();
         bindParent = GameScene.upUILayer;
         this.l = new CenterBroadcast2Group(0,0,0,0,0,0);
         this.timer = new Timer(200);
         this.timer.addEventListener(TimerEvent.TIMER,this.timerTickHd);
         this.resetPosition();
         Global.control.registerCallBack(Enum_MsgType.STAGE_RESIZE,this.resetPosition);
      }
      
      public function addStageEvent() : void
      {
         if(this._isAddStageEvent)
         {
            return;
         }
         this._isAddStageEvent = true;
         Global.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.onStageMouseDown);
      }
      
      public function removeStageEvent() : void
      {
         if(!this._isAddStageEvent)
         {
            return;
         }
         this._isAddStageEvent = false;
         Global.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStageMouseDown);
      }
      
      private function onStageMouseDown(e:*) : void
      {
         this.outAll();
      }
      
      public function addMsg(str:String, time:int = 2200, bTween:Boolean = false) : void
      {
         var item:CenterBroadcast2Item = Pool.getObject(CenterBroadcast2Item);
         item.startTime = getTimer();
         item.standTime = time;
         item.htmlText = str;
         item.alpha = 1;
         this.addItem(item);
         this.timer.start();
         this.addStageEvent();
      }
      
      private function tFun(p:Number) : Number
      {
         var rate:Number = p * 3.1416 * this.rato;
         return Math.pow(1 - Math.sin(rate) / rate,this.power);
      }
      
      public function outAll() : void
      {
         var i:int = this.curItems.length - 1;
         while(i >= 0)
         {
            this.counter += 1;
            Tween.to(this.curItems[i],1000,{"alpha":[0.8,0]},function(obj:Object):void
            {
               removeChild(obj as DisplayObject);
               Pool.saveObject(obj);
               --counter;
               if(counter == 0 && curItems.length <= 0)
               {
                  visible = false;
               }
            });
            i -= 1;
         }
         this.removeStageEvent();
         this.curItems.splice(0);
      }
      
      protected function timerTickHd(event:TimerEvent) : void
      {
         var now:int = getTimer();
         var i:int = this.curItems.length - 1;
         while(i >= 0)
         {
            if(this.curItems[i] is CenterBroadcast2Item)
            {
               if(now - this.curItems[i].startTime >= this.curItems[i].standTime)
               {
                  this.counter += 1;
                  Tween.to(this.curItems[i],1000,{"alpha":[0.8,0]},function(obj:Object):void
                  {
                     removeChild(obj as DisplayObject);
                     Pool.saveObject(obj);
                     --counter;
                     if(counter == 0 && curItems.length <= 0)
                     {
                        visible = false;
                        removeStageEvent();
                     }
                  });
                  this.l.dependItem(this.curItems[i]);
                  this.curItems.splice(i,1);
               }
            }
            i -= 1;
         }
         if(this.curItems.length == 0)
         {
            this.timer.stop();
         }
      }
      
      public function addItem(v:CenterBroadcast2Item) : void
      {
         var i:int = 0;
         this.l.clearItem();
         this.curItems.unshift(v);
         if(this.curItems.length > this.maxItem)
         {
            i = this.maxItem;
            while(i < this.curItems.length)
            {
               removeChild(this.curItems[i]);
               i += 1;
            }
            this.curItems.splice(this.maxItem);
         }
         var ii:int = 0;
         while(ii < this.curItems.length)
         {
            this.l.appendItem(this.curItems[ii]);
            addChild(v);
            ii += 1;
         }
         this.l.align();
      }
      
      override public function resetPosition() : void
      {
         this.l.x = Global.stage.stageWidth / 2;
         this.l.y = Global.stage.stageHeight / 2 - 70;
         this.l.align();
      }
   }
}

import Layout.HGroup;
import com.ui.controls.MyTextField;
import com.ui.controls.ScaleBitmap;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import flash.display.Sprite;
import flash.text.TextFieldAutoSize;

class CenterBroadcast2Group extends HGroup
{
   
   public function CenterBroadcast2Group(xx:Number, yy:Number, w:Number, h:Number, iH:Number, iInterval:Number)
   {
      super(xx,yy,w,h,iH,iInterval);
   }
   
   override public function align() : void
   {
      var l:int = int(itemArr.length);
      var i:int = 0;
      while(i < l)
      {
         itemArr[i].x = _x;
         itemArr[i].y = _y + i * -32;
         i += 1;
      }
   }
}

class CenterBroadcast2Item extends Sprite
{
   
   public var standTime:int;
   
   public var startTime:int;
   
   public var content:String;
   
   private var bg:ScaleBitmap;
   
   private var tf:MyTextField;
   
   public function CenterBroadcast2Item()
   {
      super();
      this.bg = ComponentUtil.getScaleBitmap("tipsBG",[14,12,20,6],this,{
         "x":0,
         "y":0,
         "width":87,
         "height":95
      },Global.Img_Cdm);
      this.tf = ComponentUtil.getTextField("",this,{
         "x":-155,
         "realWidth":0,
         "size":14,
         "color":16776960
      });
      this.tf.autoSize = TextFieldAutoSize.LEFT;
   }
   
   public function set htmlText(v:String) : void
   {
      this.tf.htmlText = v;
      if(this.tf.textWidth > 350)
      {
         this.bg.width = this.tf.textWidth + 20;
      }
      else
      {
         this.bg.width = 350;
      }
      this.bg.height = this.tf.textHeight + 10;
      this.bg.x = -165;
      this.bg.y = (this.tf.height - this.bg.height) / 2;
   }
}
