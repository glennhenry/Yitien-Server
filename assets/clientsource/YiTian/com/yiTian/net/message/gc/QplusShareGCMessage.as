package com.yiTian.net.message.gc
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.qplus.ViewInviteFirend;
   import com.yiTian.view.modules.qplus.ViewMicroBlog;
   import com.yiTian.view.modules.qplus.ViewShareEvent;
   import com.yiTian.view.modules.qplus.ViewWeixin;
   import flash.utils.IDataInput;
   
   public class QplusShareGCMessage
   {
      
      public function QplusShareGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_INVITE_ICON] = this.GC_INVITE_ICON;
         index[MessageType.GC_SHATE_EVENT] = this.GC_SHATE_EVENT;
         index[MessageType.GC_INVITE_FRIEND] = this.GC_INVITE_FRIEND;
         index[MessageType.GC_ROULETTE_NUM] = this.GC_ROULETTE_NUM;
         index[MessageType.GC_SHATE_GOAL] = this.GC_SHATE_GOAL;
         index[MessageType.GC_ROULETTE_ING] = this.GC_ROULETTE_ING;
         index[MessageType.GC_MICRO_ACTIVITY] = this.GC_MICRO_ACTIVITY;
         index[MessageType.GC_MICRO_BLOG] = this.GC_MICRO_BLOG;
         index[MessageType.GC_MICRO_GOAL] = this.GC_MICRO_GOAL;
         index[MessageType.GC_TOTAL_GOAD] = this.GC_TOTAL_GOAD;
      }
      
      public function GC_INVITE_ICON(patch:IDataInput) : void
      {
         var isLight:int = patch.readByte();
         if(isLight == 1)
         {
            UIManager.qplusShare.joinIconEff(true);
         }
         else if(isLight == 2)
         {
            UIManager.qplusShare.joinIconEff(false);
         }
      }
      
      public function GC_SHATE_EVENT(patch:IDataInput) : void
      {
         var i:int = 0;
         var shareArr:Array = new Array();
         i = 0;
         while(i < ViewShareEvent.SHARELEN)
         {
            shareArr.push(patch.readInt());
            i++;
         }
         ViewShareEvent.instance.shareData = shareArr;
      }
      
      public function GC_INVITE_FRIEND(patch:IDataInput) : void
      {
         var t:int = 0;
         var inviteArr:Array = new Array();
         t = 0;
         while(t < ViewInviteFirend.INVITELEN)
         {
            inviteArr.push(patch.readInt());
            t++;
         }
         ViewInviteFirend.instance.inviteData = inviteArr;
      }
      
      public function GC_ROULETTE_NUM(patch:IDataInput) : void
      {
         var roulNum:int = patch.readInt();
         UIManager.qplusShare.rouletteNum = roulNum;
      }
      
      public function GC_SHATE_GOAL(patch:IDataInput) : void
      {
         var goalId:int = patch.readInt();
      }
      
      public function GC_ROULETTE_ING(patch:IDataInput) : void
      {
         var giftId:int = patch.readInt();
         UIManager.qplusShare.rouletteGetId = giftId;
      }
      
      public function GC_MICRO_ACTIVITY(patch:IDataInput) : void
      {
         var isOpen:int = patch.readByte();
         var isFirst:int = patch.readByte();
         Utils.print("微信微博参数：",isOpen,isFirst);
         UIManager.qplusShare.microActivty(isOpen,isFirst);
      }
      
      public function GC_MICRO_BLOG(patch:IDataInput) : void
      {
         var i:int = 0;
         var state:int = 0;
         var stateArr:Array = new Array();
         i = 0;
         while(i < 4)
         {
            state = patch.readByte();
            stateArr.push(state);
            i++;
         }
         ViewMicroBlog.instance.state = stateArr;
      }
      
      public function GC_MICRO_GOAL(patch:IDataInput) : void
      {
         var goadId:int = patch.readByte();
         ViewWeixin.instance.curGoal = goadId;
      }
      
      public function GC_TOTAL_GOAD(patch:IDataInput) : void
      {
         var i:int = 0;
         var num:int = patch.readByte();
         var numArr:Array = new Array();
         i = 0;
         while(i < num)
         {
            numArr.push(patch.readByte());
            i++;
         }
         ViewWeixin.instance.microGoal(num,numArr);
      }
   }
}

