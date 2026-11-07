package com.yiTian.net.message.cg
{
   import com.utils.LongUtil;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class JiaoYiCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function JiaoYiCGMessage()
      {
         super();
      }
      
      public static function CG_JIAOYI_LIST() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_JIAOYI_LIST,bytebuff);
      }
      
      public static function CG_JIAOYI(OtherroleName:String, Theme:String, Silver:int, Gold:int, gridId:Array, nums:Array, grId:Array) : void
      {
         bytebuff.length = 0;
         OtherroleName = Model_heFu.correctRoleServName(OtherroleName);
         bytebuff.writeUTF(OtherroleName);
         bytebuff.writeUTF(Theme);
         bytebuff.writeInt(Silver);
         bytebuff.writeInt(Gold);
         bytebuff.writeShort(gridId.length);
         var i:int = 0;
         while(i < gridId.length)
         {
            bytebuff.writeShort(gridId[i]);
            i++;
         }
         bytebuff.writeShort(nums.length);
         i = 0;
         while(i < nums.length)
         {
            bytebuff.writeShort(nums[i]);
            i++;
         }
         bytebuff.writeShort(grId.length);
         i = 0;
         while(i < grId.length)
         {
            bytebuff.writeShort(grId[i]);
            i++;
         }
         SocketManager.send(MessageType.CG_JIAOYI,bytebuff);
      }
      
      public static function CG_JIAOYI_QUERY(jyId:Number) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,jyId);
         SocketManager.send(MessageType.CG_JIAOYI_QUERY,bytebuff);
      }
      
      public static function CG_JIAOYI_RETURN(jy_id:Number, jyNum:int, otherRoleName:String) : void
      {
         otherRoleName = Model_heFu.correctRoleServName(otherRoleName);
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,jy_id);
         bytebuff.writeByte(jyNum);
         bytebuff.writeUTF(otherRoleName);
         SocketManager.send(MessageType.CG_JIAOYI_RETURN,bytebuff);
      }
      
      public static function CG_JIAOYI_GET(jy_id:Number) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,jy_id);
         SocketManager.send(MessageType.CG_JIAOYI_GET,bytebuff);
      }
      
      public static function CG_JIAOYI_REP(otherRoleName:String, jy_id:Number, Silver:int, Gold:int, gridId:Array, nums:Array, grId:Array) : void
      {
         bytebuff.length = 0;
         otherRoleName = Model_heFu.correctRoleServName(otherRoleName);
         LongUtil.writeLong(bytebuff,jy_id);
         bytebuff.writeInt(Silver);
         bytebuff.writeInt(Gold);
         bytebuff.writeUTF(otherRoleName);
         bytebuff.writeByte(gridId.length);
         var i:int = 0;
         while(i < gridId.length)
         {
            bytebuff.writeShort(gridId[i]);
            i++;
         }
         bytebuff.writeByte(nums.length);
         i = 0;
         while(i < nums.length)
         {
            bytebuff.writeShort(nums[i]);
            i++;
         }
         bytebuff.writeByte(grId.length);
         i = 0;
         while(i < grId.length)
         {
            bytebuff.writeByte(grId[i]);
            i++;
         }
         SocketManager.send(MessageType.CG_JIAOYI_REP,bytebuff);
      }
   }
}

