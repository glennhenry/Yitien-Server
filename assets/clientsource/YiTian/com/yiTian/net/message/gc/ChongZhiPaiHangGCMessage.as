package com.yiTian.net.message.gc
{
   import com.yiTian.data.model.Model_ChongZhiPaiHang;
   import com.yiTian.net.handler.ChongZhiPaiHangHandle;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class ChongZhiPaiHangGCMessage
   {
      
      public function ChongZhiPaiHangGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_ChongZhiPaiHang_ICON] = GC_ChongZhiPaiHang_ICON;
         index[MessageType.GC_ChongZhiPaiHang_UPDATE] = GC_ChongZhiPaiHang_UPDATE;
      }
      
      public static function GC_ChongZhiPaiHang_ICON(patch:IDataInput) : void
      {
         var flag:int = patch.readByte();
         trace("120000开关图标>>",flag);
      }
      
      public static function GC_ChongZhiPaiHang_UPDATE(patch:IDataInput) : void
      {
         var arr:Array = [];
         Model_ChongZhiPaiHang.startTime = patch.readInt() + 36000;
         Model_ChongZhiPaiHang.endTime = patch.readInt();
         trace("时间>>",Model_ChongZhiPaiHang.startTime,Model_ChongZhiPaiHang.endTime);
         var i:int = 0;
         while(i < 100)
         {
            trace("----",i);
            if(Boolean(patch.bytesAvailable))
            {
               arr.push(patch.readUTF());
            }
            if(Boolean(patch.bytesAvailable))
            {
               arr.push(patch.readInt());
            }
            if(Boolean(patch.bytesAvailable))
            {
               arr.push(patch.readInt());
            }
            trace(arr[i * 3],arr[i * 3 + 1],arr[i * 3 + 2]);
            i++;
         }
         trace("120002收到数据长度>>",arr.length);
         ChongZhiPaiHangHandle.Update(arr);
      }
   }
}

