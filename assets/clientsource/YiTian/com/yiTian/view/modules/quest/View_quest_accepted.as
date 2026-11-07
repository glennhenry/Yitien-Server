package com.yiTian.view.modules.quest
{
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_quest_type;
   import com.yiTian.data.model.Model_quest;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.HuangbangCGMessage;
   import com.yiTian.net.message.cg.QuestCGMessage;
   import flash.events.MouseEvent;
   
   public class View_quest_accepted extends View_quest_canAccept
   {
      
      private var cb:CheckBox;
      
      private var Button_Giveup:Button;
      
      public function View_quest_accepted()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         this.cb = ComponentUtil.getCheckBox(LangConfig.getWord("10464",1),"CheckBox01",this,{
            "x":34,
            "y":389,
            "color":16777215
         },Global.Img_Cdm);
         this.Button_Giveup = ComponentUtil.getButton(LangConfig.getWord("10465",1),"Button_Four",this,{
            "x":449,
            "y":387,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_Giveup.addEventListener(MouseEvent.CLICK,this.giveUpQuest);
      }
      
      override public function update() : void
      {
         tree.init(Model_quest.accepted);
         resetInfo();
      }
      
      private function giveUpQuest(e:MouseEvent) : void
      {
         if(Boolean(curQuest))
         {
            if(curQuest.type == Enum_quest_type.SPECIAL)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("10466",1));
               return;
            }
            if(curQuest.type == Enum_quest_type.HUANGBANG)
            {
               HuangbangCGMessage.CG_GIVE_UP_HUANGBANG(curQuest.id);
            }
            else
            {
               QuestCGMessage.CG_QUEST_ABANDON(curQuest.id,1);
            }
         }
      }
   }
}

