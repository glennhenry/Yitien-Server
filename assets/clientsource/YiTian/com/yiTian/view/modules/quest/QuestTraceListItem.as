package com.yiTian.view.modules.quest
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_quest_type;
   import com.yiTian.data.model.Model_quest;
   import com.yiTian.data.vo.quest.Vo_quest;
   import com.yiTian.data.vo.quest.Vo_questStep;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.QuestDailyManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.QuestCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.modules.huangbang.Model_Huangbang;
   import com.yiTian.view.modules.huangbang.View_HuangbangInfoPanel;
   import com.yiTian.view.modules.qingMing.Model_QingMing;
   import com.yiTian.view.modules.qingMing.Msg_QingMing;
   import com.yiTian.view.modules.qingMing.View_zhuaGuiPanel;
   import flash.display.Sprite;
   import flash.events.TextEvent;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class QuestTraceListItem extends Sprite
   {
      
      private static var pool:Array = [];
      
      private var questNameTf:MyTextField;
      
      private var curStepTF:MyTextField;
      
      private var data:Vo_quest;
      
      public function QuestTraceListItem()
      {
         super();
         this.questNameTf = ComponentUtil.getTextField("",this,{"color":16777215});
         this.questNameTf.mouseEnabled = true;
         this.questNameTf.addEventListener(TextEvent.LINK,this.linkReward);
         this.curStepTF = ComponentUtil.getTextField("",this,{
            "y":18,
            "color":16777215,
            "realWidth":190,
            "wordWrap":true
         });
         this.curStepTF.mouseEnabled = true;
         this.curStepTF.addEventListener(TextEvent.LINK,this.link);
      }
      
      public static function getItem() : QuestTraceListItem
      {
         if(Boolean(pool.length))
         {
            return pool.pop();
         }
         return new QuestTraceListItem();
      }
      
      public function init(value:Vo_quest) : void
      {
         var quest:Vo_quest = null;
         var canAccTip:String = null;
         var tempArr:Array = null;
         var link:String = null;
         var linkTo:String = null;
         var discrpt:String = null;
         var specialArr:Array = null;
         var specialStr:String = null;
         var specialTempStr:String = null;
         var step:Vo_questStep = null;
         var teamStr:String = null;
         var desc:String = null;
         var huangbangStr:String = null;
         this.data = value;
         var str:String = "<font color=\'#f9ff00\'>[" + Enum_quest_type.getTypeMiniName(value.type) + "] </font>" + " · " + this.data.name;
         quest = value as Vo_quest;
         if(quest.accept_level > GameUnitManager.hero.level)
         {
            str += HtmlUtil.fontNoSize(LangConfig.getWord("10456",1,quest.accept_level),"#ff0000");
         }
         else if(quest.status == -1)
         {
            if(quest.type == Enum_quest_type.DAILY)
            {
               canAccTip = LangConfig.getWord("10461",1,QuestDailyManager.count);
            }
            else if(quest.type == Enum_quest_type.PAOBIAO)
            {
               canAccTip = LangConfig.getWord("10461",1,Model_quest.paobiaoCount);
            }
            else if(quest.type == Enum_quest_type.BANG_HUI)
            {
               canAccTip = LangConfig.getWord("10461",1,Model_quest.bhzz_count);
            }
            else if(quest.type == Enum_quest_type.ZHUOGUI)
            {
               canAccTip = LangConfig.getWord("10461",1,11 - Model_QingMing._refreshTimes);
            }
            else if(quest.type == Enum_quest_type.HUANGBANG)
            {
               canAccTip = LangConfig.getWord("10461",1,Model_Huangbang.currentCount + 1 > 100 ? 100 : Model_Huangbang.currentCount + 1);
            }
            else
            {
               canAccTip = LangConfig.getWord("10457",1);
            }
            str += HtmlUtil.fontNoSize(canAccTip,"#ff00dd");
         }
         else if(quest.status == 0)
         {
            str += HtmlUtil.fontNoSize(LangConfig.getWord("10458",1),"#ff6600");
         }
         else if(quest.status == 1)
         {
            if(quest.type == Enum_quest_type.SPECIAL)
            {
               str += HtmlUtil.createLink(HtmlUtil.fontNoSize(LangConfig.getWord("10462",1),"#f9ff00"),true,"linkReward");
            }
            else if(quest.type == Enum_quest_type.PAOBIAO)
            {
               str += HtmlUtil.fontNoSize(LangConfig.getWord("10459",1),"#33ff00");
            }
            else
            {
               str += HtmlUtil.fontNoSize(LangConfig.getWord("10460",1),"#33ff00");
            }
         }
         this.questNameTf.htmlText = str;
         var linkStr:String = "";
         if(quest.status == -1)
         {
            if(quest.accept_level > GameUnitManager.hero.level)
            {
               if(Boolean(quest.pratice))
               {
                  tempArr = quest.pratice.match(/(\(|\（)(\d|_)*(\)|\）)/gi);
                  link = tempArr[tempArr.length - 1];
                  if(link != "" && link != null)
                  {
                     linkTo = link.replace(/(\(|\（|\)|\）)/gi,"");
                     discrpt = quest.pratice.replace(link,"");
                     specialArr = discrpt.match(/<m>[\s\S]*<m>/gi);
                     if(Boolean(specialArr.length))
                     {
                        specialStr = specialArr[0];
                        specialTempStr = specialStr.replace(/<m>/gi,"");
                        linkStr = "（" + discrpt.replace(specialStr,"<u>" + HtmlUtil.link(HtmlUtil.fontNoSize(specialTempStr,"#33CCFF"),"practice" + linkTo) + "</u>") + "）";
                     }
                  }
               }
            }
            if(quest.type == Enum_quest_type.HUANGBANG && Model_Huangbang.canLookBack == true)
            {
               this.curStepTF.htmlText = Model_Huangbang.getLookBackStr();
            }
            else
            {
               this.curStepTF.htmlText = quest.acceptStep.descript + linkStr;
            }
         }
         else if(quest.status == 0)
         {
            step = quest.continueStep[quest.step - 1];
            if(Boolean(step))
            {
               desc = step.descript;
               if(Boolean(step.count))
               {
                  desc += "（" + quest.count + "/" + step.count + "）";
               }
            }
            if(quest.id == 16669)
            {
               desc += "（" + quest.count + "步）";
            }
            teamStr = "";
            if(quest.id == 12006)
            {
               teamStr = "<u>" + HtmlUtil.link(HtmlUtil.fontNoSize(LangConfig.getWord("10463",1),"#33CCFF"),"team") + "</u>";
            }
            if(quest.id == Msg_QingMing.QUEST_ID)
            {
               this.curStepTF.htmlText = View_zhuaGuiPanel.instance.getTaskStr();
            }
            else
            {
               this.curStepTF.htmlText = desc + teamStr;
            }
         }
         else if(quest.type == Enum_quest_type.SPECIAL)
         {
            this.curStepTF.htmlText = quest.continueStep[quest.step - 1].descript;
         }
         else if(Boolean(quest.finishStep))
         {
            this.curStepTF.htmlText = quest.finishStep.descript;
         }
         if(quest.type == Enum_quest_type.HUANGBANG)
         {
            if(quest.status >= 0)
            {
               huangbangStr = this.curStepTF.htmlText;
               View_HuangbangInfoPanel.instance.updateText(huangbangStr,quest);
               if(quest.status == 0)
               {
                  this.curStepTF.htmlText = huangbangStr + "\n" + Model_Huangbang.getRewardStr();
               }
            }
         }
         if(quest.type == Enum_quest_type.DAILY_GUIDE)
         {
            this.questNameTf.visible = false;
            this.curStepTF.y = 0;
            this.curStepTF.htmlText = "<font color=\'#f9ff00\'>[" + Data_lib.quest[quest.id][0] + "] </font>" + " · " + this.curStepTF.htmlText;
         }
         else
         {
            this.questNameTf.visible = true;
            this.curStepTF.y = 18;
         }
      }
      
      private function linkReward(e:TextEvent) : void
      {
         GameScene.instance.onTextEventLink();
         QuestCGMessage.CG_QUEST_HERO_FINISH((this.data as Vo_quest).id);
         UIManager.questTraceView.beginPoint = new Point(Global.stage.mouseX,Global.stage.mouseY);
      }
      
      private function link(e:TextEvent) : void
      {
         var inter:int = 0;
         GameScene.instance.onTextEventLink();
         Model_quest.doLink(e.text);
         if(GameUnitManager.hero.level < 30)
         {
            View_quest_trace.isTextLinking = true;
            inter = int(setTimeout(function():void
            {
               clearTimeout(inter);
               View_quest_trace.isTextLinking = false;
            },1));
         }
      }
      
      public function clickFun() : void
      {
         var eventArr:Array = this.curStepTF.htmlText.match(/event\:(\w+)\"/);
         GameScene.instance.onTextEventLink();
         Model_quest.doLink(eventArr[1]);
      }
      
      public function dispose() : void
      {
         pool.push(this);
      }
   }
}

