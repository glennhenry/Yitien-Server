package com.yiTian.net.message.gc
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.GuideHandler;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.fund.FundConfig;
   import com.yiTian.view.modules.newerGuide.thirdNewerGuide.Child_panWeapon;
   import com.yiTian.view.modules.newerGuide.thirdNewerGuide.Model_thirdNewer;
   import com.yiTian.view.modules.newerGuide.thirdNewerGuide.PetIcon;
   import flash.utils.IDataInput;
   
   public class GuideGCMessage
   {
      
      public function GuideGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_GUIDE_SKILL] = this.GC_GUIDE_SKILL;
         index[MessageType.GC_GUIDE_PET] = this.GC_GUIDE_PET;
         index[MessageType.GC_GUIDE_HORSE] = this.GC_GUIDE_HORSE;
         index[MessageType.GC_GET_NEWPAWARD] = this.GC_GET_NEWPAWARD;
         index[MessageType.GC_THIRDNEWER_GUIDE] = this.GC_THIRDNEWER_GUIDE;
         index[MessageType.GC_THIRDNEWER_PETCHANGE] = this.GC_THIRDNEWER_PETCHANGE;
         index[MessageType.GC_THIRDNEWER_PETTIME] = this.GC_THIRDNEWER_PETTIME;
         index[MessageType.GC_BUYWEAPON] = this.GC_BUYWEAPON;
      }
      
      private function GC_BUYWEAPON(patch:IDataInput) : void
      {
         UIManager.centerBroadcast.addMsg("购买成功");
         if(UIManager.shoppingMall.visible)
         {
            UIManager.shoppingMall.visible = false;
         }
         Child_panWeapon.instance.getAward();
      }
      
      public function GC_GUIDE_SKILL(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         GuideHandler.GC_GUIDE_SKILL(result);
      }
      
      public function GC_GUIDE_PET(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         GuideHandler.GC_GUIDE_PET(result);
      }
      
      public function GC_GUIDE_HORSE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         GuideHandler.GC_GUIDE_HORSE(result);
      }
      
      public function GC_GET_NEWPAWARD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         GuideHandler.GC_GET_NEWPAWARD(result,patch);
      }
      
      private function GC_THIRDNEWER_GUIDE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         switch(result)
         {
            case 1:
               UIManager.actKaiFu.addBtn();
               break;
            case 2:
               FundConfig.init();
               break;
            case 3:
               PetIcon.show(1);
               break;
            case 4:
               PetIcon.show(2);
               PetIcon.show_btn(true);
               break;
            case 5:
               UIManager.special_btn.showMijing();
               break;
            case 101:
            case 102:
               PetIcon.show_btn(false);
               PetIcon.hide();
               break;
            case 103:
               PetIcon.show_btn(false);
               PetIcon.hide();
               Model_thirdNewer.showPan(Model_thirdNewer.PETINDEX);
         }
      }
      
      public function GC_THIRDNEWER_PETCHANGE(patch:IDataInput) : void
      {
         UIManager.centerBroadcast.addMsg("变身成功");
      }
      
      private function GC_THIRDNEWER_PETTIME(patch:IDataInput) : void
      {
         var time:int = patch.readInt();
         PetIcon.time = time;
         PetIcon.show_btn(false);
         PetIcon.show(1);
      }
   }
}

