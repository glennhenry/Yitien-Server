package com.yiTian.view.modules.paoku.core.quadTree
{
   import flash.geom.Rectangle;
   
   public interface IQuadItem
   {
      
      function getWhichNode() : QTreeNode;
      
      function setWhichNode(param1:QTreeNode) : void;
      
      function getQuad() : Rectangle;
   }
}

