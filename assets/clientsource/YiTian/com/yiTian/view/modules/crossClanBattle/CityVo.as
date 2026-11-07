package com.yiTian.view.modules.crossClanBattle
{
   import com.utils.Util;
   import com.yiTian.manager.GameUnitManager;
   import flash.geom.ColorTransform;
   
   public class CityVo
   {
      
      public var id:int;
      
      public var name:String;
      
      public var silver:int;
      
      public var clanId:int;
      
      public var clan:String = "无";
      
      public var clanName:String = "无";
      
      public var maxSpendclanId:int;
      
      public var maxSpendclan:String = "无";
      
      public var maxSpendclanName:String = "无";
      
      public var maxSpendSilver:int;
      
      public var maxSpendClanOwnId:int;
      
      public var secondSpendclanId:int;
      
      public var secondSpendclan:String = "无";
      
      public var secondSpendclanName:String = "无";
      
      public var secondSpendSilver:int;
      
      public var secondSpendClanOwnId:int;
      
      public var endTime:int;
      
      public var color:ColorTransform = new ColorTransform(1,1,1,1,0,0,0,0);
      
      public var isOwn:Boolean;
      
      public var battleTime:int;
      
      public var index:int;
      
      public function CityVo()
      {
         super();
      }
      
      public function init(data:Array, id:int, name:String, silver:int, time:int, battleTime:int, index:int) : void
      {
         this.id = id;
         this.name = name;
         this.endTime = time;
         this.silver = silver;
         this.battleTime = battleTime;
         this.index = index;
         if(!data || !data.length)
         {
            return;
         }
         this.clanId = data[2];
         this.clan = data[3];
         this.clanName = data[3] == 0 ? "无" : data[3] + ".S" + data[4];
         this.maxSpendclanId = data[5];
         this.maxSpendClanOwnId = data[6];
         this.maxSpendclan = data[7];
         this.maxSpendclanName = data[7] == 0 ? "无" : data[7] + ".S" + data[8];
         this.maxSpendSilver = data[9];
         this.secondSpendclanId = data[10];
         this.secondSpendClanOwnId = data[11];
         this.secondSpendclan = data[12];
         this.secondSpendclanName = data[12] == 0 ? "无" : data[12] + ".S" + data[13];
         this.secondSpendSilver = data[14];
         this.color = this.getColor(int(data[15]));
         if(Boolean(GameUnitManager.hero.crossClanName))
         {
            if(GameUnitManager.hero.crossClanName == this.clanName)
            {
               GameUnitManager.hero.crossClanIdArr.push(id);
            }
         }
      }
      
      private function getColor(color:int) : ColorTransform
      {
         switch(color)
         {
            case 0:
               return new ColorTransform(1,1,1,1,0,0,0,0);
            case 1:
               return Util.qhtz1;
            case 2:
               return Util.qhtz2;
            case 3:
               return Util.qhtz3;
            case 4:
               return Util.red;
            case 5:
               return Util.yellow;
            default:
               return new ColorTransform(1,1,1,1,0,0,0,0);
         }
      }
   }
}

