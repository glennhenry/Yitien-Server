package com.yiTian.view.modules.paoku.core.quadTree
{
   import flash.geom.Rectangle;
   
   public class QTreeNode
   {
      
      public static const LEFT:int = 1;
      
      public static const RIGHT:int = 2;
      
      public static const TOP:int = 4;
      
      public static const BOTTOM:int = 8;
      
      public static const ADD:int = 128;
      
      public static const CROSS:int = 384;
      
      private static var pool:Array = [];
      
      public var _rect:Rectangle = new Rectangle();
      
      protected var _parent:QTreeNode;
      
      public var _depth:int;
      
      protected var _items:Array = [];
      
      protected var _childs:Vector.<QTreeNode> = new Vector.<QTreeNode>();
      
      private var _numChild:int;
      
      private var _width:Number;
      
      private var _height:Number;
      
      private var _left:Number;
      
      private var _top:Number;
      
      private var _centerX:Number;
      
      private var _centerY:Number;
      
      private var _right:Number;
      
      private var _bottom:Number;
      
      public function QTreeNode()
      {
         super();
      }
      
      public static function createIns() : QTreeNode
      {
         return new QTreeNode();
      }
      
      public function setQuad(x:Number, y:Number, w:Number, h:Number) : void
      {
         this._left = x;
         this._top = y;
         this._right = x + w;
         this._bottom = y + h;
         this._width = w;
         this._height = h;
         this._centerX = x + w / 2;
         this._centerY = y + h / 2;
         this._rect.x = x;
         this._rect.y = y;
         this._rect.width = w;
         this._rect.height = h;
      }
      
      public function insert(item:IQuadItem) : void
      {
         var rect:Rectangle = null;
         var iw:int = 0;
         if(this._numChild == 0)
         {
            this._items.push(item);
            item.setWhichNode(this);
         }
         else
         {
            rect = item.getQuad();
            iw = this.inWhich(rect.x,rect.y,rect.right,rect.bottom);
            if(iw >= CROSS)
            {
               this._items.push(item);
               item.setWhichNode(this);
            }
            else
            {
               if(Boolean(iw & LEFT) && Boolean(iw & TOP))
               {
                  this._childs[0].insert(item);
               }
               if(Boolean(iw & RIGHT) && Boolean(iw & TOP))
               {
                  this._childs[1].insert(item);
               }
               if(Boolean(iw & LEFT) && Boolean(iw & BOTTOM))
               {
                  this._childs[2].insert(item);
               }
               if(Boolean(iw & RIGHT) && Boolean(iw & BOTTOM))
               {
                  this._childs[3].insert(item);
               }
            }
         }
      }
      
      private function inWhich(left:Number, top:Number, right:Number, bottom:Number) : int
      {
         var rest:int = 0;
         if(left < this._centerX)
         {
            rest |= LEFT;
            rest += ADD;
         }
         if(right >= this._centerX)
         {
            rest |= RIGHT;
            rest += ADD;
         }
         if(top < this._centerY)
         {
            rest |= TOP;
            rest += ADD;
         }
         if(bottom >= this._centerY)
         {
            rest |= BOTTOM;
            rest += ADD;
         }
         return rest;
      }
      
      public function getItems(rect:Rectangle, distArr:Array) : void
      {
         var item:IQuadItem = null;
         var iw:int = 0;
         for each(item in this._items)
         {
            if(this.hitTestRect(item.getQuad(),rect))
            {
               distArr.push(item);
            }
         }
         if(this._numChild != 0)
         {
            iw = this.inWhich(rect.left,rect.top,rect.right,rect.bottom);
            if(Boolean(iw & LEFT) && Boolean(iw & TOP))
            {
               this._childs[0].getItems(rect,distArr);
            }
            if(Boolean(iw & RIGHT) && Boolean(iw & TOP))
            {
               this._childs[1].getItems(rect,distArr);
            }
            if(Boolean(iw & LEFT) && Boolean(iw & BOTTOM))
            {
               this._childs[2].getItems(rect,distArr);
            }
            if(Boolean(iw & RIGHT) && Boolean(iw & BOTTOM))
            {
               this._childs[3].getItems(rect,distArr);
            }
         }
      }
      
      public function hitTestRect(rect1:Rectangle, rect2:Rectangle) : Boolean
      {
         return rect1.intersects(rect2);
      }
      
      public function test(rect:Rectangle) : Boolean
      {
         var item:IQuadItem = null;
         var child:QTreeNode = null;
         for each(item in this._items)
         {
            if(item.getQuad().containsRect(rect))
            {
               return true;
            }
         }
         for each(child in this._childs)
         {
            if(child.test(rect))
            {
               return true;
            }
         }
         return false;
      }
      
      public function getQuad() : Rectangle
      {
         return this._rect;
      }
      
      public function addItem(item:IQuadItem) : void
      {
         this._items.push(item);
      }
      
      public function removeItem(item:IQuadItem) : void
      {
         var index:int = this._items.indexOf(item);
         this._items.splice(index,1);
         item.setWhichNode(null);
      }
      
      public function clearItems() : void
      {
         var item:IQuadItem = null;
         for each(item in this._items)
         {
            item.setWhichNode(null);
         }
         this._items.length = 0;
      }
      
      public function setDephi(dephi:int) : void
      {
         this._depth = dephi;
      }
      
      public function getDephi() : int
      {
         return this._depth;
      }
      
      public function addChild(child:QTreeNode) : void
      {
         this._numChild += 1;
         this._childs.push(child);
      }
      
      public function removeChild(child:QTreeNode) : void
      {
         var index:int = this._childs.indexOf(child);
         this._numChild -= 1;
         this._childs.splice(index,1);
      }
      
      public function clearChilds() : void
      {
         this._childs.length = 0;
      }
      
      public function getParent() : QTreeNode
      {
         return this._parent;
      }
      
      public function setParent(parent:QTreeNode) : void
      {
         this._parent = parent;
      }
      
      public function createChilds(createDepth:int) : void
      {
         var centerX:Number = NaN;
         var centerY:Number = NaN;
         var halfWidth:Number = NaN;
         var halfHeight:Number = NaN;
         var child:QTreeNode = null;
         var nextCreateDepth:int = createDepth - 1;
         var nextDepth:int = this._depth + 1;
         if(createDepth > 0)
         {
            centerX = this._rect.x + this._rect.width / 2;
            centerY = this._rect.y + this._rect.height / 2;
            halfWidth = this._rect.width / 2;
            halfHeight = this._rect.height / 2;
            child = QTreeNode.createIns();
            child.setParent(this);
            child.setQuad(this._rect.x,this._rect.y,halfWidth,halfHeight);
            child.setDephi(nextDepth);
            child.createChilds(nextCreateDepth);
            this.addChild(child);
            child = QTreeNode.createIns();
            child.setParent(this);
            child.setQuad(centerX,this._rect.y,halfWidth,halfHeight);
            child.setDephi(nextDepth);
            child.createChilds(nextCreateDepth);
            this.addChild(child);
            child = QTreeNode.createIns();
            child.setParent(this);
            child.setQuad(this._rect.x,centerY,halfWidth,halfHeight);
            child.setDephi(nextDepth);
            child.createChilds(nextCreateDepth);
            this.addChild(child);
            child = QTreeNode.createIns();
            child.setParent(this);
            child.setQuad(centerX,centerY,halfWidth,halfHeight);
            child.setDephi(nextDepth);
            child.createChilds(nextCreateDepth);
            this.addChild(child);
         }
      }
      
      public function setEmpty() : void
      {
         var child:QTreeNode = null;
         if(!this._childs.length)
         {
            this._rect.setEmpty();
            this.clearChilds();
            this.clearItems();
            this._depth = -1;
            this._parent = null;
         }
         else
         {
            for each(child in this._childs)
            {
               child.setEmpty();
            }
         }
         this._numChild = 0;
      }
      
      public function clearItem() : void
      {
         var item:IQuadItem = null;
         var child:QTreeNode = null;
         for each(item in this._items)
         {
            item.setWhichNode(null);
         }
         this._items.length = 0;
         for each(child in this._childs)
         {
            child.clearItem();
         }
      }
   }
}

