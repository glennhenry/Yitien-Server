package com.yiTian.view.modules.chatM
{
   import com.ui.controls.Button;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.scene.GameScene;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   public class TestScroll extends Sprite
   {
      
      public static var LEFT:String = "left";
      
      public static var RIGHT:String = "right";
      
      private static var WIDTH:int = 100;
      
      private static var HEIGHT:int = 100;
      
      private var _direction:String;
      
      private var back:Sprite;
      
      private var contan:Sprite;
      
      private var maskCon:Sprite;
      
      private var upBtn:Sprite;
      
      private var downBtn:Sprite;
      
      private var scollBtn:Button;
      
      private var _btnTimer:Timer;
      
      private var __x:int;
      
      private var disBack:ScaleBitmap;
      
      private var _bindTarget:DisplayObject;
      
      private var scroType:int = 1;
      
      private var dataHei:int;
      
      private var _wheelSpeed:int = 5;
      
      private var _lock:Boolean = false;
      
      public function TestScroll(_wid:int, _hei:int, direction:String = "right", _parent:DisplayObjectContainer = null)
      {
         super();
         WIDTH = _wid;
         HEIGHT = _hei;
         this._direction = direction;
         this.init();
         _parent.addChild(this);
      }
      
      public function init() : void
      {
         this.back = new Sprite();
         ComponentUtil.getScaleBitmap("Back_Translucent",[2,2,4,4],this.back,{
            "x":0,
            "y":0,
            "width":WIDTH - 4,
            "height":HEIGHT
         },Global.Img_Cdm);
         this.back.width = WIDTH - 4;
         this.back.height = HEIGHT;
         this.back.alpha = 0;
         addChild(this.back);
         this.contan = new Sprite();
         this.disBack = ComponentUtil.getScaleBitmap("Back_ComboBox",[4,4,3,3],this,{"width":20},Global.Img_Cdm);
         this.disBack.height = HEIGHT;
         addChild(this.contan);
         this.maskCon = new Sprite();
         this.maskCon.graphics.beginFill(0,0.1);
         this.maskCon.graphics.drawRect(0,0,WIDTH,HEIGHT);
         this.maskCon.graphics.endFill();
         addChild(this.maskCon);
         this.contan.mask = this.maskCon;
         this.upBtn = new Sprite();
         ComponentUtil.getButton("","ScrollBar_PageUp",this.upBtn,null,Global.Img_Cdm);
         if(this._direction == RIGHT)
         {
            this.__x = WIDTH - this.upBtn.width;
         }
         else if(this._direction == LEFT)
         {
            this.__x = 0;
         }
         this.upBtn.x = this.__x;
         this.upBtn.y = 0;
         this.disBack.x = this.__x + 1;
         addChild(this.upBtn);
         this.downBtn = new Sprite();
         ComponentUtil.getButton("","ScrollBar_PageDown",this.downBtn,null,Global.Img_Cdm);
         this.downBtn.x = this.__x;
         this.downBtn.y = HEIGHT - this.downBtn.height;
         addChild(this.downBtn);
         this.scollBtn = ComponentUtil.getButton("","ScrollBar_drag",this.downBtn,null,Global.Img_Cdm);
         this.scollBtn.x = this.__x;
         this.scollBtn.y = this.upBtn.height;
         addChild(this.scollBtn);
         addEventListener(MouseEvent.MOUSE_WHEEL,this.wheelHd);
         this._btnTimer = new Timer(50);
         this.upBtn.addEventListener(MouseEvent.MOUSE_DOWN,this.upHd);
         this.downBtn.addEventListener(MouseEvent.MOUSE_DOWN,this.downHd);
         this.scollBtn.addEventListener(MouseEvent.MOUSE_DOWN,this.moveHd);
         this.back.addEventListener(MouseEvent.CLICK,GameScene.instance.uiOnGo);
      }
      
      private function moveHd(e:MouseEvent) : void
      {
         this.scollBtn.startDrag(false,new Rectangle(this.__x,this.upBtn.height,0,HEIGHT - this.upBtn.height - this.downBtn.height - this.scollBtn.height));
         stage.addEventListener(MouseEvent.MOUSE_UP,function(e:MouseEvent):void
         {
            stage.removeEventListener(MouseEvent.MOUSE_UP,arguments.callee);
            scollBtn.stopDrag();
            removeEventListener(Event.ENTER_FRAME,tiaoZheng);
         });
         addEventListener(Event.ENTER_FRAME,this.tiaoZheng);
      }
      
      public function set item(item:DisplayObject) : void
      {
         this.contan.addChild(item);
         this._bindTarget = item;
         this.resize();
      }
      
      public function resize() : void
      {
         var backHei:int = this.back.height;
         this.dataHei = this._bindTarget.height;
         var per:Number = backHei / this.dataHei >= 1 ? 1 : backHei / this.dataHei;
         if(this.scroType == 2)
         {
            this.scollBtn.height = (HEIGHT - this.upBtn.height - this.downBtn.height) * per;
         }
         else if(this.scroType == 1)
         {
            this.showDrag(per < 1);
         }
         if(!this._lock)
         {
            this.scollBtn.y = HEIGHT - this.downBtn.height - this.scollBtn.height;
            this.getDataPos();
         }
      }
      
      private function showDrag(value:Boolean) : void
      {
         this.disBack.visible = this.upBtn.visible = this.downBtn.visible = this.scollBtn.visible = value;
      }
      
      public function toTop() : void
      {
         this.scollBtn.y = this.downBtn.height;
         this.getDataPos();
      }
      
      private function downHd(e:MouseEvent) : void
      {
         stage.addEventListener(MouseEvent.MOUSE_UP,function(e:MouseEvent):void
         {
            stage.removeEventListener(MouseEvent.MOUSE_UP,arguments.callee);
            _btnTimer.removeEventListener(TimerEvent.TIMER,downBtnTimerHandler);
            _btnTimer.stop();
         });
         this._btnTimer.addEventListener(TimerEvent.TIMER,this.downBtnTimerHandler);
         this._btnTimer.start();
      }
      
      private function downBtnTimerHandler(e:TimerEvent) : void
      {
         this.scollBtn.y += this.wheelSpeed;
         this.tiaoZheng();
      }
      
      private function upBtnTimerHandler(e:TimerEvent) : void
      {
         this.scollBtn.y -= this.wheelSpeed;
         this.tiaoZheng();
      }
      
      public function get scroWidObj() : Object
      {
         var obj:Object = new Object();
         obj.visi = this.scollBtn.visible;
         if(this.scollBtn.visible)
         {
            obj.wid = WIDTH - this.upBtn.width;
         }
         else
         {
            obj.wid = WIDTH;
         }
         return obj;
      }
      
      private function upHd(e:MouseEvent) : void
      {
         stage.addEventListener(MouseEvent.MOUSE_UP,function(e:MouseEvent):void
         {
            stage.removeEventListener(MouseEvent.MOUSE_UP,arguments.callee);
            _btnTimer.removeEventListener(TimerEvent.TIMER,upBtnTimerHandler);
            _btnTimer.stop();
         });
         this._btnTimer.addEventListener(TimerEvent.TIMER,this.upBtnTimerHandler);
         this._btnTimer.start();
      }
      
      public function set wheelSpeed(value:int) : void
      {
         this._wheelSpeed = value;
      }
      
      public function get wheelSpeed() : int
      {
         return this._wheelSpeed;
      }
      
      private function wheelHd(e:MouseEvent) : void
      {
         if(!this.scollBtn.visible)
         {
            return;
         }
         var _delta:int = e.delta;
         if(_delta > 0)
         {
            if(this.scollBtn.y == this.upBtn.y + this.upBtn.height)
            {
               return;
            }
         }
         else if(this.scollBtn.y == this.downBtn.y - this.scollBtn.height)
         {
            return;
         }
         this.scollBtn.y -= _delta * this.wheelSpeed;
         this.tiaoZheng();
      }
      
      public function set lock(value:Boolean) : void
      {
         this._lock = value;
         if(!value)
         {
            this.scollBtn.y = HEIGHT - this.downBtn.height - this.scollBtn.height;
            this.getDataPos();
         }
      }
      
      public function get lock() : Boolean
      {
         return this._lock;
      }
      
      private function getDataPos() : void
      {
         var range:int = HEIGHT - this.upBtn.height - this.downBtn.height - this.scollBtn.height;
         var gapY:Number = this.scollBtn.y - this.upBtn.height;
         var perC:Number = gapY / range;
         if(!this.scollBtn.visible)
         {
            perC = 0;
         }
         this.contan.y = -(this.dataHei - this.back.height) * perC;
      }
      
      private function tiaoZheng(e:Event = null) : void
      {
         if(this.scollBtn.y > this.downBtn.y - this.scollBtn.height)
         {
            this.scollBtn.y = this.downBtn.y - this.scollBtn.height;
         }
         if(this.scollBtn.y < this.upBtn.y + this.upBtn.height)
         {
            this.scollBtn.y = this.upBtn.y + this.upBtn.height;
         }
         this.getDataPos();
      }
   }
}

