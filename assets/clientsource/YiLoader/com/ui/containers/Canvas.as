package com.ui.containers
{
   import com.ui.controls.ScrollBar;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class Canvas extends Sprite
   {
      
      private var contentPane:Container;
      
      private var vScrollBar:ScrollBar;
      
      private var _vScrollPolicy:String = "auto";
      
      private var _scrollDirection:String;
      
      private var _explicitWidth:int;
      
      private var _explicitHeight:int;
      
      private var _isThumbBar:String = "ScrollBar_drag";
      
      public function Canvas(wid:int, hei:int, scrollDirection:String = "RIGHT", setWidth:int = 0)
      {
         super();
         this._explicitWidth = wid;
         this._explicitHeight = hei;
         this._scrollDirection = scrollDirection;
         this.init(setWidth);
      }
      
      private function init(_wid:int) : void
      {
         this.contentPane = new Container();
         super.addChild(this.contentPane);
         this.vScrollBar = new ScrollBar(this._scrollDirection);
         this.vScrollBar.scrollRectWidth = this._explicitWidth - ScrollBar.WIDTH + _wid;
         this.vScrollBar.scrollRectHeight = this._explicitHeight;
         this.vScrollBar.addEventListener(MouseEvent.MOUSE_DOWN,this.scrollBarbDonw);
         super.addChild(this.vScrollBar);
         this.vScrollBar.bind(this.contentPane);
      }
      
      public function reset() : void
      {
         this.vScrollBar.re_set();
      }
      
      private function scrollBarbDonw(e:MouseEvent) : void
      {
         e.stopPropagation();
      }
      
      public function get dragbarVis() : Boolean
      {
         return this.vScrollBar.dragBarVis;
      }
      
      public function set scrollAutoType(value:int) : void
      {
         this.vScrollBar.scrollAutoType = value;
      }
      
      public function set lock(value:Boolean) : void
      {
         this.vScrollBar.lock = value;
      }
      
      public function get lock() : Boolean
      {
         return this.vScrollBar.lock;
      }
      
      public function align() : void
      {
         this.contentPane.align();
      }
      
      override public function set width(value:Number) : void
      {
         if(this._explicitWidth != value)
         {
            this._explicitWidth = value;
            super.width = this._explicitWidth;
         }
      }
      
      public function set ThumbBa(thumbBarStr:String) : void
      {
         this._isThumbBar = thumbBarStr;
         this.vScrollBar.ThumbBa = this._isThumbBar;
      }
      
      override public function get width() : Number
      {
         return this._explicitWidth;
      }
      
      override public function set height(value:Number) : void
      {
         if(this._explicitHeight != value)
         {
            this._explicitHeight = value;
            super.height = this._explicitHeight;
         }
      }
      
      override public function get height() : Number
      {
         return this._explicitHeight;
      }
      
      public function removeAllChildren() : void
      {
         while(this.numChildren > 0)
         {
            this.removeChildAt(0);
         }
      }
      
      override public function get numChildren() : int
      {
         return this.contentPane.numChildren;
      }
      
      override public function addChild(child:DisplayObject) : DisplayObject
      {
         this.contentPane.addChild(child);
         return child;
      }
      
      override public function addChildAt(child:DisplayObject, index:int) : DisplayObject
      {
         this.contentPane.addChildAt(child,index);
         return child;
      }
      
      override public function removeChild(child:DisplayObject) : DisplayObject
      {
         if(child.parent == this.contentPane)
         {
            this.contentPane.removeChild(child);
         }
         else if(child.parent == this)
         {
            this.removeSuperChild(child);
         }
         return child;
      }
      
      override public function removeChildAt(index:int) : DisplayObject
      {
         return this.contentPane.removeChildAt(index);
      }
      
      override public function getChildAt(index:int) : DisplayObject
      {
         return this.contentPane.getChildAt(index);
      }
      
      override public function getChildByName(name:String) : DisplayObject
      {
         return this.contentPane.getChildByName(name);
      }
      
      override public function getChildIndex(child:DisplayObject) : int
      {
         if(child.parent == this)
         {
            return super.getChildIndex(child);
         }
         return this.contentPane.getChildIndex(child);
      }
      
      public function addChildToSuper(child:DisplayObject) : void
      {
         super.addChild(child);
      }
      
      public function removeSuperChild(child:DisplayObject) : void
      {
         super.removeChild(child);
      }
      
      override public function set mouseEnabled(enabled:Boolean) : void
      {
         this.contentPane.mouseEnabled = enabled;
         super.mouseEnabled = enabled;
      }
      
      public function getAllChildren() : Array
      {
         var children:Array = [];
         var i:int = 0;
         while(i < this.numChildren)
         {
            children.push(this.contentPane.getChildAt(i));
            i++;
         }
         return children;
      }
      
      public function setScrollView(per:Number) : void
      {
         this.vScrollBar.setValue(per);
      }
   }
}

import com.event.ResizeEvent;
import flash.display.DisplayObject;
import flash.display.Sprite;

class Container extends Sprite
{
   
   private var _hei:Number;
   
   public function Container()
   {
      super();
   }
   
   public function align() : void
   {
      this.calculateHeight();
      dispatchEvent(new ResizeEvent(ResizeEvent.RESIZE));
   }
   
   private function calculateHeight() : void
   {
      var child:DisplayObject = null;
      var size:int = int(numChildren);
      this._hei = 0;
      var i:int = 0;
      while(i < size)
      {
         child = getChildAt(i);
         this._hei = Math.max(this._hei,child.y + child.height);
         i++;
      }
   }
   
   override public function get height() : Number
   {
      return this._hei;
   }
}
