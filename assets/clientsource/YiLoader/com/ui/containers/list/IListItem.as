package com.ui.containers.list
{
   import com.utils.ComponentUtil;
   import flash.display.Sprite;
   
   public class IListItem extends Sprite
   {
      
      private var _data:Object;
      
      public function IListItem()
      {
         super();
         this.addShape();
         this.buttonMode = true;
         this.mouseChildren = false;
      }
      
      protected function addShape() : void
      {
         addChildAt(ComponentUtil.getShape(width,height,0,0),0);
      }
      
      public function set data(value:Object) : void
      {
         this._data = value;
      }
      
      public function updataFunc() : void
      {
      }
      
      public function updata() : void
      {
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function dispose() : void
      {
      }
   }
}

