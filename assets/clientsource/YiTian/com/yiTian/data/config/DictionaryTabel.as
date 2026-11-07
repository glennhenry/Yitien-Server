package com.yiTian.data.config
{
   import flash.utils.Dictionary;
   
   public dynamic class DictionaryTabel extends Dictionary
   {
      
      protected var _length:uint;
      
      protected var _numericArray:Array;
      
      protected var _needRebuildNumericArray:Boolean = true;
      
      public function DictionaryTabel(weakKeys:Boolean = false)
      {
         super(weakKeys);
      }
      
      public function toArray() : Array
      {
         var k:String = null;
         var numericArrayItem:Array = null;
         this._numericArray = this._numericArray || [];
         if(this._needRebuildNumericArray)
         {
            this._numericArray.splice(0);
            for(k in this)
            {
               numericArrayItem = (this[k] as Array).concat();
               numericArrayItem.unshift(int(k));
               this._numericArray.push(numericArrayItem);
            }
            this._numericArray.sortOn("0",Array.NUMERIC);
            this._needRebuildNumericArray = false;
         }
         return this._numericArray;
      }
      
      public function getLength() : uint
      {
         return this._length;
      }
      
      public function setLength(v:uint) : void
      {
         this._length = v;
      }
      
      public function put(k:String, content:*) : void
      {
         if(!this[k])
         {
            this._length += 1;
         }
         this[k] = content;
         this._needRebuildNumericArray = true;
      }
      
      public function remove(k:String) : void
      {
         if(Boolean(this[k]))
         {
            this._length -= 1;
         }
         delete this[k];
         this._needRebuildNumericArray = true;
      }
   }
}

