package Layout
{
   public class HGroup extends BaseLayout implements ILayout
   {
      
      public static const TOP:String = "top";
      
      public static const BOTTOM:String = "bottom";
      
      protected var _itemHeight:Number;
      
      protected var _itemInterval:Number;
      
      public var type:String;
      
      public function HGroup(xx:Number, yy:Number, w:Number, h:Number, iH:Number, iInterval:Number)
      {
         super(xx,yy,w,h);
         this._itemHeight = iH;
         this._itemInterval = iInterval;
      }
      
      override public function align() : void
      {
         var i:int = 0;
         var __y:Number = NaN;
         var len:int = int(itemArr.length);
         switch(this.type)
         {
            case BOTTOM:
               i = len - 1;
               while(i >= 0)
               {
                  __y = height - (this._itemHeight + this._itemInterval) * (len - i);
                  itemArr[i].y = this.y + __y;
                  itemArr[i].x = this.x;
                  if(itemArr[y] is ILayout)
                  {
                     itemArr[y].align();
                  }
                  i -= 1;
               }
               break;
            default:
               i = 0;
               while(i < len)
               {
                  __y = (this._itemHeight + this._itemInterval) * i;
                  itemArr[i].y = this.y + __y;
                  itemArr[i].x = this.x;
                  if(itemArr[y] is ILayout)
                  {
                     itemArr[y].align();
                  }
                  i += 1;
               }
         }
      }
      
      public function set itemHeight(value:Number) : void
      {
         this._itemHeight = value;
      }
      
      public function set itemInterval(value:Number) : void
      {
         this._itemInterval = value;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this._itemInterval = 0;
         this._itemHeight = 0;
      }
   }
}

