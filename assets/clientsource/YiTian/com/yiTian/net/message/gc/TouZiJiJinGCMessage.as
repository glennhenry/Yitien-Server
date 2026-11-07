package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.TouZiJiJinHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class TouZiJiJinGCMessage
   {
      
      public function TouZiJiJinGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_TouZiJiJin_SHOWICON] = GC_TouZiJiJin_SHOWICON;
         index[MessageType.GC_TouZiJiJin_SHOWPANEL] = GC_TouZiJiJin_SHOWPANEL;
         index[MessageType.GC_TouZiJiJin_RENGOU] = GC_TouZiJiJin_RENGOU;
         index[MessageType.GC_TouZiJiJin_GETAWARD] = GC_TouZiJiJin_GETAWARD;
      }
      
      public static function GC_TouZiJiJin_SHOWICON(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         TouZiJiJinHandler.GC_TouZiJiJin_SHOWICON(type);
      }
      
      public static function GC_TouZiJiJin_SHOWPANEL(patch:IDataInput) : void
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
         TouZiJiJinHandler.GC_TouZiJiJin_SHOWPANEL(dataArr);
      }
      
      public static function GC_TouZiJiJin_RENGOU(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         TouZiJiJinHandler.GC_TouZiJiJin_RENGOU(result);
      }
      
      public static function GC_TouZiJiJin_GETAWARD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         TouZiJiJinHandler.GC_TouZiJiJin_GETAWARD(result);
      }
   }
}

