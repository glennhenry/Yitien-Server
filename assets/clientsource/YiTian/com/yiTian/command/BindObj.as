package com.yiTian.command
{
   public class BindObj implements IBindObj
   {
      
      private var _data:Object;
      
      private var _bindViewer:IBindViewer;
      
      public function BindObj()
      {
         super();
      }
      
      public function setBindViewer(bindViewer:IBindViewer) : void
      {
         this._bindViewer = bindViewer;
      }
      
      public function getBindViewer() : IBindViewer
      {
         return this._bindViewer;
      }
      
      public function setData(obj:Object) : void
      {
         this._data = obj;
         this._bindViewer.update(obj);
      }
      
      public function getData() : Object
      {
         return this._data;
      }
   }
}

