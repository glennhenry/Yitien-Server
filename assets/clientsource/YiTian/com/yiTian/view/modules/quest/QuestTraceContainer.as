package com.yiTian.view.modules.quest
{
   import com.ui.constants.ScrollAutoType;
   import com.ui.containers.Canvas;
   import com.yiTian.data.config.Enum_quest_type;
   import com.yiTian.data.vo.quest.Vo_quest;
   import flash.utils.Dictionary;
   
   public class QuestTraceContainer extends Canvas
   {
      
      private var items:Array = [];
      
      public function QuestTraceContainer(wid:int, hei:int, scrollDirection:String = "RIGHT", setWidth:int = 0)
      {
         super(wid,hei,scrollDirection,setWidth);
         scrollAutoType = ScrollAutoType.TO_TOP;
      }
      
      public function init(sour:Dictionary) : void
      {
         var quest:Vo_quest = null;
         var huangbangQuest:Vo_quest = null;
         var i:int = 0;
         var item:QuestTraceListItem = null;
         this.clear();
         var data:Array = [];
         for each(quest in sour)
         {
            if(Boolean(quest))
            {
               data.push(quest);
            }
         }
         data.sortOn("type",Array.NUMERIC);
         i = 0;
         while(i < data.length)
         {
            if((data[i] as Vo_quest).type == Enum_quest_type.HUANGBANG && (data[i] as Vo_quest).status == -1)
            {
               huangbangQuest = data[i];
               data.splice(i,1);
               break;
            }
            i++;
         }
         var len:int = int(data.length);
         i = 0;
         while(i < len)
         {
            quest = data[i];
            if(Boolean(huangbangQuest) && quest.type > Enum_quest_type.BRANCH)
            {
               item = QuestTraceListItem.getItem();
               item.init(huangbangQuest);
               addChild(item);
               this.items.push(item);
               huangbangQuest = null;
               item = QuestTraceListItem.getItem();
               item.init(quest);
               addChild(item);
               this.items.push(item);
            }
            else
            {
               item = QuestTraceListItem.getItem();
               item.init(quest);
               addChild(item);
               this.items.push(item);
            }
            i++;
         }
         if(Boolean(huangbangQuest))
         {
            item = QuestTraceListItem.getItem();
            item.init(huangbangQuest);
            addChild(item);
            this.items.push(item);
            huangbangQuest = null;
         }
         this.align();
      }
      
      override public function align() : void
      {
         var nowY:int = 0;
         var i:int = 0;
         while(i < this.items.length)
         {
            this.items[i].y = nowY;
            nowY += this.items[i].height + 2;
            i++;
         }
         super.align();
      }
      
      public function clickFirstQuest() : void
      {
         var item:QuestTraceListItem = null;
         if(Boolean(this.items[0]))
         {
            item = this.items[0];
            item.clickFun();
         }
      }
      
      private function clear() : void
      {
         var i:int = this.items.length - 1;
         while(i >= 0)
         {
            this.items[i].dispose();
            removeChild(this.items[i]);
            this.items.splice(i,1);
            i--;
         }
      }
   }
}

