package Layout
{
   public class VGroup extends BaseLayout implements ILayout
   {
      
      protected var _itemWidth:Number;
      
      protected var _itemInterval:Number;
      
      public function VGroup(xx:Number, yy:Number, w:Number, h:Number, iW:Number, iInterval:Number)
      {
         super(xx,yy,w,h);
         this._itemWidth = iW;
         this._itemInterval = iInterval;
      }
      
      override public function align() : void
      {
         var __x:Number = NaN;
         var len:int = int(itemArr.length);
         var i:int = 0;
         while(i < len)
         {
            __x = (this._itemWidth + this._itemInterval) * i;
            itemArr[i].x = this.x + __x;
            itemArr[i].y = this.y;
            if(itemArr[y] is ILayout)
            {
               itemArr[y].align();
            }
            i += 1;
         }
      }
      
      public function set itemWidth(value:Number) : void
      {
         this._itemWidth = value;
      }
      
      public function set itemInterval(value:Number) : void
      {
         this._itemInterval = value;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this._itemInterval = 0;
         this._itemWidth = 0;
      }
   }
}

