package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_CrossType;
   import com.yiTian.data.config.Enum_NPC_ID;
   import com.yiTian.data.model.Model_CrossDart;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.CrossClanBattleCGMessage;
   import com.yiTian.net.message.cg.CrossDartCGMessage;
   import com.yiTian.net.message.cg.PaoBiaoCGMessage;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.crossClanBattle.Model_CrossClanBattle;
   import com.yiTian.view.modules.crossDart.CrossDartController;
   import com.yiTian.view.modules.paobiao.PaoBiaoPanel;
   import flash.text.TextFormatAlign;
   import flash.utils.setTimeout;
   
   public class CrossDartHandler
   {
      
      private static var bool:Boolean;
      
      public function CrossDartHandler()
      {
         super();
      }
      
      public static function CG_CROSSDART_QUEST(r:int, t:int, i:int) : void
      {
         Model_CrossDart.questId = i;
         CrossDartController.setQuestStatus(r,t);
      }
      
      public static function GC_CROSSDART_TIMES(times:int) : void
      {
         Model_CrossDart.times = times;
         CrossDartController.setTimes();
      }
      
      public static function GC_CROSSDART_EXIT(b:int) : void
      {
         switch(b)
         {
            case 1:
               Model_CrossClanBattle.port = 0;
               SocketManager.setChangeSocketFun(false);
               SocketManager.setKuafuSocketFun(false);
               CrossDartCGMessage.CG_CROSSDART_GOGOGO();
               CrossDartController.exitCrossWorld();
               Model_CrossDart.inCrossScence = false;
               break;
            case 0:
               UIManager.centerBroadcast.addMsg("退出失败！");
         }
      }
      
      public static function GC_CROSSDART_OPENAC(b:int, type:int) : void
      {
         var ok:Function;
         var okCallBack:Function = null;
         var okCallBack1:Function = null;
         var s1:String = null;
         var s2:String = null;
         okCallBack = function():void
         {
            if(bool)
            {
               UIManager.centerBroadcast.addMsg("请10秒后再尝试进入！",1);
               return;
            }
            Global.crossType = Enum_CrossType.CROSS_PAOBIAO;
            CrossClanBattleCGMessage.CG_ENTER_BATTLE_SCENE(Global.crossType,"");
            bool = true;
            setTimeout(function():void
            {
               bool = false;
            },10000);
         };
         okCallBack1 = function():void
         {
            if(GameUnitManager.hero.status == Status.SIT)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("60038",6));
               return;
            }
            GameUnitManager.hero.autoMove(Enum_NPC_ID.YTF_LIBIAOTOU);
         };
         var ss:Function = function(str:String):String
         {
            var vecStr:Vector.<String> = new <String>["年","月","日"];
            if(!str)
            {
               return "";
            }
            var s:String = "";
            s += str.substr(0,4) + vecStr[0];
            s += str.substr(5,2) + vecStr[1];
            s += str.substr(8,2) + vecStr[2];
            return s + str.substr(11,8);
         };
         if(b == 1)
         {
            switch(type)
            {
               case Model_CrossDart.TYPE_GO:
                  okCallBack();
                  break;
               case Model_CrossDart.TYPE_YES:
                  PaoBiaoCGMessage.CG_YUNSONG_TIMES();
                  break;
               case Model_CrossDart.TYPE_NPC:
                  View_Alert.show("  跨服运镖活动开启了，是否前往参与？<br><font color=\"#fe00000\">(15:00-16:00和21:00-22:00可获得150%经验)</font>",View_Alert.OK_CANCAL,okCallBack,null,null,null,400,"","",TextFormatAlign.CENTER);
                  break;
               case Model_CrossDart.TYPE_ICON:
                  View_Alert.show("  跨服运镖活动开启了，是否前往参与？<br><font color=\"#fe00000\">(15:00-16:00和21:00-22:00可获得150%经验)</font>",View_Alert.OK_CANCAL,okCallBack,null,null,null,400,"","",TextFormatAlign.CENTER);
            }
         }
         else if(b == 0)
         {
            switch(type)
            {
               case Model_CrossDart.TYPE_GO:
                  GameUnitManager.hero.autoMove(Enum_NPC_ID.YTF_LIBIAOTOU);
                  break;
               case Model_CrossDart.TYPE_YES:
                  GameUnitManager.hero.autoMove(Enum_NPC_ID.YTF_LIBIAOTOU);
                  break;
               case Model_CrossDart.TYPE_SB:
                  s1 = ss(PaoBiaoPanel._startTime);
                  s2 = ss(PaoBiaoPanel._endTime);
                  View_Alert.show("<font color=\"#039d4b\">" + s1 + "至" + s2 + "</font>参与运镖可获得额外<font color=\"#0367ab\">" + PaoBiaoPanel._add + "%</font>经验加成哦！",View_Alert.OK_CANCAL,okCallBack1,null,null,null,400,"","",TextFormatAlign.CENTER);
                  break;
               case Model_CrossDart.TYPE_NPC:
                  if(UIManager.paoBiaoPanel.hasIcon())
                  {
                     PaoBiaoCGMessage.CG_YUNSONG_TIMES();
                  }
                  else
                  {
                     View_Alert.show(LangConfig.getWord("10628",1),View_Alert.OK_CANCAL,function():void
                     {
                        PaoBiaoCGMessage.CG_YUNSONG_TIMES();
                     });
                  }
                  break;
               case Model_CrossDart.TYPE_ICON:
                  UIManager.paoBiaoPanel.visible = true;
            }
         }
         else
         {
            switch(type)
            {
               case Model_CrossDart.TYPE_GO:
                  GameUnitManager.hero.autoMove(Enum_NPC_ID.YTF_LIBIAOTOU);
                  break;
               case Model_CrossDart.TYPE_YES:
                  GameUnitManager.hero.autoMove(Enum_NPC_ID.YTF_LIBIAOTOU);
                  break;
               case Model_CrossDart.TYPE_SB:
                  if(UIManager.paoBiaoPanel.hasIcon())
                  {
                     okCallBack1();
                     break;
                  }
                  s1 = ss(PaoBiaoPanel._startTime);
                  s2 = ss(PaoBiaoPanel._endTime);
                  View_Alert.show("<font color=\"#039d4b\">" + s1 + "至" + s2 + "</font>参与运镖可获得额外<font color=\"#0367ab\">" + PaoBiaoPanel._add + "%</font>经验加成哦！",View_Alert.OK_CANCAL,okCallBack1,null,null,null,400,"","",TextFormatAlign.CENTER);
                  break;
               case Model_CrossDart.TYPE_NPC:
                  if(UIManager.paoBiaoPanel.hasIcon())
                  {
                     PaoBiaoCGMessage.CG_YUNSONG_TIMES();
                  }
                  else
                  {
                     View_Alert.show(LangConfig.getWord("10628",1),View_Alert.OK_CANCAL,function():void
                     {
                        PaoBiaoCGMessage.CG_YUNSONG_TIMES();
                     });
                  }
                  break;
               case Model_CrossDart.TYPE_ICON:
                  UIManager.paoBiaoPanel.visible = true;
            }
         }
      }
   }
}

