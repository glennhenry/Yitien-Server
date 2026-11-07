package com.yiTian.view.modules.xiaoxiaole
{
   public class XXLNode
   {
      
      public var col:int;
      
      public var row:int;
      
      public var value:int;
      
      public var gird:GeZi;
      
      public var gravity:int;
      
      public function XXLNode(_col:int, _row:int, _value:int, _gird:GeZi = null)
      {
         super();
         this.col = _col;
         this.row = _row;
         this.value = _value;
         this.gird = _gird;
      }
   }
}

