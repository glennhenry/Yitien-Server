package com.yiTian.view.modules.guangMingDing
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.role.BattleUnit;
   import com.yiTian.manager.BattleManager;
   import com.yiTian.manager.BattleUnitManager;
   
   public class GuangMingDingBattleCommand
   {
      
      private var _data:*;
      
      private var _battleID:Number;
      
      public function GuangMingDingBattleCommand()
      {
         super();
      }
      
      public function init(data:Object, battleID:Number) : void
      {
         this._data = data;
         this._battleID = battleID;
         if(BattleManager.isPlaying && BattleManager.battleID == battleID)
         {
            this.execute(BattleManager.battleID);
         }
         else
         {
            Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_START,this.execute);
         }
      }
      
      protected function execute(bID:Number) : void
      {
         var u:BattleUnit = null;
         var data:Object = null;
         var k:String = null;
         var rID:Number = NaN;
         var vo:Vo_MiJi = null;
         var petInfo:Array = null;
         var petPos:Number = NaN;
         var uu:BattleUnit = null;
         if(bID == this._battleID)
         {
            data = this._data;
            for(k in data)
            {
               rID = Number(k);
               u = BattleUnitManager.findUnit(rID);
               if(u != null)
               {
                  for each(vo in data[k])
                  {
                     u.miJiComp.addVo(vo);
                     petInfo = Model_team.getMemberInfo(rID);
                     if(petInfo != null)
                     {
                        petPos = Number(petInfo[12]);
                        for each(uu in BattleUnit.list)
                        {
                           if(uu != u && petPos == Number(uu.position) && u.direction == uu.direction)
                           {
                              if(uu.type == UnitType.PET)
                              {
                                 uu.miJiComp.addVo(vo);
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
         this.dispose();
      }
      
      public function dispose() : void
      {
         Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_START,this.execute);
         this._data = null;
         this._battleID = NaN;
      }
   }
}

