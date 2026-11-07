package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.MartHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class MartGCMessage
   {
      
      private static var i_index:int = 0;
      
      private static var ii_index:int = 0;
      
      private var j:int;
      
      public function MartGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_MYSOLD] = this.GC_MYSOLD;
         index[MessageType.GC_MARTSOLD] = this.GC_MARTSOLD;
         index[MessageType.GC_MY_SOLD] = this.GC_MY_SOLD;
         index[MessageType.GC_MY_BUY] = this.GC_MY_BUY;
         index[MessageType.GC_MYBUY] = this.GC_MYBUY;
         index[MessageType.GC_MARTBUY] = this.GC_MARTBUY;
         index[MessageType.GC_SEARCH] = this.GC_SEARCH;
         index[MessageType.GC_SOLD] = this.GC_SOLD;
         index[MessageType.GC_BUY] = this.GC_BUY;
         index[MessageType.GC_CANCLE_BUY] = this.GC_CANCLE_BUY;
         index[MessageType.GC_CANCLE_SOLD] = this.GC_CANCLE_SOLD;
      }
      
      public function GC_MYSOLD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         MartHandler.GC_MYSOLD(result);
      }
      
      public function GC_MARTSOLD(patch:IDataInput) : void
      {
         var temArr:Array = null;
         var type:int = 0;
         var len:int = 0;
         var wpid:Number = NaN;
         var bindStatus:int = 0;
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
         var result:int = patch.readByte();
         var totalPage:int = patch.readInt();
         var eve_num:int = patch.readByte();
         var equips:Array = [];
         var items:Array = [];
         var dataArr:Array = [];
         var typeArr:Array = [];
         var i:int = 0;
         while(i <= eve_num - 1)
         {
            temArr = [];
            temArr.push(LongUtil.readLong(patch));
            temArr.push(patch.readInt());
            temArr.push(patch.readInt());
            temArr.push(patch.readInt());
            temArr.push(patch.readByte());
            temArr.push(patch.readUTF());
            temArr.push(LongUtil.readLong(patch));
            temArr.push(patch.readInt());
            dataArr.push(temArr);
            type = patch.readByte();
            typeArr.push(type);
            if(type == 1)
            {
               wpid = LongUtil.readLong(patch);
               bindStatus = patch.readByte();
               items.push([wpid,bindStatus]);
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
         MartHandler.GC_MART_SOLD(eve_num,totalPage,typeArr,items,equips,dataArr,LangConfig.getWord("7",0));
      }
      
      public function GC_MY_SOLD(patch:IDataInput) : void
      {
         var temArr:Array = null;
         var type:int = 0;
         var len:int = 0;
         var wpid:Number = NaN;
         var bindStatus:int = 0;
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
         var result:int = patch.readByte();
         var eve_num:int = patch.readByte();
         var equips:Array = [];
         var items:Array = [];
         var dataArr:Array = [];
         var typeArr:Array = [];
         var i:int = 0;
         while(i <= eve_num - 1)
         {
            temArr = [];
            temArr.push(LongUtil.readLong(patch));
            temArr.push(patch.readInt());
            temArr.push(patch.readInt());
            temArr.push(patch.readInt());
            temArr.push(patch.readByte());
            temArr.push(patch.readUTF());
            temArr.push(LongUtil.readLong(patch));
            temArr.push(patch.readInt());
            dataArr.push(temArr);
            type = patch.readByte();
            typeArr.push(type);
            if(type == 1)
            {
               wpid = LongUtil.readLong(patch);
               bindStatus = patch.readByte();
               items.push([wpid,bindStatus]);
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
         MartHandler.GC_MY_SOLD(eve_num,typeArr,items,equips,dataArr);
      }
      
      public function GC_MYBUY(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         MartHandler.GC_MYBUY(result);
      }
      
      public function GC_MARTBUY(patch:IDataInput) : void
      {
         var temArr:Array = null;
         var result:int = patch.readByte();
         var totalPage:int = patch.readInt();
         var eve_num:int = patch.readByte();
         var data_arr:Array = [];
         var i:int = 0;
         while(i <= eve_num - 1)
         {
            temArr = [];
            temArr.push(LongUtil.readLong(patch));
            temArr.push(patch.readInt());
            temArr.push(patch.readInt());
            temArr.push(patch.readInt());
            temArr.push(patch.readByte());
            temArr.push(patch.readUTF());
            temArr.push(LongUtil.readLong(patch));
            temArr.push(patch.readInt());
            temArr.push(patch.readByte());
            temArr.push(LongUtil.readLong(patch));
            data_arr.push(temArr);
            i++;
         }
         MartHandler.GC_MARTBUY(data_arr,totalPage,eve_num);
      }
      
      public function GC_MY_BUY(patch:IDataInput) : void
      {
         var temArr:Array = null;
         var result:int = patch.readByte();
         var eve_num:int = patch.readByte();
         var data_arr:Array = [];
         var i:int = 0;
         while(i <= eve_num - 1)
         {
            temArr = [];
            temArr.push(LongUtil.readLong(patch));
            temArr.push(patch.readInt());
            temArr.push(patch.readInt());
            temArr.push(patch.readInt());
            temArr.push(patch.readByte());
            temArr.push(patch.readUTF());
            temArr.push(LongUtil.readLong(patch));
            temArr.push(patch.readInt());
            temArr.push(patch.readByte());
            temArr.push(LongUtil.readLong(patch));
            data_arr.push(temArr);
            i++;
         }
         MartHandler.GC_MY_BUY(data_arr,eve_num);
      }
      
      public function GC_SEARCH(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var evePage:int = patch.readByte();
      }
      
      public function GC_SOLD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == -1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("412",0));
            return;
         }
         if(result == -2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("413",0));
            return;
         }
         if(result == -3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("809",0));
            return;
         }
         var martId:Number = LongUtil.readLong(patch);
         var _num:int = patch.readByte();
         var _cur_pg:int = patch.readInt();
         MartHandler.GC_SOLD(result,martId,_num,_cur_pg);
      }
      
      public function GC_BUY(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == -3)
         {
            UIManager.centerBroadcast.addMsg("此物品已下架或已被购买");
            return;
         }
         var martId:Number = LongUtil.readLong(patch);
         var _num:int = patch.readByte();
         var _cur_pg:int = patch.readInt();
         MartHandler.GC_BUY(result,martId,_num,_cur_pg);
      }
      
      public function GC_CANCLE_BUY(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         MartHandler.GC_CANCLE_BUY(result);
      }
      
      public function GC_CANCLE_SOLD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         MartHandler.GC_CANCLE_SOLD(result);
      }
   }
}

