package com.yiTian.net.handler
{
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.DailyRemainManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import com.yiTian.view.modules.tianTi.Child_tianTi;
   import com.yiTian.view.modules.tianTi.Enum_ZhangMenRen;
   import com.yiTian.view.modules.tianTi.Model_ZhangMenRen;
   import com.yiTian.view.modules.tianTi.TianTiManager;
   import com.yiTian.view.modules.tianTi.View_tianTiPanel;
   
   public class tianTiHandle
   {
      
      public function tianTiHandle()
      {
         super();
      }
      
      public static function GC_ZMR(type:int) : void
      {
         var pnl:View_tianTiPanel = null;
         switch(type)
         {
            case 1:
               pnl = UIManager.tianTiPanel;
               (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pnl,function():void
               {
                  pnl.refreshIm();
               });
         }
      }
      
      public static function GC_TIANTI(wId:int, level:int, refreshTimes:int, recordLv:int) : void
      {
         var pnl:View_tianTiPanel = null;
         TianTiManager.curLv = level;
         TianTiManager.refreshTimes = refreshTimes;
         TianTiManager.recordLv = recordLv;
         pnl = UIManager.tianTiPanel;
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pnl,function():void
         {
            var tt:Child_tianTi = UIManager.tianTiPanel.tianTi;
            if(tt.isTween || TianTiManager.player != null && TianTiManager.player.isTween)
            {
               return;
            }
            pnl.tianTi.resetLayer();
            pnl.updateInfo(level);
         });
         TianTiManager.refreshCGFlag = false;
         DailyRemainManager.setCount(DailyRemainManager.ZHANG_MEN_REN,2 - refreshTimes);
      }
      
      public static function GC_TIANTIBATTLE(result:int, battleResult:int, lv:int, battleId:int, xinFa:int, gainXinFa:int) : void
      {
         var mName:String;
         var hName:String;
         var discrpt:String = null;
         var summry:String = null;
         var s:Function = null;
         TianTiManager.bInfo = [battleResult,lv,battleId,gainXinFa];
         UIManager.xinFaPanel.curXinFa = xinFa;
         mName = Data_lib.npc[Data_lib.tianTi[lv][0]][0];
         hName = GameUnitManager.hero.name;
         s = function():void
         {
            if(battleResult != 1)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("29414",2),1);
            }
            Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_END,s);
         };
         Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_END,s);
      }
      
      public static function GC_XINFA(result:int, xinfa:int, array:Array) : void
      {
         UIManager.xinFaPanel.curXinFa = xinfa;
         Model_ZhangMenRen.xinFaInfo = array;
         UIManager.xinFaPanel.xinFaInfo = array;
      }
      
      public static function GC_XINFACJ(result:int, arr:Array, xinfa:int, nxtInfo:Array) : void
      {
         if(result == 1)
         {
            UIManager.xinFaPanel.startCJ(arr,nxtInfo,10,2);
            UIManager.xinFaPanel.type = 1;
         }
         UIManager.xinFaPanel.curXinFa = xinfa;
         Model_ZhangMenRen.xinFaInfo = nxtInfo;
      }
      
      public static function GC_TIANTIAUTOB(infos:Array, bagFlag:int) : void
      {
         var lastInfo:Array = null;
         var lastLv:int = 0;
         var len:int = int(infos.length);
         if(len > 0)
         {
            lastInfo = infos[len - 1];
            lastLv = int(lastInfo[0]);
            infos.push(bagFlag);
            TianTiManager.curLv = lastLv;
            UIManager.tianTiPanel.tianTi.resetLayer();
            UIManager.tianTiPanel.updateInfo(lastLv);
            ModalUIManager.ZMRCleanUp.clearViewInfos();
            ModalUIManager.ZMRCleanUp.updateInfo(infos);
         }
      }
      
      public static function GC_XINFACJ2(results:Array, nxtInfos:Array, gains:Array, xf:int) : void
      {
         var arr:Array = null;
         var i:int = 0;
         Model_ZhangMenRen.xinFaInfo = nxtInfos.concat()[nxtInfos.length - 1];
         UIManager.xinFaPanel.startCJ2([results,nxtInfos]);
         Model_ZhangMenRen.comboGains = gains;
         var sums:Array = [0,0,0,0,0];
         for each(arr in gains)
         {
            i = 0;
            while(i < arr.length)
            {
               sums[i] += arr[i];
               i += 1;
            }
         }
         Model_ZhangMenRen.sums = sums;
         UIManager.xinFaPanel.curXinFa = xf;
      }
      
      public static function GC_TIANTIREWARDS(servData:Array) : void
      {
         var infos:Array = null;
         var otherRoleInfo:Array = null;
         var str:String = null;
         var i_index:int = 0;
         var npcName:String = null;
         var myInfo:Array = null;
         var pnl:View_tianTiPanel = null;
         otherRoleInfo = [];
         var oRep:String = LangConfig.getWord("29397",2);
         myInfo = [];
         i_index = 0;
         while(i_index < 5)
         {
            if(servData[i_index] != "" && servData[i_index] != " ")
            {
               infos = (servData[i_index] as String).split("_");
               npcName = Data_lib.npc[Data_lib.tianTi[infos[2]][0]][0];
               str = Util.rep(oRep,infos[1],npcName,Enum_BroadCastTool.instance.getItemText(int(infos[3]))) + "*" + infos[4];
               otherRoleInfo.push(str);
            }
            i_index += 1;
         }
         i_index = 5;
         while(i_index < 7)
         {
            if(servData[i_index] != "")
            {
               infos = (servData[i_index] as String).split("_");
               npcName = Data_lib.npc[Data_lib.tianTi[infos[2]][0]][0];
               str = Util.rep(oRep,LangConfig.getWord("10630",1),npcName,Enum_BroadCastTool.instance.getItemText(int(infos[3]))) + "*" + infos[4];
               myInfo.push(str);
            }
            i_index += 1;
         }
         pnl = UIManager.tianTiPanel;
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pnl,function():void
         {
            pnl.l1.update(otherRoleInfo);
            pnl.l1.goToAndPlay(0);
            pnl.l2.reRender(myInfo);
         });
      }
      
      public static function GC_XINFALVUP(result:int) : void
      {
         Model_ZhangMenRen.isGod = result == Enum_ZhangMenRen.XINFA_LV_SUC;
         if(Boolean(UIManager.xinFaPanel) && UIManager.xinFaPanel.visible)
         {
            UIManager.xinFaPanel.updataUI();
         }
      }
      
      public static function GC_XINFA_STATUS(result:int) : void
      {
         Model_ZhangMenRen.isGod = result == Enum_ZhangMenRen.XINFA_JJ_STATUS_HAS;
         if(Boolean(UIManager.xinFaPanel) && UIManager.xinFaPanel.visible)
         {
            UIManager.xinFaPanel.updataUI();
         }
      }
   }
}

