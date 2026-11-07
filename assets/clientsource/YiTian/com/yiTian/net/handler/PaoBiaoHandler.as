package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.config.Enum_NPC_ID;
   import com.yiTian.data.model.Model_CrossDart;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.gameUnit.role.Player;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BattleCGMessage;
   import com.yiTian.net.message.cg.CrossDartCGMessage;
   import com.yiTian.net.message.cg.PaoBiaoCGMessage;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.activity.Model_actDaily;
   import com.yiTian.view.modules.paobiao.PaoBiaoVO;
   import com.yiTian.view.modules.paobiao.YunSongBiaoChePanel;
   import flash.text.TextFormatAlign;
   
   public class PaoBiaoHandler
   {
      
      private static var zoneId:int;
      
      public static var paoBiaoPlayer:Player;
      
      public function PaoBiaoHandler()
      {
         super();
      }
      
      public static function GC_PAOBIAO(result:int) : void
      {
         PaoBiaoVO.isTime = result;
         if(Boolean(result))
         {
            UIManager.paoBiaoPanel.showIcon();
            Model_actDaily.getInstance().updateAct(5,true);
            UIManager.smallMap.addTip(0);
         }
         else
         {
            UIManager.paoBiaoPanel.hideIcon();
            Model_actDaily.getInstance().updateAct(5,false);
         }
      }
      
      public static function GC_PAOBIAO_EXP_BS(result:int, bs:int, exp:int) : void
      {
         if(result == 1)
         {
            UIManager.selfBroadcast.addMsg(LangConfig.getWord("10336",1,bs,exp));
         }
         else if(result == 2)
         {
            UIManager.selfBroadcast.addMsg(LangConfig.getWord("10336",1,bs,exp));
         }
         else if(result == 3)
         {
            UIManager.selfBroadcast.addMsg(LangConfig.getWord("10337",1,bs,exp));
         }
      }
      
      public static function GC_PAOBIAO_NOTE(result:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10338",1));
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10339",1));
         }
      }
      
      public static function GC_YUNSONG_TIMES(times:int) : void
      {
         PaoBiaoVO.times = times;
         if(times > 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10340",1));
         }
         else
         {
            if(PaoBiaoVO.times == 0)
            {
               throw new Error("yunbiao data not 0");
            }
            if(Boolean(Npc.getNpcBySysid(Enum_NPC_ID.YTF_LIBIAOTOU)))
            {
               UIManager.yunSongBiaoChePanel.show(Npc.getNpcBySysid(Enum_NPC_ID.YTF_LIBIAOTOU));
            }
         }
      }
      
      public static function GC_YUNSONG(result:int) : void
      {
         if(result != 1)
         {
            if(result == -1)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("10341",1));
            }
            else if(result == -2)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("10342",1));
            }
            else if(result == -3)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("10343",1));
            }
            else if(result == -4)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("10318",1));
            }
            else if(result == -5)
            {
               UIManager.centerBroadcast.addMsg("要骑上坐骑后才能运镖");
            }
         }
      }
      
      public static function GC_JIEBIAO(result:int, otherId:Number, otherName:String) : void
      {
         switch(result)
         {
            case 0:
               if(Model_CrossDart.inCrossScence)
               {
                  CrossDartCGMessage.CG_CROSSDART_JIEBIAO(otherId,zoneId);
                  break;
               }
               BattleCGMessage.CG_BATTLE(otherId,UnitType.PLAYER,0);
               break;
            case 1:
               UIManager.centerBroadcast.addMsg(otherName + LangConfig.getWord("10344",1));
               break;
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("10345",1));
               break;
            case 3:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("10346",1));
               break;
            case 4:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("10347",1));
               break;
            case 5:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("10348",1));
               break;
            case 6:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("10349",1));
               break;
            case 7:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("10350",1));
               break;
            case 8:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("10644",1));
         }
      }
      
      public static function GC_JIEBIAO_RESULT(result:int, bId:int, otherName:String, isJie:int, bs:int, exp:int) : void
      {
         var str:String = null;
         var resultStr:String = null;
         var ss:Function = null;
         var s:Function = null;
         ss = function():void
         {
            UIManager.centerBroadcast.addMsg(resultStr,1);
            Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_END,ss);
         };
         if(Boolean(exp))
         {
            s = function():void
            {
               UIManager.centerBroadcast.addMsg(str,1);
               Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_END,s);
            };
            if(Boolean(result))
            {
               str = LangConfig.getWord("10355",1,exp,bs);
            }
            else
            {
               str = LangConfig.getWord("10356",1,exp,bs);
            }
            Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_END,s);
         }
         if(isJie == 1)
         {
            if(Boolean(result))
            {
               resultStr = LangConfig.getWord("10351",1,GameUnitManager.hero.name,otherName);
            }
            else
            {
               resultStr = LangConfig.getWord("10352",1,GameUnitManager.hero.name,otherName);
            }
         }
         else if(isJie == -1)
         {
            if(Boolean(result))
            {
               resultStr = LangConfig.getWord("10353",1,GameUnitManager.hero.name,otherName);
            }
            else
            {
               resultStr = LangConfig.getWord("10354",1,GameUnitManager.hero.name,otherName);
            }
         }
         Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_END,ss);
      }
      
      public static function GC_ZHI_BIAO_SHOW_ICON(result:int, showEff:int) : void
      {
         if(result == 0)
         {
            UIManager.paoBiaoPanel.hideIcon2();
         }
         else if(result == 1)
         {
            UIManager.paoBiaoPanel.showIcon2();
         }
         if(showEff == 0)
         {
            UIManager.paoBiaoPanel.hideEff2();
         }
         else if(showEff == 1)
         {
            UIManager.paoBiaoPanel.showEff2();
         }
      }
      
      public static function GC_ZHI_BIAO(result:int, state:int) : void
      {
         if(result == 0)
         {
            if(state == 0)
            {
               UIManager.centerBroadcast.addMsg("不在活动时间内");
            }
            else if(state == 1)
            {
               UIManager.questDialog.zhiBiaoHanlder();
            }
         }
         else if(result == 1)
         {
            if(state == 0)
            {
               GameUnitManager.hero.autoMove(Enum_NPC_ID.YTF_LIBIAOTOU);
            }
            else if(state == 1)
            {
               PaoBiaoCGMessage.CG_YUNSONG(0,0);
            }
         }
      }
      
      public static function GC_JIE_BIAO_BEFORE(bindSilver:int, exp:int) : void
      {
         var s:String = null;
         var b:String = null;
         var name:String = null;
         if(Boolean(paoBiaoPlayer))
         {
            s = "";
            if(paoBiaoPlayer.paoBiao == 1)
            {
               s = "普通";
            }
            else if(paoBiaoPlayer.paoBiao > 1 && paoBiaoPlayer.paoBiao < 6)
            {
               s = YunSongBiaoChePanel.vecPaoBiaoColor[paoBiaoPlayer.paoBiao - 2];
            }
            b = "";
            if(paoBiaoPlayer.party != "")
            {
               b = "<font color=\'#168854\'>（帮会：<font color=\'#248bb6\'>" + paoBiaoPlayer.party + "</font>）</font>";
            }
            else
            {
               b = "<font color=\'#168854\'>（帮会：<font color=\'#248bb6\'>无帮会</font>）</font>";
            }
            name = Model_heFu.repNameByHero(paoBiaoPlayer.name);
            zoneId = paoBiaoPlayer.zoneId;
            View_Alert.show(LangConfig.getWord("10543",1,name,s,b) + "<br><font color=\'#eeffff\'>成功抢夺获得：</font><font color=\'#11975a\'>绑银" + bindSilver + "两</font><br>" + "<font color=\'#0d8bc5\'>　　　　　　　　经验" + exp + "</font>",View_Alert.OK_CANCAL,okCallBack,null,null,null,500,"","",TextFormatAlign.CENTER);
         }
      }
      
      private static function okCallBack() : void
      {
         if(Boolean(Model_team.teamMumberInfo_data_save.length))
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10544",1));
            return;
         }
         PaoBiaoCGMessage.CG_JIEBIAO(paoBiaoPlayer.id);
         paoBiaoPlayer = null;
      }
      
      public static function GC_DA_TING_SHEN_BIAO(result:int, startTime:String, endTime:String, add:int) : void
      {
         UIManager.paoBiaoPanel.showIcon3(result,startTime,endTime,add);
      }
   }
}

