package com.yiTian.net.message.gc
{
   import com.yiTian.Global;
   import com.yiTian.net.handler.DAUHandle;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.DAU.Model_DAU;
   import flash.utils.IDataInput;
   
   public class DAUGCMessage
   {
      
      public function DAUGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_DAU_ACT_REWARD] = this.GC_DAU_ACT_REWARD;
         index[MessageType.GC_DAU_GET_REWARD] = this.GC_DAU_GET_REWARD;
         index[MessageType.GC_DAU_HIDE_BTN] = this.GC_DAU_HIDE_BTN;
      }
      
      public function GC_DAU_ACT_REWARD(patch:IDataInput) : void
      {
         var state:int = 0;
         var info:Array = [];
         var i:int = 0;
         while(i < 3)
         {
            state = patch.readByte();
            info.push(state);
            i += 1;
         }
         DAUHandle.GC_DAU_ACT_REWARD(info);
      }
      
      public function GC_DAU_GET_REWARD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         DAUHandle.GC_DAU_GET_REWARD(result);
      }
      
      public function GC_DAU_HIDE_BTN(patch:IDataInput) : void
      {
         Global.DAUCtrl = false;
         Model_DAU.hideBTN();
      }
   }
}

