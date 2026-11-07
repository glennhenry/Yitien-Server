package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.net.handler.GuaJiHandle;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.utils.PatchReader;
   import flash.utils.IDataInput;
   
   public class GuaJiGCMessage
   {
      
      private var i_index:int = 0;
      
      private var ii_index:int = 0;
      
      public function GuaJiGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_GUAJI_INFO_CHANGE] = this.GC_GUAJI_INFO_CHANGE;
         index[MessageType.GC_LQQD_ROOM_INFO] = this.GC_LQQD_ROOM_INFO;
         index[MessageType.GC_GUAJI_CANCEL] = this.GC_GUAJI_CANCEL;
         index[MessageType.GC_GET_XINGXINGEXP] = this.GC_GET_XINGXINGEXP;
         index[MessageType.GC_REPLAY] = this.GC_SNATCH_LQROOM;
         index[MessageType.GC_SHUANGXIU_INFO] = this.GC_SHUANGXIU_INFO;
         index[MessageType.GC_SHUANGXIU_REQUEST_RE] = this.GC_SHUANGXIU_REQUEST_RE;
         index[MessageType.GC_SHUANGXIU_REQUEST_CHOOSE_RE] = this.GC_SHUANGXIU_REQUEST_CHOOSE_RE;
         index[MessageType.GC_SNATCH_COLLDOWN] = this.GC_SNATCH_COLLDOWN;
         index[MessageType.GC_GUAJIEXPADDTIP] = this.GC_GUAJIEXPADDTIP;
         index[MessageType.GC_QYSX_REQUEST_RESYLT] = this.GC_QYSX_REQUEST_RESYLT;
         index[MessageType.GC_WAWATIME] = this.GC_WAWATIME;
         index[MessageType.GC_5XGUAJITIMEON] = this.GC_5XGUAJITIMEON;
         index[MessageType.GC_5XGUAJITIMEOFF] = this.GC_5XGUAJITIMEOFF;
         index[MessageType.GC_GJDINFO] = this.GC_GJDINFO;
      }
      
      public function GC_GUAJI_INFO_CHANGE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var isRequestGJ:int = patch.readByte();
         var gainExp:int = patch.readInt();
         var countTime:int = patch.readInt();
         var sxType:int = patch.readByte();
         var lqType:int = patch.readByte();
         var starTime:int = patch.readInt();
         var vip:int = patch.readByte();
         var wawaTime:int = patch.readInt();
         var isUseWaWa:int = patch.readByte();
         var targetName:String = Model_heFu.repNameByHero(patch.readUTF());
         GuaJiHandle.GC_GUAJI_INFO_CHANGE(isRequestGJ,gainExp,countTime,sxType,lqType,starTime,vip,wawaTime,isUseWaWa,targetName);
      }
      
      public function GC_GET_XINGXINGEXP(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var xingxingTime:int = patch.readInt();
         var gainExp:int = patch.readInt();
         GuaJiHandle.GC_GET_XINGXINGEXP(xingxingTime,gainExp);
      }
      
      public function GC_GUAJI_CANCEL(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         GuaJiHandle.GC_GUAJI_CANCEL(result);
      }
      
      public function GC_LQQD_ROOM_INFO(patch:IDataInput) : void
      {
         var arr1:Array = null;
         var arr2:Array = null;
         var arr3:Array = null;
         var result:int = patch.readByte();
         var refreshViewFlag:int = patch.readByte();
         var lqType1:int = patch.readByte();
         var length1:int = patch.readByte();
         var array1:Array = new Array();
         var index1:uint = 0;
         while(index1 < length1)
         {
            arr1 = new Array();
            arr1.push(patch.readByte());
            arr1.push(LongUtil.readLong(patch));
            arr1.push(Model_heFu.repNameByHero(patch.readUTF()));
            arr1.push(patch.readShort());
            arr1.push(patch.readByte());
            arr1.push(patch.readByte());
            arr1.push(patch.readUTF());
            array1.push(arr1);
            index1++;
         }
         var lqType2:int = patch.readByte();
         var length2:int = patch.readByte();
         var array2:Array = new Array();
         var index2:uint = 0;
         while(index2 < length2)
         {
            arr2 = new Array();
            arr2.push(patch.readByte());
            arr2.push(LongUtil.readLong(patch));
            arr2.push(Model_heFu.repNameByHero(patch.readUTF()));
            arr2.push(patch.readShort());
            arr2.push(patch.readByte());
            arr2.push(patch.readByte());
            arr2.push(patch.readUTF());
            array2.push(arr2);
            index2++;
         }
         var lqType3:int = patch.readByte();
         var length3:int = patch.readByte();
         var array3:Array = new Array();
         var index3:uint = 0;
         while(index3 < length3)
         {
            arr3 = new Array();
            arr3.push(patch.readByte());
            arr3.push(LongUtil.readLong(patch));
            arr3.push(Model_heFu.repNameByHero(patch.readUTF()));
            arr3.push(patch.readShort());
            arr3.push(patch.readByte());
            arr3.push(patch.readByte());
            arr3.push(patch.readUTF());
            array3.push(arr3);
            index3++;
         }
         GuaJiHandle.GC_LQQD_INFO(lqType1,array1,lqType2,array2,lqType3,array3,refreshViewFlag);
      }
      
      public function GC_SNATCH_LQROOM(patch:IDataInput) : void
      {
         var infos:Array = PatchReader.instance.readBattle(patch);
         var battleId:int = int(infos[0]);
         var result:int = int(infos[1]);
         var type:int = int(infos[2]);
         var selfZF:int = int(infos[3]);
         var targetZF:int = int(infos[4]);
         var roles:Array = infos[5];
         var steps:Array = infos[6];
         var isWin:int = int(infos[7]);
         var roundStartMap:Object = infos[8];
         var oppnId:Number = LongUtil.readLong(patch);
         var name:String = patch.readUTF();
         name = Model_heFu.repNameByHero(name);
         var lqType:int = patch.readByte();
         GuaJiHandle.GC_SNATCH_LQROOM(battleId,oppnId,name,lqType,type,selfZF,targetZF,roles,steps,isWin,roundStartMap);
      }
      
      public function GC_SNATCH_COLLDOWN(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         var coolTime:int = patch.readShort();
         GuaJiHandle.GC_SNATCH_COLLDOWN(type,coolTime);
      }
      
      public function GC_SHUANGXIU_INFO(patch:IDataInput) : void
      {
         var arr:Array = null;
         var result:int = patch.readByte();
         var length:int = patch.readShort();
         var array:Array = new Array();
         var index:int = 0;
         while(index < length)
         {
            arr = new Array();
            arr.push(LongUtil.readLong(patch));
            arr.push(Model_heFu.repNameByHero(patch.readUTF()));
            arr.push(patch.readShort());
            arr.push(patch.readByte());
            array.push(arr);
            index++;
         }
         GuaJiHandle.GC_SHUANGXIU_INFO(array);
      }
      
      public function GC_SHUANGXIU_REQUEST_RE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var obj:Object = new Object();
         obj.id = LongUtil.readLong(patch);
         obj.name = patch.readUTF();
         obj.name = Model_heFu.repNameByHero(obj.name);
         obj.sex = patch.readByte();
         GuaJiHandle.GC_SHUANGXIU_REQUEST_RE(obj);
      }
      
      public function GC_QYSX_REQUEST_RESYLT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         GuaJiHandle.GC_QYSX_REQUEST_RESYLT(result);
      }
      
      public function GC_SHUANGXIU_REQUEST_CHOOSE_RE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var choose:int = patch.readByte();
         var name:String = patch.readUTF();
         name = Model_heFu.repNameByHero(name);
         GuaJiHandle.GC_SHUANGXIU_REQUEST_CHOOSE_RE(choose,name);
      }
      
      private function GC_GUAJIEXPADDTIP(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var countExp:int = patch.readInt();
         GuaJiHandle.GC_GUAJIEXPADDTIP(countExp);
      }
      
      public function GC_WAWATIME(patch:IDataInput) : void
      {
         var countTime:int = patch.readInt();
         GuaJiHandle.GC_WAWATIME(countTime);
      }
      
      public function GC_5XGUAJITIMEON(patch:IDataInput) : void
      {
         GuaJiHandle.GC_5XGUAJITIMEON(true);
      }
      
      public function GC_5XGUAJITIMEOFF(patch:IDataInput) : void
      {
         GuaJiHandle.GC_5XGUAJITIMEOFF();
      }
      
      public function GC_GJDINFO(patch:IDataInput) : void
      {
         var type:int = patch.readInt();
         var remainTime:int = patch.readInt();
         GuaJiHandle.GC_GJDINFO(type,remainTime);
      }
   }
}

