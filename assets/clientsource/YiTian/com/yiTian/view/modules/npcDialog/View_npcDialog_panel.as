package com.yiTian.view.modules.npcDialog
{
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Const_strImg;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.data.config.Enum_npc_fun;
   import com.yiTian.data.config.Enum_quest_step_type;
   import com.yiTian.data.config.Enum_quest_type;
   import com.yiTian.data.model.Model_quest;
   import com.yiTian.data.vo.quest.Vo_quest;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.NpcFunManager;
   import com.yiTian.manager.QuestGuiManager;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.QuestCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.NpcPanel;
   import com.yiTian.view.modules.guide.View_questGuiJian;
   import com.yiTian.view.modules.huangbang.Enum_Huangbang;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class View_npcDialog_panel extends NpcPanel
   {
      
      public static var lastNpc:Npc;
      
      private var NPC_DIALOG:MyTextField;
      
      private var Player_DIALOG:WordItem;
      
      private var NPCHead:Bitmap;
      
      private var questTFs:Array = [];
      
      private var funTFs:Array = [];
      
      private var quest_length:int = 0;
      
      private var fun_len:int = 0;
      
      private var huangbangSpecialQuest:Array = [16252,16253,16254,16258];
      
      public function View_npcDialog_panel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var back:Bitmap = ComponentUtil.getBitmap("Talk",this,null,Global.npcTalk);
         CloseButton = ComponentUtil.getButton("","NPC_Close",this,{
            "x":517,
            "y":7
         },Global.npcTalk);
         this.NPC_DIALOG = ComponentUtil.getTextField("",this,{
            "x":195,
            "y":11,
            "color":14145887,
            "realWidth":340,
            "multiline":true,
            "wordWrap":true,
            "leading":3
         });
         this.Player_DIALOG = new WordItem();
         this.Player_DIALOG.x = 16;
         this.Player_DIALOG.y = 112;
         addChild(this.Player_DIALOG);
         this.Player_DIALOG.addEventListener(MouseEvent.CLICK,this.playDialogLink);
         this.NPCHead = new Bitmap();
         this.NPCHead.x = 0;
         this.NPCHead.y = -14;
         addChild(this.NPCHead);
         addEventListener(MouseEvent.CLICK,this.doQuest);
      }
      
      private function doQuest(e:MouseEvent) : void
      {
         var selItem:DialogItem = null;
         if(Boolean(e) && e.target == CloseButton)
         {
            return;
         }
         if(this.quest_length == 1 && this.fun_len == 0)
         {
            selItem = this.questTFs[0] as DialogItem;
            if(Boolean(selItem.quest))
            {
               UIManager.questDialog.showQuest(bindNpc,selItem.quest);
               this.visible = false;
            }
         }
      }
      
      override public function show(npc:Npc) : void
      {
         var finish_quest:Vo_quest = null;
         var _h:int = 0;
         var quest:Vo_quest = null;
         var dialogItem:DialogItem = null;
         var item:DialogItem = null;
         var abb:int = 0;
         if(SceneConfig.getSceneType() == SceneConfig.HUANGBANG)
         {
            return;
         }
         if(npc.sysId == 52301 && Model_quest.checkCurMainQStepType(Enum_quest_step_type.BUY_SKILL_BOOK))
         {
            NpcFunManager.oper(Enum_npc_fun.ZA_HUO_DIAN,npc);
            return;
         }
         super.show(npc);
         lastNpc = npc;
         this.clear();
         Model_quest.checkArrow(npc.sysId);
         this.NPCHead.bitmapData = null;
         Utils.getSwfBitmap(Const_strImg.getNpcHeadSWF(Data_lib.npc[npc.sysId][Npc.HEAD]),this.NPCHead,null,this.npcLoadComp);
         this.NPC_DIALOG.htmlText = HtmlUtil.fontBr(npc.name + "：",ColorConstant.getColorStr(ColorConstant.NPC_NAME),14) + "    " + Data_lib.npc[npc.sysId][Npc.DIALOG];
         this.quest_length = 0;
         _h = 112;
         for each(quest in Model_quest.accepted)
         {
            if(quest.type != Enum_quest_type.SPECIAL)
            {
               if(this.huangbangSpecialQuest.indexOf(quest.id) == -1)
               {
                  if(Boolean(quest.status > 0) && Boolean(quest.finishStep) && quest.finishStep.npcId == bindNpc.sysId)
                  {
                     item = DialogItem.getDialogItem();
                     item.quest = quest;
                     item.x = 16;
                     item.y = _h;
                     _h += 20;
                     addChild(item);
                     this.questTFs.push(item);
                     ++this.quest_length;
                     finish_quest = quest;
                  }
                  else if(quest.status == 0 && quest.continueStep[quest.step - 1].npcId == bindNpc.sysId)
                  {
                     item = DialogItem.getDialogItem();
                     item.quest = quest;
                     item.x = 16;
                     item.y = _h;
                     _h += 20;
                     addChild(item);
                     this.questTFs.push(item);
                     ++this.quest_length;
                  }
               }
            }
         }
         for each(quest in Model_quest.canAccept)
         {
            if(!(quest.accept_level > GameUnitManager.hero.level || quest.id == Enum_Huangbang.START_QUEST_ID))
            {
               if(quest.acceptStep.npcId == bindNpc.sysId)
               {
                  if(this.huangbangSpecialQuest.indexOf(quest.id) == -1)
                  {
                     item = DialogItem.getDialogItem();
                     item.quest = quest;
                     item.x = 16;
                     item.y = _h;
                     _h += 20;
                     addChild(item);
                     this.questTFs.push(item);
                     ++this.quest_length;
                  }
               }
            }
         }
         if(Boolean(finish_quest) && this.quest_length == 1)
         {
            UIManager.questDialog.showQuest(npc,finish_quest);
            return;
         }
         this.fun_len = 0;
         var abilitys:Array = bindNpc.ability;
         var i:int = 0;
         for(; i < abilitys.length; i++)
         {
            abb = int(abilitys[i]);
            if(Global.pf != Enum_SPStr.GUANWANG)
            {
               if(abb == 27)
               {
                  continue;
               }
            }
            dialogItem = DialogItem.getDialogItem();
            dialogItem.update(abilitys[i]);
            dialogItem.x = 16;
            dialogItem.y = _h;
            _h += 20;
            addChild(dialogItem);
            this.funTFs.push(dialogItem);
            ++this.fun_len;
         }
         if(!this.quest_length && !this.fun_len)
         {
            this.Player_DIALOG.visible = true;
            this.Player_DIALOG.htmlText = HtmlUtil.fontNoSize(HtmlUtil.link("<u>" + LangConfig.getWord("10614",1) + "</u>","close"),ColorConstant.getColorStr(ColorConstant.GREEN));
         }
         else
         {
            this.Player_DIALOG.visible = false;
         }
         this.visible = true;
         if(Boolean(Model_quest.curMainQ) && Boolean(Model_quest.curMainQ.status == -1) && Model_quest.curMainQ.acceptStep.npcId == bindNpc.sysId)
         {
            this.showMainQGuide();
         }
      }
      
      private function npcLoadComp() : void
      {
         this.NPCHead.y = 102 - this.NPCHead.height + 1;
      }
      
      private function playDialogLink(e:MouseEvent) : void
      {
         this.visible = false;
         e.stopPropagation();
      }
      
      private function clear() : void
      {
         var delItem:DialogItem = null;
         var i:int = this.questTFs.length - 1;
         while(i >= 0)
         {
            delItem = this.questTFs[i];
            removeChild(delItem);
            delItem.dispose();
            this.questTFs.splice(i,1);
            i--;
         }
         i = this.funTFs.length - 1;
         while(i >= 0)
         {
            delItem = this.funTFs[i];
            removeChild(delItem);
            delItem.dispose();
            this.funTFs.splice(i,1);
            i--;
         }
      }
      
      public function selItem(e:MouseEvent) : void
      {
         e.stopPropagation();
         var selItem:DialogItem = e.target as DialogItem;
         if(Boolean(selItem.quest))
         {
            if(selItem.quest.type == Enum_quest_type.HUANGBANG && selItem.quest.status == -1)
            {
               QuestCGMessage.CG_QUEST_ACCEPT(selItem.quest.id);
            }
            else
            {
               UIManager.questDialog.showQuest(bindNpc,selItem.quest);
            }
         }
         else
         {
            NpcFunManager.oper(selItem.abilityIndex,bindNpc);
         }
         this.visible = false;
      }
      
      public function showMainQGuide() : void
      {
         var wid:int = 200;
         if(Boolean(this.questTFs.length))
         {
            wid = int(this.questTFs[0].width);
         }
         QuestGuiManager.addKuang(null,25,110,wid,23);
         QuestGuiManager.addJian(this,wid + 25,120,180);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(!value)
         {
            if(View_questGuiJian.instance.bindSpr == this)
            {
               UIManager.questTraceView.showMainQGuide();
            }
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 560) / 2;
         y = (Global.stage.stageHeight - 200) / 2;
      }
   }
}

