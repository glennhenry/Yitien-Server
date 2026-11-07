package com.yiTian.net.message.gc
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.gongce.gcPanel;
   import flash.utils.IDataInput;
   
   public class GongCeGCMessage
   {
      
      public function GongCeGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_GongCe_Show] = GC_GongCe_Show;
      }
      
      public static function GC_GongCe_Show(patch:IDataInput) : void
      {
         var see:int = patch.readByte();
         UIManager.gcBtn.show(see);
         if(see == 0)
         {
            if(Boolean(gcPanel))
            {
               gcPanel.instance.visible = false;
            }
         }
      }
   }
}

