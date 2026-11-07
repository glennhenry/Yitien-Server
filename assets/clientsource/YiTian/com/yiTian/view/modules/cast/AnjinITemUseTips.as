package com.yiTian.view.modules.cast
{
   import com.utils.ComponentUtil;
   import com.yiTian.view.modules.pet.petD.PetMoveObj;
   import flash.display.DisplayObjectContainer;
   import flash.geom.Point;
   
   public class AnjinITemUseTips
   {
      
      private static var moveTip:PetMoveObj;
      
      public function AnjinITemUseTips()
      {
         super();
      }
      
      public static function addTip(point:Point, _parent:DisplayObjectContainer) : void
      {
         if(!moveTip)
         {
            moveTip = PetMoveObj.instance;
         }
         moveTip.b.rotation = 180;
         ComponentUtil.setPropertie(moveTip.b,{
            "x":moveTip.b.width,
            "y":moveTip.b.height
         });
         moveTip.setTextDescrip("精炼暗金",new Point(0,18));
         moveTip.move(point.x,point.y,_parent);
      }
      
      public static function removeTip() : void
      {
         if(Boolean(moveTip))
         {
            moveTip.remove();
         }
      }
   }
}

