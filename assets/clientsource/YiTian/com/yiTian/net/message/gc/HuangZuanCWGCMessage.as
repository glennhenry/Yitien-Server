package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.HuangZuanChongWuHandle;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class HuangZuanCWGCMessage
   {
      
      public function HuangZuanCWGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_HZCW_SHOWICON] = GC_HZCW_SHOWICON;
         index[MessageType.GC_HZCW_SHOWPANEL] = GC_HZCW_SHOWPANEL;
         index[MessageType.GC_HZCW_CHOUJIANG] = GC_HZCW_CHOUJIANG;
         index[MessageType.GC_HZCW_DUIHUAN] = GC_HZCW_DUIHUAN;
      }
      
      public static function GC_HZCW_SHOWICON(patch:IDataInput) : void
      {
         var flag:int = patch.readByte();
         HuangZuanChongWuHandle.GC_HZCW_SHOWICON(flag);
      }
      
      public static function GC_HZCW_SHOWPANEL(patch:IDataInput) : void
      {
         var availible:int = patch.readInt();
         var geted:int = patch.readInt();
         var status:int = patch.readByte();
         var hasAwardStr:String = patch.readUTF();
         HuangZuanChongWuHandle.GC_HZCW_SHOWPANEL(availible,geted,status,hasAwardStr);
      }
      
      public static function GC_HZCW_CHOUJIANG(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var index:int = 0;
         if(result == 1)
         {
            index = patch.readInt();
         }
         HuangZuanChongWuHandle.GC_HZCW_CHOUJIANG(result,index);
      }
      
      public static function GC_HZCW_DUIHUAN(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         HuangZuanChongWuHandle.GC_HZCW_DUIHUAN(result);
      }
   }
}

