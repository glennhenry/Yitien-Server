package com.yiTian.net.message.gc
{
   import com.yiTian.data.vo.Vo_MeiRiXianGou;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.MeiRiXianGouHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class MeiRiXianGouGCMessage
   {
      
      public function MeiRiXianGouGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_MRXG_OPEN] = this.GC_MRXG_OPEN;
         index[MessageType.GC_MRXG_BUY] = this.GC_MRXG_BUY;
      }
      
      private function GC_MRXG_OPEN(patch:IDataInput) : void
      {
         var vo:Vo_MeiRiXianGou = null;
         var reslut:int = patch.readByte();
         var type:int = patch.readByte();
         if(!reslut)
         {
            UIManager.centerBroadcast.addMsg("活动已结束！");
            return;
         }
         var len:int = patch.readByte();
         var vec:Vector.<Vo_MeiRiXianGou> = new Vector.<Vo_MeiRiXianGou>();
         var k:int = 0;
         while(k < len)
         {
            vo = new Vo_MeiRiXianGou();
            vo.index = patch.readByte();
            vo.count = patch.readShort();
            vec.push(vo);
            k++;
         }
         MeiRiXianGouHandler.GC_MRXG_OPEN(type,vec);
      }
      
      private function GC_MRXG_BUY(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         MeiRiXianGouHandler.GC_MRXG_BUY(result);
      }
   }
}

