package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.net.handler.BroadCastHandle;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.utils.PatchReader;
   import flash.utils.IDataInput;
   
   public class BroadCastGCMessage
   {
      
      public function BroadCastGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_BROADCAST] = this.GC_BROADCAST;
         index[MessageType.GC_GENERAL] = this.GC_GENERAL;
         index[MessageType.GC_GET_ITEM] = this.GC_GET_ITEM;
         index[MessageType.GC_SB_SHOW] = this.GC_SB_SHOW;
         index[MessageType.GC_LINK_BC] = this.GC_LINK_BC;
         index[MessageType.GC_SERVER_LOG] = this.GC_SERVER_LOG;
      }
      
      private function GC_BROADCAST(patch:IDataInput) : void
      {
         var msgId:int = patch.readInt();
         BroadCastHandle.GC_BROADCAST(msgId,patch);
      }
      
      private function GC_GET_ITEM(patch:IDataInput) : void
      {
         var arr:Array = null;
         var type:int = 0;
         var id:Number = NaN;
         var count:Number = NaN;
         var tt:int = patch.readByte();
         var length:int = patch.readShort();
         var objArr:Array = new Array();
         var index:int = 0;
         while(index < length)
         {
            arr = new Array();
            type = patch.readByte();
            id = LongUtil.readLong(patch);
            count = LongUtil.readLong(patch);
            arr.push(type,id,count);
            objArr.push(arr);
            index++;
         }
         BroadCastHandle.GC_GET_ITEM(objArr);
      }
      
      private function GC_SB_SHOW(patch:IDataInput) : void
      {
         var obj:Object = null;
         var length:int = patch.readByte();
         var array:Array = new Array();
         var index:int = 0;
         while(index < length)
         {
            obj = new Object();
            obj.index = patch.readByte();
            obj.isShow = patch.readByte();
            array.push(obj);
            index++;
         }
         BroadCastHandle.GC_SB_SHOW(array);
      }
      
      private function GC_LINK_BC(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         var remainTime:int = patch.readShort();
         BroadCastHandle.GC_LINK_BC(type,remainTime);
      }
      
      private function GC_GENERAL(patch:IDataInput) : void
      {
         var msgID:int = patch.readInt();
         var infos:Array = PatchReader.instance.readGeneralPatch(patch);
         BroadCastHandle.GC_GENERAL(msgID,infos);
      }
      
      private function GC_SERVER_LOG(patch:IDataInput) : void
      {
         var url:String = patch.readUTF();
         BroadCastHandle.GC_SERVER_LOG(url);
      }
   }
}

