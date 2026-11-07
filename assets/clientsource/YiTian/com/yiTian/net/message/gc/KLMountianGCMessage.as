package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.net.handler.KLMountianHandle;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.Kunlun.Vo_klRank;
   import flash.utils.IDataInput;
   
   public class KLMountianGCMessage
   {
      
      public function KLMountianGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_KL_EXTRA_RESULT] = GC_KL_EXTRA_RESULT;
         index[MessageType.GC_ENTER_KLMOUNTIAN] = GC_ENTER_KL_MOUNTIAN;
         index[MessageType.GC_KLSHAN_ONTIME] = GC_KLSHAN_ONTIME;
         index[MessageType.GC_GET_KL_ROOM] = GC_GET_KL_ROOM;
         index[MessageType.GC_KILL_INFO] = GC_KILL_INFO;
         index[MessageType.GC_KL_END] = GC_KL_END;
         index[MessageType.GC_DATA_REFRESH] = GC_INFO_REFRESH_FLAG;
         index[MessageType.GC_KL_RANK1] = GC_KL_RANK1;
         index[MessageType.GC_KL_RANK] = GC_KL_RANK;
         index[MessageType.GC_LIXIANDIAN_RESULT] = GC_LIXIANDIAN_RESULT;
      }
      
      public static function GC_KL_EXTRA_RESULT(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         KLMountianHandle.GC_KL_EXTRA_RESULT(type,patch);
      }
      
      public static function GC_ENTER_KL_MOUNTIAN(patch:IDataInput) : void
      {
         var roomIndex:int = patch.readShort();
         var numKl1:int = patch.readShort();
         var numKl2:int = patch.readShort();
         var sbId:Number = LongUtil.readLong(patch);
         var sbName:String = patch.readUTF();
         var actRemainTime:int = patch.readShort();
         var freRemainTime:int = patch.readShort();
         KLMountianHandle.GC_ENTER_KL_MOUNTIAN(roomIndex,numKl1,numKl2,sbId,sbName,actRemainTime,freRemainTime);
      }
      
      public static function GC_KLSHAN_ONTIME(patch:IDataInput) : void
      {
         KLMountianHandle.GC_KLSHAN_ONTIME();
      }
      
      public static function GC_GET_KL_ROOM(patch:IDataInput) : void
      {
         var myIndex:int = patch.readShort();
         var num:int = patch.readShort();
         var arr:Array = new Array();
         var i:int = 0;
         while(i < num)
         {
            arr.push(patch.readByte());
            i++;
         }
         KLMountianHandle.GC_GET_KL_ROOM(arr,myIndex);
      }
      
      public static function GC_KILL_INFO(patch:IDataInput) : void
      {
         var k1:int = patch.readShort();
         var k2:int = patch.readShort();
         KLMountianHandle.GC_KILL_INFO(k1,k2);
      }
      
      public static function GC_KL_END(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         KLMountianHandle.GC_KL_END(type);
      }
      
      public static function GC_INFO_REFRESH_FLAG(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         KLMountianHandle.GC_INFO_REFRESH_FLAG(type);
      }
      
      public static function GC_KL_RANK1(patch:IDataInput) : void
      {
         var id:Number = NaN;
         var name:String = null;
         var job:int = 0;
         var soccer:int = 0;
         var len:int = patch.readByte();
         var arr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            id = LongUtil.readLong(patch);
            name = patch.readUTF();
            job = patch.readByte();
            soccer = patch.readInt();
            arr.push([id,name,job,soccer]);
            i += 1;
         }
         KLMountianHandle.GC_KL_RANK1(arr);
      }
      
      public static function GC_KL_RANK(patch:IDataInput) : void
      {
         var obj:Vo_klRank = null;
         var type:int = patch.readByte();
         var myRank:int = patch.readInt();
         var dataCount:int = patch.readByte();
         var pageIndex:int = patch.readByte();
         var length:int = patch.readByte();
         var array:Array = new Array();
         var index:int = 0;
         while(index < length)
         {
            obj = new Vo_klRank();
            obj.roleId = patch.readInt();
            obj.roleName = patch.readUTF();
            obj.roleLevel = patch.readByte();
            obj.roleJob = patch.readByte();
            obj.score = patch.readShort();
            array.push(obj);
            index++;
         }
         KLMountianHandle.GC_KL_RANK(type,myRank,dataCount,pageIndex,array);
      }
      
      public static function GC_LIXIANDIAN_RESULT(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         var lixiandian:int = patch.readInt();
         var total:int = patch.readInt();
         KLMountianHandle.GC_LIXIANDIAN_RESULT(type,lixiandian,total);
      }
   }
}

