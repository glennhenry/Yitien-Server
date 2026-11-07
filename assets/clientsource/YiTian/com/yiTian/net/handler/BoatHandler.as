package com.yiTian.net.handler
{
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.boatChall.BoatBuff;
   import com.yiTian.view.modules.boatChall.BoatManager;
   import com.yiTian.view.modules.boatChall.EnterBtn;
   import com.yiTian.view.modules.boatChall.ShipCrues;
   import com.yiTian.view.modules.ship.Ship;
   
   public class BoatHandler
   {
      
      public function BoatHandler()
      {
         super();
      }
      
      public static function gameStart() : void
      {
         EnterBtn.instance.show();
      }
      
      public static function gameEnd() : void
      {
         EnterBtn.instance.hide();
      }
      
      public static function addShipers(idStr:String, lefts:String, rights:String) : void
      {
         var leftsArr:Array = null;
         var rightsArr:Array = null;
         var heroName:String = null;
         var isInLeft:Boolean = false;
         var isInRight:Boolean = false;
         leftsArr = lefts.split("_");
         rightsArr = rights.split("_");
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(ShipCrues.instance,function():void
         {
            ShipCrues.instance.show(leftsArr,rightsArr,idStr);
         });
         if(Boolean(Ship.myShip))
         {
            if(Ship.myShip.idStr == idStr)
            {
               heroName = GameUnitManager.hero.name;
               isInLeft = Boolean(leftsArr.indexOf(heroName) != -1);
               isInRight = Boolean(rightsArr.indexOf(heroName) != -1);
               if(isInLeft)
               {
                  Ship.myShip.position = 0;
               }
               else
               {
                  Ship.myShip.position = 1;
               }
            }
         }
      }
      
      public static function GC_ADD_BOAT(status:int, idStr:String, global_x:int, global_y:int, speed:int, way:int, _route:Array, name:String, quHao:int, bangId:int) : void
      {
         var ship:Ship = BoatManager.findUnit(idStr) as Ship;
         if(!ship)
         {
            ship = BoatManager.getUnit() as Ship;
         }
         ship.sign = status;
         ship.bangId = bangId;
         ship.quHao = quHao;
         ship.init(idStr,Status.NOMAL,Action.STAND,name,global_x,global_y,speed,way,12345);
         if(status > 0)
         {
            ship.action = Action.RUN;
            ship.route = _route;
         }
         BoatManager.addUnit(ship);
         UIManager.smallMap.addShipPoint(ship);
      }
      
      public static function GC_UPDATE_BOAT(idStr:String, status:int, speed:int, name:String, way:int) : void
      {
         var ship:Ship = BoatManager.findUnit(idStr) as Ship;
         if(Boolean(ship))
         {
            ship.speed = speed;
            if(Boolean(Ship.myShip) && Ship.myShip == ship)
            {
               if(status == -1)
               {
                  status = 0;
               }
            }
            ship.sign = status;
            ship.name = name;
            ship.way = way;
         }
      }
      
      public static function GC_ADD_ITEM_BOAT(sysId:int, global_x:int, global_y:int, itemId:int, type:int) : void
      {
         var boatBuff:BoatBuff = BoatManager.findUnit(sysId,2) as BoatBuff;
         if(!boatBuff)
         {
            boatBuff = BoatManager.getUnit(2) as BoatBuff;
         }
         boatBuff.type = type;
         boatBuff.init_buff(sysId,global_x,global_y,itemId);
         BoatManager.addUnit(boatBuff);
      }
   }
}

