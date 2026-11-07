package com.yiTian.net.message.gc
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.vip.VipPanel;
   import flash.utils.IDataInput;
   
   public class ChargeGuideGCMessage
   {
      
      public function ChargeGuideGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_TEMP_FASHION_ICON] = this.GC_TEMP_FASHION_ICON;
         index[MessageType.GC_GET_TEMP_FASHION] = this.GC_GET_TEMP_FASHION;
         index[MessageType.GC_TEMP_VIP_ICON] = this.GC_TEMP_VIP_ICON;
         index[MessageType.GC_VIP_STOP_USE] = this.GC_VIP_STOP_USE;
         index[MessageType.GC_GET_TEMP_VIP] = this.GC_GET_TEMP_VIP;
      }
      
      private function GC_TEMP_FASHION_ICON(patch:IDataInput) : void
      {
         var time:int = 0;
         var result:int = patch.readByte();
         switch(result)
         {
            case 1:
               UIManager.fashionGuide.show();
               break;
            case 2:
               UIManager.fashionGuide.move();
               break;
            case 3:
               time = patch.readInt();
               UIManager.fashionGuide.setTime(time);
               break;
            case 4:
               UIManager.fashionGuide.stop();
               break;
            case 5:
               UIManager.fashionGuide.removeIcon();
               UIManager.view_fsPan.callEff(1);
               break;
            case 6:
               UIManager.fashionGuide.removeIcon();
         }
      }
      
      private function GC_GET_TEMP_FASHION(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("领取成功！");
               UIManager.fashionGuide.backMove();
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("等级不够！");
         }
      }
      
      private function GC_GET_TEMP_VIP(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("领取成功！");
               UIManager.vipGuide.backMove();
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("等级不够！");
         }
      }
      
      private function GC_TEMP_VIP_ICON(patch:IDataInput) : void
      {
         var time:int = 0;
         var result:int = patch.readByte();
         switch(result)
         {
            case 1:
               UIManager.vipGuide.show();
               break;
            case 2:
               UIManager.vipGuide.move();
               break;
            case 3:
               time = patch.readInt();
               UIManager.vipGuide.setTime(time);
               UIManager.heroHead.getVipEff();
               VipPanel.canAddK = true;
               break;
            case 4:
               UIManager.vipGuide.stop();
               UIManager.vipGuide.removeIcon();
               UIManager.guidVip.visible = true;
               break;
            case 5:
               UIManager.vipGuide.removeIcon();
         }
      }
      
      private function GC_VIP_STOP_USE(patch:IDataInput) : void
      {
         UIManager.vipGuide.removeIcon();
         UIManager.view_fsPan.callEff(2);
      }
   }
}

