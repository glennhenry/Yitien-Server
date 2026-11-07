package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.data.config.Enum_BytesReadTypes;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.PataHandler;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.utils.PatchReader;
   import com.yiTian.view.modules.mainUIBtnContainer.View_mainUiBtn_container;
   import com.yiTian.view.modules.pata.PataVO;
   import flash.utils.IDataInput;
   
   public class PataGCMessage
   {
      
      public function PataGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_OVERLORD] = GC_OVERLORD;
         index[MessageType.GC_TTF_ENTRANCE] = GC_TTF_ENTRANCE;
         index[MessageType.GC_LEAVE_TTF] = GC_LEAVE_TTF;
         index[MessageType.GC_OVERLORD_LAYER_INFO] = GC_OVERLORD_LAYER_INFO;
         index[MessageType.GC_ENTER_TTF] = GC_ENTER_TTF;
         index[MessageType.GC_SKIP_BATTLE] = GC_SKIP_BATTLE;
         index[MessageType.GC_CHALLENGE_OVERLORD] = GC_CHALLENGE_OVERLORD;
         index[MessageType.GC_CHALLENGE_OVERLORD_STATE] = GC_CHALLENGE_OVERLORD_STATE;
         index[MessageType.GC_ENTER_TTF_TIMES] = GC_ENTER_TTF_TIMES;
         index[MessageType.GC_OVERLORD_INFO] = GC_OVERLORD_INFO;
         index[MessageType.GC_UPDATE_TIMES] = GC_UPDATE_TIMES;
      }
      
      public static function GC_OVERLORD(patch:IDataInput) : void
      {
         var pataTimes:int = 0;
         var overlordsList:String = null;
         var tiaoGuoCiShu:int = 0;
         var result:int = patch.readByte();
         if(result == 1)
         {
            pataTimes = patch.readByte();
            overlordsList = patch.readUTF();
            tiaoGuoCiShu = patch.readByte();
            overlordsList = Model_heFu.repNameByHero(overlordsList);
            PataHandler.GC_OVERLORD(pataTimes,overlordsList,tiaoGuoCiShu);
         }
      }
      
      public static function GC_TTF_ENTRANCE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         PataHandler.GC_TTF_ENTRANCE(result);
      }
      
      public static function GC_UPDATE_TIMES(patch:IDataInput) : void
      {
         var pataTimes:int = patch.readByte();
         PataHandler.GC_UPDATE_TIMES(pataTimes);
      }
      
      public static function GC_LEAVE_TTF(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var fuBenFlat:int = patch.readByte();
         PataHandler.GC_LEAVE_TTF(result,fuBenFlat);
      }
      
      public static function GC_OVERLORD_LAYER_INFO(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var layers:int = patch.readShort();
         var type:int = layers / 1000;
         layers %= 1000;
         var overlordsInfo:String = patch.readUTF();
         overlordsInfo = Model_heFu.repNameByHero(overlordsInfo);
         var tiaoGuoCiShu:int = patch.readByte();
         PataHandler.GC_OVERLORD_LAYER_INFO(result,layers,overlordsInfo,tiaoGuoCiShu,type);
      }
      
      public static function GC_ENTER_TTF(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var roleId:Number = LongUtil.readLong(patch);
         var roleName:String = patch.readUTF();
         roleName = Model_heFu.repNameByHero(roleName);
         PataHandler.GC_ENTER_TTF(result,roleId,roleName);
      }
      
      public static function GC_SKIP_BATTLE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var tiaoGuoCiShu:int = patch.readByte();
         PataHandler.GC_SKIP_BATTLE(result,tiaoGuoCiShu);
      }
      
      public static function GC_CHALLENGE_OVERLORD(patch:IDataInput) : void
      {
         var layers:int = 0;
         var overlordsStr:String = null;
         var result:int = patch.readByte();
         if(result == 1)
         {
            layers = patch.readByte();
            overlordsStr = patch.readUTF();
            overlordsStr = Model_heFu.repNameByHero(overlordsStr);
            PataHandler.GC_CHALLENGE_OVERLORD(result,layers,overlordsStr);
         }
      }
      
      public static function GC_CHALLENGE_OVERLORD_STATE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var state:int = patch.readByte();
         PataHandler.GC_CHALLENGE_OVERLORD_STATE(result,state);
      }
      
      public static function GC_ENTER_TTF_TIMES(patch:IDataInput) : void
      {
         var roleId:Number = NaN;
         var roleName:String = null;
         var state:int = patch.readByte();
         switch(state)
         {
            case -2:
               roleId = LongUtil.readLong(patch);
               roleName = patch.readUTF();
               roleName = Model_heFu.repNameByHero(roleName);
               if(roleId == GameUnitManager.hero.id)
               {
                  UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10384",1) + "</font>");
                  break;
               }
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + roleName + LangConfig.getWord("10385",1) + "</font>");
               break;
            case -1:
               roleId = LongUtil.readLong(patch);
               roleName = patch.readUTF();
               roleName = Model_heFu.repNameByHero(roleName);
               if(roleId == GameUnitManager.hero.id)
               {
                  UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10386",1) + "</font>");
                  break;
               }
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + roleName + LangConfig.getWord("10387",1) + "</font>");
               break;
            case 1:
               PataVO.fuBenFlat = patch.readByte();
               PataVO.tiaoGuoCiShu = patch.readByte();
               UIManager.mainUiBtnContainer.showLeaveBtn(View_mainUiBtn_container.PATA);
               UIManager.pataOverlordViewPanel.visible = false;
         }
      }
      
      public static function GC_OVERLORD_INFO(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var id:Number = LongUtil.readLong(patch);
         var name:String = patch.readUTF();
         name = Model_heFu.repNameByHero(name);
         var level:int = patch.readInt();
         var sex:int = patch.readByte();
         var job:int = patch.readByte();
         var equips:Array = PatchReader.instance.readPatch(Enum_BytesReadTypes.ROLEEQUIPS2,patch)[0];
         PataHandler.GC_OVERLORD_INFO(id,name,level,sex,job,equips);
      }
   }
}

