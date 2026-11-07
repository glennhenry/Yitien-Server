package com.yiTian.net.message.gc
{
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_NewRechargeFeedback;
   import com.yiTian.data.model.Model_NewRechargeFeedback;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.newRechargeFeedback.View_NewRechargeFeedback;
   import flash.utils.IDataInput;
   
   public class NewRechargeFeedbackGCMessage
   {
      
      public function NewRechargeFeedbackGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_NEW_SHOW_FEEDBACK_ICON] = this.GC_NEW_SHOW_FEEDBACK_ICON;
         index[MessageType.GC_NEW_FEEDBACK_DATA] = this.GC_NEW_FEEDBACK_DATA;
         index[MessageType.GC_NEW_GET_FEEDBACK] = this.GC_NEW_GET_FEEDBACK;
      }
      
      private function GC_NEW_GET_FEEDBACK(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == 1)
         {
            View_NewRechargeFeedback.instance.itemList.flyToBag();
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("80227",8));
         }
      }
      
      private function GC_NEW_SHOW_FEEDBACK_ICON(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         if(type == 1)
         {
            Model_NewRechargeFeedback.inTime = true;
         }
         else
         {
            Model_NewRechargeFeedback.inTime = false;
            if(View_NewRechargeFeedback.instance.visible)
            {
               View_NewRechargeFeedback.instance.visible = false;
            }
         }
      }
      
      private function GC_NEW_FEEDBACK_DATA(patch:IDataInput) : void
      {
         var day:int = patch.readByte();
         Model_NewRechargeFeedback.nowTarget = patch.readInt();
         Model_NewRechargeFeedback.nowRecharge = patch.readInt();
         if(Model_NewRechargeFeedback.nowRecharge > Data_lib.gcfk[Enum_NewRechargeFeedback.MAX_TARGET][0])
         {
            Model_NewRechargeFeedback.nowRecharge = Data_lib.gcfk[Enum_NewRechargeFeedback.MAX_TARGET][0];
         }
         var len:int = patch.readByte();
         Model_NewRechargeFeedback.statusArr.length = 0;
         var i:int = 0;
         while(i < len)
         {
            Model_NewRechargeFeedback.statusArr.push(patch.readByte());
            i++;
         }
         View_NewRechargeFeedback.instance.upData();
         View_NewRechargeFeedback.instance.upTip(day);
      }
   }
}

