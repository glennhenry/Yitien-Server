package com.yiTian.view.modules.paoku.userCom
{
   import com.yiTian.view.modules.paoku.core.entity.Entity;
   import com.yiTian.view.modules.paoku.core.entity.MoveData;
   import com.yiTian.view.modules.paoku.core.quadTree.IQuadItem;
   import com.yiTian.view.modules.paoku.core.quadTree.QTreeNode;
   import flash.geom.Rectangle;
   
   public class KuPaoEntity extends Entity implements IQuadItem
   {
      
      public var moveData:MoveData;
      
      public var quadRect:Rectangle = new Rectangle();
      
      protected var qNodeRecord:QTreeNode;
      
      public function KuPaoEntity()
      {
         super();
      }
      
      public function getWhichNode() : QTreeNode
      {
         return this.qNodeRecord;
      }
      
      public function setWhichNode(node:QTreeNode) : void
      {
         this.qNodeRecord = node;
      }
      
      public function getQuad() : Rectangle
      {
         return this.quadRect;
      }
      
      override public function update() : void
      {
         super.update();
      }
   }
}

