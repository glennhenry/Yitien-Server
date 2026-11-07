package com.yiTian.view.modules.quest
{
   import com.ui.containers.tree.ITreeItem;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.data.config.Enum_quest_type;
   import com.yiTian.data.vo.quest.Vo_quest;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.HtmlUtil;
   
   public class QuestPanelItem extends ITreeItem
   {
      
      private var tf:MyTextField;
      
      public function QuestPanelItem(wid:int)
      {
         super(wid);
         this.tf = ComponentUtil.getTextField("",this,{"x":20});
         buttonMode = true;
      }
      
      override public function set data(value:Object) : void
      {
         super.data = value;
         var quest:Vo_quest = value as Vo_quest;
         var str:String = data.name;
         if(quest.accept_level > GameUnitManager.hero.level)
         {
            str += HtmlUtil.fontNoSize(LangConfig.getWord("10456",1,quest.accept_level),"#ff0000");
         }
         else if(quest.status == -1)
         {
            str += HtmlUtil.fontNoSize(LangConfig.getWord("10457",1),"#ff00dd");
         }
         else if(quest.status == 0)
         {
            str += HtmlUtil.fontNoSize(LangConfig.getWord("10458",1),"#ff6600");
         }
         else if(quest.status == 1)
         {
            if(quest.type == Enum_quest_type.PAOBIAO)
            {
               str += HtmlUtil.fontNoSize(LangConfig.getWord("10459",1),"#33ff00");
            }
            else
            {
               str += HtmlUtil.fontNoSize(LangConfig.getWord("10460",1),"#33ff00");
            }
         }
         this.tf.htmlText = str;
      }
   }
}

