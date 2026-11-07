package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.ChongChuJiangHuHandle;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class ChongChuJinagHuGCMessage
   {
      
      public function ChongChuJinagHuGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_ChongChuJiangHu_ICON] = GC_ChongChuJiangHu_ICON;
         index[MessageType.GC_ChongChuJiangHu_OPEN_MENU] = GC_ChongChuJiangHu_OPEN_MENU;
         index[MessageType.GC_ChongChuJiangHu_GET] = GC_ChongChuJiangHu_GET;
      }
      
      public static function GC_ChongChuJiangHu_ICON(patch:IDataInput) : void
      {
         var flag:int = patch.readByte();
         trace("113000开关图标>>",flag);
         ChongChuJiangHuHandle.IconHandle(flag);
      }
      
      public static function GC_ChongChuJiangHu_OPEN_MENU(patch:IDataInput) : void
      {
         var len:int = patch.readByte();
         var arr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            arr.push(patch.readByte());
            i++;
         }
         trace("113002领取状态>>",arr);
         ChongChuJiangHuHandle.OpenMenuHandle(arr);
      }
      
      public static function GC_ChongChuJiangHu_GET(patch:IDataInput) : void
      {
         var flag:int = patch.readByte();
         trace("113004领取是否成功>>",flag);
         ChongChuJiangHuHandle.GetPrizeHandle(flag);
      }
   }
}

