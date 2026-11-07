package com.yiTian.net.handler
{
   import com.utils.ColorConstant;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_battle_delay_type;
   import com.yiTian.data.config.Enum_quest_lib_info;
   import com.yiTian.data.config.Enum_quest_reward_type;
   import com.yiTian.data.config.Enum_quest_type;
   import com.yiTian.data.config.guide.Enum_guide_quest;
   import com.yiTian.data.model.Model_quest;
   import com.yiTian.data.vo.quest.Vo_quest;
   import com.yiTian.effects.Effect_quest;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.manager.BattleResultManager;
   import com.yiTian.manager.DailyRemainManager;
   import com.yiTian.manager.GuideManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.QuestDailyManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.modules.guide.View_guide_finish;
   import com.yiTian.view.modules.huangbang.View_HuangbangInfoPanel;
   import com.yiTian.view.modules.newerGuide.Model_newer;
   import com.yiTian.view.modules.pet.PetPanel;
   import com.yiTian.view.modules.qingMing.Model_QingMing;
   import com.yiTian.view.modules.qingMing.Msg_QingMing;
   import com.yiTian.view.modules.qingMing.View_zhuaGuiPanel;
   
   public class QuestHandler
   {
      
      private static var _isFirst:Boolean = true;
      
      public function QuestHandler()
      {
         super();
      }
      
      public static function GC_QUEST_LIST(result:int, accepted:Array, canAccept:Array) : void
      {
         var mainQuest:Vo_quest = null;
         var len:int = 0;
         var quest:Vo_quest = null;
         var quest_lib_data:Array = null;
         var i:int = 0;
         var qid:int = 0;
         if(result == 1 || result == 2)
         {
            len = int(accepted.length);
            i = 0;
            while(i < len)
            {
               quest_lib_data = accepted[i];
               if(!Model_quest.list[quest_lib_data[Enum_quest_lib_info.QUEST_ID]])
               {
                  quest = new Vo_quest(quest_lib_data[Enum_quest_lib_info.QUEST_ID]);
               }
               else
               {
                  quest = Model_quest.list[quest_lib_data[Enum_quest_lib_info.QUEST_ID]];
               }
               quest.step = quest_lib_data[Enum_quest_lib_info.STEP];
               quest.status = quest_lib_data[Enum_quest_lib_info.STATUS];
               quest.count = quest_lib_data[Enum_quest_lib_info.COUNT];
               quest.leftTime = quest_lib_data[Enum_quest_lib_info.LEFT_TIME];
               if(quest.type == Enum_quest_type.MAIN)
               {
                  mainQuest = quest;
               }
               i++;
            }
            len = int(canAccept.length);
            i = 0;
            while(i < len)
            {
               quest_lib_data = canAccept[i];
               qid = int(quest_lib_data[Enum_quest_lib_info.QUEST_ID]);
               if(!Model_quest.list[qid])
               {
                  quest = new Vo_quest(qid);
               }
               else
               {
                  quest = Model_quest.list[qid];
               }
               delSameTypeQuest(quest.id,quest.type);
               quest.step = quest_lib_data[Enum_quest_lib_info.STEP];
               quest.status = -1;
               quest.count = quest_lib_data[Enum_quest_lib_info.COUNT];
               quest.leftTime = quest_lib_data[Enum_quest_lib_info.LEFT_TIME];
               if(quest.type == Enum_quest_type.MAIN)
               {
                  mainQuest = quest;
               }
               i++;
            }
            Npc.refreshQuestIcon();
            UIManager.questTraceView.update();
            UIManager.questPanel.update();
            if(result == 1)
            {
               Model_quest.AUTO_MOVE();
            }
            if(Boolean(mainQuest))
            {
               if(_isFirst || result == 1)
               {
                  Model_quest.curMainQ = mainQuest;
               }
               UIManager.questTraceView.showIconSp(quest.id);
            }
            if(_isFirst)
            {
               if(Boolean(mainQuest))
               {
                  UIManager.mainMenu.initMicroBtns(mainQuest.id);
                  UIManager.special_btn.initMicroBtns(mainQuest.id);
               }
               else
               {
                  UIManager.mainMenu.initMicroBtns(999999);
                  UIManager.special_btn.initMicroBtns(999999);
               }
               _isFirst = false;
            }
         }
      }
      
      private static function delSameTypeQuest(compareQuestId:int, compareQuestType:int) : void
      {
         var quest:Vo_quest = null;
         if(compareQuestType == Enum_quest_type.DAILY || compareQuestType == Enum_quest_type.PAOBIAO || compareQuestType == Enum_quest_type.BANG_HUI)
         {
            for each(quest in Model_quest.canAccept)
            {
               if(quest.id != compareQuestId && quest.type == compareQuestType)
               {
                  Model_quest.delQuest(quest.id);
               }
            }
         }
      }
      
      public static function GC_QUEST_ADD(result:int, questId:int, status:int, step:int, count:String, leftTime:int) : void
      {
         var quest:Vo_quest = null;
         if(result == 1)
         {
            if(!Model_quest.list[questId])
            {
               quest = new Vo_quest(questId);
            }
            else
            {
               quest = Model_quest.list[questId];
            }
            quest.step = step;
            quest.status = status;
            quest.count = count;
            quest.leftTime = leftTime;
            Npc.refreshQuestIcon();
            UIManager.questTraceView.update();
            UIManager.questPanel.update();
            if(questId == 10101)
            {
               Model_newer.newerGuideStart();
            }
            else if(questId == 16260)
            {
               UIManager.petPanel.openView(PetPanel.ZHUANGBEI,0);
            }
            Effect_quest.getItem().play(Effect_quest.ACCEPT_QUEST);
            Model_quest.curQuest = quest;
            Model_quest.AUTO_MOVE();
            if(quest.type == Enum_quest_type.MAIN)
            {
               Model_quest.curMainQ = quest;
            }
         }
         else if(result == 2)
         {
            UIManager.selfBroadcast.addMsg(LangConfig.getWord("10482",1));
         }
         else if(result == 3)
         {
            UIManager.selfBroadcast.addMsg(LangConfig.getWord("10483",1));
         }
         else if(result == 4)
         {
            UIManager.selfBroadcast.addMsg(LangConfig.getWord("10484",1));
         }
         else if(result == 5)
         {
            UIManager.selfBroadcast.addMsg(LangConfig.getWord("10485",1));
         }
         else if(result == 6)
         {
            UIManager.selfBroadcast.addMsg(LangConfig.getWord("10486",1));
         }
         else if(result == 7)
         {
            UIManager.selfBroadcast.addMsg(LangConfig.getWord("10487",1));
         }
         else if(result == 8)
         {
            UIManager.selfBroadcast.addMsg(LangConfig.getWord("10489",1));
         }
      }
      
      public static function GC_QUEST_MSG(result:int, questId:int) : void
      {
         var quest:Vo_quest = null;
         var data:Array = null;
         if(result == 1 || result == 5)
         {
            quest = Model_quest.list[questId];
            if(result == 1)
            {
               Model_quest.delQuest(questId);
               if(GuideManager.checkQuest(questId))
               {
                  data = Data_lib.guideQuest[questId];
                  GuideManager.showGuide(data[Enum_guide_quest.INFO],data[Enum_guide_quest.REWARD]);
               }
               if(questId == 10316)
               {
                  new View_guide_finish();
               }
               UIManager.mainMenu.updateMicro(questId);
               UIManager.special_btn.updateMicro(questId);
            }
            else
            {
               quest.step = 0;
               quest.status = -1;
               quest.count = "0";
               quest.leftTime = -1;
               Model_quest.AUTO_MOVE();
            }
            Npc.refreshQuestIcon();
            UIManager.questTraceView.update();
            UIManager.questPanel.update();
            if(Boolean(quest) && !(quest.id >= 16660 && quest.id <= 16668))
            {
               Effect_quest.getItem().play(Effect_quest.FINISH_QUEST);
            }
         }
         else if(result == 4)
         {
            UIManager.selfBroadcast.addMsg(LangConfig.getWord("10488",1));
         }
      }
      
      public static function GC_QUEST_DELETE(result:int, questId:int) : void
      {
         var quest:Vo_quest = null;
         if(questId == Msg_QingMing.QUEST_ID)
         {
            View_zhuaGuiPanel.instance.removeGui();
            Model_QingMing.data = [];
         }
         if(result == 1)
         {
            if(!Model_quest.list[questId])
            {
               quest = new Vo_quest(questId);
            }
            else
            {
               quest = Model_quest.list[questId];
            }
            quest.step = 0;
            quest.status = -1;
            quest.count = "0";
            quest.leftTime = -1;
         }
         else if(result == 2)
         {
            Model_quest.delQuest(questId);
            View_HuangbangInfoPanel.instance.reset();
         }
         Npc.refreshQuestIcon();
         UIManager.questTraceView.update();
         UIManager.questPanel.update();
      }
      
      public static function GC_QUEST_MODIFY(result:int, questId:int, status:int, step:int, count:String, leftTime:int) : void
      {
         var quest:Vo_quest = null;
         if(result == 1)
         {
            Model_quest.dealLastMainQ();
            if(!Model_quest.list[questId])
            {
               quest = new Vo_quest(questId);
            }
            else
            {
               quest = Model_quest.list[questId];
            }
            quest.step = step;
            quest.status = status;
            quest.count = count;
            quest.leftTime = leftTime;
            Npc.refreshQuestIcon();
            UIManager.questTraceView.update();
            UIManager.questPanel.update();
            Model_quest.curQuest = quest;
            Model_quest.AUTO_MOVE();
            if(quest.type == Enum_quest_type.MAIN)
            {
               Model_quest.curMainQ = quest;
            }
         }
      }
      
      public static function GC_QUEST_DAILY_ACCEPT(result:int, questId:int, status:int, exp:int) : void
      {
         var quest:Vo_quest = null;
         if(result == 1)
         {
            if(!Model_quest.list[questId])
            {
               quest = new Vo_quest(questId);
            }
            else
            {
               quest = Model_quest.list[questId];
            }
            quest.step = 1;
            quest.status = status;
            quest.count = "0";
            quest.leftTime = 0;
            quest.reward.baseProp.push(Enum_quest_reward_type.getTypeName(Enum_quest_reward_type.EXP) + HtmlUtil.fontNoSize(exp.toString(),ColorConstant.getColorStr(ColorConstant.MAP_NAME)));
            Npc.refreshQuestIcon();
            UIManager.questTraceView.update();
            UIManager.questPanel.update();
            Model_quest.curQuest = quest;
            Model_quest.AUTO_MOVE();
            Effect_quest.getItem().play(Effect_quest.ACCEPT_QUEST);
         }
      }
      
      public static function GC_QUEST_DAILY_COUNT(count:int) : void
      {
         QuestDailyManager.count = count;
         DailyRemainManager.setCount(DailyRemainManager.DAILY_QUEST,Boolean(count) ? int(11 - count) : count);
      }
      
      public static function GC_QUEST_DAILY_REFRESH(questId:int) : void
      {
         var quest:Vo_quest = null;
         if(!Model_quest.list[questId])
         {
            quest = new Vo_quest(questId);
         }
         else
         {
            quest = Model_quest.list[questId];
         }
         delSameTypeQuest(quest.id,quest.type);
         quest.step = 1;
         quest.status = -1;
         quest.count = "0";
         quest.leftTime = 0;
         Npc.refreshQuestIcon();
         Model_quest.AUTO_MOVE();
      }
      
      public static function GC_QUEST_HERO_ACCEPT(questId:int) : void
      {
         var quest:Vo_quest = null;
         if(!Model_quest.list[questId])
         {
            quest = new Vo_quest(questId);
         }
         else
         {
            quest = Model_quest.list[questId];
         }
         quest.step = 1;
         quest.status = 0;
         quest.count = "0";
         quest.leftTime = 0;
         UIManager.questTraceView.update();
         UIManager.questPanel.update();
         if(Global.isInBattle)
         {
            BattleResultManager.pushDelayInfo([Enum_battle_delay_type.HERO_QUEST]);
         }
         else
         {
            UIManager.questHeroPanel.showQuestBegin();
         }
      }
      
      public static function GC_QUEST_HERO_REFRESH(questId:int) : void
      {
         var quest:Vo_quest = null;
         if(!Model_quest.list[questId])
         {
            quest = new Vo_quest(questId);
         }
         else
         {
            quest = Model_quest.list[questId];
         }
         quest.step = 1;
         quest.status = 1;
         quest.count = "0";
         quest.leftTime = 0;
         UIManager.questTraceView.update();
         UIManager.questPanel.update();
      }
      
      public static function GC_QUEST_HERO_FINISH(result:int, questId:int) : void
      {
         if(result == 1)
         {
            Model_quest.delQuest(questId);
            UIManager.questTraceView.update();
            UIManager.questPanel.update();
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10489",1));
         }
      }
      
      public static function GC_PAOBIAO_COUNT(count:int) : void
      {
         Model_quest.paobiaoCount = count;
         DailyRemainManager.setCount(DailyRemainManager.PAO_BIAO,Boolean(count) ? int(4 - count) : count);
      }
      
      public static function GC_BHZZ_COUNT(count:int) : void
      {
         Model_quest.bhzz_count = count;
      }
   }
}

