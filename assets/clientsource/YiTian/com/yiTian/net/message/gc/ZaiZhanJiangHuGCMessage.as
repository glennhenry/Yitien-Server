package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.ZaiZhanJiangHuHandle;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class ZaiZhanJiangHuGCMessage
   {
      
      public function ZaiZhanJiangHuGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_ZZJH_ISOPENACTIVITY] = this.GC_ZZJH_ISOPENACTIVITY;
         index[MessageType.GC_ZZJH_AWARDSTATE] = this.GC_ZZJH_AWARDSTATE;
         index[MessageType.GC_ZZJH_AWARDRESULT] = this.GC_ZZJH_AWARDRESULT;
      }
      
      public function GC_ZZJH_ISOPENACTIVITY(patch:IDataInput) : void
      {
         var flag:int = patch.readByte();
         ZaiZhanJiangHuHandle.IconSwitch(flag);
      }
      
      public function GC_ZZJH_AWARDSTATE(patch:IDataInput) : void
      {
         var arr:Array = null;
         var dataA:Array = [];
         var len:int = patch.readByte();
         var i:int = 0;
         while(i < len)
         {
            arr = [];
            arr.push(patch.readByte());
            arr.push(patch.readByte());
            dataA.push(arr);
            i++;
         }
         ZaiZhanJiangHuHandle.ReadAwardBtnState(dataA);
      }
      
      public function GC_ZZJH_AWARDRESULT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var btnIndex:int = patch.readByte();
         ZaiZhanJiangHuHandle.AwardResultShow(result,btnIndex);
      }
   }
}

