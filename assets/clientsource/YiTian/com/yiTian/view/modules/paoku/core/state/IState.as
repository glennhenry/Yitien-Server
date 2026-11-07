package com.yiTian.view.modules.paoku.core.state
{
   public interface IState
   {
      
      function enter(param1:*) : void;
      
      function exit(param1:*) : void;
      
      function update(param1:*) : void;
      
      function askExit(param1:int) : Boolean;
   }
}

