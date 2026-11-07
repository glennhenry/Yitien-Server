package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.FishingHandle;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class FishingGCMessage
   {
      
      public function FishingGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_RIVER_PLAYER_INFO] = this.GC_RIVER_PLAYER_INFO;
         index[MessageType.GC_ENTER_RIVER] = this.GC_ENTER_RIVER;
         index[MessageType.GC_XIAGAN] = this.GC_XIAGAN;
         index[MessageType.GC_FISHINGONTIME] = this.GC_FISHINGONTIME;
         index[MessageType.GC_SHOUGAN] = this.GC_SHOUGAN;
         index[MessageType.GC_CHECK_FISH] = this.GC_CHECK_FISH;
         index[MessageType.GC_SNATCH_FISH] = this.GC_SNATCH_FISH;
         index[MessageType.GC_LEAVE_FISHING] = this.GC_LEAVE_FISHING;
         index[MessageType.GC_FISH_TO_WHERE] = this.GC_FISH_TO_WHERE;
         index[MessageType.GC_SNATCH_ERROR] = this.GC_SNATCH_ERROR;
         index[MessageType.GC_FISH_ROOM] = this.GC_FISH_ROOM;
         index[MessageType.GC_FISHING_FULL] = this.GC_FISHING_FULL;
      }
      
      public function GC_RIVER_PLAYER_INFO(patch:IDataInput) : void
      {
         var obj:Object = null;
         var id:Number = NaN;
         var name:String = null;
         var job:int = 0;
         var sex:int = 0;
         var length:int = patch.readByte();
         var array:Array = new Array();
         var index:int = 0;
         while(index < length)
         {
            obj = new Object();
            id = LongUtil.readLong(patch);
            name = patch.readUTF();
            job = patch.readByte();
            sex = patch.readByte();
            obj.id = id;
            obj.name = name;
            obj.job = job;
            obj.sex = sex;
            array.push(obj);
            index++;
         }
         FishingHandle.GC_UPDATE_RIVERPLAYER_INFO(array);
      }
      
      public function GC_ENTER_RIVER(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var riverIndex:int = patch.readByte();
         FishingHandle.GC_ENTER_RIVER(result,riverIndex);
      }
      
      public function GC_XIAGAN(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         FishingHandle.GC_XIAGAN(result);
      }
      
      public function GC_FISHINGONTIME(patch:IDataInput) : void
      {
         var fishId:int = patch.readInt();
         var exp:int = patch.readInt();
         FishingHandle.GC_FISHINGONTIME(fishId,exp);
      }
      
      public function GC_SHOUGAN(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         FishingHandle.GC_SHOUGAN(result);
      }
      
      public function GC_CHECK_FISH(patch:IDataInput) : void
      {
         var fishId:int = 0;
         var id:Number = LongUtil.readLong(patch);
         var length:int = patch.readByte();
         var array:Array = new Array();
         var index:int = 0;
         while(index < length)
         {
            fishId = patch.readInt();
            array.push(fishId);
            index++;
         }
         FishingHandle.GC_CHECK_FISH(id,array);
      }
      
      public function GC_FISH_TO_WHERE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var where:int = patch.readByte();
         var id:int = patch.readInt();
         FishingHandle.GC_FISH_TO_WHERE(result,where,id);
      }
      
      public function GC_SNATCH_FISH(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var exp:int = patch.readInt();
         FishingHandle.GC_SNATCH_FISH(result,exp);
      }
      
      public function GC_LEAVE_FISHING(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         FishingHandle.GC_LEAVE_FISHING(result);
      }
      
      public function GC_SNATCH_ERROR(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         FishingHandle.GC_SNATCH_ERROR(result);
      }
      
      public function GC_FISH_ROOM(patch:IDataInput) : void
      {
         var id:int = 0;
         var result:int = patch.readByte();
         var len:int = patch.readByte();
         var array:Array = new Array();
         var i:int = 0;
         while(i < len)
         {
            id = patch.readByte();
            array[id - 1] = patch.readByte();
            i++;
         }
         FishingHandle.GC_FISH_ROOM(result,array);
      }
      
      private function GC_FISHING_FULL(patch:IDataInput) : void
      {
         UIManager.centerBroadcast.addMsg("钓鱼人数已满");
      }
   }
}

