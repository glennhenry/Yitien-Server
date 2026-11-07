package com.yiTian.utils
{
   import flash.geom.Point;
   import flash.utils.ByteArray;
   
   public class AStar
   {
      
      private static var _open:BinaryHeap;
      
      public static var _grid:Grid;
      
      private static var _endNode:Node;
      
      private static var _startNode:Node;
      
      private static var _path:Array;
      
      public static var jump_position:Array;
      
      private static var ex:int;
      
      private static var ey:int;
      
      public static var size:int = 25;
      
      public static var heuristic:Function = diagonal;
      
      private static var _straightCost:Number = 1;
      
      private static var _diagCost:Number = Math.SQRT2;
      
      private static var nowversion:int = 1;
      
      private static var isFirstInHome:Boolean = false;
      
      private static var TwoOneTwoZero:Number = 2 * Math.cos(Math.PI / 3);
      
      public function AStar(grid:Grid)
      {
         super();
         _grid = grid;
         heuristic = euclidian2;
      }
      
      public static function init(byte:ByteArray) : void
      {
         var j:int = 0;
         var node:Node = null;
         var value:int = 0;
         var jump_point:Array = null;
         byte.position = 0;
         var mapCol:int = byte.readShort();
         var mapRow:int = byte.readShort();
         _grid = new Grid(mapCol,mapRow);
         var i:int = 0;
         while(i < mapRow)
         {
            j = 0;
            while(j < mapCol)
            {
               node = new Node(j,i);
               value = byte.readByte();
               node.value = value;
               node.block = Boolean(value & 1) ? false : true;
               node.walkable = !node.block;
               node.alpha = Boolean(value & 2) ? true : false;
               node.safeArea = Boolean(value & 4) ? true : false;
               node.buffArea = Boolean(value & 8) ? true : false;
               if(node.buffArea)
               {
                  node.buffId = (value & 0xF0) >> 4;
               }
               _grid.setNode(j,i,node);
               j++;
            }
            i++;
         }
         _grid.calculateLinks();
         if(jump_position != null && Boolean(jump_position.length))
         {
            for each(jump_point in jump_position)
            {
               _grid.getNode(jump_point[0],jump_point[1]).jumpArea = true;
               _grid.getNode(jump_point[0],jump_point[1]).jumpLink = jump_point[2];
            }
         }
      }
      
      public static function resetGrid(arrayNode:Array) : Array
      {
         if(!_grid || !arrayNode)
         {
            return null;
         }
         var oldArrayNode:Array = [];
         var i:int = 0;
         while(i < arrayNode.length)
         {
            oldArrayNode.push(_grid.getNode(arrayNode[i].x,arrayNode[i].y));
            _grid.setNode(arrayNode[i].x,arrayNode[i].y,arrayNode[i]);
            i++;
         }
         _grid.calculateLinks();
         return oldArrayNode;
      }
      
      public static function setBlock(valueXY:Array, bBlock:Boolean) : void
      {
         var node:Node = null;
         if(!_grid || !valueXY)
         {
            return;
         }
         var i:int = 0;
         while(i < valueXY.length)
         {
            node = _grid.getNode(valueXY[i][0],valueXY[i][1]);
            if(node)
            {
               node.walkable = !(node.block = bBlock);
            }
            i++;
         }
         _grid.calculateLinks();
      }
      
      public static function setBuff(valueXY:Array, buffid:int) : void
      {
         var node:Node = null;
         if(!_grid || !valueXY)
         {
            return;
         }
         var i:int = 0;
         while(i < valueXY.length)
         {
            node = _grid.getNode(valueXY[i][0],valueXY[i][1]);
            if(node)
            {
               node.buffArea = true;
               node.buffId = buffid;
            }
            i++;
         }
      }
      
      private static function justMin(x:Object, y:Object) : Boolean
      {
         return x.f < y.f;
      }
      
      private static function getRound(i:int) : Node
      {
         var result:Node = null;
         var col:int = 0;
         var temp:int = 0;
         var startX:int = _grid.endNode.x >= i ? int(_grid.endNode.x - i) : 0;
         var endX:int = _grid.endNode.x < _grid.numCols - i ? int(_grid.endNode.x + i) : int(_grid.numCols - 1);
         var startY:int = _grid.endNode.y > i ? int(_grid.endNode.y - i) : 0;
         var endY:int = _grid.endNode.y < _grid.numRows - i ? int(_grid.endNode.y + i) : int(_grid.numRows - 1);
         var distance:int = 10000;
         var row:int = startY;
         while(row <= endY)
         {
            col = startX;
            while(col <= endX)
            {
               if(_grid.getNode(col,row).walkable && _grid.getNode(col,row) != _grid.startNode)
               {
                  temp = Math.abs(row - _grid.startNode.y) + Math.abs(col - _grid.startNode.x);
                  if(temp < distance)
                  {
                     distance = temp;
                     result = _grid.getNode(col,row);
                  }
               }
               col++;
            }
            row++;
         }
         if(result == null)
         {
            return getRound(i + 1);
         }
         return result;
      }
      
      public static function find(x1:int, y1:int, x2:int, y2:int) : Array
      {
         var bool:Boolean = false;
         var node:Node = null;
         ex = x2;
         ey = y2;
         var startCol:int = x1 / size;
         var startRow:int = y1 / size;
         var targetCol:int = Math.min(_grid.numCols - 1,x2 / size);
         var targetRow:int = Math.min(_grid.numRows - 1,y2 / size);
         bool = _grid.setStartNode(startCol,startRow);
         if(!bool)
         {
            return null;
         }
         bool = _grid.setEndNode(targetCol,targetRow);
         if(!bool)
         {
            return null;
         }
         if(_grid.getNode(targetCol,targetRow).walkable == false)
         {
            node = getRound(1);
            ex = (node.x + 0.5) * size;
            ey = (node.y + 0.5) * size;
            _grid.setEndNode(node.x,node.y);
         }
         if(findPath())
         {
            return _path;
         }
         return null;
      }
      
      private static function findPath() : Boolean
      {
         _endNode = _grid.endNode;
         ++nowversion;
         _startNode = _grid.startNode;
         _open = new BinaryHeap(justMin);
         _startNode.g = 0;
         return search();
      }
      
      public static function search() : Boolean
      {
         var len:int = 0;
         var i:int = 0;
         var test:Node = null;
         var cost:Number = NaN;
         var g:Number = NaN;
         var h:Number = NaN;
         var f:Number = NaN;
         var node:Node = _startNode;
         node.version = nowversion;
         while(node != _endNode)
         {
            len = int(node.links.length);
            i = 0;
            while(i < len)
            {
               test = node.links[i].node;
               cost = Number(node.links[i].cost);
               g = node.g + cost;
               h = heuristic(test);
               f = g + h;
               if(test.version == nowversion)
               {
                  if(test.f > f)
                  {
                     test.f = f;
                     test.g = g;
                     test.h = h;
                     test.parent = node;
                  }
               }
               else
               {
                  test.f = f;
                  test.g = g;
                  test.h = h;
                  test.parent = node;
                  _open.ins(test);
                  test.version = nowversion;
               }
               i++;
            }
            if(_open.a.length == 1)
            {
               return false;
            }
            node = _open.pop() as Node;
         }
         buildPath();
         return true;
      }
      
      private static function buildPath() : void
      {
         var arr:Array = [];
         var node:Node = _endNode;
         arr.push([(node.x + 0.5) * size,(node.y + 0.5) * size]);
         while(node != _startNode)
         {
            node = node.parent;
            arr.unshift([(node.x + 0.5) * size,(node.y + 0.5) * size]);
         }
         var sx:int = (_grid.startNode.x + 0.5) * size;
         var sy:int = (_grid.startNode.y + 0.5) * size;
         _path = [];
         var length:int = arr.length - 1;
         var start:int = 0;
         var j:int = length;
         while(j > start)
         {
            if(pathCheck(sx,sy,arr[j][0],arr[j][1]))
            {
               _path.push(arr[j]);
               if(j == length)
               {
                  break;
               }
               sx = int(arr[j][0]);
               sy = int(arr[j][1]);
               start = j;
               j = length + 1;
            }
            j--;
         }
         if(!_path.length)
         {
            _path.push([ex,ey]);
         }
      }
      
      private static function pathCheck(x1:int, y1:int, x2:int, y2:int) : Boolean
      {
         var temp:int = 0;
         var rate:Number = NaN;
         var ny:int = 0;
         var nx:int = 0;
         var dx:int = x2 - x1;
         var dy:int = y2 - y1;
         var len:int = Math.sqrt((y2 - y1) * (y2 - y1) + (x2 - x1) * (x2 - x1));
         while(true)
         {
            temp = temp + size;
            if(temp > len)
            {
               break;
            }
            rate = temp / len;
            ny = rate * dy + y1;
            nx = rate * dx + x1;
            if(dx > 0 && nx > x2 || dx < 0 && nx < x2)
            {
               nx = x2;
            }
            if(dy > 0 && ny > y2 || dy < 0 && ny < y2)
            {
               ny = y2;
            }
            if(_grid.getNode(nx / size,ny / size).block)
            {
               return false;
            }
         }
         return true;
      }
      
      public static function get path() : Array
      {
         return _path;
      }
      
      public static function manhattan(node:Node) : Number
      {
         return Math.abs(node.x - _endNode.x) + Math.abs(node.y - _endNode.y);
      }
      
      public static function manhattan2(node:Node) : Number
      {
         var dx:Number = Math.abs(node.x - _endNode.x);
         var dy:Number = Math.abs(node.y - _endNode.y);
         return dx + dy + Math.abs(dx - dy) / 1000;
      }
      
      public static function euclidian(node:Node) : Number
      {
         var dx:Number = node.x - _endNode.x;
         var dy:Number = node.y - _endNode.y;
         return Math.sqrt(dx * dx + dy * dy);
      }
      
      public static function chineseCheckersEuclidian2(node:Node) : Number
      {
         var y:int = node.y / TwoOneTwoZero;
         var x:int = node.x + node.y / 2;
         var dx:Number = x - _endNode.x - _endNode.y / 2;
         var dy:Number = y - _endNode.y / TwoOneTwoZero;
         return sqrt(dx * dx + dy * dy);
      }
      
      private static function sqrt(x:Number) : Number
      {
         return Math.sqrt(x);
      }
      
      public static function euclidian2(node:Node) : Number
      {
         var dx:Number = node.x - _endNode.x;
         var dy:Number = node.y - _endNode.y;
         return dx * dx + dy * dy;
      }
      
      public static function diagonal(node:Node) : Number
      {
         var dx:Number = Math.abs(node.x - _endNode.x);
         var dy:Number = Math.abs(node.y - _endNode.y);
         var diag:Number = Math.min(dx,dy);
         var straight:Number = dx + dy;
         return _diagCost * diag + _straightCost * (straight - 2 * diag);
      }
      
      public static function getAlpha(global_x:int, global_y:int) : Boolean
      {
         var targetCol:int = Math.min(_grid.numCols - 1,global_x / size);
         var targetRow:int = Math.min(_grid.numRows - 1,global_y / size);
         var node:Node = _grid.getNode(targetCol,targetRow);
         if(Boolean(node))
         {
            return node.alpha;
         }
         return false;
      }
      
      public static function getWalkable(x:int, y:int, inspa:Boolean = true) : Boolean
      {
         var targetCol:int = Math.min(_grid.numCols - 1,x / size);
         var targetRow:int = Math.min(_grid.numRows - 1,y / size);
         var node:Node = _grid.getNode(targetCol,targetRow);
         if(!node)
         {
            return false;
         }
         if(inspa)
         {
            return Boolean(node.value & 0x20) ? true : false;
         }
         return Boolean(node.value & 1) && !(node.value & 0x20) ? true : false;
      }
      
      public static function getSafe(global_x:int, global_y:int) : Boolean
      {
         var targetCol:int = Math.min(_grid.numCols - 1,global_x / size);
         var targetRow:int = Math.min(_grid.numRows - 1,global_y / size);
         var node:Node = _grid.getNode(targetCol,targetRow);
         if(Boolean(node))
         {
            return node.safeArea;
         }
         return false;
      }
      
      public static function getBuff(global_x:int, global_y:int) : int
      {
         var targetCol:int = Math.min(_grid.numCols - 1,global_x / size);
         var targetRow:int = Math.min(_grid.numRows - 1,global_y / size);
         var node:Node = _grid.getNode(targetCol,targetRow);
         if(Boolean(node) && node.buffArea)
         {
            return node.buffId;
         }
         return -1;
      }
      
      public static function getBuffIdforGrid(gridX:int, gridY:int) : int
      {
         var node:Node = _grid.getNode(gridX,gridY);
         if(Boolean(node) && node.buffArea)
         {
            return node.buffId;
         }
         return -1;
      }
      
      public static function checkJumpArea(x:int, y:int) : Object
      {
         var targetCol:int = Math.min(_grid.numCols - 1,x / size);
         var targetRow:int = Math.min(_grid.numRows - 1,y / size);
         if(Boolean(_grid.getNode(targetCol,targetRow)))
         {
            if(_grid.getNode(targetCol,targetRow).jumpArea)
            {
               return _grid.getNode(targetCol,targetRow).jumpLink;
            }
            return null;
         }
         return null;
      }
      
      public static function checkBlock(x:int, y:int) : Boolean
      {
         var index_x:int = x / size;
         var index_y:int = y / size;
         if(index_x >= _grid.numCols || index_x < 0 || index_y >= _grid.numRows || index_y < 0)
         {
            return true;
         }
         return !_grid.getNode(index_x,index_y).walkable;
      }
      
      public static function getNearWalkableArea(x:int, y:int, depth:int = 5) : Point
      {
         var start_x:int = 0;
         var end_x:int = 0;
         var start_y:int = 0;
         var end_y:int = 0;
         var m:int = 0;
         var n:int = 0;
         if(checkBlock(x,y) == false)
         {
            return new Point(x,y);
         }
         var index_x:int = x / size;
         var index_y:int = y / size;
         if(index_x < 0 || index_y < 0)
         {
            return null;
         }
         var i:int = 1;
         loop0:
         while(i <= depth)
         {
            start_x = index_x - i > 0 ? int(index_x - i) : 0;
            end_x = index_x + i >= _grid.numCols - 1 ? int(_grid.numCols - 1) : int(index_x + i);
            start_y = index_y - i > 0 ? int(index_y - i) : 0;
            end_y = index_y + i >= _grid.numRows - 1 ? int(_grid.numRows - 1) : int(index_y + i);
            m = start_x;
            loop1:
            while(true)
            {
               if(m > end_x)
               {
                  i++;
                  continue loop0;
               }
               n = start_y;
               while(n <= end_y)
               {
                  if(_grid.getNode(m,n).walkable)
                  {
                     break loop1;
                  }
                  n++;
               }
               m++;
            }
            return new Point(m * size,n * size);
         }
         return null;
      }
   }
}

class Grid
{
   
   private var _startNode:Node;
   
   private var _endNode:Node;
   
   private var _nodes:Array;
   
   private var _numCols:int;
   
   private var _numRows:int;
   
   private var type:int;
   
   private var _straightCost:Number = 1;
   
   private var _diagCost:Number = 1.4142135623730951;
   
   public function Grid(numCols:int, numRows:int)
   {
      super();
      this._numCols = numCols;
      this._numRows = numRows;
      this._nodes = new Array();
      var i:int = 0;
      while(i < this._numCols)
      {
         this._nodes[i] = new Array();
         i++;
      }
   }
   
   public function calculateLinks(type:int = 0) : void
   {
      var j:int = 0;
      this.type = type;
      var i:int = 0;
      while(i < this._numCols)
      {
         j = 0;
         while(j < this._numRows)
         {
            this.initNodeLink(this._nodes[i][j],type);
            j++;
         }
         i++;
      }
   }
   
   public function getType() : int
   {
      return this.type;
   }
   
   private function initNodeLink(node:Node, type:int) : void
   {
      var j:int = 0;
      var test:Node = null;
      var cost:Number = NaN;
      var test2:Node = null;
      var startX:int = Math.max(0,node.x - 1);
      var endX:int = Math.min(this.numCols - 1,node.x + 1);
      var startY:int = Math.max(0,node.y - 1);
      var endY:int = Math.min(this.numRows - 1,node.y + 1);
      node.links = [];
      var i:int = startX;
      while(i <= endX)
      {
         j = startY;
         for(; j <= endY; j++)
         {
            test = this.getNode(i,j);
            if(!(test == node || !test.walkable))
            {
               if(type != 2 && i != node.x && j != node.y)
               {
                  test2 = this.getNode(node.x,j);
                  if(!test2.walkable)
                  {
                     continue;
                  }
                  test2 = this.getNode(i,node.y);
                  if(!test2.walkable)
                  {
                     continue;
                  }
               }
               cost = Number(this._straightCost);
               if(!(node.x == test.x || node.y == test.y))
               {
                  if(type == 1)
                  {
                     continue;
                  }
                  if(type == 2 && (node.x - test.x) * (node.y - test.y) == 1)
                  {
                     continue;
                  }
                  if(type == 2)
                  {
                     cost = Number(this._straightCost);
                  }
                  else
                  {
                     cost = Number(this._diagCost);
                  }
               }
               node.links.push(new Link(test,cost));
            }
         }
         i++;
      }
   }
   
   public function getNode(x:int, y:int) : Node
   {
      if(!this._nodes[x] || !this._nodes[x][y])
      {
         return null;
      }
      return this._nodes[x][y];
   }
   
   public function get Nodes() : Array
   {
      return this._nodes;
   }
   
   public function setEndNode(x:int, y:int) : Boolean
   {
      if(this._nodes == null || this._nodes[x] == null || this._nodes[x][y] == null)
      {
         return false;
      }
      this._endNode = this._nodes[x][y];
      return true;
   }
   
   public function setStartNode(x:int, y:int) : Boolean
   {
      if(this._nodes == null || this._nodes[x] == null || this._nodes[x][y] == null)
      {
         return false;
      }
      this._startNode = this._nodes[x][y];
      return true;
   }
   
   public function setWalkable(x:int, y:int, value:Boolean) : void
   {
      this._nodes[x][y].walkable = value;
   }
   
   public function setNode(x:int, y:int, node:Node) : void
   {
      this._nodes[x][y] = node;
   }
   
   public function get endNode() : Node
   {
      return this._endNode;
   }
   
   public function get numCols() : int
   {
      return this._numCols;
   }
   
   public function get numRows() : int
   {
      return this._numRows;
   }
   
   public function get startNode() : Node
   {
      return this._startNode;
   }
}

class Link
{
   
   public var node:Node;
   
   public var cost:Number;
   
   public function Link(node:Node, cost:Number)
   {
      super();
      this.node = node;
      this.cost = cost;
   }
}

class BinaryHeap
{
   
   public var a:Array = [];
   
   public function justMinFun(x:Object, y:Object):Boolean
   {
      return x < y;
   }
   public function BinaryHeap(justMinFun:Function = null)
   {
      super();
      this.a.push(-1);
      if(justMinFun != null)
      {
         this.justMinFun = justMinFun;
      }
   }
   
   public function ins(value:Object) : void
   {
      var temp:Object = null;
      var p:int = int(this.a.length);
      this.a[p] = value;
      var pp:int = p >> 1;
      while(p > 1 && Boolean(this.justMinFun(this.a[p],this.a[pp])))
      {
         temp = this.a[p];
         this.a[p] = this.a[pp];
         this.a[pp] = temp;
         p = pp;
         pp = p >> 1;
      }
   }
   
   public function pop() : Object
   {
      var minp:int = 0;
      var temp:Object = null;
      var min:Object = this.a[1];
      this.a[1] = this.a[this.a.length - 1];
      this.a.pop();
      var p:int = 1;
      var l:int = int(this.a.length);
      var sp1:int = p << 1;
      var sp2:int = sp1 + 1;
      while(sp1 < l)
      {
         if(sp2 < l)
         {
            minp = Boolean(this.justMinFun(this.a[sp2],this.a[sp1])) ? sp2 : sp1;
         }
         else
         {
            minp = sp1;
         }
         if(!Boolean(this.justMinFun(this.a[minp],this.a[p])))
         {
            break;
         }
         temp = this.a[p];
         this.a[p] = this.a[minp];
         this.a[minp] = temp;
         p = minp;
         sp1 = p << 1;
         sp2 = sp1 + 1;
      }
      return min;
   }
}

class Node
{
   
   public var x:int;
   
   public var y:int;
   
   public var f:Number;
   
   public var g:Number;
   
   public var h:Number;
   
   public var walkable:Boolean = true;
   
   public var parent:Node;
   
   public var version:int = 1;
   
   public var links:Array;
   
   public var value:int;
   
   public var block:Boolean;
   
   public var alpha:Boolean;
   
   public var safeArea:Boolean;
   
   public var buffArea:Boolean;
   
   public var buffId:int;
   
   public var jumpArea:Boolean;
   
   public var jumpLink:Object;
   
   public function Node(x:int, y:int)
   {
      super();
      this.x = x;
      this.y = y;
   }
}
