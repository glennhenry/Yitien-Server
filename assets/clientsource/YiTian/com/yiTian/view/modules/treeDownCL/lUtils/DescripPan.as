package com.yiTian.view.modules.treeDownCL.lUtils
{
   import com.utils.ComponentUtil;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class DescripPan extends Sprite
   {
      
      private var property:Object = new Object();
      
      private var pool:Array = [];
      
      public function DescripPan(_wid:int, _hei:int)
      {
         this.property.wid = _wid;
         this.property.hei = _hei;
         super();
      }
      
      public function setMask(obj:Object) : void
      {
         var sp:Shape = new Shape();
         sp.graphics.beginFill(0,0.5);
         sp.graphics.drawRect(0,0,obj.width,obj.height);
         sp.graphics.endFill();
         ComponentUtil.setPropertie(sp,{
            "x":obj.x,
            "y":obj.y
         });
         ComponentUtil.setPropertie(this,{
            "x":obj.x,
            "y":obj.y
         });
         if(Boolean(parent) && !parent.contains(sp))
         {
            parent.addChild(sp);
         }
         this.mask = sp;
      }
      
      public function addItem(movePanUnit:MoveRoundPan, moveType:int, data:Object) : void
      {
         var _movePanUnit:MoveRoundPan = null;
         movePanUnit.setProperty(this.property.wid,this.property.hei);
         movePanUnit.update(data);
         addChild(movePanUnit);
         movePanUnit.moveIn(moveType);
         if(Boolean(this.pool.length))
         {
            _movePanUnit = this.pool.pop();
            _movePanUnit.moveOut(MoveRoundPan.reverse(moveType),data);
         }
         this.pool.unshift(movePanUnit);
      }
   }
}

