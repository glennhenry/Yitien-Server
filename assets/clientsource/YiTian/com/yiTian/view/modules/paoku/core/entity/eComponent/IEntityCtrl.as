package com.yiTian.view.modules.paoku.core.entity.eComponent
{
   import com.yiTian.view.modules.paoku.core.entity.Entity;
   
   public interface IEntityCtrl
   {
      
      function setName(param1:String) : void;
      
      function getName() : String;
      
      function setSortIndex(param1:int) : void;
      
      function getSortIndex() : int;
      
      function enter(param1:Entity) : void;
      
      function exit(param1:Entity) : void;
      
      function update(param1:Entity) : void;
      
      function unActive(param1:Entity) : void;
      
      function active(param1:Entity) : void;
   }
}

