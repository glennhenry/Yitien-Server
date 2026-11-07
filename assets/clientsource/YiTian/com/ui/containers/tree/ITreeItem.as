package com.ui.containers.tree
{
   import com.utils.ComponentUtil;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ITreeItem extends Sprite
   {
      
      public static var itemHeight:int = 22;
      
      private var _click:Function;
      
      private var _overFun:Function;
      
      private var _outFun:Function;
      
      private var _data:Object;
      
      public function ITreeItem(wid:int)
      {
         super();
         addChild(ComponentUtil.getShape(wid,itemHeight,0,0));
         this.addEventListener(MouseEvent.MOUSE_OVER,this.mouseOver);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.mouseOut);
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDown);
      }
      
      public function init(data:Object, selFun:Function, overFun:Function, outFun:Function) : void
      {
         this.data = data;
         this._click = selFun;
         this._overFun = overFun;
         this._outFun = outFun;
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function set data(value:Object) : void
      {
         this._data = value;
      }
      
      public function mouseOver(evt:MouseEvent) : void
      {
         if(this._overFun != null)
         {
            this._overFun(this);
         }
      }
      
      public function mouseOut(evt:MouseEvent) : void
      {
         if(this._outFun != null)
         {
            this._outFun(this);
         }
      }
      
      public function mouseDown(e:MouseEvent) : void
      {
         if(this._click != null)
         {
            this._click(this);
         }
      }
      
      public function dispose() : void
      {
         this._data = null;
         this._overFun = null;
         this._outFun = null;
         this._click = null;
      }
   }
}

