package com.ui.containers.tree
{
   import flash.display.Sprite;
   
   public class TreePara extends Sprite
   {
      
      public var items:Array = [];
      
      private var parentItem:TreeParentItem;
      
      private var _wid:int;
      
      private var _align:Function;
      
      private var _tree:Tree;
      
      private var itemVisible:Boolean = true;
      
      public function TreePara(wid:int, type:String, _align:Function, tree:Tree)
      {
         super();
         this._wid = wid;
         this._align = _align;
         this._tree = tree;
         this.parentItem = new TreeParentItem(wid);
         this.parentItem.init(type);
         this.parentItem.click = this.parentItemClick;
         addChild(this.parentItem);
      }
      
      private function parentItemClick() : void
      {
         var item:ITreeItem = null;
         this.itemVisible = !this.itemVisible;
         for each(item in this.items)
         {
            item.visible = this.itemVisible;
         }
         this._align();
      }
      
      public function addItem(data:Object, selFun:Function, overFun:Function, outFun:Function) : void
      {
         var item:ITreeItem = this._tree.getTreeItem() as ITreeItem;
         item.init(data,selFun,overFun,outFun);
         addChild(item);
         this.items.push(item);
      }
      
      public function removeItem(id:int) : void
      {
         var item:ITreeItem = null;
         var i:int = 0;
         while(i < this.items.length)
         {
            if(this.items[i].data.id == id)
            {
               item = this.items[i] as ITreeItem;
               item.dispose();
               removeChild(item);
               this.items.splice(i,1);
               this._tree.pool.push(item);
               break;
            }
            i++;
         }
      }
      
      public function align() : int
      {
         var nowY:int = 0;
         var item:ITreeItem = null;
         if(!this.items.length)
         {
            visible = false;
            return 0;
         }
         visible = true;
         nowY = ITreeItem.itemHeight;
         for each(item in this.items)
         {
            if(item.visible)
            {
               item.y = nowY;
               nowY += item.height;
            }
         }
         return nowY;
      }
      
      public function clear() : void
      {
         var item:ITreeItem = null;
         var i:int = this.items.length - 1;
         while(i >= 0)
         {
            item = this.items[i] as ITreeItem;
            item.dispose();
            removeChild(item);
            this.items.splice(i,1);
            this._tree.pool.push(item);
            i--;
         }
      }
      
      public function dispose() : void
      {
         this.clear();
         this.parentItem.dispose();
      }
   }
}

