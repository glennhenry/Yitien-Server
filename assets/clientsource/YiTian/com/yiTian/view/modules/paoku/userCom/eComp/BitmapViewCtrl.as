package com.yiTian.view.modules.paoku.userCom.eComp
{
   import com.yiTian.view.modules.kupao.KPMap;
   import com.yiTian.view.modules.paoku.core.entity.Entity;
   import com.yiTian.view.modules.paoku.core.entity.eComponent.IEntityCtrl;
   import com.yiTian.view.modules.paoku.userCom.KuPaoEntity;
   import com.yiTian.view.modules.paoku.userCom.util.KuPaoUtil;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   
   public class BitmapViewCtrl implements IEntityCtrl
   {
      
      public var bm:Bitmap;
      
      public var bmd:BitmapData;
      
      public var px:int;
      
      public var py:int;
      
      private var _target:KuPaoEntity;
      
      public function BitmapViewCtrl()
      {
         super();
      }
      
      public function setName(v:String) : void
      {
      }
      
      public function getName() : String
      {
         return null;
      }
      
      public function setSortIndex(v:int) : void
      {
      }
      
      public function getSortIndex() : int
      {
         return 10000;
      }
      
      public function enter(entity:Entity) : void
      {
         this._target = entity as KuPaoEntity;
         this.bm = this.bm || new Bitmap();
         this.bm.bitmapData = this.bmd;
      }
      
      public function exit(entity:Entity) : void
      {
         this.bm.bitmapData = null;
         this.bm = null;
      }
      
      public function update(entity:Entity) : void
      {
         this.bm.x = this.px + this._target.moveData.xPos;
         this.bm.y = this.py + KuPaoUtil.convertViewY(this._target.moveData.yPos);
      }
      
      public function unActive(entity:Entity) : void
      {
         KPMap.instance._view.removeChild(this.bm);
      }
      
      public function active(entity:Entity) : void
      {
         KPMap.instance._view.addChild(this.bm);
      }
   }
}

