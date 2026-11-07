package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.net.handler.DepotHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class DepotGCMessage
   {
      
      private var i:int;
      
      private var j:int;
      
      public function DepotGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_DEPOT_TIDY] = this.GC_DEPOT_TIDY;
         index[MessageType.GC_DEPOT_EMPTY] = this.GC_DEPOT_EMPTY;
         index[MessageType.GC_DEPOT_EXTENSION] = this.GC_DEPOT_EXTENSION;
      }
      
      public function GC_DEPOT_EMPTY(patch:IDataInput) : void
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
         DepotHandler.GC_DEPOT_EMPTY(result,arr_gridId);
      }
      
      public function GC_DEPOT_EXTENSION(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var canUse:int = patch.readShort();
         DepotHandler.GC_DEPOT_EXTENSION(result,canUse);
      }
      
      public function GC_DEPOT_TIDY(patch:IDataInput) : void
      {
         var len:int = 0;
         var array_EQUIP:Array = null;
         var temp_basic:Array = null;
         var temp_intensify:Array = null;
         var temp_extra:Array = null;
         var temp_stoneId:Array = null;
         var extra_polish:String = null;
         var isGrey:int = 0;
         var skillId:int = 0;
         var skillGrade:int = 0;
         var jingLianCount:int = 0;
         var czLen:int = 0;
         var temp_jingLian_arr:Array = null;
         var array_ITEM:Array = null;
         var result:int = patch.readByte();
         var len_equips:int = patch.readShort();
         var equips:Array = [];
         this.i = 0;
         while(this.i < len_equips)
         {
            array_EQUIP = [];
            array_EQUIP.push(LongUtil.readLong(patch));
            array_EQUIP.push(patch.readInt());
            array_EQUIP.push(LongUtil.readLong(patch));
            array_EQUIP.push(patch.readByte());
            array_EQUIP.push(patch.readByte());
            array_EQUIP.push(patch.readByte());
            array_EQUIP.push(patch.readByte());
            array_EQUIP.push(patch.readInt());
            array_EQUIP.push(patch.readByte());
            array_EQUIP.push(patch.readInt());
            array_EQUIP.push(patch.readShort());
            len = patch.readByte();
            temp_basic = [];
            this.j = 0;
            while(this.j < len)
            {
               temp_basic.push(patch.readByte());
               temp_basic.push(patch.readInt());
               temp_basic.push(patch.readInt());
               ++this.j;
            }
            array_EQUIP.push(temp_basic);
            len = patch.readByte();
            temp_intensify = [];
            this.j = 0;
            while(this.j < len)
            {
               temp_intensify.push(patch.readByte());
               temp_intensify.push(patch.readInt());
               ++this.j;
            }
            array_EQUIP.push(temp_intensify);
            len = patch.readByte();
            temp_extra = [];
            this.j = 0;
            while(this.j < len)
            {
               temp_extra.push(patch.readByte());
               temp_extra.push(patch.readInt());
               temp_extra.push(patch.readByte());
               temp_extra.push(patch.readInt());
               ++this.j;
            }
            array_EQUIP.push(temp_extra);
            len = patch.readByte();
            temp_stoneId = [];
            this.j = 0;
            while(this.j < len)
            {
               temp_stoneId.push(patch.readInt());
               ++this.j;
            }
            array_EQUIP.push(temp_stoneId);
            extra_polish = patch.readUTF();
            array_EQUIP.push(extra_polish);
            isGrey = patch.readByte();
            skillId = patch.readInt();
            skillGrade = patch.readByte();
            jingLianCount = patch.readByte();
            array_EQUIP.push(isGrey);
            array_EQUIP.push(skillId);
            array_EQUIP.push(skillGrade);
            array_EQUIP.push(jingLianCount);
            czLen = patch.readByte();
            temp_jingLian_arr = [];
            this.j = 0;
            while(this.j < czLen)
            {
               temp_jingLian_arr.push(patch.readByte());
               temp_jingLian_arr.push(patch.readInt());
               ++this.j;
            }
            array_EQUIP.push(temp_jingLian_arr);
            array_EQUIP.push(patch.readInt());
            array_EQUIP.push(patch.readByte());
            array_EQUIP.push(patch.readByte());
            array_EQUIP.push(patch.readByte());
            array_EQUIP.push(patch.readByte());
            equips.push(array_EQUIP);
            ++this.i;
         }
         len = patch.readShort();
         var items:Array = [];
         this.i = 0;
         while(this.i < len)
         {
            array_ITEM = [];
            array_ITEM.push(patch.readInt());
            array_ITEM.push(patch.readShort());
            array_ITEM.push(patch.readByte());
            array_ITEM.push(patch.readByte());
            items.push(array_ITEM);
            ++this.i;
         }
         DepotHandler.GC_DEPOT_TIDY(result,equips,items);
      }
   }
}

