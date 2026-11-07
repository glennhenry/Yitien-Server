package com.yiTian.net.message.gc
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.CrossDartHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class CrossDartGCMessage
   {
      
      public function CrossDartGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_CROSSDART_OPENAC] = this.GC_CROSSDART_OPENAC;
         index[MessageType.GC_CROSSDART_EXIT] = this.GC_CROSSDART_EXIT;
         index[MessageType.GC_CROSSDART_TIMES] = this.GC_CROSSDART_TIMES;
         index[MessageType.CG_CROSSDART_QUEST] = this.CG_CROSSDART_QUEST;
         index[MessageType.CG_CROSSDART_CANENTER] = this.CG_CROSSDART_CANENTER;
      }
      
      private function CG_CROSSDART_CANENTER(patch:IDataInput) : void
      {
         UIManager.centerBroadcast.addMsg("服务器人数已满，请稍等几分钟再进入",1);
      }
      
      private function CG_CROSSDART_QUEST(patch:IDataInput) : void
      {
         var id:int = 0;
         var result:int = patch.readByte();
         var times:int = patch.readByte();
         if(times != 0)
         {
            id = patch.readInt();
         }
         else
         {
            id = 0;
         }
         CrossDartHandler.CG_CROSSDART_QUEST(result,times,id);
      }
      
      private function GC_CROSSDART_OPENAC(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var type:int = patch.readByte();
         CrossDartHandler.GC_CROSSDART_OPENAC(result,type);
      }
      
      private function GC_CROSSDART_EXIT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         CrossDartHandler.GC_CROSSDART_EXIT(result);
      }
      
      private function GC_CROSSDART_TIMES(patch:IDataInput) : void
      {
         var times:int = patch.readByte();
         CrossDartHandler.GC_CROSSDART_TIMES(times);
      }
   }
}

