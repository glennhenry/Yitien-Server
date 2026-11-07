package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.ShenBingHandle;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class ShenBingGCMessage
   {
      
      public function ShenBingGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_SHENBING] = this.GC_SHENBING;
         index[MessageType.GC_SB_SWAP_SKILL] = this.GC_SB_SWAP_SKILL;
         index[MessageType.GC_CUILIAN] = this.GC_CUILIAN;
         index[MessageType.GC_SHENBING_UPDATE_SKILL] = this.GC_SHENBING_UPDATE_SKILL;
         index[MessageType.GC_SHENBING_BUY_SKILL] = this.GC_SHENBING_BUY_SKILL;
         index[MessageType.GC_SHENBING_GRID_ENABELD] = this.GC_SHENBING_GRID_ENABELD;
      }
      
      public function GC_SHENBING(patch:IDataInput) : void
      {
         var i:int = 0;
         var len:int = 0;
         var slotInfo:Array = null;
         var slotIndex:int = 0;
         var slotSkillID:int = 0;
         var idleInfo:Array = null;
         var gridIndex:int = 0;
         var ildeSkillID:int = 0;
         var currentLevel:int = patch.readByte();
         var currentExp:int = patch.readInt();
         len = patch.readByte();
         var useingSkills:Array = [];
         i = 0;
         while(i < len)
         {
            slotInfo = [];
            slotIndex = patch.readByte();
            slotSkillID = patch.readInt();
            slotInfo.push(slotIndex,slotSkillID);
            useingSkills.push(slotInfo);
            i += 1;
         }
         len = patch.readByte();
         var idleSkills:Array = [];
         i = 0;
         while(i < len)
         {
            idleInfo = [];
            gridIndex = patch.readByte();
            ildeSkillID = patch.readInt();
            idleInfo.push(gridIndex,ildeSkillID);
            idleSkills.push(idleInfo);
            i += 1;
         }
         ShenBingHandle.GC_SHENBING(currentLevel,currentExp,useingSkills,idleSkills);
      }
      
      public function GC_SB_USEING_SKILL(patch:IDataInput) : void
      {
      }
      
      public function GC_SB_SWAP_SKILL(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         ShenBingHandle.GC_SB_SWAP_SKILL(result);
      }
      
      public function GC_CUILIAN(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var currentLevel:int = patch.readByte();
         var currentExp:int = patch.readInt();
         ShenBingHandle.GC_CUILIAN(result,currentLevel,currentExp);
      }
      
      public function GC_SHENBING_UPDATE_SKILL(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         ShenBingHandle.GC_SHENBING_UPDATE_SKILL(result);
      }
      
      public function GC_SHENBING_BUY_SKILL(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var id:int = patch.readInt();
         ShenBingHandle.GC_SHENBING_BUY_SKILL(result,id);
      }
      
      public function GC_SHENBING_GRID_ENABELD(patch:IDataInput) : void
      {
         var gridIndex:int = patch.readByte();
         ShenBingHandle.GC_SHENBING_GRID_ENABELD(gridIndex);
      }
   }
}

