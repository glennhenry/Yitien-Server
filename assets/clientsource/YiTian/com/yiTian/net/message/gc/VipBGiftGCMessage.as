package com.yiTian.net.message.gc
{
   import com.yiTian.data.config.Enum_vipBGift;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.VipBGiftHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class VipBGiftGCMessage
   {
      
      public function VipBGiftGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_VIPBG_OPENWIN] = this.GC_VIPBG_OPENWIN;
         index[MessageType.GC_VIPBG_GETGIFT] = this.GC_VIPBG_GETGIFT;
         index[MessageType.GC_VIPBG_BUYGIFT] = this.GC_VIPBG_BUYGIFT;
         index[MessageType.GC_VIPBG_ADDICON] = this.GC_VIPBG_ADDICON;
      }
      
      private function GC_VIPBG_OPENWIN(patch:IDataInput) : void
      {
         var state:int = 0;
         var i:int = 0;
         var arr:Array = [];
         var arr1:Array = [];
         i = 0;
         while(i < 5)
         {
            state = patch.readByte();
            arr.push(state);
            i++;
         }
         i = 0;
         while(i < 3)
         {
            state = patch.readByte();
            arr1.push(state);
            i++;
         }
         var date:int = patch.readByte();
         VipBGiftHandler.GC_VIPBG_OPENWIN(arr,arr1,date);
      }
      
      private function GC_VIPBG_GETGIFT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == Enum_vipBGift.isTrue)
         {
            VipBGiftHandler.GC_VIPBG_GETGIFT();
            UIManager.centerBroadcast.addMsg("领取成功！");
         }
         else
         {
            UIManager.centerBroadcast.addMsg("您不符合领取条件！");
         }
      }
      
      private function GC_VIPBG_BUYGIFT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == Enum_vipBGift.isTrue)
         {
            VipBGiftHandler.GC_VIPBG_BUYGIFT();
            UIManager.centerBroadcast.addMsg("购买成功！");
         }
         else
         {
            UIManager.centerBroadcast.addMsg("此礼包只能限购10个!");
         }
      }
      
      private function GC_VIPBG_ADDICON(patch:IDataInput) : void
      {
         var state:int = patch.readByte();
         VipBGiftHandler.GC_VIPBG_ADDICON(state);
      }
   }
}

