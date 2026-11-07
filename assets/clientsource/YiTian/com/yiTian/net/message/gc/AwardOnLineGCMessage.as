package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.AwardOnlineHandle;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class AwardOnLineGCMessage
   {
      
      public function AwardOnLineGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_AWARD_TIP] = this.GC_AWARD_TIP;
         index[MessageType.GC_CJ_INFO] = this.GC_RCCJ_INFO;
         index[MessageType.GC_CJ_START_RE] = this.GC_CJ_START_RE;
         index[MessageType.GC_GET_CJ_AWARD_RE] = this.GC_GET_DLCJ_AWARD_RE;
         index[MessageType.GC_JRCJ_START_RE] = this.GC_JRCJ_START_RE;
      }
      
      public function GC_AWARD_TIP(patch:IDataInput) : void
      {
         var item:Array = null;
         var result:int = patch.readByte();
         if(result == 2)
         {
            AwardOnlineHandle.GC_AWARD_TIP(result,0,0,0,null);
            return;
         }
         var id:int = patch.readByte();
         var remainTime:int = patch.readInt();
         var nextTimeCount:int = patch.readInt();
         var length:int = patch.readByte();
         var arr:Array = new Array();
         var index:uint = 0;
         while(index < length)
         {
            item = new Array();
            item.push(patch.readInt());
            item.push(patch.readByte());
            item.push(patch.readShort());
            arr.push(item);
            index++;
         }
         AwardOnlineHandle.GC_AWARD_TIP(result,id,remainTime,nextTimeCount,arr);
      }
      
      public function GC_RCCJ_INFO(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var comboDay:int = patch.readShort();
         var state:int = patch.readByte();
         var itemLength:int = patch.readByte();
         var itemArr:Array = new Array();
         var index:int = 0;
         while(index < itemLength)
         {
            itemArr.push(patch.readByte() - 1);
            index++;
         }
         var state2:int = patch.readByte();
         var nextFre:int = patch.readShort();
         var nxtFreName:String = patch.readUTF();
         var itemLength2:int = patch.readByte();
         var itemArr2:Array = new Array();
         var index2:int = 0;
         while(index2 < itemLength2)
         {
            itemArr2.push(patch.readByte() - 1);
            index2++;
         }
         AwardOnlineHandle.GC_RCCJ_INFO(comboDay,state,itemArr,state2,nextFre,nxtFreName,itemArr2);
      }
      
      public function GC_CJ_START_RE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var isDouble:int = patch.readByte();
         var itemCount:int = patch.readByte();
         var zjArr:Array = new Array();
         var index:int = 0;
         while(index < itemCount)
         {
            zjArr.push(patch.readByte());
            index++;
         }
         AwardOnlineHandle.GC_CJ_START_RE(result,isDouble,zjArr);
      }
      
      public function GC_GET_DLCJ_AWARD_RE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var type:int = patch.readByte();
         AwardOnlineHandle.GC_GET_CJ_AWARD_RE(result,type);
      }
      
      public function GC_JRCJ_START_RE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var isDouble:int = patch.readByte();
         var itemCount:int = patch.readByte();
         var zjArr:Array = new Array();
         var index:int = 0;
         while(index < itemCount)
         {
            zjArr.push(patch.readByte());
            index++;
         }
         AwardOnlineHandle.GC_JRCJ_START_RE(result,isDouble,zjArr);
      }
   }
}

