package com.yiTian.view.modules.mainUIBtnContainer
{
   import com.yiTian.Global;
   import com.yiTian.scene.GameScene;
   import com.yiTian.view.UIBase;
   import flash.display.DisplayObject;
   
   public class View_TipBtnContainer extends UIBase
   {
      
      private var _viewerItemVec:Vector.<viewerItem>;
      
      private var _itemOffsetY:Number;
      
      private var _cowMaxItem:int;
      
      private var _itemOffsetX:Number;
      
      private var _del_vec:Vector.<viewerItem>;
      
      public function View_TipBtnContainer(itemOffsetX:Number = 40, itemOffsetY:Number = 40, cowMaxItem:int = 7)
      {
         super();
         GameScene.uiLayer.addChild(this);
         this._itemOffsetX = itemOffsetX;
         this._itemOffsetY = itemOffsetY;
      }
      
      override protected function initStaticView() : void
      {
      }
      
      override protected function initDynamicView() : void
      {
         this._viewerItemVec = new Vector.<viewerItem>();
         this._del_vec = new Vector.<viewerItem>();
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = Global.stage.stageHeight - 120;
      }
      
      public function getItemAt(index:uint) : DisplayObject
      {
         if(index >= this._viewerItemVec.length)
         {
            return null;
         }
         return this._viewerItemVec[index].obj;
      }
      
      public function addItem(obj:DisplayObject, priority:int = 0) : void
      {
         if(this.hasItem(obj))
         {
            return;
         }
         var it:viewerItem = this.getFreeItem();
         it.obj = obj;
         it.priority = priority;
         this._viewerItemVec.push(it);
         if(priority > 0)
         {
            this.sort();
         }
         this.reAllPos();
         addChild(obj);
         x = (Global.stage.stageWidth - width) / 2;
      }
      
      public function hasItem(obj:DisplayObject) : Boolean
      {
         var it:viewerItem = null;
         for each(it in this._viewerItemVec)
         {
            if(it.obj === obj)
            {
               return true;
            }
         }
         return false;
      }
      
      public function removeItem(obj:DisplayObject) : void
      {
         var it:viewerItem = this.findItem(obj);
         this._viewerItemVec.splice(this._viewerItemVec.indexOf(it),1);
         removeChild(obj);
         it.dispose();
         this.addFreeItem(it);
         this.reAllPos();
      }
      
      private function findItem(obj:DisplayObject) : viewerItem
      {
         var it:viewerItem = null;
         for each(it in this._viewerItemVec)
         {
            if(it.obj === obj)
            {
               return it;
            }
         }
         return null;
      }
      
      private function reAllPos() : void
      {
         var index:int = 0;
         var rol:int = 0;
         var cow:int = 0;
         index = 0;
         while(index < this._viewerItemVec.length)
         {
            rol = index % 7;
            cow = int(index / 7);
            this._viewerItemVec[index].obj.x = rol * this._itemOffsetX;
            this._viewerItemVec[index].obj.y = cow * this._itemOffsetY;
            index++;
         }
      }
      
      private function sort() : void
      {
         var j:int = 0;
         var temp:viewerItem = null;
         var length:int = int(this._viewerItemVec.length);
         var i:int = 0;
         while(i < length)
         {
            j = 0;
            while(j < length - 1)
            {
               if(this._viewerItemVec[j].priority < this._viewerItemVec[j + 1].priority)
               {
                  temp = this._viewerItemVec[j];
                  this._viewerItemVec[j] = this._viewerItemVec[j + 1];
                  this._viewerItemVec[j + 1] = temp;
               }
               j++;
            }
            i++;
         }
      }
      
      private function addFreeItem(it:viewerItem) : void
      {
         this._del_vec.push(it);
      }
      
      private function getFreeItem() : viewerItem
      {
         var it:viewerItem = null;
         if(this._del_vec.length > 0)
         {
            it = this._del_vec.pop();
         }
         else
         {
            it = new viewerItem();
         }
         return it;
      }
   }
}

import flash.display.DisplayObject;

class viewerItem
{
   
   public var obj:DisplayObject;
   
   public var priority:int;
   
   public function viewerItem()
   {
      super();
   }
   
   public function dispose() : void
   {
      this.obj = null;
      this.priority = 0;
   }
}
