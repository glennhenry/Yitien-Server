package com.yiTian.net.message.gc
{
   import com.yiTian.data.config.Enum_quest_id;
   import com.yiTian.data.model.Model_quest;
   import com.yiTian.net.handler.QuestHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class QuestGCMessage
   {
      
      private static var i_index:int = 0;
      
      private static var ii_index:int = 0;
      
      public function QuestGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_QUEST_LIST] = this.GC_QUEST_LIST;
         index[MessageType.GC_QUEST_ADD] = this.GC_QUEST_ADD;
         index[MessageType.GC_QUEST_DELETE] = this.GC_QUEST_DELETE;
         index[MessageType.GC_QUEST_MODIFY] = this.GC_QUEST_MODIFY;
         index[MessageType.GC_QUEST_MSG] = this.GC_QUEST_MSG;
         index[MessageType.GC_QUEST_DAILY_ACCEPT] = this.GC_QUEST_DAILY_ACCEPT;
         index[MessageType.GC_QUEST_DAILY_COUNT] = this.GC_QUEST_DAILY_COUNT;
         index[MessageType.GC_QUEST_DAILY_REFRESH] = this.GC_QUEST_DAILY_REFRESH;
         index[MessageType.GC_QUEST_HERO_ACCEPT] = this.GC_QUEST_HERO_ACCEPT;
         index[MessageType.GC_QUEST_HERO_REFRESH] = this.GC_QUEST_HERO_REFRESH;
         index[MessageType.GC_QUEST_HERO_FINISH] = this.GC_QUEST_HERO_FINISH;
         index[MessageType.GC_PAOBIAO_COUNT] = this.GC_PAOBIAO_COUNT;
         index[MessageType.GC_BHZZ_COUNT] = this.GC_BHZZ_COUNT;
      }
      
      public function GC_QUEST_LIST(patch:IDataInput) : void
      {
         var tempID:int = 0;
         var array_QUEST:Array = null;
         var result:int = patch.readByte();
         var accepted_len:int = patch.readShort();
         var accepted:Array = [];
         i_index = 0;
         while(i_index < accepted_len)
         {
            array_QUEST = [];
            array_QUEST.push(patch.readInt());
            array_QUEST.push(patch.readByte());
            array_QUEST.push(patch.readByte());
            array_QUEST.push(patch.readUTF());
            array_QUEST.push(patch.readShort());
            accepted.push(array_QUEST);
            ++i_index;
         }
         var canAccept_len:int = patch.readShort();
         var canAccept:Array = [];
         i_index = 0;
         while(i_index < canAccept_len)
         {
            array_QUEST = [];
            tempID = patch.readInt();
            array_QUEST.push(tempID);
            array_QUEST.push(patch.readByte());
            array_QUEST.push(patch.readByte());
            array_QUEST.push(patch.readUTF());
            array_QUEST.push(patch.readShort());
            if(!((tempID == 13002 || tempID == Enum_quest_id.KF_PAOBIAO) && Model_quest.paobiaoCount == 0))
            {
               canAccept.push(array_QUEST);
            }
            ++i_index;
         }
         QuestHandler.GC_QUEST_LIST(result,accepted,canAccept);
      }
      
      public function GC_QUEST_ADD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var questId:int = patch.readInt();
         var status:int = patch.readByte();
         var step:int = patch.readByte();
         var count:String = patch.readUTF();
         var leftTime:int = patch.readShort();
         QuestHandler.GC_QUEST_ADD(result,questId,status,step,count,leftTime);
      }
      
      public function GC_QUEST_MSG(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var questId:int = patch.readInt();
         QuestHandler.GC_QUEST_MSG(result,questId);
      }
      
      public function GC_QUEST_DELETE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var questId:int = patch.readInt();
         QuestHandler.GC_QUEST_DELETE(result,questId);
      }
      
      public function GC_QUEST_MODIFY(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var questId:int = patch.readInt();
         var status:int = patch.readByte();
         var step:int = patch.readByte();
         var count:String = patch.readUTF();
         var leftTime:int = patch.readShort();
         QuestHandler.GC_QUEST_MODIFY(result,questId,status,step,count,leftTime);
      }
      
      public function GC_QUEST_DAILY_ACCEPT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var questId:int = patch.readInt();
         var status:int = patch.readByte();
         var exp:int = patch.readInt();
         QuestHandler.GC_QUEST_DAILY_ACCEPT(result,questId,status,exp);
      }
      
      public function GC_QUEST_DAILY_COUNT(patch:IDataInput) : void
      {
         var count:int = patch.readByte();
         QuestHandler.GC_QUEST_DAILY_COUNT(count);
      }
      
      public function GC_QUEST_DAILY_REFRESH(patch:IDataInput) : void
      {
         var questId:int = patch.readInt();
         QuestHandler.GC_QUEST_DAILY_REFRESH(questId);
      }
      
      public function GC_QUEST_HERO_ACCEPT(patch:IDataInput) : void
      {
         var questId:int = patch.readInt();
         QuestHandler.GC_QUEST_HERO_ACCEPT(questId);
      }
      
      public function GC_QUEST_HERO_REFRESH(patch:IDataInput) : void
      {
         var questId:int = patch.readInt();
         QuestHandler.GC_QUEST_HERO_REFRESH(questId);
      }
      
      public function GC_QUEST_HERO_FINISH(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var questId:int = patch.readInt();
         QuestHandler.GC_QUEST_HERO_FINISH(result,questId);
      }
      
      public function GC_PAOBIAO_COUNT(patch:IDataInput) : void
      {
         var count:int = patch.readByte();
         if(count == 0)
         {
            Model_quest.delQuest(13002);
            Model_quest.delQuest(Enum_quest_id.KF_PAOBIAO);
         }
         QuestHandler.GC_PAOBIAO_COUNT(count);
      }
      
      public function GC_BHZZ_COUNT(patch:IDataInput) : void
      {
         var count:int = patch.readByte();
         QuestHandler.GC_BHZZ_COUNT(count);
      }
   }
}

