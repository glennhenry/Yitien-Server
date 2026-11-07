package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.net.handler.JiaoYiHandle;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class JiaoYiGCMessage
   {
      
      private var i_index:int = 0;
      
      private var ii_index:int;
      
      private var j:int;
      
      public function JiaoYiGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_JIAOYI] = this.GC_JIAOYI;
         index[MessageType.GC_JIAOYI_LIST] = this.GC_JIAOYI_LIST;
         index[MessageType.GC_JIAOYI_QUERY] = this.GC_JIAOYI_QUERY;
         index[MessageType.GC_JIAOYI_RETURN] = this.GC_JIAOYI_RETURN;
         index[MessageType.GC_JIAOYI_REP] = this.GC_JIAOYI_REP;
         index[MessageType.GC_TRANS_RETURN] = this.GC_TRANS_RETURN;
         index[MessageType.GET_RESULT_TIP] = this.GET_RESULT_TIP;
      }
      
      public function GC_JIAOYI(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var tem_arr:Array = [];
         tem_arr.push(LongUtil.readLong(patch));
         tem_arr.push(LongUtil.readLong(patch));
         tem_arr.push(Model_heFu.repNameByHero(patch.readUTF()));
         tem_arr.push(patch.readByte());
         tem_arr.push(patch.readByte());
         tem_arr.push(patch.readUTF());
         tem_arr.push(patch.readUTF());
         JiaoYiHandle.GC_JIAOYI(tem_arr);
      }
      
      public function GC_JIAOYI_LIST(patch:IDataInput) : void
      {
         var array_JIAOYIITEM:Array = null;
         var len:int = patch.readByte();
         if(len == 0)
         {
            JiaoYiHandle.GC_JIAOYI_LIST();
            return;
         }
         var jyInfos:Array = [];
         this.i_index = 0;
         while(this.i_index < len)
         {
            array_JIAOYIITEM = [];
            array_JIAOYIITEM.push(LongUtil.readLong(patch));
            array_JIAOYIITEM.push(LongUtil.readLong(patch));
            array_JIAOYIITEM.push(Model_heFu.repNameByHero(patch.readUTF()));
            array_JIAOYIITEM.push(patch.readByte());
            array_JIAOYIITEM.push(patch.readByte());
            array_JIAOYIITEM.push(patch.readUTF());
            array_JIAOYIITEM.push(patch.readUTF());
            jyInfos.push(array_JIAOYIITEM);
            ++this.i_index;
         }
         JiaoYiHandle.GC_JIAOYI_LIST(jyInfos,len);
      }
      
      public function GC_JIAOYI_QUERY(patch:IDataInput) : void
      {
         var len:int = 0;
         var type:int = 0;
         var wpid:Number = NaN;
         var num:int = 0;
         var bindStatus:int = 0;
         var dealUIGridId:int = 0;
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
         var _type:int = 0;
         var _wpid:Number = NaN;
         var _num:int = 0;
         var _bindStatus:int = 0;
         var _dealUIGridId:int = 0;
         var _array_EQUIP:Array = null;
         var _temp_basic:Array = null;
         var _temp_intensify:Array = null;
         var _temp_extra:Array = null;
         var temp_stone_Id:Array = null;
         var _isGrey:int = 0;
         var _skillId:int = 0;
         var _skillGrade:int = 0;
         var _jingLianCount:int = 0;
         var _czLen:int = 0;
         var _temp_jingLian_arr:Array = null;
         var jyId:Number = LongUtil.readLong(patch);
         var roleYB:int = patch.readInt();
         var roleYL:int = patch.readInt();
         var otherRoleYB:int = patch.readInt();
         var otherRoleYL:int = patch.readInt();
         var good_len:int = patch.readByte();
         var equips:Array = [];
         var items:Array = [];
         var i:int = 0;
         while(i <= good_len - 1)
         {
            type = patch.readByte();
            if(type == 1)
            {
               wpid = LongUtil.readLong(patch);
               num = patch.readShort();
               bindStatus = patch.readByte();
               dealUIGridId = patch.readByte();
               items.push([wpid,num,bindStatus,dealUIGridId]);
            }
            else if(type == 2)
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
            }
            i++;
         }
         var _good_len:int = patch.readByte();
         var _equips:Array = [];
         var _items:Array = [];
         var _i:int = 0;
         while(_i <= _good_len - 1)
         {
            _type = patch.readByte();
            if(_type == 1)
            {
               _wpid = LongUtil.readLong(patch);
               _num = patch.readShort();
               _bindStatus = patch.readByte();
               _dealUIGridId = patch.readByte();
               _items.push([_wpid,_num,_bindStatus,_dealUIGridId]);
               trace(_items);
            }
            else if(_type == 2)
            {
               _array_EQUIP = [];
               _array_EQUIP.push(LongUtil.readLong(patch));
               _array_EQUIP.push(patch.readInt());
               _array_EQUIP.push(LongUtil.readLong(patch));
               _array_EQUIP.push(patch.readByte());
               _array_EQUIP.push(patch.readByte());
               _array_EQUIP.push(patch.readByte());
               _array_EQUIP.push(patch.readByte());
               _array_EQUIP.push(patch.readInt());
               _array_EQUIP.push(patch.readByte());
               _array_EQUIP.push(patch.readInt());
               _array_EQUIP.push(patch.readShort());
               len = patch.readByte();
               _temp_basic = [];
               this.j = 0;
               while(this.j < len)
               {
                  _temp_basic.push(patch.readByte());
                  _temp_basic.push(patch.readInt());
                  _temp_basic.push(patch.readInt());
                  ++this.j;
               }
               _array_EQUIP.push(_temp_basic);
               len = patch.readByte();
               _temp_intensify = [];
               this.j = 0;
               while(this.j < len)
               {
                  _temp_intensify.push(patch.readByte());
                  _temp_intensify.push(patch.readInt());
                  ++this.j;
               }
               _array_EQUIP.push(_temp_intensify);
               len = patch.readByte();
               _temp_extra = [];
               this.j = 0;
               while(this.j < len)
               {
                  _temp_extra.push(patch.readByte());
                  _temp_extra.push(patch.readInt());
                  _temp_extra.push(patch.readByte());
                  _temp_extra.push(patch.readInt());
                  ++this.j;
               }
               _array_EQUIP.push(_temp_extra);
               len = patch.readByte();
               temp_stone_Id = [];
               this.j = 0;
               while(this.j < len)
               {
                  temp_stone_Id.push(patch.readInt());
                  ++this.j;
               }
               _array_EQUIP.push(temp_stone_Id);
               extra_polish = patch.readUTF();
               _array_EQUIP.push(extra_polish);
               _isGrey = patch.readByte();
               _skillId = patch.readInt();
               _skillGrade = patch.readByte();
               _jingLianCount = patch.readByte();
               _array_EQUIP.push(_isGrey);
               _array_EQUIP.push(_skillId);
               _array_EQUIP.push(_skillGrade);
               _array_EQUIP.push(_jingLianCount);
               _czLen = patch.readByte();
               _temp_jingLian_arr = [];
               this.j = 0;
               while(this.j < _czLen)
               {
                  _temp_jingLian_arr.push(patch.readByte());
                  _temp_jingLian_arr.push(patch.readInt());
                  ++this.j;
               }
               _array_EQUIP.push(_temp_jingLian_arr);
               _array_EQUIP.push(patch.readInt());
               _array_EQUIP.push(patch.readByte());
               _array_EQUIP.push(patch.readByte());
               _array_EQUIP.push(patch.readByte());
               _array_EQUIP.push(patch.readByte());
               _equips.push(_array_EQUIP);
            }
            _i++;
         }
         JiaoYiHandle.GC_JIAOYI_QUERY(jyId,items,equips,_items,_equips,roleYB,roleYL,otherRoleYB,otherRoleYL);
      }
      
      public function GC_TRANS_RETURN(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         JiaoYiHandle.GC_TRANS_RETURN(result);
      }
      
      public function GC_JIAOYI_RETURN(patch:IDataInput) : void
      {
         var jy_id:int = patch.readInt();
         var otherRoleId:int = patch.readInt();
         var jy_result:int = patch.readByte();
         var jy_isgood:int = patch.readByte();
         JiaoYiHandle.GC_JIAOYI_RETURN(jy_id,otherRoleId,jy_result,jy_isgood);
      }
      
      public function GC_JIAOYI_REP(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var jyId:int = patch.readInt();
         var roleJyStatus:int = patch.readByte();
         var roleGetStatus:int = patch.readByte();
         JiaoYiHandle.GC_JIAOYI_REP(result,jyId,roleJyStatus,roleGetStatus);
      }
      
      public function GET_RESULT_TIP(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         JiaoYiHandle.GET_RESULT_TIP(result);
      }
   }
}

