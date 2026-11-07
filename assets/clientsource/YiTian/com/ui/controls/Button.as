package com.ui.controls
{
   import com.utils.ComponentUtil;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.system.ApplicationDomain;
   
   public class Button extends Sprite
   {
      
      protected var _textField:MyTextField;
      
      protected var _bmp:Bitmap;
      
      private var _upStyle:BitmapData;
      
      private var _overStyle:BitmapData;
      
      private var _downStyle:BitmapData;
      
      private var _disabledStyle:BitmapData;
      
      private var _style:String;
      
      private var _dm:ApplicationDomain;
      
      protected var _textColor:uint = 16184781;
      
      protected var _textOverColor:uint = 16777164;
      
      protected var _textDisabledColor:uint = 13421772;
      
      protected var _textSize:int = 12;
      
      public var callBack:Function;
      
      protected var _label:String;
      
      protected var _tx:Number;
      
      protected var _ty:Number;
      
      protected var _needReneder:Boolean = false;
      
      protected var _needResizeLabel:Boolean = false;
      
      protected var _enabled:Boolean = true;
      
      protected var _mouseDown:Boolean = false;
      
      protected var _rollOver:Boolean = false;
      
      public function Button(label:String, style:String, dm:ApplicationDomain)
      {
         super();
         this._style = style;
         this._dm = dm;
         this._label = label;
         this._upStyle = ComponentUtil.getBitmapData(style + "_up",dm);
         this._overStyle = ComponentUtil.getBitmapData(style + "_over",dm);
         this._downStyle = ComponentUtil.getBitmapData(style + "_down",dm);
         this._bmp = new Bitmap();
         addChild(this._bmp);
         this._bmp.bitmapData = this._upStyle;
         this._textField = ComponentUtil.getTextField("",this,{"color":this.textColor});
         this._label = label;
         addEventListener(MouseEvent.ROLL_OVER,this.rollover);
         addEventListener(MouseEvent.ROLL_OUT,this.rollout);
         addEventListener(MouseEvent.MOUSE_DOWN,this.mousedown);
         addEventListener(MouseEvent.CLICK,this.click);
         mouseChildren = false;
         buttonMode = true;
         useHandCursor = true;
         mouseEnabled = true;
         this.invalidate();
      }
      
      public function set enabled(value:Boolean) : void
      {
         this._enabled = value;
         if(value)
         {
            buttonMode = true;
            useHandCursor = true;
            mouseEnabled = true;
         }
         else
         {
            buttonMode = false;
            useHandCursor = false;
            mouseEnabled = false;
         }
         this.invalidate();
      }
      
      public function set style(style:String) : void
      {
         this._style = style;
         this._upStyle = ComponentUtil.getBitmapData(style + "_up",this._dm);
         this._overStyle = ComponentUtil.getBitmapData(style + "_over",this._dm);
         this._downStyle = ComponentUtil.getBitmapData(style + "_down",this._dm);
         this.invalidate();
      }
      
      public function get style() : String
      {
         return this._style;
      }
      
      public function get enabled() : Boolean
      {
         return this._enabled;
      }
      
      public function set textColor(value:uint) : void
      {
         this._textColor = value;
         this.invalidate();
      }
      
      public function get textColor() : uint
      {
         return this._textColor;
      }
      
      public function set textOverColor(value:uint) : void
      {
         this._textOverColor = value;
         this.invalidate();
      }
      
      public function get textOverColor() : uint
      {
         return this._textOverColor;
      }
      
      public function set label(txt:String) : void
      {
         this._label = txt;
         this.invalidate();
      }
      
      public function set_htmlText(txt:String) : void
      {
         this._label = txt;
         this.invalidate();
      }
      
      public function LabelResize(tx:int = 0, ty:int = 0) : void
      {
         this._tx = tx;
         this._ty = ty;
         this._needResizeLabel = true;
         this.invalidate();
      }
      
      public function get btnLabel() : String
      {
         return this._textField.text;
      }
      
      public function set labelSize(size:int) : void
      {
         this._textSize = size;
         this.invalidate();
      }
      
      public function get labelSize() : int
      {
         return this._textSize;
      }
      
      public function get label() : String
      {
         return this._label;
      }
      
      public function get sourStype() : String
      {
         return this._style;
      }
      
      private function rollover(e:MouseEvent) : void
      {
         this._rollOver = true;
         this.invalidate();
      }
      
      private function rollout(e:MouseEvent) : void
      {
         this._rollOver = false;
         this.invalidate();
      }
      
      private function mousedown(e:MouseEvent) : void
      {
         this._mouseDown = true;
         this.invalidate();
         stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp,true);
      }
      
      private function click(e:MouseEvent) : void
      {
         if(this.enabled)
         {
            if(this.callBack != null)
            {
               this.callBack.call(null,e);
            }
         }
         this.invalidate();
      }
      
      public function get labelTF() : MyTextField
      {
         return this._textField;
      }
      
      protected function onStageMouseUp(e:Event) : void
      {
         if(Boolean(stage))
         {
            stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp,true);
         }
         this._mouseDown = false;
         this.invalidate();
      }
      
      public function invalidate() : void
      {
         if(this._needReneder)
         {
            return;
         }
         addEventListener(Event.EXIT_FRAME,this._render);
      }
      
      public function setOtherDisabledSkin(style:String) : void
      {
         this._style = style;
         this._bmp.bitmapData = ComponentUtil.getBitmapData(style + "_disabled",this._dm);
      }
      
      protected function _render(e:Event) : void
      {
         this._needReneder = false;
         removeEventListener(Event.EXIT_FRAME,this._render);
         if(this._enabled)
         {
            if(this._rollOver)
            {
               if(this._mouseDown)
               {
                  this._bmp.bitmapData = this._downStyle;
               }
               else
               {
                  this._bmp.bitmapData = this._overStyle;
               }
               this._textField.color = this._textOverColor;
            }
            else
            {
               this._bmp.bitmapData = this._upStyle;
               this._textField.color = this._textColor;
            }
         }
         else
         {
            this._bmp.bitmapData = ComponentUtil.getBitmapData(this._style + "_disabled",this._dm);
            this._textField.color = this._textDisabledColor;
         }
         this._textField.size = this._textSize;
         if(this._needResizeLabel)
         {
            this._textField.htmlText = this._label;
            this._textField.x = this._tx;
            this._textField.y = this._ty;
         }
         else
         {
            this._textField.htmlText = this._label;
            this._textField.x = (this._bmp.width - this._textField.width) / 2;
            this._textField.y = (this._bmp.height - this._textField.height) / 2;
         }
      }
   }
}

