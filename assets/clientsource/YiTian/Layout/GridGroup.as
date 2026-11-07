package Layout
{
   public class GridGroup extends BaseLayout implements ILayout
   {
      
      protected var _itemHeight:Number;
      
      protected var _itemIntervalH:Number;
      
      protected var _itemWidth:Number;
      
      protected var _itemIntervalW:Number;
      
      public var vNum:int;
      
      public function GridGroup(xx:Number, yy:Number, w:Number, h:Number, iH:Number, iIntervalH:Number, iW:Number, iIntervalW:Number, vvNum:int)
      {
         super(xx,yy,w,h);
         this._itemHeight = iH;
         this._itemIntervalH = iIntervalH;
         this._itemWidth = iW;
         this._itemIntervalW = iIntervalW;
         this.vNum = vvNum;
      }
      
      override public function align() : void
      {
         var vIndex:int = 0;
         var hIndex:int = 0;
         var __y:Number = NaN;
         var __x:Number = NaN;
         var len:int = int(itemArr.length);
         var i:int = 0;
         while(i < len)
         {
            vIndex = i % this.vNum;
            hIndex = i / this.vNum;
            __y = (this._itemHeight + this._itemIntervalH) * hIndex;
            __x = (this._itemWidth + this._itemIntervalW) * vIndex;
            itemArr[i].y = this.y + __y;
            itemArr[i].x = this.x + __x;
            if(itemArr[y] is ILayout)
            {
               itemArr[y].align();
            }
            i += 1;
         }
      }
      
      public function set itemHeight(value:Number) : void
      {
         this._itemHeight = value;
      }
      
      public function set itemIntervalH(value:Number) : void
      {
         this._itemIntervalH = value;
      }
      
      public function set itemIntervalW(value:Number) : void
      {
         this._itemIntervalW = value;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this._itemIntervalH = 0;
         this._itemIntervalW = 0;
         this._itemHeight = 0;
         this._itemWidth = 0;
      }
   }
}

