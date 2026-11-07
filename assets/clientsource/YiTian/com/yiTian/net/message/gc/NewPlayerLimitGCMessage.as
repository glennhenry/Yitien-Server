package com.yiTian.net.message.gc
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class NewPlayerLimitGCMessage
   {
      
      public function NewPlayerLimitGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_NewPlayer_Limit] = this.GC_NewPlayer_Limit;
      }
      
      private function GC_NewPlayer_Limit(patch:IDataInput) : void
      {
         var flag:int = patch.readInt();
         switch(flag)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("今日您邀请这个玩家次数已达上限");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("今日您的帮派邀请次数已达上限");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("今日您的江湖聊天次数已达上限");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("今日您的私聊人数已达上限");
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("今日您添加的好友次数已达上限");
               break;
            case 6:
               UIManager.centerBroadcast.addMsg("今日您的邮件发放次数已达上限");
         }
      }
   }
}

