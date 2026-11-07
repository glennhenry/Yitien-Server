package com.yiTian.net.message.gc
{
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_RechargeFeedback;
   import com.yiTian.data.model.Model_RechargeFeedback;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.rechargeFeedback.FeedBack_Btn;
   import com.yiTian.view.modules.rechargeFeedback.View_RechargeFeedback;
   import com.yiTian.view.modules.rechargeFeedback.reChangeBack.View_chargeBackPan;
   import com.yiTian.view.modules.wuXing.WuXingMter;
   import flash.utils.IDataInput;
   
   public class RechargeFeedbackGCMessage
   {
      
      public static var isUsingNewReCharge:Boolean = true;
      
      public function RechargeFeedbackGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_SHOW_FEEDBACK_ICON] = this.GC_SHOW_FEEDBACK_ICON;
         index[MessageType.GC_FEEDBACK_DATA] = this.GC_FEEDBACK_DATA;
         index[MessageType.GC_GET_FEEDBACK] = this.GC_GET_FEEDBACK;
      }
      
      private function GC_GET_FEEDBACK(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == 1)
         {
            if(isUsingNewReCharge)
            {
               WuXingMter.getPan(View_chargeBackPan,function(pan:View_chargeBackPan):void
               {
                  pan.getAward();
               });
            }
            else
            {
               View_RechargeFeedback.instance.itemList.flyToBag();
            }
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("80227",8));
         }
      }
      
      private function GC_SHOW_FEEDBACK_ICON(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         if(type == 1)
         {
            FeedBack_Btn.instance.show();
         }
         else
         {
            FeedBack_Btn.instance.hide();
         }
      }
      
      private function GC_FEEDBACK_DATA(patch:IDataInput) : void
      {
         var len:int;
         var i:int;
         var day:int = 0;
         day = patch.readByte();
         Model_RechargeFeedback.nowTarget = patch.readInt();
         Model_RechargeFeedback.nowRecharge = patch.readInt();
         if(Model_RechargeFeedback.nowRecharge > Data_lib.czfk[Enum_RechargeFeedback.MAX_TARGET][0])
         {
            Model_RechargeFeedback.nowRecharge = Data_lib.czfk[Enum_RechargeFeedback.MAX_TARGET][0];
         }
         len = patch.readByte();
         Model_RechargeFeedback.statusArr.length = 0;
         i = 0;
         while(i < len)
         {
            Model_RechargeFeedback.statusArr.push(patch.readByte());
            i++;
         }
         if(isUsingNewReCharge)
         {
            WuXingMter.getPan(View_chargeBackPan,function(pan:View_chargeBackPan):void
            {
               pan.updateData();
               pan.upTip(day);
            });
         }
         else
         {
            View_RechargeFeedback.instance.upData();
            View_RechargeFeedback.instance.upTip(day);
         }
      }
   }
}

