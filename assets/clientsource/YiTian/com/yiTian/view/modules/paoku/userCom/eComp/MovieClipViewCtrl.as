package com.yiTian.view.modules.paoku.userCom.eComp
{
   import com.yiTian.view.modules.kupao.KPMap;
   import com.yiTian.view.modules.paoku.core.entity.Entity;
   import com.yiTian.view.modules.paoku.core.entity.eComponent.IEntityCtrl;
   import com.yiTian.view.modules.paoku.userCom.KuPaoEntity;
   import com.yiTian.view.modules.paoku.userCom.util.KuPaoUtil;
   import flash.display.MovieClip;
   
   public class MovieClipViewCtrl implements IEntityCtrl
   {
      
      private var _target:KuPaoEntity;
      
      public var _movie:MovieClip;
      
      public var _name:String;
      
      public function MovieClipViewCtrl()
      {
         super();
      }
      
      public function setName(v:String) : void
      {
         this._name = v;
      }
      
      public function getName() : String
      {
         return this._name;
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
      }
      
      public function exit(entity:Entity) : void
      {
         this._target = null;
      }
      
      public function update(entity:Entity) : void
      {
         this._movie.x = this._target.moveData.xPos;
         this._movie.y = KuPaoUtil.convertViewY(this._target.moveData.yPos);
      }
      
      public function unActive(entity:Entity) : void
      {
         this._movie.stop();
         KPMap.instance._view.removeChild(this._movie);
      }
      
      public function active(entity:Entity) : void
      {
         this._movie.x = this._target.moveData.xPos;
         this._movie.y = KuPaoUtil.convertViewY(this._target.moveData.yPos);
         this._movie.play();
         KPMap.instance._view.addChild(this._movie);
      }
   }
}

