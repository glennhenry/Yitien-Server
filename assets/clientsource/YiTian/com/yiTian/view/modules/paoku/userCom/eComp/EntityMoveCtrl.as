package com.yiTian.view.modules.paoku.userCom.eComp
{
   import com.yiTian.view.modules.paoku.core.entity.Entity;
   import com.yiTian.view.modules.paoku.core.entity.MoveData;
   import com.yiTian.view.modules.paoku.core.entity.eComponent.IEntityCtrl;
   import com.yiTian.view.modules.paoku.userCom.KuPaoEntity;
   import com.yiTian.view.modules.paoku.userCom.KuPaoMgr;
   import com.yiTian.view.modules.paoku.userCom.util.KuPaoUtil;
   
   public class EntityMoveCtrl implements IEntityCtrl
   {
      
      protected var _entity:KuPaoEntity;
      
      public function EntityMoveCtrl()
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
         return 900;
      }
      
      public function enter(entity:Entity) : void
      {
         this._entity = entity as KuPaoEntity;
      }
      
      public function exit(entity:Entity) : void
      {
         this._entity = null;
      }
      
      public function update(entity:Entity) : void
      {
         var nextHorType:int = 0;
         var nextVerType:int = 0;
         var md:MoveData = this._entity.moveData;
         var curType:int = KuPaoMgr.instance.getType(md.xPos,md.yPos);
         if(!this._entity.moveData.canCrossWall && curType == 0)
         {
            nextHorType = KuPaoMgr.instance.getType(md.xPos + md.xSpeed,md.yPos);
            if(nextHorType == 1)
            {
               md.xPos = KuPaoUtil.restrictXInBlock(md.xPos,md.xPos + md.xSpeed);
            }
            else
            {
               md.xPos = md.xSpeed + md.xPos;
            }
            nextVerType = KuPaoMgr.instance.getType(md.xPos,md.yPos + md.ySpeed);
            if(nextVerType == 1)
            {
               md.yPos = KuPaoUtil.restrictYInBlock(md.yPos,md.yPos + md.ySpeed);
            }
            else
            {
               md.yPos = md.ySpeed + md.yPos;
            }
         }
         else
         {
            md.xPos = md.xSpeed + md.xPos;
            md.yPos = md.ySpeed + md.yPos;
         }
      }
      
      public function unActive(entity:Entity) : void
      {
      }
      
      public function active(entity:Entity) : void
      {
      }
   }
}

