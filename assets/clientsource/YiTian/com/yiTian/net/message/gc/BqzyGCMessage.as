package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.BqzyHandler;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.bianqiangzhiyin.Vo_Bqzy;
   import flash.utils.IDataInput;
   
   public class BqzyGCMessage
   {
      
      public function BqzyGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_BQZY_GETDATE] = this.GC_BQZY_GETDATE;
      }
      
      private function GC_BQZY_GETDATE(patch:IDataInput) : void
      {
         var vo:Vo_Bqzy = null;
         var count:int = patch.readByte();
         var arr:Vector.<Vo_Bqzy> = new Vector.<Vo_Bqzy>();
         var i:int = 0;
         while(i < count)
         {
            vo = new Vo_Bqzy();
            vo.index = i + 1;
            vo.status = patch.readByte();
            vo.params = patch.readInt();
            arr.push(vo);
            i++;
         }
         BqzyHandler.GC_BQZY_GETDATE(arr);
      }
   }
}

