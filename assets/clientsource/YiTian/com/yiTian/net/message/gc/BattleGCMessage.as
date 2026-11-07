package com.yiTian.net.message.gc
{
   import com.yiTian.data.model.Model_Battle;
   import com.yiTian.data.vo.Vo_battle_lib_data;
   import com.yiTian.net.handler.BattleHandler;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.utils.PatchReader;
   import flash.utils.IDataInput;
   
   public class BattleGCMessage
   {
      
      private static var i_index:int = 0;
      
      private static var ii_index:int = 0;
      
      public function BattleGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_BATTLE] = GC_BATTLE;
         index[MessageType.GC_BATTLE_RESULT] = this.GC_BATTLE_RESULT;
         index[MessageType.GC_SIWANG_FUHUO] = this.GC_SIWANG_FUHUO;
         index[MessageType.GC_CHALLENGE] = this.GC_CHALLENGE;
         index[MessageType.GC_BATTLE_VIDEO_DATA] = this.GC_BATTLE_VIDEO_DATA;
      }
      
      public static function GC_BATTLE(patch:IDataInput) : void
      {
         var infos:Array = PatchReader.instance.readBattle(patch);
         BattleHandler.GC_BATTLE(infos[0],infos[1],infos[2],infos[3],infos[4],infos[5],infos[6],infos[7],infos[8],infos[9]);
      }
      
      public function GC_BATTLE_RESULT(patch:IDataInput) : void
      {
         var array_THING:Array = null;
         var battleId:int = patch.readInt();
         var module:int = patch.readByte();
         var info_len:int = patch.readShort();
         var info:Array = [];
         i_index = 0;
         while(i_index < info_len)
         {
            array_THING = [];
            array_THING.push(patch.readByte());
            array_THING.push(patch.readInt());
            array_THING.push(patch.readInt());
            array_THING.push(patch.readByte());
            info.push(array_THING);
            ++i_index;
         }
         BattleHandler.GC_BATTLE_RESULT(battleId,module,info);
      }
      
      public function GC_SIWANG_FUHUO(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         BattleHandler.GC_SIWANG_FUHUO(result);
      }
      
      public function GC_CHALLENGE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var leftTime:int = patch.readShort();
         BattleHandler.GC_CHALLENGE(result,leftTime);
      }
      
      public function GC_BATTLE_VIDEO_DATA(patch:IDataInput) : void
      {
         var battleInfo:Array = PatchReader.instance.readBattle(patch);
         var battleVo:Vo_battle_lib_data = new Vo_battle_lib_data();
         battleVo.battleId = battleInfo[0];
         battleVo.selfZF = battleInfo[3];
         battleVo.targetZF = battleInfo[4];
         battleVo.units = battleInfo[5];
         battleVo.steps = battleInfo[6];
         battleVo.isWin = battleInfo[7];
         battleVo.roundStartMap = battleInfo[8];
         battleVo.isReplay = true;
         Model_Battle.addBattleVideoData(battleVo);
      }
   }
}

