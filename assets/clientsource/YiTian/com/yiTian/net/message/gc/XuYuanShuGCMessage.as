package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.XuYuanShuHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class XuYuanShuGCMessage
   {
      
      public function XuYuanShuGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_XuYuanShu_SHOWICON] = GC_XuYuanShu_SHOWICON;
         index[MessageType.GC_XuYuanShu_SHOWPANEL] = GC_XuYuanShu_SHOWPANEL;
         index[MessageType.GC_XuYuanShu_RENGOU] = GC_XuYuanShu_RENGOU;
         index[MessageType.GC_XuYuanShu_GETAWARD] = GC_XuYuanShu_GETAWARD;
      }
      
      public static function GC_XuYuanShu_SHOWICON(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         XuYuanShuHandler.GC_XuYuanShu_SHOWICON(type);
      }
      
      public static function GC_XuYuanShu_SHOWPANEL(patch:IDataInput) : void
      {
         var arr:Array = [];
         var type:int = patch.readByte();
         arr = patch.readUTF().split("*");
         var price:int = patch.readInt();
         var haveBuyNum:int = patch.readByte();
         var status:int = patch.readByte();
         var index:int = patch.readByte();
         var dataArr:Array = [];
         dataArr.push(type,arr,price,haveBuyNum,status,index);
         XuYuanShuHandler.GC_XuYuanShu_SHOWPANEL(dataArr);
      }
      
      public static function GC_XuYuanShu_RENGOU(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         XuYuanShuHandler.GC_XuYuanShu_RENGOU(result);
      }
      
      public static function GC_XuYuanShu_GETAWARD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         XuYuanShuHandler.GC_XuYuanShu_GETAWARD(result);
      }
   }
}

