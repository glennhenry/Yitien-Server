package com.yiTian.view.modules.hapStone
{
   import com.utils.ComponentUtil;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   
   public class HapManager
   {
      
      private static var maskDic:Dictionary = new Dictionary();
      
      public function HapManager()
      {
         super();
      }
      
      public static function addMaskUnit(obj:Object, beenMskSp:Sprite) : void
      {
         var sp:Shape = null;
         if(!maskDic[beenMskSp])
         {
            sp = ComponentUtil.getShape(obj.width,obj.height,0,0.4);
            ComponentUtil.setPropertie(sp,{
               "x":obj.x,
               "y":obj.y
            });
            if(Boolean(beenMskSp.parent))
            {
               beenMskSp.parent.addChild(sp);
            }
            beenMskSp.mask = sp;
            maskDic[beenMskSp] = sp;
         }
      }
      
      public static function removeMskUnit(beenMskSp:Sprite) : void
      {
         if(Boolean(maskDic[beenMskSp]))
         {
            delete maskDic[beenMskSp];
         }
         beenMskSp.mask = null;
      }
   }
}

