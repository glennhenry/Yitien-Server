package com.ui.controls
{
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class RadioButtonGroup extends Sprite
   {
      
      public static var SELECTED_CHANGE:String = "selected change";
      
      public static var VERTICAL:String = "vertical";
      
      public static var HORIZONTAL:String = "horizontal";
      
      private var defaultItemWidth:Number = 80;
      
      private var defaultItemHeight:Number = 25;
      
      private var items:Array;
      
      private var _selectedItem:RadioButton;
      
      private var _selectedIndex:int = -1;
      
      private var _space:Number = 5;
      
      private var _direction:String = HORIZONTAL;
      
      public function RadioButtonGroup()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         this.items = new Array();
      }
      
      public function get selectedItem() : RadioButton
      {
         if(Boolean(this.items[this._selectedIndex]))
         {
            return this.items[this._selectedIndex];
         }
         return null;
      }
      
      public function set selectedItem(value:RadioButton) : void
      {
         if(value == null || value.parent != this)
         {
            return;
         }
         this.clear(value);
      }
      
      public function get selectedIndex() : int
      {
         return this._selectedIndex;
      }
      
      public function set selectedIndex(value:int) : void
      {
         if(this.items.length <= value || value < 0)
         {
            return;
         }
         this.selectedItem = this.getByIndex(value);
      }
      
      public function addItem(item:RadioButton) : void
      {
         if(item.parent == this)
         {
            return;
         }
         addChild(item);
         this.items.push(item);
         item.addEventListener(RadioButton.SELECTED,this.onChange);
         this.updateDisplayList();
      }
      
      private function onChange(evt:Event) : void
      {
         var target:RadioButton = evt.target as RadioButton;
         if(target != null)
         {
            this.clear(target);
         }
         this.dispatchEvent(new Event(SELECTED_CHANGE));
      }
      
      public function set space(value:Number) : void
      {
         if(this._space == value)
         {
            return;
         }
         this._space = value;
         this.updateDisplayList();
      }
      
      public function get space() : Number
      {
         return this._space;
      }
      
      public function set direction(value:String) : void
      {
         if(value != HORIZONTAL && value != VERTICAL)
         {
            return;
         }
         if(this._direction == value)
         {
            return;
         }
         this._direction = value;
         this.updateDisplayList();
      }
      
      public function get direction() : String
      {
         return this._direction;
      }
      
      override public function set width(value:Number) : void
      {
         if(super.width == value)
         {
            return;
         }
         super.width = value;
      }
      
      override public function set height(value:Number) : void
      {
         if(super.height == value)
         {
            return;
         }
         super.height = value;
      }
      
      public function getByIndex(index:int) : RadioButton
      {
         if(this.items.length <= index || index < 0)
         {
            return null;
         }
         return this.items[index] as RadioButton;
      }
      
      public function getRadioButtonNum() : int
      {
         return this.items.length;
      }
      
      private function clear(rb:RadioButton) : void
      {
         var button:RadioButton = null;
         for each(button in this.items)
         {
            if(button != rb)
            {
               button.selected = false;
            }
         }
         if(Boolean(rb))
         {
            this._selectedIndex = this.items.indexOf(rb);
            rb.selected = true;
         }
      }
      
      public function reset() : void
      {
         this.clear(null);
      }
      
      protected function updateDisplayList() : void
      {
         var num:int = this.getRadioButtonNum();
         if(num > 0)
         {
            if(this._direction == HORIZONTAL)
            {
               this.width = this.width == 0 ? this.getDefaultWidth() : this.width;
               this.height = this.height == 0 ? this.defaultItemHeight : this.height;
            }
            else
            {
               this.width = this.width == 0 ? this.defaultItemWidth : this.width;
               this.height = this.height == 0 ? this.getDefaultHeight() : this.height;
            }
            this.layout();
         }
      }
      
      private function layout() : void
      {
         var item:RadioButton = null;
         var num:int = this.getRadioButtonNum();
         var itemWidth:Number = (this.width - (num - 1) * this.space) / num;
         var itemHeight:Number = (this.height - (num - 1) * this.space) / num;
         var i:int = 0;
         while(i < this.items.length)
         {
            item = this.items[i] as RadioButton;
            if(this._direction == HORIZONTAL)
            {
               item.x = (itemWidth + this.space) * i;
               item.height = this.height;
               item.y = 0;
            }
            else
            {
               item.y = (itemHeight + this.space) * i;
               item.x = 0;
               item.width = this.width;
            }
            i++;
         }
      }
      
      private function getDefaultWidth() : Number
      {
         return this.defaultItemWidth * this.getRadioButtonNum() + this.space * (this.getRadioButtonNum() - 1);
      }
      
      private function getDefaultHeight() : Number
      {
         return this.defaultItemHeight * this.getRadioButtonNum() + this.space * (this.getRadioButtonNum() - 1);
      }
   }
}

