package com.ui.containers.list
{
   import com.ui.containers.Canvas;
   import com.utils.ComponentUtil;
   import com.utils.DmManager;
   import flash.display.Bitmap;
   import flash.display.BlendMode;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class List extends Canvas
   {
      
      public static const TYPE_NO_STATE:int = -1;
      
      public static const TYPE_NORMAL:int = 0;
      
      public static const TYPE_SELECT:int = 1;
      
      private var pool:Array = [];
      
      private var items:Array = [];
      
      private var _itemClass:Class;
      
      private var _source:Array;
      
      private var _selFun:Function;
      
      private var _highlight:Bitmap;
      
      private var _selBM:Bitmap;
      
      private var _selectedItem:IListItem;
      
      private var _nSelectFlag:int;
      
      private var _fieldName:Object;
      
      private var _options:Object;
      
      public function List(wid:int, hei:int, itemClass:Class, selFun:Function = null, nSelectFlag:int = 0, scrollDerect:String = "RIGHT")
      {
         super(wid,hei,scrollDerect);
         this._nSelectFlag = nSelectFlag;
         this._itemClass = itemClass;
         this._selFun = selFun;
         if(nSelectFlag != TYPE_NO_STATE)
         {
            this._highlight = new Bitmap(ComponentUtil.getBitmapData("tree_select",DmManager.New_Imgsdm));
            this._highlight.height = 18;
            this._highlight.blendMode = BlendMode.SCREEN;
            this._highlight.visible = false;
            addChild(this._highlight);
            this._highlight.x = 0;
            this._highlight.y = 2;
            if(nSelectFlag == TYPE_SELECT)
            {
               this._selBM = new Bitmap(ComponentUtil.getBitmapData("tree_select",DmManager.New_Imgsdm));
               this._selBM.height = 18;
               this._selBM.blendMode = BlendMode.SCREEN;
               this._selBM.visible = false;
               addChild(this._selBM);
               this._selBM.x = 0;
               this._selBM.y = 2;
            }
         }
      }
      
      public function set callBack(selFun:Function) : void
      {
         this._selFun = selFun;
      }
      
      public function set source(sour:Array) : void
      {
         var item:Sprite = null;
         this._source = sour;
         this.clear();
         if(!sour.length)
         {
            return;
         }
         var i:int = 0;
         while(i < this._source.length)
         {
            item = Boolean(this.pool.length) ? this.pool.pop() : new this._itemClass();
            (item as this._itemClass).data = this._source[i];
            item.visible = true;
            item.addEventListener(MouseEvent.MOUSE_DOWN,this.down);
            item.addEventListener(MouseEvent.CLICK,this.selItem);
            item.addEventListener(MouseEvent.ROLL_OVER,this.over);
            item.addEventListener(MouseEvent.ROLL_OUT,this.out);
            addChild(item);
            this.items.push(item);
            i++;
         }
         if(Boolean(item))
         {
            if(Boolean(this._highlight))
            {
               this._highlight.width = item.width;
            }
            if(Boolean(this._selBM))
            {
               this._selBM.width = item.width;
            }
         }
         this.reSort();
      }
      
      public function setSort(fieldName:Object, options:Object = null) : void
      {
         this._fieldName = fieldName;
         this._options = options;
      }
      
      private function reSort() : void
      {
         if(this._fieldName != null)
         {
            this.items.sortOn(this._fieldName,this._options);
         }
         this.align();
      }
      
      public function sortOn(fieldName:Object, options:Object = null) : Array
      {
         this.setSort(fieldName,options);
         var arrayData:Array = this._source.sortOn(fieldName,options);
         this.reSort();
         return arrayData;
      }
      
      public function updateItem(index:int, itemData:Object, isCallBack:Boolean = false) : void
      {
         var item:Sprite = this.items[index];
         (item as this._itemClass).data = itemData;
         (item as this._itemClass).updata();
         if(isCallBack)
         {
            this.updateFunc();
         }
      }
      
      private function updateFunc() : void
      {
         var item:Sprite = null;
         var i:int = 0;
         while(i < this.items.length)
         {
            item = this.items[i];
            (item as this._itemClass).updataFunc();
            i++;
         }
      }
      
      public function addItem(index:int, itemData:Object) : void
      {
         var item:Sprite = null;
         item = Boolean(this.pool.length) ? this.pool.pop() : new this._itemClass();
         (item as this._itemClass).data = itemData;
         item.addEventListener(MouseEvent.MOUSE_DOWN,this.down);
         item.addEventListener(MouseEvent.CLICK,this.selItem);
         item.addEventListener(MouseEvent.ROLL_OVER,this.over);
         item.addEventListener(MouseEvent.ROLL_OUT,this.out);
         addChild(item);
         this.items.splice(index,0,item);
         if(!this._source)
         {
            this._source = [];
         }
         this._source.splice(index,0,itemData);
         this._selBM.width = this._highlight.width = item.width;
         this.reSort();
      }
      
      public function changeItem(index:int, itemData:Object) : void
      {
         (this.items[index] as this._itemClass).data = itemData;
         this._source[index] = itemData;
         this.reSort();
      }
      
      public function getItem(indexData:int, value:Object) : Object
      {
         var i:int = 0;
         while(i < this.items.length)
         {
            if((this.items[i] as this._itemClass).data)
            {
               if((this.items[i] as this._itemClass).data[indexData] == value)
               {
                  return {
                     "item":this.items[i] as this._itemClass,
                     "index":i
                  };
               }
            }
            i++;
         }
         return null;
      }
      
      override public function set scrollAutoType(value:int) : void
      {
         super.scrollAutoType = value;
      }
      
      public function removeItem(index:int) : void
      {
         var item:Sprite = this.items[index];
         item.removeEventListener(MouseEvent.MOUSE_DOWN,this.down);
         item.removeEventListener(MouseEvent.CLICK,this.selItem);
         item.removeEventListener(MouseEvent.ROLL_OVER,this.over);
         item.removeEventListener(MouseEvent.ROLL_OUT,this.out);
         if(item == this._selectedItem)
         {
            this._selectedItem = null;
            this._selBM.visible = false;
         }
         if(Boolean(this._highlight))
         {
            if(item.contains(this._highlight))
            {
               item.removeChild(this._highlight);
            }
         }
         if(Boolean(this._selBM))
         {
            if(item.contains(this._selBM))
            {
               item.removeChild(this._selBM);
            }
         }
         (item as this._itemClass).dispose();
         removeChild(item);
         this.pool.push(item);
         this.items.splice(index,1);
         if(Boolean(this._source))
         {
            this._source.splice(index,1);
         }
         this.reSort();
      }
      
      public function get length() : int
      {
         return this.items.length;
      }
      
      override public function align() : void
      {
         var nowY:int = 0;
         var i:int = 0;
         while(i < this.items.length)
         {
            this.items[i].y = nowY;
            nowY += this.items[i].height;
            i++;
         }
         super.align();
      }
      
      private function clear() : void
      {
         this._selectedItem = null;
         if(Boolean(this._selBM))
         {
            this._selBM.visible = false;
         }
         if(Boolean(this._highlight))
         {
            this._highlight.visible = false;
         }
         var i:int = this.items.length - 1;
         while(i >= 0)
         {
            this.items[i].removeEventListener(MouseEvent.MOUSE_DOWN,this.down);
            this.items[i].removeEventListener(MouseEvent.CLICK,this.selItem);
            this.items[i].removeEventListener(MouseEvent.ROLL_OVER,this.over);
            this.items[i].removeEventListener(MouseEvent.ROLL_OUT,this.out);
            if(Boolean(this._highlight) && Boolean(this.items[i].contains(this._highlight)))
            {
               this.items[i].removeChild(this._highlight);
            }
            if(Boolean(this._selBM) && Boolean(this.items[i].contains(this._selBM)))
            {
               this.items[i].removeChild(this._selBM);
            }
            this.items[i].dispose();
            removeChild(this.items[i]);
            this.pool.push(this.items[i]);
            this.items.splice(i,1);
            i--;
         }
      }
      
      private function over(e:MouseEvent) : void
      {
         if(!(e.target is IListItem))
         {
            return;
         }
         if(this._nSelectFlag == List.TYPE_NO_STATE)
         {
            return;
         }
         e.target.addChildAt(this._highlight,0);
      }
      
      private function out(e:MouseEvent) : void
      {
         if(!(e.target is IListItem))
         {
            return;
         }
         if(this._nSelectFlag == List.TYPE_NO_STATE)
         {
            return;
         }
         if(Boolean(e.target.contains(this._highlight)))
         {
            e.target.removeChild(this._highlight);
         }
      }
      
      private function down(e:MouseEvent) : void
      {
         if(!(e.target is IListItem))
         {
            return;
         }
         if(this._nSelectFlag != List.TYPE_SELECT)
         {
            return;
         }
         this._selBM.y = e.target.y + 2;
         this._selectedItem = e.target as IListItem;
      }
      
      public function getItems() : Array
      {
         return this.items;
      }
      
      public function getSelectedItem() : IListItem
      {
         return this._selectedItem;
      }
      
      public function getOptions() : Object
      {
         return this._options;
      }
      
      private function selItem(e:MouseEvent) : void
      {
         if(!(e.target is IListItem))
         {
            return;
         }
         if(this._selFun != null)
         {
            this._selFun(e.target.data);
         }
      }
      
      public function setSelect(index:int) : void
      {
         (this.items[index] as IListItem).dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
      }
      
      public function dispose() : void
      {
         this.clear();
         if(contains(this._selBM))
         {
            removeChild(this._selBM);
         }
         if(contains(this._highlight))
         {
            removeChild(this._highlight);
         }
      }
   }
}

