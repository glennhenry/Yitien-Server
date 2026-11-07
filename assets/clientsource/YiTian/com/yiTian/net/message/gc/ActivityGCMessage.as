package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.ActivityHandler;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.activityGuide.Model_ActivityGuide;
   import com.yiTian.view.modules.activityGuide.WuYueTip;
   import flash.utils.IDataInput;
   
   public class ActivityGCMessage
   {
      
      public function ActivityGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_ACTIVITY_ICON] = this.GC_ACTIVITY_ICON;
         index[MessageType.GC_ACTIVITY_CWJX_HIGHLINE] = this.GC_ACTIVITY_CWJX_HIGHLINE;
         index[MessageType.GC_ACTIVITY_CWJX_OPEN] = this.GC_ACTIVITY_CWJX_OPEN;
         index[MessageType.GC_ACTIVITY_CWJX_GETWARD] = this.GC_ACTIVITY_CWJX_GETWARD;
      }
      
      private function GC_ACTIVITY_ICON(patch:IDataInput) : void
      {
         Model_ActivityGuide.isShowIcon = true;
         WuYueTip.showTip();
      }
      
      private function GC_ACTIVITY_CWJX_HIGHLINE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         ActivityHandler.GC_ACTIVITY_CWJX_HIGHLINE(result);
      }
      
      private function GC_ACTIVITY_CWJX_OPEN(patch:IDataInput) : void
      {
         var o:Object = null;
         var value:int = patch.readInt();
         var len:int = patch.readByte();
         var arr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            o = new Object();
            o.index = patch.readByte();
            o.value = patch.readByte();
            arr.push(o);
            i++;
         }
         arr.sortOn("index",Array.NUMERIC);
         ActivityHandler.GC_ACTIVITY_CWJX_OPEN(value,arr);
      }
      
      private function GC_ACTIVITY_CWJX_GETWARD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var index:int = patch.readByte();
         trace("++++++++++++++",index);
         ActivityHandler.GC_ACTIVITY_CWJX_GETWARD(result,index - 1);
      }
   }
}

