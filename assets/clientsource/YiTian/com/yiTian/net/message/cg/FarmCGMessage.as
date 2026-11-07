package com.yiTian.net.message.cg
{
   import com.utils.LongUtil;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class FarmCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function FarmCGMessage()
      {
         super();
      }
      
      public static function cg_get_farm_data(id:Number) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,id);
         SocketManager.send(MessageType.cg_farm_data,bytebuff);
      }
      
      public static function gc_farm_data_seed() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.cg_farm_seed_data_request,bytebuff);
      }
      
      public static function cg_farm_plant(pos:uint, id:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(pos);
         bytebuff.writeInt(id);
         SocketManager.send(MessageType.cg_farm_plant,bytebuff);
      }
      
      public static function cg_farm_is_need_water(roleid:uint, pos:uint) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(roleid);
         bytebuff.writeByte(pos);
      }
      
      public static function cg_farm_fruit_mature(roleid:Number, pos:uint) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,roleid);
         bytebuff.writeByte(pos);
         SocketManager.send(MessageType.cg_farm_fruit_mature,bytebuff);
      }
      
      public static function cg_farm_water(roleid:uint, pos:uint) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(roleid);
         bytebuff.writeByte(pos);
      }
      
      public static function cg_farm_land_expand(roleid:Number, pos:uint) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,roleid);
         bytebuff.writeByte(pos);
         SocketManager.send(MessageType.cg_farm_land_expand,bytebuff);
      }
      
      public static function cg_farm_fruit_kill(roleid:uint, pos:uint) : void
      {
      }
      
      public static function cg_farm_pick_fruit(roleid:Number, pos:uint) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,roleid);
         bytebuff.writeByte(pos);
         SocketManager.send(MessageType.cg_farm_pick_fruit,bytebuff);
      }
      
      public static function cg_farm_steal_fruit(roleid:Number, pos:uint) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,roleid);
         bytebuff.writeByte(pos);
         SocketManager.send(MessageType.cg_farm_steal_fruit,bytebuff);
      }
      
      public static function cg_farm_land_levelup(farmId:uint, landPos:uint) : void
      {
      }
      
      public static function cg_farm_refresh_fruit(farmId:Number, pos:uint) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,farmId);
         bytebuff.writeByte(pos);
         SocketManager.send(MessageType.cg_farm_refresh_fruit,bytebuff);
      }
      
      public static function cg_friends_list(value:int, id:Number) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(value);
         LongUtil.writeLong(bytebuff,id);
         SocketManager.send(MessageType.cg_friends_list,bytebuff);
      }
      
      public static function cg_farm_catch_farmer(catch_id:Number, be_catch_id:Number, catch_type:uint, catch_grab:uint, pos:uint) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,catch_id);
         LongUtil.writeLong(bytebuff,be_catch_id);
         bytebuff.writeByte(catch_type);
         bytebuff.writeByte(catch_grab);
         bytebuff.writeByte(pos);
         SocketManager.send(MessageType.cg_farm_catch_farmer,bytebuff);
      }
      
      public static function cg_farm_seekHelp(seek_id:Number, be_seek_id:Number, seek_master_id:Number, info:String, rescue_type:uint) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,seek_id);
         LongUtil.writeLong(bytebuff,be_seek_id);
         LongUtil.writeLong(bytebuff,seek_master_id);
         bytebuff.writeUTF(info);
         bytebuff.writeByte(rescue_type);
         SocketManager.send(MessageType.cg_farm_seekHelp,bytebuff);
      }
      
      public static function cg_farm_release(release:Number, be_release:Number, pos:uint, type:uint = 0) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(type);
         LongUtil.writeLong(bytebuff,release);
         LongUtil.writeLong(bytebuff,be_release);
         bytebuff.writeByte(pos);
         SocketManager.send(MessageType.cg_farm_release,bytebuff);
      }
      
      public static function cg_farm_master_request_release(id:uint) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(id);
         SocketManager.send(MessageType.cg_farm_master_request_release,bytebuff);
      }
      
      public static function cg_farm_reward(reward:Number, be_reward:Number) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,reward);
         LongUtil.writeLong(bytebuff,be_reward);
         SocketManager.send(MessageType.cg_farm_reward,bytebuff);
      }
      
      public static function cg_farm_hit_farmer(be_hit:uint, pos:uint, master:uint) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(be_hit);
         bytebuff.writeByte(pos);
         bytebuff.writeInt(master);
         SocketManager.send(MessageType.cg_farm_hit_farmer,bytebuff);
      }
      
      public static function cg_farm_request_sleep(farmer:uint, pos:uint, master:uint) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(farmer);
         bytebuff.writeByte(pos);
         bytebuff.writeInt(master);
      }
      
      public static function cg_farm_resist(resist:Number, be_resist:Number) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,resist);
         LongUtil.writeLong(bytebuff,be_resist);
         SocketManager.send(MessageType.cg_farm_resist,bytebuff);
      }
      
      public static function cg_farm_redeem(id:Number) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,id);
         SocketManager.send(MessageType.cg_farm_redeem,bytebuff);
      }
      
      public static function cg_farm_journal(id:Number) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,id);
         SocketManager.send(MessageType.cg_farm_journal,bytebuff);
      }
      
      public static function cg_farm_onekey(type:uint, id:uint, be_id:uint, payMoney:uint = 0) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(type);
         bytebuff.writeByte(payMoney);
         bytebuff.writeInt(id);
         bytebuff.writeInt(be_id);
         SocketManager.send(MessageType.cg_farm_one_key,bytebuff);
      }
      
      public static function cg_farm_get_everyday_gift() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.cg_farm_get_everyday_gift,bytebuff);
      }
      
      public static function cg_farm_guide(type:uint) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(type);
         SocketManager.send(MessageType.cg_farm_guide,bytebuff);
      }
   }
}

