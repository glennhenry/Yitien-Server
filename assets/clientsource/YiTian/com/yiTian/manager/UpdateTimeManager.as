package com.yiTian.manager
{
   import flash.utils.Dictionary;
   
   public class UpdateTimeManager
   {
      
      private var dic:Dictionary;
      
      public function UpdateTimeManager()
      {
         super();
         this.dic = new Dictionary();
      }
      
      public function add(id:int, updateTime:Number, interval:Number) : void
      {
         var vec:Vector.<Number> = new Vector.<Number>(2,true);
         vec[0] = updateTime * 1000;
         vec[1] = interval * 1000;
         this.dic[id] = vec;
      }
      
      public function update(id:int) : void
      {
         var updateTime:Number = Number(this.dic[id][0]);
         var interval:Number = Number(this.dic[id][1]);
         var count:int = (CommandManager.get_serverTime().time - updateTime) / interval + 1;
         this.dic[id][0] = updateTime + interval * count;
      }
      
      public function bUpdate(id:int) : Boolean
      {
         if(this.dic[id] == null)
         {
            return false;
         }
         if(CommandManager.get_serverTime().time > this.dic[id][0])
         {
            return true;
         }
         return false;
      }
   }
}

