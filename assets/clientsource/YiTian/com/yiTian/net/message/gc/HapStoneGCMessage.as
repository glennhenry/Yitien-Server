package com.yiTian.net.message.gc
{
   import com.yiTian.Global;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.hapStone.Model_hapStone;
   import com.yiTian.view.modules.hapStone.View_hapStone;
   import flash.utils.IDataInput;
   
   public class HapStoneGCMessage
   {
      
      private static var statusArr1:Array = ["没对兑次数了","积分不够","背包空格子","兑换成功","属性丹已经吃满了，不能再继续购买了"];
      
      private static var statusArr2:Array = ["还没达标","已领","背包空格子","领取成功"];
      
      public function HapStoneGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_OPEN_HAP_PAN] = this.GC_OPEN_HAP_PAN;
         index[MessageType.GC_DUIHUAN_HAP] = this.GC_DUIHUAN_HAP;
         index[MessageType.GC_GETAWARD_HAP] = this.GC_GETAWARD_HAP;
         index[MessageType.GC_TOTAL_CORT] = this.GC_TOTAL_CORT;
      }
      
      private function GC_OPEN_HAP_PAN(patch:IDataInput) : void
      {
         var info1:String = patch.readUTF();
         Model_hapStone.data_of_duihuan = info1.split("_");
         var info2:String = patch.readUTF();
         Model_hapStone.data_of_jifen = info2.split("_");
         var nowCort:int = patch.readInt();
         var totalCort:int = patch.readInt();
         Model_hapStone.nowScore = nowCort;
         Model_hapStone.totalScore = totalCort;
         Global.control.sendNotification(View_hapStone.MSG_DATA_BACK,null);
         Global.control.sendNotification(View_hapStone.MSG_SINGLE_S,null);
      }
      
      private function GC_DUIHUAN_HAP(patch:IDataInput) : void
      {
         var index:int = patch.readByte();
         var leftNum:int = patch.readInt();
         var status:int = patch.readByte();
         var nowCort:int = patch.readInt();
         Model_hapStone.nowScore = nowCort;
         UIManager.centerBroadcast.addMsg(statusArr1[status - 1]);
         Global.control.sendNotification(View_hapStone.MSG_SINGLE_F,{
            "leftNum":leftNum,
            "index":index
         });
         if(status == 4)
         {
            if(Boolean(Model_hapStone.nowHapItem))
            {
               Model_hapStone.nowHapItem.get_award_eff();
            }
         }
      }
      
      private function GC_GETAWARD_HAP(patch:IDataInput) : void
      {
         var index:int = patch.readByte();
         var status:int = patch.readByte();
         var info:String = patch.readUTF();
         Model_hapStone.data_of_jifen = info.split("_");
         UIManager.centerBroadcast.addMsg(statusArr2[status - 1]);
         Global.control.sendNotification(View_hapStone.MSG_SINGLE_S,index);
         if(status == 4)
         {
            View_hapStone.instance.awartItem_vec[index - 1].getAwardEff();
         }
      }
      
      private function GC_TOTAL_CORT(patch:IDataInput) : void
      {
         var totalCort:int = patch.readInt();
         var nowCort:int = patch.readInt();
         Model_hapStone.totalScore = totalCort;
         Model_hapStone.nowScore = nowCort;
         Global.control.sendNotification(View_hapStone.MSG_DATA_BACK,null);
         Global.control.sendNotification(View_hapStone.MSG_SINGLE_S,null);
      }
   }
}

