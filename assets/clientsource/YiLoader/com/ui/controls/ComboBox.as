package com.ui.controls
{
   import com.ui.containers.Canvas;
   import com.utils.ComponentUtil;
   import com.utils.DmManager;
   import com.utils.Util;
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.ui.Keyboard;
   
   public class ComboBox extends Sprite
   {
      
      private static var nowComboBox:ComboBox;
      
      public static const LABEL:int = 0;
      
      public static const VALUE:int = 1;
      
      private static const HEIGHT_CTRL:int = 24;
      
      private var pool:Array = [];
      
      private var items:Array = [];
      
      private var titleItem:ComboxItem;
      
      private var titleBtn:Button;
      
      private var back:ScaleBitmap;
      
      private var container:Canvas;
      
      private var _highlight:DisplayObject;
      
      private var _selIndex:int;
      
      private var _selValue:Object;
      
      private var _selFun:Function;
      
      private var _itemWid:int;
      
      private var _height:int;
      
      private var _source:Array;
      
      private var START_WIDTH:int;
      
      private var nowY:int;
      
      public function ComboBox(sour:Array, selFun:Function = null, _width:int = 75, _btnStyle:String = "Button_PageDown", _kuangStyle:String = "kuangBg", _overStyle:String = "xuanze_over", set_height:int = 85)
      {
         super();
         this._selFun = selFun;
         this._itemWid = _width;
         this._height = set_height;
         this.back = ComponentUtil.getScaleBitmap("Back_List",[5,5,2,2],null,{
            "width":_width + 4,
            "height":set_height + 4
         });
         this.titleItem = new ComboxItem("",0,0,_width,0);
         this.titleItem.y = 3;
         this.titleItem.addEventListener(MouseEvent.MOUSE_DOWN,this.setVisible);
         addChild(this.titleItem);
         this.titleBtn = ComponentUtil.getButton("",_btnStyle,this,{
            "x":_width - 30 - 3 + 13,
            "y":1
         },DmManager.Img_Cdm);
         this.titleBtn.addEventListener(MouseEvent.MOUSE_DOWN,this.setVisible);
         addChild(this.titleBtn);
         this.START_WIDTH = _width + 19;
         this.container = new Canvas(_width - 3,set_height,"RIGHT");
         this.container.addEventListener(MouseEvent.ROLL_OVER,rollEvent);
         this.container.addEventListener(MouseEvent.ROLL_OUT,rollEvent);
         this._highlight = ComponentUtil.getDisplayObject("ButtonListBG_up",null,{"width":_width});
         this._highlight.blendMode = BlendMode.SCREEN;
         this.source = sour;
      }
      
      private static function rollEvent(e:MouseEvent) : void
      {
         Util.isOnUI = e.type == MouseEvent.ROLL_OVER;
      }
      
      public function set source(value:Array) : void
      {
         this._source = value;
         this.clear();
         if(!this._source)
         {
            return;
         }
         var i:int = 0;
         while(i < this._source.length)
         {
            this.addItem(this._source[i],i,this._itemWid);
            i++;
         }
         this.align();
      }
      
      private function addItem(data:Array, index:int, wid:int) : void
      {
         var item:ComboxItem = null;
         if(Boolean(this.pool.length))
         {
            item = this.pool.pop();
            item.text = data[LABEL];
            item.value = data[VALUE];
            item.index = index;
            item.width = wid;
         }
         else
         {
            item = new ComboxItem(data[LABEL],data[VALUE],index,wid);
         }
         item.addEventListener(MouseEvent.MOUSE_DOWN,this.selItem);
         item.addEventListener(MouseEvent.ROLL_OVER,this.over);
         item.addEventListener(MouseEvent.ROLL_OUT,this.out);
         this.container.addChild(item);
         this.items.push(item);
      }
      
      private function align() : void
      {
         var item:ComboxItem = null;
         this.nowY = 0;
         var i:int = 0;
         while(i < this.items.length)
         {
            item = this.items[i] as ComboxItem;
            item.y = this.nowY;
            this.nowY += 20;
            i++;
         }
         this.container.align();
         this.back.height = (this._height < this.nowY ? this._height : this.nowY) + 4;
      }
      
      public function clear() : void
      {
         var item:ComboxItem = null;
         var i:int = this.items.length - 1;
         while(i >= 0)
         {
            item = this.items[i] as ComboxItem;
            item.removeEventListener(MouseEvent.MOUSE_DOWN,this.selItem);
            item.removeEventListener(MouseEvent.ROLL_OVER,this.over);
            item.removeEventListener(MouseEvent.ROLL_OUT,this.out);
            if(this.container.contains(item))
            {
               this.container.removeChild(item);
            }
            this.items.splice(i,1);
            this.pool.push(item);
            i--;
         }
      }
      
      private function setVisible(e:MouseEvent) : void
      {
         this.showHidePop();
         e.stopPropagation();
      }
      
      public function showHidePop(value:int = -1) : void
      {
         if(Boolean(nowComboBox) && nowComboBox != this)
         {
            nowComboBox.showHidePop(0);
         }
         if(!Util.stage.contains(this.container) && value == -1)
         {
            Util.point.x = 0;
            Util.point.y = HEIGHT_CTRL;
            Util.point = this.localToGlobal(Util.point);
            this.container.x = Util.point.x;
            this.container.y = Util.point.y;
            this.back.x = Util.point.x - 2;
            this.back.y = Util.point.y - 2;
            Util.stage.addChild(this.back);
            Util.stage.addChild(this.container);
            Util.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.stageClick);
            Util.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.stageKeyDown);
            nowComboBox = this;
         }
         else
         {
            Util.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.stageClick);
            Util.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.stageKeyDown);
            if(Util.stage.contains(this.back))
            {
               Util.stage.removeChild(this.back);
            }
            if(Util.stage.contains(this.container))
            {
               Util.stage.removeChild(this.container);
            }
            nowComboBox = null;
         }
      }
      
      private function stageKeyDown(e:KeyboardEvent) : void
      {
         if(e.keyCode == Keyboard.DOWN)
         {
            this.select(++this._selIndex > this._source.length - 1 ? (this._selIndex = this._source.length - 1) : this._selIndex);
            if(this._selFun != null)
            {
               this._selFun(this._selValue);
            }
         }
         if(e.keyCode == Keyboard.UP)
         {
            this.select(--this._selIndex < 0 ? (this._selIndex = 0) : this._selIndex);
            if(this._selFun != null)
            {
               this._selFun(this._selValue);
            }
         }
         if(e.keyCode == Keyboard.ENTER)
         {
            this.stageClick();
         }
      }
      
      private function stageClick(e:MouseEvent = null) : void
      {
         if(Util.stage.contains(this.container))
         {
            this.showHidePop(0);
         }
         if(Boolean(e))
         {
            e.stopPropagation();
         }
      }
      
      public function set containerWidth(_num:int) : void
      {
         this.container.width = _num;
      }
      
      public function get drag_bar_vis() : Boolean
      {
         return this.container.dragbarVis;
      }
      
      private function over(e:MouseEvent) : void
      {
         var cbi:ComboxItem = e.target as ComboxItem;
         cbi.addChild(this._highlight);
         e.stopPropagation();
      }
      
      private function out(e:MouseEvent) : void
      {
         var cbi:ComboxItem = e.target as ComboxItem;
         if(cbi.contains(this._highlight))
         {
            cbi.removeChild(this._highlight);
         }
         e.stopPropagation();
      }
      
      private function selItem(e:MouseEvent) : void
      {
         this._selIndex = (e.target as ComboxItem).index;
         this._selValue = (e.target as ComboxItem).value;
         this.titleItem.index = this._selIndex;
         this.titleItem.value = this._selValue;
         this.titleItem.text = (e.target as ComboxItem).text;
         if(this._selFun != null)
         {
            this._selFun(this._selValue);
         }
         this.showHidePop(0);
         e.stopPropagation();
      }
      
      public function get selIndex() : int
      {
         return this._selIndex;
      }
      
      public function get selValue() : Object
      {
         return this._selValue;
      }
      
      public function set defaultText(Str:String) : void
      {
         this.titleItem.text = Str;
      }
      
      public function select(value:Object) : void
      {
         var i:int = 0;
         while(i < this._source.length)
         {
            if(this._source[i][VALUE] == value)
            {
               this._selIndex = i;
               this._selValue = value;
               this.titleItem.text = this._source[i][LABEL];
               this.titleItem.addChild(this._highlight);
               break;
            }
            i++;
         }
      }
      
      public function getTitle() : String
      {
         return this.titleItem.text;
      }
      
      public function dispose() : void
      {
         var item:ComboxItem = null;
         this.titleItem.removeEventListener(MouseEvent.MOUSE_DOWN,this.setVisible);
         removeChild(this.titleBtn);
         removeChild(this.titleItem);
         while(Boolean(this.container.numChildren))
         {
            item = this.container.getChildAt(0) as ComboxItem;
            item.removeEventListener(MouseEvent.MOUSE_DOWN,this.selItem);
            item.removeEventListener(MouseEvent.ROLL_OVER,this.over);
            item.removeEventListener(MouseEvent.ROLL_OUT,this.out);
            item.dispose();
         }
         removeChild(this._highlight);
         removeChild(this.container);
      }
   }
}

import com.utils.ColorConstant;
import com.utils.ComponentUtil;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.text.TextField;

class ComboxItem extends Sprite
{
   
   private var label:TextField;
   
   private var _text:String;
   
   private var _value:Object;
   
   private var _index:int;
   
   public function ComboxItem(text:String, value:Object, index:int, width:int, _alpha:Number = 0.5)
   {
      super();
      this.buttonMode = true;
      this.mouseChildren = false;
      this._text = text;
      this._value = value;
      this._index = index;
      this.label = ComponentUtil.getTextField(text,null,{
         "color":ColorConstant.getColorInt(1),
         "realWidth":width,
         "height":20,
         "x":5,
         "y":-1
      });
      this.label.text = text;
      addChild(this.label);
   }
   
   override public function set width(value:Number) : void
   {
      this.label.width = value;
      super.width = value;
   }
   
   public function get index() : int
   {
      return this._index;
   }
   
   public function set index(value:int) : void
   {
      this._index = value;
   }
   
   public function get text() : String
   {
      return this._text;
   }
   
   public function set text(value:String) : void
   {
      this._text = this.label.text = value;
   }
   
   public function get value() : Object
   {
      return this._value;
   }
   
   public function set value(valu:Object) : void
   {
      this._value = valu;
   }
   
   public function dispose() : void
   {
      var child:DisplayObject = null;
      while(Boolean(numChildren))
      {
         child = getChildAt(0);
         removeChild(child);
      }
   }
}
