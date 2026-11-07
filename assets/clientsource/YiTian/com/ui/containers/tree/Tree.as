package com.ui.containers.tree
{
   import com.ui.constants.ScrollAutoType;
   import com.ui.containers.Canvas;
   import com.ui.controls.ScrollBar;
   import com.utils.ComponentUtil;
   import flash.display.Bitmap;
   import flash.display.BlendMode;
   import flash.utils.Dictionary;
   
   public class Tree extends Canvas
   {
      
      public var pool:Array = [];
      
      private var _backGround:Bitmap;
      
      private var _highlight:Bitmap;
      
      private var paraArr:Array = [];
      
      private var _selFun:Function;
      
      private var _overFun:Function;
      
      private var _outFun:Function;
      
      private var _selItem:ITreeItem;
      
      private var _overitem:ITreeItem;
      
      private var _itemClass:Class;
      
      private var _isNeedSelBg:Boolean = true;
      
      private var nowY:int;
      
      public function Tree(wid:int, hei:int, itemClass:Class, types:Array, selfun:Function, overfun:Function = null, outfun:Function = null)
      {
         var para:TreePara = null;
         super(wid,hei,ScrollBar.RIGHT);
         scrollAutoType = ScrollAutoType.TO_TOP;
         this._itemClass = itemClass;
         this._selFun = selfun;
         this._overFun = overfun;
         this._outFun = outfun;
         this._backGround = new Bitmap(ComponentUtil.getBitmapData("tree_select"));
         this._backGround.scaleX = wid / this._backGround.width;
         this._backGround.blendMode = BlendMode.SCREEN;
         this._backGround.visible = false;
         this._backGround.x = -10;
         addChild(this._backGround);
         this._highlight = new Bitmap(ComponentUtil.getBitmapData("tree_select"));
         this._highlight.scaleX = wid / this._highlight.width;
         this._highlight.blendMode = BlendMode.SCREEN;
         this._highlight.visible = false;
         this._highlight.x = -10;
         addChild(this._highlight);
         var i:int = 0;
         while(i < types.length)
         {
            para = new TreePara(wid,types[i][1],this.align,this);
            addChild(para);
            this.paraArr[types[i][0]] = para;
            i++;
         }
      }
      
      public function getTreeItem() : ITreeItem
      {
         return Boolean(this.pool.length) ? this.pool.pop() : new this._itemClass(width - 30);
      }
      
      public function init(source:Dictionary) : void
      {
         var data:Object = null;
         this.clear();
         for each(data in source)
         {
            this.addData(data);
         }
      }
      
      public function addData(data:Object) : void
      {
         if(Boolean(this.paraArr[data.type]))
         {
            (this.paraArr[data.type] as TreePara).addItem(data,this.selItem,this.overItem,this.outItem);
         }
         this.align();
      }
      
      public function removeData(id:int, type:int) : void
      {
         if(Boolean(this._selItem) && Boolean(this._selItem.data.id == id) && this._selItem.contains(this._backGround))
         {
            this._selItem.removeChild(this._backGround);
            this._backGround.visible = false;
            this._selItem = null;
         }
         (this.paraArr[type] as TreePara).removeItem(id);
         this.align();
      }
      
      public function getSelItem() : ITreeItem
      {
         return this._selItem;
      }
      
      public function set select(data:Object) : void
      {
         var type_array:Array = null;
         var item:ITreeItem = null;
         if(Boolean(data))
         {
            type_array = this.paraArr[data.type].items;
            if(Boolean(type_array))
            {
               for each(item in type_array)
               {
                  if(item.data.id == data.id)
                  {
                     this.selItem(item);
                     break;
                  }
               }
            }
         }
         this._selFun(data);
      }
      
      public function set isNeedSelBg(value:Boolean) : void
      {
         this._isNeedSelBg = value;
      }
      
      private function selItem(item:ITreeItem) : void
      {
         if(this._selItem == item)
         {
            return;
         }
         this._selItem = item;
         if(this._isNeedSelBg)
         {
            this._selItem.addChild(this._backGround);
            this._backGround.visible = true;
         }
         if(this._selFun != null)
         {
            this._selFun(this._selItem.data);
         }
      }
      
      private function overItem(item:ITreeItem) : void
      {
         if(this._overitem == item)
         {
            return;
         }
         this._overitem = item;
         if(this._isNeedSelBg)
         {
            this._overitem.addChild(this._highlight);
            this._highlight.visible = true;
         }
         if(this._overFun != null)
         {
            this._overFun(this._overitem.data);
         }
      }
      
      private function outItem(item:ITreeItem) : void
      {
         if(item == this._overitem)
         {
            if(this._overitem.contains(this._highlight))
            {
               this._overitem.removeChild(this._highlight);
            }
            this._highlight.visible = false;
            this._overitem = null;
         }
         if(this._outFun != null)
         {
            this._outFun();
         }
      }
      
      public function clear() : void
      {
         if(Boolean(this._selItem) && this._selItem.contains(this._backGround))
         {
            this._selItem.removeChild(this._backGround);
            this._backGround.visible = false;
            this._selItem = null;
         }
         var i:int = 0;
         while(i < this.paraArr.length)
         {
            if(Boolean(this.paraArr[i]))
            {
               this.paraArr[i].clear();
            }
            i++;
         }
         this.align();
      }
      
      override public function align() : void
      {
         this.nowY = 0;
         var i:int = 0;
         while(i < this.paraArr.length)
         {
            if(Boolean(this.paraArr[i]))
            {
               this.paraArr[i].y = this.nowY;
               this.nowY += this.paraArr[i].align();
            }
            i++;
         }
         super.align();
      }
   }
}

