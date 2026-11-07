package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.QingmingHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class QingmingGCMessage
   {
      
      public function QingmingGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_SHOW_ZHUAGUI_ICON] = this.GC_SHOW_ZHUAGUI_ICON;
         index[MessageType.GC_QINGMING_QUALITY] = this.GC_QINGMING_QUALITY;
         index[MessageType.GC_QINGMING_TASK_COUNT] = this.GC_QINGMING_TASK_COUNT;
         index[MessageType.GC_QINGMING_TASK_RESULT] = this.GC_QINGMING_TASK_RESULT;
         index[MessageType.GC_QINGMING_TASK_DATA] = this.GC_QINGMING_TASK_DATA;
         index[MessageType.GC_QINGMING_CATCHGHOSE_RESULT] = this.GC_QINGMING_CATCHGHOSE_RESULT;
         index[MessageType.GC_QINGMING_TASK_FAIL] = this.GC_QINGMING_TASK_FAIL;
         index[MessageType.GC_QINGMING_CATCHGHOSE_OK] = this.GC_QINGMING_CATCHGHOSE_OK;
         index[MessageType.GC_QINGMING_REFRESH_TIP] = this.GC_QINGMING_REFRESH_TIP;
      }
      
      private function GC_SHOW_ZHUAGUI_ICON(patch:IDataInput) : void
      {
         var str:String = patch.readUTF();
         QingmingHandler.GC_SHOW_ZHUAGUI_ICON(str);
      }
      
      private function GC_QINGMING_QUALITY(patch:IDataInput) : void
      {
         var currentQuality:int = patch.readByte();
         var count:int = patch.readByte();
         QingmingHandler.GC_QINGMING_QUALITY(currentQuality,count);
      }
      
      private function GC_QINGMING_TASK_COUNT(patch:IDataInput) : void
      {
         var count:int = patch.readByte();
         QingmingHandler.GC_QINGMING_TASK_COUNT(count);
      }
      
      private function GC_QINGMING_TASK_RESULT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         QingmingHandler.GC_QINGMING_TASK_RESULT(result);
      }
      
      private function GC_QINGMING_TASK_DATA(patch:IDataInput) : void
      {
         var id:int = patch.readInt();
         var monsterId:int = patch.readInt();
         var sceneId:int = patch.readInt();
         var x:int = patch.readInt();
         var y:int = patch.readInt();
         QingmingHandler.GC_QINGMING_TASK_DATA(id,monsterId,sceneId,x,y);
      }
      
      private function GC_QINGMING_CATCHGHOSE_RESULT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         QingmingHandler.GC_QINGMING_CATCHGHOSE_RESULT(result);
      }
      
      private function GC_QINGMING_TASK_FAIL(patch:IDataInput) : void
      {
         QingmingHandler.GC_QINGMING_TASK_FAIL();
      }
      
      private function GC_QINGMING_CATCHGHOSE_OK(patch:IDataInput) : void
      {
         var battleId:int = patch.readInt();
         var result:int = patch.readByte();
         var count:int = patch.readInt();
         QingmingHandler.GC_QINGMING_CATCHGHOSE_OK(battleId,result,count);
      }
      
      private function GC_QINGMING_REFRESH_TIP(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         QingmingHandler.GC_QINGMING_REFRESH_TIP(result);
      }
   }
}

