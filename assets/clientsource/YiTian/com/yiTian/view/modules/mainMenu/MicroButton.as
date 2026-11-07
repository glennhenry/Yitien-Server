package com.yiTian.view.modules.mainMenu
{
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.manager.TipManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   
   public class MicroButton extends Sprite
   {
      
      public static const FROM_QUEST:int = 1;
      
      public static const FROM_LEVEL:int = 2;
      
      private var icon:Bitmap;
      
      private var _tip:String;
      
      private var _colorTransform:ColorTransform;
      
      private var _visType:int;
      
      private var _visValue:int;
      
      private var _stype:String;
      
      private var _target:DisplayObject;
      
      public function MicroButton(url:String, tip:String = "")
      {
         super();
         this._tip = tip;
         this.icon = ComponentUtil.getBitmap(url,this,null,Global.Img_Cdm);
         this._stype = url;
         var shape:Shape = new Shape();
         shape.graphics.beginFill(0,0);
         shape.graphics.drawRect(0,0,this.icon.width,this.icon.height);
         addChildAt(shape,0);
         addEventListener(MouseEvent.ROLL_OVER,this.over);
         addEventListener(MouseEvent.ROLL_OUT,this.rollOut);
         addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDown);
         addEventListener(MouseEvent.MOUSE_UP,this.over);
         addEventListener(MouseEvent.CLICK,this.click);
         if(this._tip != "")
         {
            TipManager.bind(this,this._tip);
         }
         this.buttonMode = true;
      }
      
      public function getIconBMD() : BitmapData
      {
         return this.icon.bitmapData;
      }
      
      public function setVisValue(type:int, value:int) : void
      {
         this._visType = type;
         this._visValue = value;
      }
      
      public function get visType() : int
      {
         return this._visType;
      }
      
      public function get visValue() : int
      {
         return this._visValue;
      }
      
      public function set enabled(boo:Boolean) : void
      {
         this.mouseEnabled = boo;
         this.buttonMode = boo;
         if(!boo)
         {
            this.filters = Util.disabled;
         }
         else
         {
            this.filters = null;
         }
      }
      
      private function rollOut(e:MouseEvent) : void
      {
         this.icon.y = 0;
         filters = [];
      }
      
      private function mouseDown(e:MouseEvent) : void
      {
         this.icon.y = 0;
      }
      
      public function set bind(target:DisplayObject) : void
      {
         this._target = target;
      }
      
      private function click(e:MouseEvent) : void
      {
         if(Boolean(this._target))
         {
            this._target.visible = !this._target.visible;
         }
      }
      
      private function over(e:MouseEvent) : void
      {
         this.icon.y = -4;
         filters = Util.glowFFFF00;
      }
      
      public function get colorTransform() : ColorTransform
      {
         return transform.colorTransform;
      }
      
      public function get redOffset() : int
      {
         return transform.colorTransform.redOffset;
      }
      
      public function get greenOffset() : int
      {
         return transform.colorTransform.greenOffset;
      }
      
      public function get blueOffset() : int
      {
         return transform.colorTransform.blueOffset;
      }
      
      public function set greenOffset(value:int) : void
      {
         if(!this._colorTransform)
         {
            this._colorTransform = new ColorTransform();
         }
         this._colorTransform.greenOffset = value;
         transform.colorTransform = this._colorTransform;
      }
      
      public function set blueOffset(value:int) : void
      {
         if(!this._colorTransform)
         {
            this._colorTransform = new ColorTransform(1,1,1,1,0,0,0);
         }
         this._colorTransform.blueOffset = value;
         transform.colorTransform = this._colorTransform;
      }
      
      public function set redOffset(value:int) : void
      {
         if(!this._colorTransform)
         {
            this._colorTransform = new ColorTransform(1,1,1,1,0,0,0);
         }
         this._colorTransform.redOffset = value;
         transform.colorTransform = this._colorTransform;
      }
      
      public function get sourStype() : String
      {
         return this._stype;
      }
   }
}

