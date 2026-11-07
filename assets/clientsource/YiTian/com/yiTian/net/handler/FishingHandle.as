package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.fishing.Model_fishing;
   import com.yiTian.view.modules.fishing.View_fishingPlayerPanel;
   import com.yiTian.view.modules.fishing.View_myFishMark;
   import com.yiTian.view.modules.fishing.View_otherFishMark;
   import flash.utils.Dictionary;
   
   public class FishingHandle
   {
      
      public function FishingHandle()
      {
         super();
      }
      
      public static function GC_UPDATE_RIVERPLAYER_INFO(array:Array) : void
      {
         var obj:Object = null;
         UIManager.fishingPlayerPanel.fishingPlayerInfo = array;
         for each(obj in array)
         {
            Model_fishing.getInstance().fishingPlayerDic[obj.id] = obj;
         }
      }
      
      public static function GC_ENTER_RIVER(result:int, riverId:int) : void
      {
         if(result == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("23301",2));
            return;
         }
         if(result == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("29493",2));
            return;
         }
         UIManager.fishingPlayerPanel.visible = true;
         UIManager.fishingPlayerPanel.currentPageIndex = 0;
         Model_fishing.getInstance().currentRiverId = riverId;
         if(result == 1)
         {
            if(riverId <= 36)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("23303",2,riverId));
            }
            else
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("29420",2,riverId - 36));
            }
         }
      }
      
      public static function GC_XIAGAN(result:int) : void
      {
         var fmp:View_fishingPlayerPanel = null;
         switch(result)
         {
            case 1:
               fmp = UIManager.fishingPlayerPanel;
               fmp.fishingStatus = 2;
               fmp.resetTimer();
               fmp.counterStart();
               GameUnitManager.hero.status = Status.FISH;
               Model_fishing.getInstance().isFishing = true;
               break;
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("23304",2));
         }
      }
      
      public static function GC_FISHINGONTIME(fishId:int, exp:int) : void
      {
         var expStr:String = null;
         var dic:Dictionary = Data_lib.finshing;
         if(!dic[fishId])
         {
            return;
         }
         var str:String = dic[fishId][0];
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("23305",2,str));
         if((Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isIwan(Global.pf)) && GameUnitManager.hero.huangZuanLvl >= 1)
         {
            expStr = LangConfig.getWord("23306",2,exp.toString()) + "<font color=\'#ffff00\'>【黄钻经验加成 10%】</font>";
         }
         else if(Global.pf == Enum_SPStr.QQGAME && GameUnitManager.hero.ylDiaLvl >= 1)
         {
            expStr = LangConfig.getWord("23306",2,exp.toString()) + "<font color=\'#00ffff\'>【蓝钻经验加成 10%】</font>";
         }
         else if(Global.pf == Enum_SPStr.QQJIA)
         {
            expStr = LangConfig.getWord("23306",2,exp.toString()) + "<font color=\'#00ffff\'>【会员经验加成 10%】</font>";
         }
         else
         {
            expStr = LangConfig.getWord("23306",2,exp.toString());
         }
         UIManager.selfBroadcast.addMsg(expStr);
         UIManager.myFishMark.data1AtVoid = fishId;
         var fmp:View_fishingPlayerPanel = UIManager.fishingPlayerPanel;
         fmp.fishingStatus = 2;
         fmp.resetTimer();
         fmp.counterStart();
         UIManager.myFishMark.resetChoose();
      }
      
      public static function GC_SHOUGAN(result:int) : void
      {
         var fmp:View_fishingPlayerPanel = null;
         if(result == 1)
         {
            fmp = UIManager.fishingPlayerPanel;
            fmp.fishingStatus = 1;
            fmp.counterStop();
            if(GameUnitManager.hero.status == Status.FISH)
            {
               GameUnitManager.hero.status = Status.NOMAL;
               Model_fishing.getInstance().isFishing = false;
            }
            UIManager.myFishMark.visible = false;
         }
      }
      
      public static function GC_CHECK_FISH(id:Number, array:Array) : void
      {
         var myFishMark:View_myFishMark = null;
         var otherFishMark:View_otherFishMark = null;
         var isMyMark:Boolean = id == GameUnitManager.hero.id;
         if(isMyMark == true)
         {
            myFishMark = UIManager.myFishMark;
            myFishMark.visible = myFishMark.visible || true;
            myFishMark.data = array;
         }
         else
         {
            otherFishMark = UIManager.otherFishMark;
            otherFishMark.id = id;
            otherFishMark.data = array;
            otherFishMark.visible = true;
         }
      }
      
      public static function GC_FISH_TO_WHERE(result:int, where:int, id:int) : void
      {
         var dic:Dictionary = Data_lib.finshing;
         if(!dic[id])
         {
            return;
         }
         var name:String = dic[id][0];
         switch(where)
         {
            case 0:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("23307",2));
               break;
            case 1:
               switch(result)
               {
                  case 1:
                     UIManager.centerBroadcast.addMsg(LangConfig.getWord("23308",2,name));
                     break;
                  case 2:
                     UIManager.centerBroadcast.addMsg(LangConfig.getWord("23309",2));
               }
               break;
            case 2:
               switch(result)
               {
                  case 1:
                     UIManager.centerBroadcast.addMsg(LangConfig.getWord("23310",2));
                     break;
                  case 2:
                     UIManager.centerBroadcast.addMsg(LangConfig.getWord("23311",2));
               }
         }
      }
      
      public static function GC_SNATCH_FISH(result:int, exp:int) : void
      {
         switch(result)
         {
            case 1:
               UIManager.selfBroadcast.addMsg(LangConfig.getWord("23312",2,exp.toString()));
               break;
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("23313",2));
               break;
            case 3:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("23314",2));
         }
      }
      
      public static function GC_LEAVE_FISHING(result:int) : void
      {
         var mfInstance:Model_fishing = null;
         if(Boolean(result))
         {
            GameUnitManager.hero.status = Status.NOMAL;
            Model_fishing.getInstance().isFishing = false;
            UIManager.fishingPlayerPanel.counterStop();
            mfInstance = Model_fishing.getInstance();
            mfInstance.cleanFishingPlayerDic();
         }
      }
      
      public static function GC_SNATCH_ERROR(result:int) : void
      {
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("23315",2));
      }
      
      public static function GC_FISH_ROOM(result:int, array:Array) : void
      {
         Model_fishing.getInstance().roomMaxPage2 = 2 + result;
         Model_fishing.getInstance().fishRoomInfo.setData(array);
      }
   }
}

