package com.yiTian.utils
{
   import flash.utils.Dictionary;
   
   public class Pool_delete
   {
      
      private var _pool:Dictionary;
      
      private var _class:Class;
      
      public function Pool_delete($class:Class)
      {
         super();
         this._class = $class;
         this._pool = new Dictionary(true);
      }
      
      public function push(obj:Object, _index:String = null) : void
      {
         this._pool[obj] = _index;
      }
      
      public function pop(_index:String = null) : Object
      {
         var i:Object = null;
         for(i in this._pool)
         {
            if(this._pool[i] == _index)
            {
               delete this._pool[i];
               return i;
            }
         }
         return new this._class();
      }
   }
}

