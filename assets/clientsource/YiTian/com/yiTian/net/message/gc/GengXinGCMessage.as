package com.yiTian.net.message.gc
{
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.activity.View_ActivityMainPanel;
   import flash.utils.IDataInput;
   
   public class GengXinGCMessage
   {
      
      public function GengXinGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_GENGXINGONGGAO] = this.GC_GENGXINGONGGAO;
      }
      
      public function GC_GENGXINGONGGAO(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         if(type == 1)
         {
            View_ActivityMainPanel.isGengXinPan = true;
            View_ActivityMainPanel.GC_SNATCH_LQROOM();
         }
      }
   }
}

