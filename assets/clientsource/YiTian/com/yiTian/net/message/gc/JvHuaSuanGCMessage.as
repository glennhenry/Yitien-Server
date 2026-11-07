package com.yiTian.net.message.gc
{
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.JvHuaSuanHandler;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.juhuasuan.Vo_JuHuaSuan;
   import flash.utils.Dictionary;
   import flash.utils.IDataInput;
   
   public class JvHuaSuanGCMessage
   {
      
      public function JvHuaSuanGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_JHS_OPEN] = GC_JHS_OPEN;
         index[MessageType.GC_JHS_BUY] = GC_JHS_BUY;
         index[MessageType.GC_JHS_GETAWARD] = GC_JHS_GETAWARD;
         index[MessageType.GC_JHS_HIGHLIGHT] = this.GC_JHS_HIGHLIGHT;
      }
      
      public static function GC_JHS_OPEN(patch:IDataInput) : void
      {
         var vo:Vo_JuHuaSuan = null;
         var id:int = 0;
         var btnIndex:int = 0;
         var days:int = 0;
         var isOpen:int = patch.readByte();
         if(isOpen == 1)
         {
            UIManager.centerBroadcast.addMsg("不在活动时间内",1);
            return;
         }
         if(isOpen == 3)
         {
            UIManager.centerBroadcast.addMsg("不在活动时间内,无法购买",1);
         }
         var count:int = patch.readByte();
         vo = new Vo_JuHuaSuan();
         var idArr:Array = [];
         var btnArr:Array = [];
         var daysArr:Array = [];
         var dictionary:Dictionary = Data_lib.jvhuasuan;
         var i:int = 0;
         while(i < count)
         {
            id = patch.readByte();
            idArr.push(id);
            days = patch.readByte();
            daysArr.push(days);
            btnIndex = patch.readByte();
            btnArr.push(btnIndex);
            i++;
         }
         vo.expId = patch.readByte();
         vo.allStatus = patch.readByte();
         vo.allYuanBao = patch.readInt();
         vo.idArr = idArr;
         vo.daysArr = daysArr;
         vo.btnArr = btnArr;
         JvHuaSuanHandler.GC_JHS_OPEN(vo);
      }
      
      public static function GC_JHS_BUY(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var id:int = -1;
         if(result == 1)
         {
            id = patch.readInt();
         }
         JvHuaSuanHandler.GC_JHS_BUY(result,id);
      }
      
      public static function GC_JHS_GETAWARD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var id:int = -1;
         if(result == 1)
         {
            id = patch.readInt();
         }
         JvHuaSuanHandler.GC_JHS_GETAWARD(result,id);
      }
      
      private function GC_JHS_HIGHLIGHT(patch:IDataInput) : void
      {
         var isHighLight:int = patch.readByte();
         JvHuaSuanHandler.GC_JHS_HIGHLIGHT(isHighLight);
      }
   }
}

