package com.yiTian.view.modules.npcDialog
{
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_npc_fun;
   import com.yiTian.data.config.Enum_quest_type;
   import com.yiTian.data.vo.quest.Vo_quest;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.QuestDailyManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.HtmlUtil;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   
   public class DialogItem extends WordItem
   {
      
      private static var questCanAccept:BitmapData;
      
      private static var questAccepted:BitmapData;
      
      private static var gongnenBmd:BitmapData;
      
      public static var pool:Array = [];
      
      public var abilityIndex:int;
      
      private var _quest:Vo_quest;
      
      public function DialogItem()
      {
         super();
         if(!questAccepted)
         {
            questAccepted = ComponentUtil.getBitmapData("NPC_Take",Global.npcTalk);
         }
         if(!questCanAccept)
         {
            questCanAccept = ComponentUtil.getBitmapData("NPC_Finish",Global.npcTalk);
         }
         if(!gongnenBmd)
         {
            gongnenBmd = ComponentUtil.getBitmapData("NPC_GongNeng",Global.npcTalk);
         }
         addEventListener(MouseEvent.CLICK,UIManager.npcDialog.selItem);
      }
      
      public static function getDialogItem() : DialogItem
      {
         return Boolean(pool.length) ? pool.pop() : new DialogItem();
      }
      
      public function update(ability:int) : void
      {
         _icon.bitmapData = gongnenBmd;
         this.abilityIndex = ability;
         word.color = ColorConstant.getColorInt(10);
         var temp:String = ability == Enum_npc_fun.QUEST_DAILY ? LangConfig.getWord("10612",1,QuestDailyManager.count) : "";
         word.htmlText = LangConfig.getWord("10613",1) + HtmlUtil.fontNoSize(Enum_npc_fun.getType(ability) + temp,"#92b7b8");
         word.x = _icon.x + _icon.width + 5;
      }
      
      public function set quest(value:Vo_quest) : void
      {
         _icon.bitmapData = value.status == -1 ? questCanAccept : questAccepted;
         var questStatus:String = value.status == -1 ? (value.type == Enum_quest_type.DAILY ? LangConfig.getWord("10612",1,QuestDailyManager.count) : LangConfig.getWord("10457",1)) : LangConfig.getWord("10460",1);
         word.htmlText = "<font color=\'" + ColorConstant.getColorStr(10) + "\'>[" + Enum_quest_type.getTypeName(value.type) + "] </font>" + "<font color=\'" + ColorConstant.getColorStr(4) + "\'>" + value.name + "</font>" + HtmlUtil.fontNoSize(questStatus,ColorConstant.getColorStr(ColorConstant.QUEST_YIWANCHENG));
         word.x = _icon.x + _icon.width + 5;
         this._quest = value;
      }
      
      public function get quest() : Vo_quest
      {
         return this._quest;
      }
      
      public function dispose() : void
      {
         this.abilityIndex = 0;
         this._quest = null;
         tiao.visible = false;
         pool.push(this);
      }
   }
}

