package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.LeiJiChongZhiHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class LeiJiChongZhiGCMessage
   {
      
      public function LeiJiChongZhiGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_LJCZ_SHOWICON] = GC_LJCZ_SHOWICON;
         index[MessageType.GC_LJCZ_SHOWPANEL] = GC_LJCZ_SHOWPANEL;
         index[MessageType.GC_LJCZ_GETAWARD] = GC_LJCZ_GETAWARD;
      }
      
      public static function GC_LJCZ_SHOWICON(patch:IDataInput) : void
      {
         var isShow:int = patch.readByte();
         var isLight:int = patch.readByte();
         LeiJiChongZhiHandler.showIcon(isShow,isLight);
      }
      
      public static function GC_LJCZ_SHOWPANEL(patch:IDataInput) : void
      {
         var temp:Array = null;
         var j:int = 0;
         var money:int = patch.readInt();
         var dangshu:int = patch.readByte();
         var typeArr:Array = [];
         var i:int = 0;
         while(i < dangshu)
         {
            temp = [];
            j = 0;
            while(j < 7)
            {
               temp.push(patch.readByte());
               j++;
            }
            typeArr.push(temp);
            i++;
         }
         LeiJiChongZhiHandler.showPanel(typeArr,money);
      }
      
      public static function GC_LJCZ_GETAWARD(patch:IDataInput) : void
      {
         var dangshu:int = patch.readByte();
         var btnIndex:int = patch.readByte();
         var result:int = patch.readByte();
         LeiJiChongZhiHandler.getAward(dangshu,btnIndex,result);
      }
   }
}

