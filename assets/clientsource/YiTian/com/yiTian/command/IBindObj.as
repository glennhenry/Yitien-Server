package com.yiTian.command
{
   public interface IBindObj
   {
      
      function setData(param1:Object) : void;
      
      function getData() : Object;
      
      function getBindViewer() : IBindViewer;
      
      function setBindViewer(param1:IBindViewer) : void;
   }
}

