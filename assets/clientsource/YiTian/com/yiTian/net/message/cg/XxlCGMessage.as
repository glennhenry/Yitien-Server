package com.yiTian.net.message.cg
{
   import com.yiTian.data.model.Model_xiaoxiaole;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.utils.Utils;
   import flash.utils.ByteArray;
   
   public class XxlCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function XxlCGMessage()
      {
         super();
      }
      
      public static function CG_XXL_OPENWIN() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_XXL_OPENWIN,bytebuff);
      }
      
      public static function CG_XXL_SYNMAP() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_XXL_SYNMAP,bytebuff);
      }
      
      public static function CG_XXL_CHANGEPOS(step:int, pos:String, pos2:String, posArr:String) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(step);
         bytebuff.writeUTF(pos);
         bytebuff.writeUTF(pos2);
         bytebuff.writeUTF(posArr);
         Model_xiaoxiaole.isSelected = true;
         Model_xiaoxiaole.getInstance().testMap("交换之前的");
         Utils.print("发送的数据step:",step,"pos",pos,"pos2",pos2,"所有",posArr);
         SocketManager.send(MessageType.CG_XXL_CHANGEPOS,bytebuff);
      }
      
      public static function CG_XXL_KILL_GIRD(step:int, u:String) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(step);
         bytebuff.writeUTF(u);
         Utils.print("二次消除发送的格子：",u,"发送的数据step:",step);
         SocketManager.send(MessageType.CG_XXL_KILL_GIRD,bytebuff);
      }
      
      public static function CG_XXL_USE_TOOL_CLEAR() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_XXL_USE_TOOL_CLEAR,bytebuff);
      }
      
      public static function CG_XXL_USE_TOOL_PP() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_XXL_USE_TOOL_PP,bytebuff);
      }
      
      public static function CG_XXL_USE_TOOL_ADDSTEP() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_XXL_USE_TOOL_ADDSTEP,bytebuff);
      }
      
      public static function CG_XXL_USE_TOOL_BW() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_XXL_USE_TOOL_BW,bytebuff);
      }
      
      public static function CG_XXL_REFRESHMAP() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_XXL_REFRESHMAP,bytebuff);
      }
   }
}

