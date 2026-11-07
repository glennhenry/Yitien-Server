package com.yiTian.net.message.cg
{
   import com.utils.LongUtil;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.utils.Utils;
   import flash.utils.ByteArray;
   
   public class CastCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function CastCGMessage()
      {
         super();
      }
      
      public static function CG_ADD_HOLE(pos_id:Number, stone_id:int, stone_bBind:int, askType:int) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,pos_id);
         bytebuff.writeInt(stone_id);
         bytebuff.writeByte(stone_bBind);
         bytebuff.writeByte(askType);
         SocketManager.send(MessageType.CG_ADD_HOLE,bytebuff);
      }
      
      public static function CG_INLAY(pos_id:Number, stone_pos:int, stone_id:int, stone_bBind:int) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,pos_id);
         bytebuff.writeByte(stone_pos);
         bytebuff.writeInt(stone_id);
         bytebuff.writeByte(stone_bBind);
         SocketManager.send(MessageType.CG_INLAY,bytebuff);
      }
      
      public static function CG_POLISH_OK(pos_id:Number) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,pos_id);
         SocketManager.send(MessageType.CG_POLISH_OK,bytebuff);
      }
      
      public static function CG_POLISH(Only_id:Number, stone_id:int, stone_bBind:int, lock_Arr:Array, unlockArr:Array, askType:int) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,Only_id);
         bytebuff.writeInt(stone_id);
         bytebuff.writeByte(stone_bBind);
         bytebuff.writeByte(lock_Arr.length);
         var i:int = 0;
         while(i < lock_Arr.length)
         {
            bytebuff.writeByte(lock_Arr[i]);
            i++;
         }
         bytebuff.writeByte(unlockArr.length);
         i = 0;
         while(i < unlockArr.length)
         {
            bytebuff.writeByte(unlockArr[i]);
            i++;
         }
         bytebuff.writeByte(askType);
         SocketManager.send(MessageType.CG_POLISH,bytebuff);
      }
      
      public static function CG_UNLOAD(pos_id:Number, stone_pos:int) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,pos_id);
         bytebuff.writeByte(stone_pos);
         SocketManager.send(MessageType.CG_UNLOAD,bytebuff);
      }
      
      public static function CG_DECOMPOSE(vec_GridId:Vector.<Number>) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(vec_GridId.length);
         var i:int = 0;
         while(i < vec_GridId.length)
         {
            LongUtil.writeLong(bytebuff,vec_GridId[i]);
            i++;
         }
         SocketManager.send(MessageType.CG_DECOMPOSE,bytebuff);
      }
      
      public static function CG_INTENSIFY(position_id:Number, insten_stone_id:int, insten_stone_bBind:int, askType:int, luckyValue:int = 0, lucky_sign_str:String = "") : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,position_id);
         bytebuff.writeInt(insten_stone_id);
         bytebuff.writeByte(insten_stone_bBind);
         bytebuff.writeShort(luckyValue);
         bytebuff.writeUTF(lucky_sign_str);
         bytebuff.writeByte(askType);
         SocketManager.send(MessageType.CG_INTENSIFY,bytebuff);
      }
      
      public static function CG_GEM_COMPOSE(wpId:int, _num:int, bBind:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(wpId);
         bytebuff.writeShort(_num);
         bytebuff.writeByte(bBind);
         SocketManager.send(MessageType.CG_GEM_COMPOSE,bytebuff);
      }
      
      public static function CG_RIDE_COMPOSE(toolGridId:int, isBind:int, money_material:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(toolGridId);
         bytebuff.writeByte(isBind);
         bytebuff.writeByte(money_material);
         SocketManager.send(MessageType.CG_RIDE_COMPOSE,bytebuff);
      }
      
      public static function CG_INSTEN_CHANGED(pos_id1:Number, pos_id2:Number, isUseMoney:int) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,pos_id1);
         LongUtil.writeLong(bytebuff,pos_id2);
         bytebuff.writeByte(isUseMoney);
         SocketManager.send(MessageType.CG_INSTEN_CHANGED,bytebuff);
      }
      
      public static function CG_RIDE_UP(gridId:Number) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,gridId);
         SocketManager.send(MessageType.CG_RIDE_UP,bytebuff);
      }
      
      public static function CG_CZ_REFINE(equipId:Number, meterialId:int) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,equipId);
         bytebuff.writeInt(meterialId);
         SocketManager.send(MessageType.CG_CZ_REFINE,bytebuff);
      }
      
      public static function CG_CZ_XILIAN(equipId:Number, meterialGridId:int) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,equipId);
         bytebuff.writeShort(meterialGridId);
         SocketManager.send(MessageType.CG_CZ_XILIAN,bytebuff);
      }
      
      public static function CG_BAISHI_QIANKE(num:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(num);
         Utils.print("数量：" + num);
         SocketManager.send(MessageType.CG_BAISHI_QIANKE,bytebuff);
      }
      
      public static function CG_CLICK_UP_LEVEL(serverId:Number) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,serverId);
         SocketManager.send(MessageType.CG_CLICK_UP_LEVEL,bytebuff);
      }
      
      public static function CG_FIRST_OPEN_PAN_JINJI() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_FIRST_OPEN_PAN_JINJI,bytebuff);
      }
      
      public static function CG_FIRST_OPEN_PAN_JINJI_DIANHUA() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_FIRST_OPEN_PAN_JINJI_DIANHUA,bytebuff);
      }
      
      public static function CG_CLICK_UP_LEVEL_DIANHUA(serverId:Number) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,serverId);
         SocketManager.send(MessageType.CG_CLICK_UP_LEVEL_DIANHUA,bytebuff);
      }
   }
}

