package com.yiTian.view.modules.quest
{
   import com.ui.containers.tree.Tree;
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.Enum_quest_type;
   import com.yiTian.data.model.Model_quest;
   import com.yiTian.data.vo.quest.Vo_quest;
   import com.yiTian.data.vo.quest.Vo_questStep;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.message.cg.HuangbangCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.qingMing.Msg_QingMing;
   import com.yiTian.view.modules.qingMing.View_zhuaGuiPanel;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   
   public class View_quest_canAccept extends Sprite
   {
      
      protected var tree:Tree;
      
      private var discriptTF:MyTextField;
      
      private var beginNpcTF:MyTextField;
      
      private var endNpcTF:MyTextField;
      
      private var curStepTF:MyTextField;
      
      private var questRewardTF:MyTextField;
      
      private var rewardGrids:Array = [];
      
      private var btnFast:Button;
      
      private var questTypes:Array;
      
      protected var curQuest:Vo_quest;
      
      public function View_quest_canAccept()
      {
         super();
         this.questTypes = [[1,LangConfig.getWord("10467",1)],[2,LangConfig.getWord("10468",1)],[3,LangConfig.getWord("10469",1)],[4,LangConfig.getWord("10470",1)],[5,LangConfig.getWord("10471",1)],[6,LangConfig.getWord("10472",1)],[7,LangConfig.getWord("10473",1)],[8,"捉鬼"],[9,"周"],[10,"宠物"],[11,"引导"]];
         this.init();
         visible = false;
      }
      
      protected function init() : void
      {
         var rewardGrid:View_Grid = null;
         this.tree = new Tree(160,275 + 26,QuestPanelItem,this.questTypes,this.selQuest,null,null);
         this.tree.x = 39;
         this.tree.y = 89 - 13;
         addChild(this.tree);
         ComponentUtil.getTextField(LangConfig.getWord("60261",6),this,{
            "x":203,
            "y":77,
            "color":14662240,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60262",6),this,{
            "x":203,
            "y":160,
            "color":14662240,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60263",6),this,{
            "x":203,
            "y":265,
            "color":14662240,
            "size":12,
            "leading":0
         });
         this.discriptTF = ComponentUtil.getTextField("",this,{
            "x":213,
            "y":102.1,
            "color":11904647,
            "realWidth":270,
            "wordWrap":true
         });
         this.beginNpcTF = ComponentUtil.getTextField(LangConfig.getWord("10474",1),this,{
            "x":213,
            "y":185,
            "color":11904647
         });
         this.endNpcTF = ComponentUtil.getTextField(LangConfig.getWord("10475",1),this,{
            "x":213,
            "y":205,
            "color":11904647
         });
         this.curStepTF = ComponentUtil.getTextField("",this,{
            "x":213,
            "y":225,
            "color":11904647,
            "wordWrap":true,
            "realWidth":250
         });
         this.questRewardTF = ComponentUtil.getTextField("",this,{
            "x":213,
            "y":290,
            "color":11904647
         });
         this.btnFast = ComponentUtil.getButton("快速完成","Button_Four",this,{
            "x":369,
            "y":387,
            "textColor":16184781,
            "callBack":this.fastFinish
         },Global.Img_Cdm);
         this.btnFast.visible = false;
         this.beginNpcTF.mouseEnabled = true;
         this.curStepTF.mouseEnabled = true;
         this.endNpcTF.mouseEnabled = true;
         this.beginNpcTF.addEventListener(TextEvent.LINK,this.textLink);
         this.curStepTF.addEventListener(TextEvent.LINK,this.textLink);
         this.endNpcTF.addEventListener(TextEvent.LINK,this.textLink);
         var i:int = 0;
         while(i < 6)
         {
            rewardGrid = new View_Grid();
            rewardGrid.type = Enum_type_grid.QUEST_MAIN_PANEL;
            rewardGrid.set_bmp_bg();
            rewardGrid.set_bmp_over();
            rewardGrid.x = 213 + i * 45;
            rewardGrid.y = 330;
            addChild(rewardGrid);
            this.rewardGrids.push(rewardGrid);
            i++;
         }
      }
      
      private function fastFinish(e:MouseEvent) : void
      {
         View_Alert.show("是否花费<font color=\'" + ColorConstant.getColorStr(ColorConstant.GREEN) + "\'>2元宝</font>快速完成该任务？",View_Alert.OK_CANCAL,function():void
         {
            HuangbangCGMessage.CG_FAST_FINISH_HUANGBANG(curQuest.id);
         });
      }
      
      private function selQuest(quest:Vo_quest) : void
      {
         var step:Vo_questStep = null;
         var desc:String = null;
         this.curQuest = quest;
         if(this.curQuest.type == Enum_quest_type.HUANGBANG && this.curQuest.status == 0)
         {
            this.btnFast.visible = true;
         }
         else
         {
            this.btnFast.visible = false;
         }
         this.discriptTF.htmlText = quest.discript;
         if(quest.type == Enum_quest_type.SPECIAL || quest.type == Enum_quest_type.DAILY_GUIDE || quest.type == Enum_quest_type.HUANGBANG && quest.status == 0 && Model_quest.huangbangTypeArr.indexOf(quest.acceptStep.stepType) != -1)
         {
            this.beginNpcTF.htmlText = LangConfig.getWord("10474",1);
            this.endNpcTF.htmlText = LangConfig.getWord("10475",1);
         }
         else
         {
            this.beginNpcTF.htmlText = LangConfig.getWord("10474",1) + "<u>" + HtmlUtil.link(HtmlUtil.fontNoSize(quest.acceptStep.npcName,ColorConstant.getColorStr(ColorConstant.NPC_NAME)),"npc" + quest.acceptStep.npcId) + "</u>";
            this.endNpcTF.htmlText = LangConfig.getWord("10475",1) + "<u>" + (quest.finishStep == null || quest.finishStep.npcName == null ? "无" : HtmlUtil.link(HtmlUtil.fontNoSize(quest.finishStep.npcName,ColorConstant.getColorStr(ColorConstant.NPC_NAME)),"npc" + quest.finishStep.npcId)) + "</u>";
         }
         if(quest.status == -1)
         {
            this.curStepTF.htmlText = quest.acceptStep.descript;
         }
         else if(quest.status == 0)
         {
            step = quest.continueStep[quest.step - 1];
            desc = step.descript;
            if(Boolean(step.count))
            {
               desc += "（" + quest.count + "/" + step.count + "）";
            }
            if(quest.id == Msg_QingMing.QUEST_ID)
            {
               this.curStepTF.htmlText = View_zhuaGuiPanel.instance.getTaskStr();
            }
            else
            {
               this.curStepTF.htmlText = desc;
            }
         }
         else if(quest.type == Enum_quest_type.SPECIAL)
         {
            this.curStepTF.htmlText = quest.continueStep[quest.step - 1].descript;
         }
         else
         {
            this.curStepTF.htmlText = quest.finishStep.descript;
         }
         var rewardStr:String = "";
         var i:int = 0;
         while(i < quest.reward.baseProp.length)
         {
            rewardStr += quest.reward.baseProp[i] + "    ";
            if(i % 3 == 2)
            {
               rewardStr += "\n";
            }
            i++;
         }
         this.questRewardTF.htmlText = rewardStr;
         i = 0;
         while(i < this.rewardGrids.length)
         {
            if(Boolean(quest.reward.items[i]))
            {
               this.rewardGrids[i].vo = quest.reward.items[i];
               this.rewardGrids[i].visible = true;
            }
            else
            {
               this.rewardGrids[i].visible = false;
            }
            i++;
         }
      }
      
      private function textLink(e:TextEvent) : void
      {
         Model_quest.doLink(e.text);
      }
      
      public function update() : void
      {
         this.tree.init(Model_quest.canAccept);
         this.resetInfo();
      }
      
      protected function resetInfo() : void
      {
         this.curQuest = null;
         this.discriptTF.htmlText = "";
         this.beginNpcTF.htmlText = "";
         this.endNpcTF.htmlText = "";
         this.curStepTF.htmlText = "";
         this.questRewardTF.htmlText = "";
         this.btnFast.visible = false;
         var i:int = 0;
         i = 0;
         while(i < this.rewardGrids.length)
         {
            this.rewardGrids[i].visible = false;
            i++;
         }
      }
   }
}

