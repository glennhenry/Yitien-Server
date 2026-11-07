package com.ui.controls
{
   import com.event.ResizeEvent;
   import com.ui.constants.ScrollAutoType;
   import com.utils.ComponentUtil;
   import com.utils.DmManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   public class ScrollBar extends Sprite
   {
      
      public static const LEFT:String = "LEFT";
      
      public static const RIGHT:String = "RIGHT";
      
      public static const WIDTH:Number = 18;
      
      private var _direction:String;
      
      private var _upBtn:Button;
      
      private var _downBtn:Button;
      
      private var _thumbBar:Button;
      
      private var _thumbBarBg:ScaleBitmap;
      
      private var _btnTimer:Timer;
      
      private var _scrollBack:String = "ScrollBar_background";
      
      private var _isThumbBa:String = "ScrollBar_drag";
      
      public var dragBarVis:Boolean = false;
      
      private var _pageSize:Number;
      
      private var _itemHeight:Number = 30;
      
      private var _scrollRectHeight:Number;
      
      private var _scrollRectWidth:Number;
      
      private var _enabled:Boolean;
      
      private var _autoVisible:Boolean;
      
      private var _scrollAutoType:int = 1;
      
      private var _mouseWheelSpeed:Number = 5;
      
      private var _bindSprite:Sprite;
      
      private var _lock:Boolean = false;
      
      public function ScrollBar($direction:String = "RIGHT")
      {
         super();
         this._direction = $direction;
         this._btnTimer = new Timer(250);
         this._thumbBar = ComponentUtil.getButton("",this._isThumbBa,this,null,DmManager.Img_Cdm);
         this._thumbBar.visible = false;
         this._thumbBarBg = ComponentUtil.getScaleBitmap("Back_ComboBox",[4,4,3,3],this,{"width":20},DmManager.Img_Cdm);
         this._upBtn = ComponentUtil.getButton("","ScrollBar_PageUp",this,null,DmManager.Img_Cdm);
         this._downBtn = ComponentUtil.getButton("","ScrollBar_PageDown",this,null,DmManager.Img_Cdm);
         this._upBtn.visible = false;
         this._downBtn.visible = false;
         this._upBtn.addEventListener(MouseEvent.CLICK,this.onUpClickHandler);
         this._upBtn.addEventListener(MouseEvent.MOUSE_DOWN,this.onUpBtnMouseDownHandler);
         this._downBtn.addEventListener(MouseEvent.CLICK,this.onDownClickHandler);
         this._downBtn.addEventListener(MouseEvent.MOUSE_DOWN,this.onDownBtnMouseDownHandler);
         this._thumbBarBg.addEventListener(MouseEvent.CLICK,this.onThumbBarBgClickHandler);
         this._thumbBar.addEventListener(MouseEvent.MOUSE_DOWN,this.onThumbBarMouseDownHandler);
         addChild(this._upBtn);
         addChild(this._thumbBar);
         addChild(this._downBtn);
      }
      
      private function onThumbBarBgClickHandler(evt:MouseEvent) : void
      {
         var rate:Number = NaN;
         var rect1:Rectangle = null;
         var rect2:Rectangle = null;
         var rect3:Rectangle = null;
         if(this._thumbBar.visible)
         {
            if(evt.localY > this._thumbBar.height)
            {
               if(this.scrollRectHeight - this._upBtn.height - this._downBtn.height - evt.localY > this._thumbBar.height)
               {
                  rate = (evt.localY - this._thumbBar.height) / (this.scrollRectHeight - this._upBtn.height - this._downBtn.height - this._thumbBar.height);
                  rect1 = this._bindSprite.scrollRect;
                  rect1.y = (this._bindSprite.height - this.scrollRectHeight) * rate;
                  this._bindSprite.scrollRect = rect1;
                  this.updateThumbPosition();
               }
               else
               {
                  rect2 = this._bindSprite.scrollRect;
                  rect2.y = this._bindSprite.height - this.scrollRectHeight;
                  this._bindSprite.scrollRect = rect2;
                  this.updateThumbPosition();
               }
            }
            else
            {
               rect3 = this._bindSprite.scrollRect;
               rect3.y = 0;
               this._bindSprite.scrollRect = rect3;
               this._thumbBar.y = this._upBtn.height;
            }
         }
      }
      
      private function onSizeChangeHandler(evt:Event) : void
      {
         var rect:Rectangle = null;
         var rate:Number = NaN;
         var rect2:Rectangle = null;
         if(!this._lock)
         {
            if(this._bindSprite.height > this.scrollRectHeight)
            {
               if(!this._autoVisible)
               {
                  if(!this._thumbBar.visible)
                  {
                     this._thumbBar.visible = true;
                     this.dragBarVis = true;
                     this._thumbBarBg.visible = true;
                     this._upBtn.visible = true;
                     this._downBtn.visible = true;
                  }
               }
               else
               {
                  this.showHide = true;
               }
               rect = this._bindSprite.scrollRect;
               rect.width = this._scrollRectWidth;
               if(this._scrollAutoType == ScrollAutoType.TO_BOTTOM)
               {
                  rect.y = this._bindSprite.height - this.scrollRectHeight;
                  this._bindSprite.scrollRect = rect;
                  this.updateThumbPosition();
               }
               else if(this._scrollAutoType == ScrollAutoType.TO_TOP)
               {
                  rect.y = 0;
                  this._bindSprite.scrollRect = rect;
                  this._thumbBar.y = this._upBtn.height;
               }
               else if(this._scrollAutoType == ScrollAutoType.REMAIN)
               {
                  rate = (this._thumbBar.y - this._upBtn.height) / (this.scrollRectHeight - this._upBtn.height - this._downBtn.height - this._thumbBar.height);
                  rect.y = (this._bindSprite.height - this.scrollRectHeight) * rate;
                  this._bindSprite.scrollRect = rect;
               }
            }
            else
            {
               this.reset();
               rect2 = this._bindSprite.scrollRect;
               rect2.width = this._scrollRectWidth + WIDTH;
               this._bindSprite.scrollRect = rect2;
            }
         }
      }
      
      private function reset() : void
      {
         var rect:Rectangle = this._bindSprite.scrollRect;
         rect.y = 0;
         this._bindSprite.scrollRect = rect;
         if(!this._autoVisible)
         {
            this._thumbBar.visible = false;
            this.dragBarVis = false;
         }
      }
      
      public function re_set() : void
      {
         var rect:Rectangle = this._bindSprite.scrollRect;
         rect.y = 0;
         this._bindSprite.scrollRect = rect;
         if(!this._autoVisible)
         {
            this._thumbBar.visible = false;
            this.dragBarVis = false;
            this._upBtn.visible = false;
            this._thumbBarBg.visible = false;
            this._downBtn.visible = false;
         }
      }
      
      private function updateThumbPosition() : void
      {
         var rate:Number = NaN;
         if(this._thumbBar.visible)
         {
            this.dragBarVis = true;
            rate = this._bindSprite.scrollRect.y / (this._bindSprite.height - this.scrollRectHeight);
            this._thumbBar.y = rate * (this.scrollRectHeight - this._upBtn.height - this._thumbBar.height - this._downBtn.height) + this._upBtn.height;
         }
      }
      
      private function onUpClickHandler(evt:MouseEvent = null) : void
      {
         var rect:Rectangle = this._bindSprite.scrollRect;
         if(this._bindSprite.scrollRect.y > this.itemHeight)
         {
            rect.y -= this.itemHeight;
         }
         else
         {
            rect.y = 0;
         }
         this._bindSprite.scrollRect = rect;
         this.updateThumbPosition();
      }
      
      private function onUpBtnMouseDownHandler(evt:MouseEvent) : void
      {
         stage.addEventListener(MouseEvent.MOUSE_UP,function upBtnMouseUpHandler(evt:MouseEvent):void
         {
            stage.removeEventListener(MouseEvent.MOUSE_UP,arguments.callee);
            _btnTimer.removeEventListener(TimerEvent.TIMER,upBtnTimerHandler);
            _btnTimer.stop();
         });
         this._btnTimer.addEventListener(TimerEvent.TIMER,this.upBtnTimerHandler);
         this._btnTimer.start();
      }
      
      private function upBtnTimerHandler(evt:TimerEvent) : void
      {
         this.onUpClickHandler();
      }
      
      private function onDownClickHandler(evt:MouseEvent = null) : void
      {
         var rect:Rectangle = null;
         if(this._bindSprite.height > this.scrollRectHeight)
         {
            rect = this._bindSprite.scrollRect;
            if(this._bindSprite.height - this._bindSprite.scrollRect.y - this.scrollRectHeight > this.itemHeight)
            {
               rect.y += this.itemHeight;
            }
            else
            {
               rect.y = this._bindSprite.height - this.scrollRectHeight;
            }
            this._bindSprite.scrollRect = rect;
            this.updateThumbPosition();
         }
      }
      
      private function onDownBtnMouseDownHandler(evt:MouseEvent) : void
      {
         stage.addEventListener(MouseEvent.MOUSE_UP,function upBtnMouseUpHandler(evt:MouseEvent):void
         {
            stage.removeEventListener(MouseEvent.MOUSE_UP,arguments.callee);
            _btnTimer.removeEventListener(TimerEvent.TIMER,downBtnTimerHandler);
            _btnTimer.stop();
         });
         this._btnTimer.addEventListener(TimerEvent.TIMER,this.downBtnTimerHandler);
         this._btnTimer.start();
      }
      
      private function downBtnTimerHandler(evt:TimerEvent) : void
      {
         this.onDownClickHandler();
      }
      
      protected function mouseWheelHandler(evt:MouseEvent) : void
      {
         if(evt.delta > 0)
         {
            if(this._thumbBar.y - this._upBtn.height > this.mouseWheelSpeed * evt.delta)
            {
               this._thumbBar.y += -this.mouseWheelSpeed * evt.delta;
            }
            else
            {
               this._thumbBar.y = this._upBtn.height;
            }
         }
         else if(this.scrollRectHeight - this._thumbBar.y - this._thumbBar.height - this._downBtn.height > -this.mouseWheelSpeed * evt.delta)
         {
            this._thumbBar.y += -this.mouseWheelSpeed * evt.delta;
         }
         else
         {
            this._thumbBar.y = this.scrollRectHeight - this._downBtn.height - this._thumbBar.height;
         }
         this.thumbBarEnterFrame();
      }
      
      private function onThumbBarMouseDownHandler(evt:MouseEvent) : void
      {
         var range:Number = Math.ceil(this.scrollRectHeight - this._thumbBar.height - this._upBtn.height - this._downBtn.height);
         if(this._direction == LEFT)
         {
            this._thumbBar.startDrag(false,new Rectangle(0,this._upBtn.height,0,range));
         }
         else
         {
            this._thumbBar.startDrag(false,new Rectangle(this.scrollRectWidth,this._upBtn.height,0,range));
         }
         stage.addEventListener(MouseEvent.MOUSE_UP,function thumbBarMouseUpHandler(evt:MouseEvent):void
         {
            stage.removeEventListener(MouseEvent.MOUSE_UP,arguments.callee);
            _thumbBar.stopDrag();
            removeEventListener(Event.ENTER_FRAME,thumbBarEnterFrame);
         });
         addEventListener(Event.ENTER_FRAME,this.thumbBarEnterFrame);
      }
      
      public function setValue(per:Number) : void
      {
         var max:Number = this.scrollRectHeight - this._downBtn.height - this._thumbBar.height;
         this._thumbBar.y = per * max;
         this.thumbBarEnterFrame();
      }
      
      private function thumbBarEnterFrame(evt:Event = null) : void
      {
         var per:Number = (this._thumbBar.y - this._upBtn.height - this._upBtn.y) / (this.scrollRectHeight - this._upBtn.height - this._thumbBar.height - this._downBtn.height);
         var rect:Rectangle = this._bindSprite.scrollRect;
         var curretnHeight:int = this._bindSprite.height;
         if(curretnHeight >= this.scrollRectHeight)
         {
            rect.y = per * (curretnHeight - this.scrollRectHeight);
         }
         this._bindSprite.scrollRect = rect;
      }
      
      public function set pageSize(value:Number) : void
      {
         if(!isNaN(value))
         {
            this._pageSize = value;
            if(!isNaN(this._itemHeight))
            {
               this._scrollRectHeight = this._pageSize * this._itemHeight;
            }
            return;
         }
      }
      
      public function set ThumbBa(_thumbBarStr:String) : void
      {
         this._isThumbBa = _thumbBarStr;
         this._thumbBar = ComponentUtil.getButton("",this._isThumbBa,this);
         this._thumbBar.visible = false;
         this.dragBarVis = false;
      }
      
      public function get ThumbBa() : String
      {
         return this._isThumbBa;
      }
      
      public function get pageSize() : Number
      {
         return this._pageSize;
      }
      
      public function set itemHeight(value:Number) : void
      {
         this._itemHeight = value;
         if(!isNaN(value))
         {
            this._itemHeight = value;
            if(!isNaN(this._pageSize))
            {
               this._scrollRectHeight = this._pageSize * this._itemHeight;
            }
            return;
         }
      }
      
      public function get itemHeight() : Number
      {
         return this._itemHeight;
      }
      
      public function get scrollRectHeight() : Number
      {
         return this._scrollRectHeight;
      }
      
      public function set scrollRectHeight(value:Number) : void
      {
         this._scrollRectHeight = value;
      }
      
      public function set scrollRectWidth(value:Number) : void
      {
         this._scrollRectWidth = value;
      }
      
      public function get scrollRectWidth() : Number
      {
         return this._scrollRectWidth;
      }
      
      public function set enabled(value:Boolean) : void
      {
         this._enabled = value;
      }
      
      public function get enabled() : Boolean
      {
         return this._enabled;
      }
      
      public function set autoVisible(value:Boolean) : void
      {
         this._autoVisible = value;
         this.showHide = !value;
      }
      
      public function set scrollAutoType(value:int) : void
      {
         this._scrollAutoType = value;
      }
      
      private function set showHide(value:Boolean) : void
      {
         this.re_set();
         this._thumbBarBg.visible = value;
         this._thumbBar.visible = value;
         this.dragBarVis = value;
         this._upBtn.visible = value;
         this._downBtn.visible = value;
      }
      
      public function set mouseWheelSpeed(value:Number) : void
      {
         this._mouseWheelSpeed = value;
      }
      
      public function get mouseWheelSpeed() : Number
      {
         return this._mouseWheelSpeed;
      }
      
      public function getBind() : Sprite
      {
         return this._bindSprite;
      }
      
      public function bind($bindSprite:Sprite = null) : void
      {
         this._bindSprite = $bindSprite;
         this._bindSprite.addEventListener(ResizeEvent.RESIZE,this.onSizeChangeHandler);
         this._thumbBarBg.height = this._scrollRectHeight;
         this._thumbBarBg.visible = false;
         if(this._direction == LEFT)
         {
            this._upBtn.x = 0;
            this._upBtn.y = 0;
            this._thumbBarBg.x = this._upBtn.x;
            this._thumbBar.x = this._upBtn.x;
            this._thumbBar.y = this._upBtn.height + this._upBtn.y;
            this._downBtn.x = this._upBtn.x;
            this._downBtn.y = this._scrollRectHeight - this._downBtn.height;
            $bindSprite.x = this._upBtn.width;
            $bindSprite.y = 0;
            addChild(this._thumbBar);
         }
         else if(this._direction == RIGHT)
         {
            this._upBtn.x = this._scrollRectWidth;
            this._upBtn.y = 0;
            this._thumbBarBg.x = this._upBtn.x;
            this._thumbBar.x = this._upBtn.x;
            this._thumbBar.y = this._upBtn.height + this._upBtn.y;
            this._downBtn.x = this._upBtn.x;
            this._downBtn.y = this._scrollRectHeight - this._downBtn.height;
            $bindSprite.x = 0;
            $bindSprite.y = 0;
            addChild(this._thumbBar);
            this._upBtn.visible = false;
            this._thumbBarBg.visible = false;
            this._downBtn.visible = false;
         }
         $bindSprite.scrollRect = new Rectangle(0,0,this.scrollRectWidth,this.scrollRectHeight);
         addChild($bindSprite);
         $bindSprite.addEventListener(MouseEvent.MOUSE_WHEEL,this.mouseWheelHandler);
      }
      
      public function set lock(value:Boolean) : void
      {
         this._lock = value;
      }
      
      public function get lock() : Boolean
      {
         return this._lock;
      }
      
      public function dispose() : void
      {
      }
   }
}

