package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.ZhuanZhiHandle;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.utils.PatchReader;
   import flash.utils.IDataInput;
   
   public class ZhuanZhiGCMessage
   {
      
      public function ZhuanZhiGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_ZZ_ZHUANZHIINFO] = this.GC_ZZ_ZHUANZHIINFO;
         index[MessageType.GC_ZZ_WOYAOZHUANZHI] = this.GC_ZZ_WOYAOZHUANZHI;
         index[MessageType.GC_APPLY_TASK] = this.GC_APPLY_TASK;
         index[MessageType.GC_ZZ_CHOICE_WAY] = this.GC_ZZ_CHOICE_WAY;
      }
      
      public function GC_ZZ_ZHUANZHIINFO(patch:IDataInput) : void
      {
         var types:Array = ["b",["b","b","b"]];
         var info:Array = PatchReader.instance.readPatch(types,patch);
         ZhuanZhiHandle.GC_ZZ_ZHUANZHIINFO(info);
      }
      
      public function GC_ZZ_WOYAOZHUANZHI(patch:IDataInput) : void
      {
         var r:int = patch.readByte();
         ZhuanZhiHandle.GC_ZZ_WOYAOZHUANZHI(r);
      }
      
      public function GC_APPLY_TASK(patch:IDataInput) : void
      {
         var r:int = patch.readByte();
         ZhuanZhiHandle.GC_APPLY_TASK(r);
      }
      
      public function GC_ZZ_CHOICE_WAY(patch:IDataInput) : void
      {
         var r:int = patch.readByte();
         ZhuanZhiHandle.GC_ZZ_CHOICE_WAY(r);
      }
   }
}

