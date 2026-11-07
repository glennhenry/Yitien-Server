package com.yiTian.net.message.gc
{
   import com.yiTian.net.message.MessageType;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.modules.actions.frids.Model_FI;
   import com.yiTian.view.modules.actions.frids.NewFriends;
   import flash.utils.IDataInput;
   
   public class InviteFriendNewGCMessage
   {
      
      public function InviteFriendNewGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_OPEN_NEWFRIEND_PAN] = this.GC_OPEN_NEWFRIEND_PAN;
         index[MessageType.GC_GETAWARD_NEWFRIEND] = this.GC_GETAWARD_NEWFRIEND;
      }
      
      private function GC_OPEN_NEWFRIEND_PAN(patch:IDataInput) : void
      {
         var len:int = patch.readByte();
         var i:int = 0;
         while(i < len)
         {
            Model_FI.getStatus[i] = patch.readByte();
            i++;
         }
         var pan:NewFriends = Singleton.getInstance(NewFriends);
         if(pan.visible)
         {
            pan.updateStatus();
         }
      }
      
      private function GC_GETAWARD_NEWFRIEND(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(Boolean(result))
         {
            Model_FI.getAward();
         }
      }
   }
}

