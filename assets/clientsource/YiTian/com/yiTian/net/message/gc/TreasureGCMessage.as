package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.data.model.Model_treasureBowl;
   import com.yiTian.data.vo.Vo_treasureBowl_role;
   import com.yiTian.net.handler.TreasureBowlHandle;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class TreasureGCMessage
   {
      
      public function TreasureGCMessage(index:Array)
      {
         super();
         index[MessageType.gc_treasure_bowl_data] = this.gc_treasure_bowl_data;
      }
      
      private function gc_treasure_bowl_data(patch:IDataInput) : void
      {
         var vo:Vo_treasureBowl_role = null;
         Model_treasureBowl.instace.todayPlayerCount = patch.readInt();
         Model_treasureBowl.instace.todayMoney = patch.readInt();
         Model_treasureBowl.instace.myConsume = patch.readInt();
         var len:uint = uint(patch.readByte());
         Model_treasureBowl.instace.roles = new Vector.<Vo_treasureBowl_role>();
         var i:uint = 0;
         while(i < len)
         {
            vo = new Vo_treasureBowl_role();
            vo.id = LongUtil.readLong(patch);
            vo.name = patch.readUTF();
            vo.sex = patch.readByte();
            vo.profession = patch.readByte();
            vo.money = patch.readInt();
            Model_treasureBowl.instace.roles.push(vo);
            i++;
         }
         TreasureBowlHandle.update();
      }
   }
}

