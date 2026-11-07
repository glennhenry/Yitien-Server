package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.SkillHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class SkillGCMessage
   {
      
      private static var i_index:int = 0;
      
      private static var ii_index:int = 0;
      
      public function SkillGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_SKILL_QUERY] = this.GC_SKILL_QUERY;
         index[MessageType.GC_SKILL_STUDY] = this.GC_SKILL_STUDY;
         index[MessageType.GC_SET_BAR] = this.GC_SET_BAR;
         index[MessageType.GC_BAR_QUERY] = this.GC_BAR_QUERY;
      }
      
      public function GC_SKILL_QUERY(patch:IDataInput) : void
      {
         var temArr:Array = null;
         var result:int = patch.readByte();
         var skillIds_len:int = patch.readShort();
         var skillIds:Array = [];
         i_index = 0;
         while(i_index < skillIds_len)
         {
            temArr = [];
            temArr.push(patch.readInt());
            temArr.push(patch.readInt());
            skillIds.push(temArr);
            ++i_index;
         }
         SkillHandler.GC_SKILL_QUERY(result,skillIds);
      }
      
      public function GC_SKILL_STUDY(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var index:int = patch.readByte();
         var id:int = patch.readInt();
         var realId:int = patch.readInt();
         SkillHandler.GC_SKILL_STUDY(result,index,id,realId);
      }
      
      public function GC_SET_BAR(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var index_len:int = patch.readShort();
         var index:Array = [];
         i_index = 0;
         while(i_index < index_len)
         {
            index.push(patch.readByte());
            ++i_index;
         }
         var ids_len:int = patch.readShort();
         var ids:Array = [];
         i_index = 0;
         while(i_index < ids_len)
         {
            ids.push(patch.readInt());
            ++i_index;
         }
         SkillHandler.GC_SET_BAR(result,index,ids);
      }
      
      public function GC_BAR_QUERY(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var skillIds_len:int = patch.readShort();
         var skillIds:Array = [];
         i_index = 0;
         while(i_index < skillIds_len)
         {
            skillIds.push(patch.readInt());
            ++i_index;
         }
         SkillHandler.GC_BAR_QUERY(result,skillIds);
      }
   }
}

