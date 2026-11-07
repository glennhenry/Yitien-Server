package com.yiTian.data.model
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.config.Enum_quest_step_type;
   import com.yiTian.data.config.Enum_quest_type;
   import com.yiTian.data.vo.quest.Vo_quest;
   import com.yiTian.data.vo.quest.Vo_questStep;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.QuestGuiManager;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.FeiXingQiCGMessage;
   import com.yiTian.net.message.cg.InviteFriendNewCGMessage;
   import com.yiTian.net.message.cg.LingQiWuHunCGMessage;
   import com.yiTian.net.message.cg.PataCGMessage;
   import com.yiTian.net.message.cg.WanAnSiCGMessage;
   import com.yiTian.net.message.cg.XxlCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.FeiXingQi.Model_FeiXingQi;
   import com.yiTian.view.modules.Shopping.shoppingMall.ShoppingMallPan;
   import com.yiTian.view.modules.actions.frids.NewFriends;
   import com.yiTian.view.modules.farm.View_farm;
   import com.yiTian.view.modules.fubenSel.View_fuBenSaodanging;
   import com.yiTian.view.modules.guangMingDing.GuangMingDingConfig;
   import com.yiTian.view.modules.guide.View_questGuiJian;
   import com.yiTian.view.modules.huangbang.Model_Huangbang;
   import com.yiTian.view.modules.huangbang.View_HuangbangInfoPanel;
   import com.yiTian.view.modules.jianghulixian.View_Jianghulixian_icon;
   import com.yiTian.view.modules.newerGuide.thirdNewerGuide.Model_thirdNewer;
   import com.yiTian.view.modules.npcDialog.View_npcDialog_panel;
   import com.yiTian.view.modules.panel.Enum_panel_cast;
   import com.yiTian.view.modules.pet.PetPanel;
   import com.yiTian.view.modules.qiJu.QiJu_Btn;
   import com.yiTian.view.modules.qingMing.Model_QingMing;
   import com.yiTian.view.modules.wuXing.WuXingMter;
   import com.yiTian.view.modules.xiaoxiaole.View_xiaoxiaole;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class Model_quest
   {
      
      public static var curQuest:Vo_quest;
      
      private static var _curMainQ:Vo_quest;
      
      public static var paobiaoCount:int;
      
      public static var bhzz_count:int;
      
      public static var list:Dictionary = new Dictionary();
      
      public static var accepted:Dictionary = new Dictionary();
      
      public static var canAccept:Dictionary = new Dictionary();
      
      public static var huangbangTypeArr:Array = [12,13,20,27,28,29,30,31,32,33,34];
      
      public function Model_quest()
      {
         super();
      }
      
      public static function delQuest(id:int) : void
      {
         delete list[id];
         delete accepted[id];
         delete canAccept[id];
         if(Boolean(curQuest) && curQuest.id == id)
         {
            curQuest = null;
         }
         if(Boolean(_curMainQ) && _curMainQ.id == id)
         {
            _curMainQ = null;
         }
      }
      
      public static function hasAcceptQuest(questId:int) : Boolean
      {
         var quest:Vo_quest = null;
         for each(quest in accepted)
         {
            if(quest.id == questId)
            {
               return true;
            }
         }
         return false;
      }
      
      private static function jumpFromHuangbang(step:Vo_questStep) : void
      {
         var onEnterSceneOk:Function = null;
         onEnterSceneOk = function():void
         {
            var timeOut:int = 0;
            if(Model_Huangbang.canAutoMove == true)
            {
               timeOut = int(setTimeout(function():void
               {
                  if(step.stepType == Enum_quest_step_type.TONG_GUAN)
                  {
                     GameUnitManager.hero.autoMoveLocation(step.mapId);
                  }
                  else if(Boolean(step.npcId))
                  {
                     GameUnitManager.hero.autoMove(step.npcId,UnitType.NPC);
                  }
                  clearTimeout(timeOut);
               },200));
               Global.control.removeCallBack(Enum_MsgType.MSG_ASK_CHANGE_SCENE_OK,onEnterSceneOk);
               Model_Huangbang.canAutoMove = false;
            }
         };
         Model_Huangbang.isClickQuest = false;
         View_HuangbangInfoPanel.instance.leaveCb();
         Model_Huangbang.canAutoMove = true;
         Global.control.registerCallBack(Enum_MsgType.MSG_ASK_CHANGE_SCENE_OK,onEnterSceneOk);
      }
      
      public static function doLink(text:String) : void
      {
         var str:int = 0;
         var pan:ShoppingMallPan = null;
         var mapId:int = 0;
         var npcid:int = 0;
         var npc:Npc = null;
         if(View_fuBenSaodanging.isQingJiao)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("495",0));
            return;
         }
         if(!text)
         {
            return;
         }
         if(text.indexOf("open") != -1)
         {
            str = int(text.substr(4));
            if(huangbangTypeArr.indexOf(str) != -1)
            {
               Model_Huangbang.isClickQuest = false;
            }
            switch(str)
            {
               case Enum_quest_step_type.PET_XI:
                  UIManager.petPanel.visible = true;
                  break;
               case Enum_quest_step_type.ADD_FRIEND:
                  UIManager.joinFriendsPanel.showJoinFriends();
                  break;
               case Enum_quest_step_type.SHANG_CHENG:
                  Model_thirdNewer.showPan(Model_thirdNewer.WEAPONINDEX);
                  break;
               case Enum_quest_step_type.JING_JI:
                  UIManager.jjc_panel.visible = true;
                  break;
               case Enum_quest_step_type.EQUIP_STRENGTH:
                  UIManager.castPanel.visible = true;
                  break;
               case Enum_quest_step_type.EQUIP_HOLE:
               case Enum_quest_step_type.EQUIP_XIANG_QIAN:
                  UIManager.castPanel.visible = true;
                  UIManager.castPanel.updata_choose(Enum_panel_cast.EQUIP_HOLE);
                  break;
               case Enum_quest_step_type.PA_TA:
                  UIManager.pataOverlordViewPanel.visible = true;
                  PataCGMessage.CG_OVERLORD();
                  break;
               case Enum_quest_step_type.ADD_PARTY:
                  if(!GameUnitManager.hero.partyId)
                  {
                     UIManager.bangList.visible = true;
                  }
                  break;
               case Enum_quest_step_type.DAILY_QUEST:
                  GameUnitManager.hero.autoMove(51033,UnitType.NPC);
                  break;
               case Enum_quest_step_type.PET_CHENGZHANG:
                  UIManager.petPanel.visible = true;
                  break;
               case Enum_quest_step_type.ZHANGMENGREN:
                  (Singleton.getInstance(Delegate123) as Delegate123).dosomething(UIManager.tianTiPanel,function():void
                  {
                     UIManager.tianTiPanel.visible = true;
                  });
                  break;
               case Enum_quest_step_type.LENG_XINFA:
                  UIManager.xinFaPanel.visible = true;
                  break;
               case Enum_quest_step_type.BUY_SKILL_BOOK:
                  GameUnitManager.hero.autoMove(52301,UnitType.NPC);
                  break;
               case Enum_quest_step_type.LINPAI_EXCHANGE:
                  pan = Singleton.getInstance(ShoppingMallPan) as ShoppingMallPan;
                  pan.openView(1,1);
                  break;
               case Enum_quest_step_type.WU_LIN_SHAN_ZHUANG:
                  if(!UIManager.farm)
                  {
                     UIManager.farm = new View_farm();
                     UIManager.farm.init();
                  }
                  UIManager.farm.visible = true;
                  break;
               case Enum_quest_step_type.QINGMING_ZHUAGUI:
                  Model_QingMing.needFresh = false;
                  break;
               case Enum_quest_step_type.OPEN_MIJING:
                  UIManager.special_btn.smsHandle();
                  break;
               case Enum_quest_step_type.JUANLINGQI:
                  UIManager.lingQiWuHunPanel.visible = true;
                  LingQiWuHunCGMessage.CG_LINGQIWUHUN();
                  break;
               case Enum_quest_step_type.SEND_FRIEND_INVITE:
                  WuXingMter.getPan(NewFriends,function(pan:NewFriends):void
                  {
                     pan.visible = true;
                     InviteFriendNewCGMessage.CG_OPEN_NEWFRIEND_PAN();
                  });
                  break;
               case Enum_quest_step_type.EQUIP_WASH:
                  UIManager.castPanel.visible = true;
                  UIManager.castPanel.updata_choose(Enum_panel_cast.EQUIP_INLAY);
                  break;
               case Enum_quest_step_type.SEND_FRIEND_GIFT:
                  if(UIManager.zhufuPanel.needBless() == false)
                  {
                     UIManager.centerBroadcast.addMsg("你现在还没有好友可祝福");
                     return;
                  }
                  Global.delegate.dosomething(UIManager.zhufuPanel,function():void
                  {
                     UIManager.zhufuPanel.visible = true;
                  });
                  break;
               case Enum_quest_step_type.KUFUJINGJI:
                  Global.delegate.dosomething(UIManager.kuafujoin,UIManager.kuafujoin.show);
                  break;
               case Enum_quest_step_type.PET_SKILL:
                  if(Boolean(UIManager.petPanel.petVO))
                  {
                     UIManager.petPanel.visible = !UIManager.petPanel.visible;
                     if(UIManager.petPanel.visible)
                     {
                        UIManager.petPanel.openView(PetPanel.LIANHUA,0);
                     }
                     break;
                  }
                  UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10172",1) + "</font>");
                  break;
               case Enum_quest_step_type.HECHENG:
                  UIManager.castPanel.visible = true;
                  UIManager.castPanel.updata_choose(Enum_panel_cast.GEM_COMPOSE);
                  break;
               case Enum_quest_step_type.PETEQUIP_QIANGHUA:
                  UIManager.petPanel.openView(PetPanel.ZHUANGBEI,0);
                  break;
               case Enum_quest_step_type.DAILY_GUIDE_ZhangMenRen:
                  UIManager.tianTiPanel.visible = true;
                  break;
               case Enum_quest_step_type.DAILY_GUIDE_ChuangGuan:
                  if(UIManager.feiXingQiPanel.visible == false)
                  {
                     FeiXingQiCGMessage.CG_FXQINFO(Model_FeiXingQi.version);
                  }
                  break;
               case Enum_quest_step_type.DAILY_GUIDE_LingQiJuanXian:
                  UIManager.lingQiWuHunPanel.visible = true;
                  LingQiWuHunCGMessage.CG_LINGQIWUHUN();
                  break;
               case Enum_quest_step_type.DAILY_GUIDE_JiangHuLiXian:
                  View_Jianghulixian_icon.instance.onClickHandle(null);
                  break;
               case Enum_quest_step_type.DAILY_GUIDE_JingJi:
                  UIManager.jjc_panel.visible = true;
                  break;
               case Enum_quest_step_type.DAILY_GUIDE_GuangMingDing:
                  GuangMingDingConfig.btnClick(null);
                  break;
               case Enum_quest_step_type.DAILY_GUIDE_WanAnSi:
                  UIManager.wanAnSiPanel.visible = true;
                  WanAnSiCGMessage.CG_WANANSI_TIMES();
                  break;
               case Enum_quest_step_type.DAILY_GUIDE_ZhenLongQiJu:
                  QiJu_Btn.instance.onClick(null);
                  break;
               case Enum_quest_step_type.DAILY_GUIDE_TongTianFeng:
                  if(SceneConfig.getSceneType() == SceneConfig.COMMON)
                  {
                     UIManager.pataOverlordViewPanel.visible = !UIManager.pataOverlordViewPanel.visible;
                  }
                  if(UIManager.pataOverlordViewPanel.visible)
                  {
                     PataCGMessage.CG_OVERLORD();
                     break;
                  }
                  View_Alert.show("非主城地图不能进行此操作",1);
                  break;
               case Enum_quest_step_type.LOOK_BACK_HUANGBANG_QUEST:
                  Model_Huangbang.lookBackHuangBangQuest();
                  break;
               case Enum_quest_step_type.DAILY_GUIDE_JINGPO:
                  if(View_xiaoxiaole.getInstance().visible)
                  {
                     View_xiaoxiaole.getInstance().visible = false;
                     break;
                  }
                  XxlCGMessage.CG_XXL_OPENWIN();
            }
            return;
         }
         GameUnitManager.hero.lockTarget = null;
         GameUnitManager.hero.autoMoveID = 0;
         GameUnitManager.hero.autoMoveType = -1;
         if(text.indexOf("pick") != -1)
         {
            GameUnitManager.hero.autoMove(int(text.substr(4)),UnitType.NPC);
            return;
         }
         if(text.indexOf("map") != -1)
         {
            GameUnitManager.hero.autoMoveLocation(int(text.substr(3)),null);
            return;
         }
         if(text.indexOf("npc") != -1)
         {
            if(text.indexOf("_bang") != -1)
            {
               mapId = int(text.substring(text.indexOf("_bang") + 5));
               npcid = int(text.substr(3,5));
               if(mapId == Global.sceneID)
               {
                  if(SceneConfig.getSceneType() == SceneConfig.BANGPLANT)
                  {
                     npc = Npc.getBangHuiNpc(npcid);
                     GameUnitManager.hero.target = npc;
                  }
                  else
                  {
                     GameUnitManager.hero.autoMove(npcid,UnitType.NPC);
                  }
               }
               else if(SceneConfig.getSceneType() == SceneConfig.BANGPLANT)
               {
                  UIManager.mainUiBtnContainer.dispatchLeaveEvent();
               }
               else if(mapId == 12407)
               {
                  UIManager.bangPlant.visible = true;
               }
               else
               {
                  GameUnitManager.hero.autoMove(npcid,UnitType.NPC);
               }
            }
            else
            {
               GameUnitManager.hero.autoMove(int(text.substr(3)),UnitType.NPC);
            }
            return;
         }
         if(text.indexOf("practice") != -1)
         {
            GameUnitManager.hero.autoMove(int(text.substr(8)),UnitType.FUBENG_POINT);
            return;
         }
         if(text.indexOf("showHuangbangGift") != -1)
         {
            Model_Huangbang.showItemTip();
            return;
         }
         if(text.indexOf("team") != -1)
         {
            UIManager.mainMenu.teamCliHandle();
            return;
         }
      }
      
      public static function AUTO_MOVE() : void
      {
         var quest:Vo_quest = null;
         var step:Vo_questStep = null;
         if(View_fuBenSaodanging.isQingJiao)
         {
            return;
         }
         if(Boolean(curQuest))
         {
            switch(curQuest.status)
            {
               case -1:
                  GameUnitManager.hero.autoMove(curQuest.acceptStep.npcId);
                  break;
               case 0:
                  step = curQuest.continueStep[curQuest.step - 1];
                  if(Boolean(step && curQuest.type == Enum_quest_type.HUANGBANG && huangbangTypeArr.indexOf(step.stepType) == -1) && Boolean(SceneConfig.getSceneType() == SceneConfig.HUANGBANG) && Model_Huangbang.isClickQuest == true)
                  {
                     jumpFromHuangbang(step);
                     return;
                  }
                  if(step.stepType == Enum_quest_step_type.TONG_GUAN)
                  {
                     GameUnitManager.hero.autoMoveLocation(step.mapId);
                     break;
                  }
                  if(Boolean(step.npcId))
                  {
                     GameUnitManager.hero.autoMove(step.npcId);
                  }
                  break;
               case 1:
                  if(Boolean(curQuest.finishStep && curQuest.type == Enum_quest_type.HUANGBANG && huangbangTypeArr.indexOf(curQuest.finishStep.stepType) == -1) && Boolean(SceneConfig.getSceneType() == SceneConfig.HUANGBANG) && Model_Huangbang.isClickQuest == true)
                  {
                     jumpFromHuangbang(curQuest.finishStep);
                     return;
                  }
                  if(curQuest.id == 10007 || curQuest.id == 10102 || curQuest.id == 10113 || curQuest.id == 10207 || curQuest.id == 10213 || curQuest.id == 10214 || curQuest.id == 10222 || curQuest.id == 10302)
                  {
                     return;
                  }
                  if(Boolean(curQuest.finishStep))
                  {
                     GameUnitManager.hero.autoMove(curQuest.finishStep.npcId);
                  }
            }
            return;
         }
         if(!View_npcDialog_panel.lastNpc)
         {
            return;
         }
         var distance:int = Utils.dist(GameUnitManager.hero.global_x,GameUnitManager.hero.global_y,View_npcDialog_panel.lastNpc.global_x,View_npcDialog_panel.lastNpc.global_y);
         if(distance > 100000)
         {
            return;
         }
         var npc_id:int = View_npcDialog_panel.lastNpc.sysId;
         var type:int = UnitType.NPC;
         for each(quest in accepted)
         {
            if(quest.type == Enum_quest_type.SPECIAL)
            {
               continue;
            }
            switch(quest.status)
            {
               case -1:
                  if(quest.acceptStep.npcId == npc_id)
                  {
                     View_npcDialog_panel.lastNpc.interaction();
                     return;
                  }
                  break;
               case 0:
                  if((quest.continueStep[quest.step - 1] as Vo_questStep).npcId == npc_id)
                  {
                     View_npcDialog_panel.lastNpc.interaction();
                     return;
                  }
                  break;
               case 1:
                  if(Boolean(quest.finishStep) && quest.finishStep.npcId == npc_id)
                  {
                     View_npcDialog_panel.lastNpc.interaction();
                     return;
                  }
            }
         }
         for each(quest in canAccept)
         {
            if(quest.acceptStep.npcId == npc_id)
            {
               View_npcDialog_panel.lastNpc.interaction();
               return;
            }
         }
      }
      
      public static function set curMainQ(value:Vo_quest) : void
      {
         var step:Vo_questStep = null;
         if(value.id > 10316)
         {
            QuestGuiManager.addKuang(null,0,0,0,0);
            QuestGuiManager.addJian(null,0,0,0);
            return;
         }
         _curMainQ = value;
         if(Global.isFirstPlay)
         {
            return;
         }
         switch(_curMainQ.status)
         {
            case -1:
               if(UIManager.npcDialog.visible && Boolean(UIManager.npcDialog.bindNpc.sysId))
               {
                  UIManager.npcDialog.showMainQGuide();
                  break;
               }
               UIManager.questTraceView.showMainQGuide();
               break;
            case 0:
               step = _curMainQ.continueStep[_curMainQ.step - 1];
               if(step.stepType == Enum_quest_step_type.TONG_GUAN)
               {
                  UIManager.questTraceView.showMainQGuide();
                  break;
               }
               if(step.stepType == Enum_quest_step_type.PET_XI)
               {
                  if(UIManager.petPanel.visible)
                  {
                     UIManager.petPanel.showXiZhi();
                     break;
                  }
                  UIManager.questTraceView.showMainQGuide();
                  break;
               }
               if(step.stepType == Enum_quest_step_type.ADD_FRIEND)
               {
                  if(UIManager.joinFriendsPanel.visible)
                  {
                     UIManager.joinFriendsPanel.showJoinFriends();
                     break;
                  }
                  UIManager.questTraceView.showMainQGuide();
                  break;
               }
               if(step.stepType == Enum_quest_step_type.PET_CHENGZHANG)
               {
                  if(UIManager.petPanel.visible)
                  {
                     UIManager.petPanel.showChengZhang();
                     break;
                  }
                  UIManager.questTraceView.showMainQGuide();
                  break;
               }
               if(step.stepType == Enum_quest_step_type.EQUIP_STRENGTH)
               {
                  if(UIManager.castPanel.visible)
                  {
                     UIManager.castPanel.showQuestGuide();
                     break;
                  }
                  UIManager.questTraceView.showMainQGuide();
                  break;
               }
               if(step.stepType == Enum_quest_step_type.ZHANGMENGREN)
               {
                  if(UIManager.tianTiPanel.visible)
                  {
                     UIManager.tianTiPanel.showQuestGuide();
                     break;
                  }
                  UIManager.questTraceView.showMainQGuide();
                  break;
               }
               if(step.stepType == Enum_quest_step_type.LENG_XINFA)
               {
                  if(UIManager.xinFaPanel.visible)
                  {
                     UIManager.xinFaPanel.showQuestGuide();
                     break;
                  }
                  UIManager.questTraceView.showMainQGuide();
                  break;
               }
               if(step.stepType == Enum_quest_step_type.JING_JI)
               {
                  if(UIManager.jjc_panel.visible)
                  {
                     UIManager.jjc_panel.showQuestGuide();
                     break;
                  }
                  UIManager.questTraceView.showMainQGuide();
                  break;
               }
               if(step.stepType == Enum_quest_step_type.BUY_SKILL_BOOK)
               {
                  if(UIManager.zaHuoDian.visible && UIManager.zaHuoDian.bindNpc.sysId == 52301)
                  {
                     UIManager.zaHuoDian.showQuestGuide();
                     break;
                  }
                  UIManager.questTraceView.showMainQGuide();
               }
               break;
            case 1:
               if(Boolean(View_questGuiJian.instance.bindSpr) && Boolean(View_questGuiJian.instance.bindSpr.visible) && !(View_questGuiJian.instance.bindSpr is Npc))
               {
                  return;
               }
               if(UIManager.questDialog.visible && Boolean(UIManager.questDialog.bindNpc.sysId))
               {
                  UIManager.questDialog.showMainQGuide();
                  break;
               }
               UIManager.questTraceView.showMainQGuide();
         }
      }
      
      public static function dealLastMainQ() : void
      {
         var step:Vo_questStep;
         if(!_curMainQ)
         {
            return;
         }
         if(_curMainQ.status != 0)
         {
            return;
         }
         step = _curMainQ.continueStep[_curMainQ.step - 1];
         if(step.stepType == Enum_quest_step_type.PET_XI)
         {
            setCloseGuide(UIManager.petPanel);
         }
         else if(step.stepType == Enum_quest_step_type.ADD_FRIEND)
         {
            UIManager.joinFriendsPanel.visible = false;
         }
         else if(step.stepType == Enum_quest_step_type.PET_CHENGZHANG)
         {
            setCloseGuide(UIManager.petPanel);
         }
         else if(step.stepType == Enum_quest_step_type.EQUIP_STRENGTH)
         {
            closeBindSpr(null);
         }
         else if(step.stepType == Enum_quest_step_type.ZHANGMENGREN)
         {
            (Singleton.getInstance(Delegate123) as Delegate123).dosomething(UIManager.tianTiPanel,function():void
            {
               UIManager.tianTiPanel.visible = false;
            });
         }
         else if(step.stepType == Enum_quest_step_type.LENG_XINFA)
         {
            setCloseGuide(UIManager.xinFaPanel);
         }
         else if(step.stepType == Enum_quest_step_type.JING_JI)
         {
            setCloseGuide(UIManager.jjc_panel);
         }
         else if(step.stepType == Enum_quest_step_type.BUY_SKILL_BOOK)
         {
            setCloseGuide(UIManager.zaHuoDian);
         }
      }
      
      private static function setCloseGuide(view:Sprite) : void
      {
         if(view.visible)
         {
            view["showCloseGuide"]();
            Global.stage.addEventListener(MouseEvent.CLICK,closeBindSpr);
         }
      }
      
      private static function closeBindSpr(e:MouseEvent) : void
      {
         Global.stage.removeEventListener(MouseEvent.CLICK,closeBindSpr);
         var bindSpr:Sprite = View_questGuiJian.instance.bindSpr;
         if(bindSpr.visible && bindSpr != UIManager.questTraceView && bindSpr.parent != UIManager.questTraceView)
         {
            View_questGuiJian.instance.bindSpr.visible = false;
         }
         if(Boolean(_curMainQ) && _curMainQ.status == 1)
         {
            UIManager.questTraceView.showMainQGuide();
         }
      }
      
      public static function get curMainQ() : Vo_quest
      {
         return _curMainQ;
      }
      
      public static function checkCurMainQStepType(type:int) : Boolean
      {
         if(!curMainQ)
         {
            return false;
         }
         if(curMainQ.status != 0)
         {
            return false;
         }
         var step:Vo_questStep = curMainQ.continueStep[curMainQ.step - 1];
         if(step.stepType != type)
         {
            return false;
         }
         return true;
      }
      
      public static function checkArrow(id:int) : void
      {
         var step:Vo_questStep = null;
         if(!UIManager.arrow)
         {
            return;
         }
         if(Boolean(curQuest))
         {
            switch(curQuest.status)
            {
               case -1:
                  if(curQuest.acceptStep.npcId == id)
                  {
                     UIManager.arrow.hide();
                  }
                  break;
               case 0:
                  step = curQuest.continueStep[curQuest.step - 1];
                  if(step.stepType == Enum_quest_step_type.TONG_GUAN)
                  {
                     if(step.mapId == id)
                     {
                        UIManager.arrow.hide();
                     }
                     break;
                  }
                  if(step.npcId == id)
                  {
                     UIManager.arrow.hide();
                  }
                  break;
               case 1:
                  if(curQuest.finishStep.npcId == id)
                  {
                     UIManager.arrow.hide();
                  }
            }
         }
      }
   }
}

