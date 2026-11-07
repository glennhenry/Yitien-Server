package com.yiTian.net.message.gc
{
   import com.yiTian.data.Data_lib;
   import com.yiTian.net.handler.XiaoFeiTuanGouHandle;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.xiaofeituangou.TuanGouVo;
   import flash.utils.IDataInput;
   
   public class XiaoFeiTuanGouGCMessage
   {
      
      public function XiaoFeiTuanGouGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_XFTG_OPEN] = this.GC_XFTG_OPEN;
         index[MessageType.GC_XFTG_OPEN2] = this.GC_XFTG_OPEN2;
         index[MessageType.GC_XFTG_GETAWARD] = this.GC_XFTG_GETAWARD;
         index[MessageType.GC_XFTG_BUY] = this.GC_XFTG_BUY;
         index[MessageType.GC_XFTG_BROCAST] = this.GC_XFTG_BROCAST;
      }
      
      private function GC_XFTG_OPEN(patch:IDataInput) : void
      {
         var vo:TuanGouVo = null;
         var len:int = patch.readByte();
         var arr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            vo = new TuanGouVo();
            vo.id = patch.readByte();
            vo.yuanbao = patch.readInt();
            vo.status = patch.readByte();
            vo.type = Data_lib.xiaofeituangou[vo.id][0];
            arr.push(vo);
            i++;
         }
         if(Boolean(arr.length))
         {
            XiaoFeiTuanGouHandle.GC_XFTG_OPEN(arr);
         }
      }
      
      private function GC_XFTG_OPEN2(patch:IDataInput) : void
      {
         var id:int = 0;
         var num:int = 0;
         var len:int = patch.readByte();
         TuanGouVo.tuanGouNum = [];
         var i:int = 0;
         while(i < len)
         {
            id = patch.readByte();
            num = patch.readInt();
            TuanGouVo.tuanGouNum.push(num);
            i++;
         }
         if(Boolean(TuanGouVo.tuanGouNum.length))
         {
            XiaoFeiTuanGouHandle.GC_XFTG_OPEN2();
         }
      }
      
      private function GC_XFTG_GETAWARD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         XiaoFeiTuanGouHandle.GC_XFTG_GETAWARD(result);
      }
      
      private function GC_XFTG_BUY(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         XiaoFeiTuanGouHandle.GC_XFTG_BUY(result);
      }
      
      private function GC_XFTG_BROCAST(patch:IDataInput) : void
      {
         XiaoFeiTuanGouHandle.GC_XFTG_BROCAST();
      }
   }
}

