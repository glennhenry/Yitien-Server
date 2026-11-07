package com.yiTian.command
{
   public class List1
   {
      
      public var array:Array = [];
      
      protected var _idleIndexs:Array = [];
      
      protected var _idleLen:uint;
      
      protected var _arrayLen:uint;
      
      public function List1()
      {
         super();
      }
      
      public function add(item:*) : void
      {
         if(item == null)
         {
            return;
         }
         var index:int = Boolean(this._idleIndexs.length) ? int(this._idleIndexs.shift()) : -1;
         if(index == -1)
         {
            this.array.push(item);
            ++this._arrayLen;
         }
         else
         {
            this.array[index] = item;
            --this._idleLen;
         }
      }
      
      public function remove(item:*) : void
      {
         if(item == null)
         {
            return;
         }
         var index:int = this.array.indexOf(item);
         if(index != -1)
         {
            this.array[index] = null;
            this._idleIndexs.push(index);
            --this._idleLen;
         }
      }
      
      public function get length() : uint
      {
         return this._arrayLen;
      }
      
      public function indexOf(item:*) : int
      {
         if(item == null)
         {
            return -1;
         }
         return this.array.indexOf(item);
      }
      
      public function isIdle() : Boolean
      {
         return this._idleLen == this._arrayLen;
      }
      
      public function rest() : void
      {
         this._idleIndexs.length = this.array.length = this._arrayLen = this._idleLen = 0;
      }
   }
}

