package Layout
{
   public interface ILayout
   {
      
      function align() : void;
      
      function appendItem(param1:Object) : void;
      
      function appendSomeItem(... rest) : void;
      
      function dependItem(param1:Object) : void;
      
      function set width(param1:Number) : void;
      
      function get width() : Number;
      
      function set height(param1:Number) : void;
      
      function get height() : Number;
      
      function set x(param1:Number) : void;
      
      function get x() : Number;
      
      function set y(param1:Number) : void;
      
      function get y() : Number;
      
      function getNumItem() : uint;
      
      function clearItem() : void;
      
      function dispose() : void;
   }
}

