package Layout
{
   import flash.display.DisplayObject;
   
   public class BaseLayout implements ILayout
   {
      
      protected var _width:Number;
      
      protected var _height:Number;
      
      protected var _itemArr:Array;
      
      protected var _x:Number;
      
      protected var _y:Number;
      
      public function BaseLayout(xx:Number, yy:Number, w:Number, h:Number)
      {
         super();
         this._width = w;
         this._height = h;
         this._x = xx;
         this._y = yy;
         this._itemArr = [];
      }
      
      protected function get itemArr() : Array
      {
         return this._itemArr;
      }
      
      public function align() : void
      {
         var len:int = int(this.itemArr.length);
         var i:int = 0;
         while(i < len)
         {
            this.itemArr[i].y = this.y + this.itemArr[i].y;
            this.itemArr[i].x = this.x + this.itemArr[i].x;
            if(this.itemArr[this.y] is ILayout)
            {
               this.itemArr[this.y].align();
            }
            i += 1;
         }
      }
      
      public function appendItem(item:Object) : void
      {
         if(item is DisplayObject || item is ILayout)
         {
            if(this._itemArr.indexOf(item) == -1)
            {
               this._itemArr.push(item);
            }
         }
      }
      
      public function appendSomeItem(... param) : void
      {
         var obj:Object = null;
         if(param is Array)
         {
            for each(obj in param)
            {
               this.appendItem(obj);
            }
         }
         else
         {
            this.appendItem(param);
         }
      }
      
      public function dependItem(item:Object) : void
      {
         var index:int = 0;
         if(item is DisplayObject || item is ILayout)
         {
            index = this._itemArr.indexOf(item);
            if(index != -1)
            {
               this._itemArr.splice(index,1);
            }
         }
      }
      
      public function set x(xx:Number) : void
      {
         this._x = xx;
      }
      
      public function get x() : Number
      {
         return this._x;
      }
      
      public function set y(yy:Number) : void
      {
         this._y = yy;
      }
      
      public function get y() : Number
      {
         return this._y;
      }
      
      public function set width(value:Number) : void
      {
         this._width = value;
      }
      
      public function get width() : Number
      {
         return this._width;
      }
      
      public function set height(value:Number) : void
      {
         this._height = value;
      }
      
      public function get height() : Number
      {
         return this._height;
      }
      
      public function getNumItem() : uint
      {
         return this._itemArr.length;
      }
      
      public function clearItem() : void
      {
         this._itemArr.splice(0);
      }
      
      public function dispose() : void
      {
         this._itemArr.splice(0);
         this._width = 0;
         this._height = 0;
         this._itemArr = null;
      }
   }
}

