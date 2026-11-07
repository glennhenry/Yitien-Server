package com.yiTian.manager
{
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.gameUnit.IBattleUnit;
   import com.yiTian.gameUnit.magic.BattleMagic;
   import com.yiTian.gameUnit.role.BattleUnit;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Utils;
   import flash.display.DisplayObject;
   
   public class BattleUnitManager
   {
      
      public static var overObj:BattleUnit;
      
      private static var len:int;
      
      private static var count:int;
      
      public static var list:Array = [];
      
      private static var sort:Array = ["y","id"];
      
      public function BattleUnitManager()
      {
         super();
      }
      
      public static function run(now:int) : void
      {
         var unit:BattleUnit = null;
         len = list.length;
         count = len - 1;
         while(count >= 0)
         {
            if(!list[count])
            {
               return;
            }
            list[count].update(now);
            --count;
         }
         len = list.length;
         list.sortOn(sort,Array.NUMERIC);
         count = len - 1;
         while(count >= 0)
         {
            if(GameScene.battleLayer.unitLayer.getChildIndex(list[count]) != count)
            {
               GameScene.battleLayer.unitLayer.setChildIndex(list[count],count);
            }
            --count;
         }
         Utils.point.x = Global.stage.mouseX;
         Utils.point.y = Global.stage.mouseY;
         var overArr:Array = GameScene.battleLayer.unitLayer.getObjectsUnderPoint(Utils.point);
         var i:int = overArr.length - 1;
         while(i >= 0)
         {
            if(Util.isOnUI)
            {
               break;
            }
            unit = testUnit(overArr[i]);
            if(unit != overObj || !CursorManager.isShow)
            {
               if(Boolean(overObj))
               {
                  overObj.mouseOut();
               }
               overObj = unit;
               if(Boolean(overObj))
               {
                  overObj.mouseOver();
               }
            }
            if(overObj)
            {
               return;
            }
            i--;
         }
         if(Boolean(overObj))
         {
            overObj.mouseOut();
            overObj = null;
         }
      }
      
      private static function testUnit(obj:DisplayObject) : BattleUnit
      {
         if(obj is BattleUnit)
         {
            return obj as BattleUnit;
         }
         if(Boolean(obj.parent))
         {
            return testUnit(obj.parent);
         }
         return null;
      }
      
      public static function addUnit(unit:IBattleUnit) : void
      {
         if(list.indexOf(unit) == -1)
         {
            list.push(unit);
            GameScene.battleLayer.unitLayer.addChild(unit);
         }
         unit.show();
      }
      
      public static function removeUnit(unit:IBattleUnit) : void
      {
         if(list.indexOf(unit) != -1)
         {
            list.splice(list.indexOf(unit),1);
            if(Boolean(unit.parent))
            {
               unit.parent.removeChild(unit);
            }
            unit.dispose();
         }
      }
      
      public static function findUnit(id:Number) : BattleUnit
      {
         return BattleUnit.list[id];
      }
      
      public static function getUnit() : BattleUnit
      {
         return Boolean(BattleUnit.pool.length) ? BattleUnit.pool.pop() : new BattleUnit();
      }
      
      public static function findMagic(id:int) : BattleMagic
      {
         return BattleMagic.list[id];
      }
      
      public static function getMagic() : BattleMagic
      {
         return Boolean(BattleMagic.pool.length) ? BattleMagic.pool.pop() : new BattleMagic();
      }
      
      public static function align() : void
      {
         var i:int = list.length - 1;
         while(i >= 0)
         {
            list[i].align();
            i--;
         }
      }
      
      public static function dispose() : void
      {
         var i:int = list.length - 1;
         while(i >= 0)
         {
            removeUnit(list[i]);
            i--;
         }
      }
   }
}

