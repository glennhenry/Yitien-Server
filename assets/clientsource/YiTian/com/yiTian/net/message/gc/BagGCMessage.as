package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.data.config.Enum_BytesReadTypes;
   import com.yiTian.net.handler.BagHandler;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.utils.PatchReader;
   import flash.utils.IDataInput;
   
   public class BagGCMessage
   {
      
      private var i:int;
      
      private var j:int;
      
      public function BagGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_BAG_UPDATE] = this.GC_BAG_UPDATE;
         index[MessageType.GC_BAG_EMPTY] = this.GC_BAG_EMPTY;
         index[MessageType.GC_BAG_EXTENSION] = this.GC_BAG_EXTENSION;
         index[MessageType.GC_TIPS_ADD] = this.GC_TIPS_ADD;
         index[MessageType.GC_TIPS_RIGHT_DOWN] = this.GC_TIPS_RIGHT_DOWN;
         index[MessageType.GC_BAG_FULL_TIPS] = this.GC_BAG_FULL_TIPS;
         index[MessageType.GC_NAIJIU_TISHI] = this.GC_NAIJIU_TISHI;
         index[MessageType.GC_CZ_END] = this.GC_CZ_END;
         index[MessageType.GC_SZ_RENEW] = this.GC_SZ_RENEW;
         index[MessageType.GC_BAG_OPEN_GRID_TIPS] = this.GC_BAG_OPEN_GRID_TIPS;
         index[MessageType.GC_BAG_OPEN_GRID_ON_CD] = this.GC_BAG_OPEN_GRID_ON_CD;
         index[MessageType.GC_BAG_OPEN_GRID_OPEN] = this.GC_BAG_OPEN_GRID_OPEN;
         index[MessageType.GC_BAG_OPEN_GRID_NOT_ON_TIME] = this.GC_BAG_OPEN_GRID_NOT_ON_TIME;
         index[MessageType.GC_BAG_PWD_STATE] = this.GC_BAG_PWD_STATE;
         index[MessageType.GC_BAG_PWD_SETTER] = this.GC_BAG_PWD_SETTER;
         index[MessageType.GC_BAG_PWD_TYPE_SETTING] = this.GC_BAG_PWD_TYPE_SETTING;
         index[MessageType.GC_BAG_PWD_LOCK_UP] = this.GC_BAG_PWD_LOCK_UP;
      }
      
      public function GC_BAG_EMPTY(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var gridId_len:int = patch.readShort();
         var arr_gridId:Array = [];
         this.i = 0;
         while(this.i < gridId_len)
         {
            arr_gridId.push(patch.readShort());
            ++this.i;
         }
         BagHandler.GC_BAG_EMPTY(result,arr_gridId);
      }
      
      public function GC_BAG_EXTENSION(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var canUse:int = patch.readShort();
         BagHandler.GC_BAG_EXTENSION(result,canUse);
      }
      
      public function GC_BAG_UPDATE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var equips:Array = PatchReader.instance.readPatch(Enum_BytesReadTypes.BAGEQUIPS,patch)[0];
         var items:Array = PatchReader.instance.readPatch(Enum_BytesReadTypes.BAGITEMS,patch)[0];
         BagHandler.GC_BAG_UPDATE(result,equips,items);
      }
      
      public function GC_BAG_FULL(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         BagHandler.GC_BAG_FULL(result);
      }
      
      public function GC_TIPS_ADD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var value:int = patch.readInt();
         BagHandler.GC_TIPS_ADD(result,value);
      }
      
      public function GC_BAG_FULL_TIPS(patch:IDataInput) : void
      {
         var res:int = patch.readByte();
         BagHandler.GC_BAG_FULL_TIPS(res);
      }
      
      public function GC_TIPS_RIGHT_DOWN(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var color:int = patch.readByte();
         BagHandler.GC_TIPS_RIGHT_DOWN(color,result);
      }
      
      public function GC_NAIJIU_TISHI(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         BagHandler.GC_NAIJIU_TISHI(result);
      }
      
      public function GC_CZ_END(patch:IDataInput) : void
      {
         var equipId:Number = LongUtil.readLong(patch);
         var _type:int = patch.readByte();
         var _pri:int = patch.readInt();
         BagHandler.GC_CZ_END(equipId,_type,_pri);
      }
      
      public function GC_SZ_RENEW(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         BagHandler.GC_SZ_RENEW(result);
      }
      
      public function GC_BAG_OPEN_GRID_TIPS(patch:IDataInput) : void
      {
         var gridID:int = patch.readInt();
         var seconds:int = patch.readInt();
         BagHandler.GC_BAG_OPEN_GRID_TIPS(gridID,seconds);
      }
      
      public function GC_BAG_OPEN_GRID_ON_CD(patch:IDataInput) : void
      {
         var gridID:int = patch.readInt();
         var money:int = patch.readInt();
         BagHandler.GC_BAG_OPEN_GRID_ON_CD(gridID,money);
      }
      
      public function GC_BAG_OPEN_GRID_OPEN(patch:IDataInput) : void
      {
         var gridID:int = patch.readInt();
         var type:int = patch.readByte();
         var isSuccess:int = patch.readByte();
         BagHandler.GC_BAG_OPEN_GRID_OPEN(gridID,type,isSuccess);
      }
      
      public function GC_BAG_OPEN_GRID_NOT_ON_TIME(patch:IDataInput) : void
      {
         var gridID:int = patch.readInt();
         var leftNum:int = patch.readInt();
         var money:int = patch.readInt();
         BagHandler.GC_BAG_OPEN_GRID_NOT_ON_TIME(gridID,leftNum,money);
      }
      
      public function GC_BAG_PWD_STATE(patch:IDataInput) : void
      {
         var state:int = patch.readByte();
         var days:int = patch.readByte();
         BagHandler.GC_BAG_PWD_STATE(state,days);
      }
      
      public function GC_BAG_PWD_SETTER(patch:IDataInput) : void
      {
         var isSuccess:int = patch.readByte();
         var state:int = patch.readByte();
         BagHandler.GC_BAG_PWD_SET_SUCCESS_STATE_SETTER(isSuccess,state);
      }
      
      public function GC_BAG_PWD_TYPE_SETTING(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         var isSuccess:int = patch.readByte();
         var state:int = patch.readByte();
         BagHandler.GC_BAG_PWD_SET_SUCCESS_STATE_SETTING(type,isSuccess,state);
      }
      
      public function GC_BAG_PWD_LOCK_UP(patch:IDataInput) : void
      {
         var isSuccess:int = patch.readByte();
         var state:int = patch.readByte();
         BagHandler.GC_BAG_PWD_SET_SUCCESS_STATE_LOCK_UP(isSuccess,state);
      }
   }
}

