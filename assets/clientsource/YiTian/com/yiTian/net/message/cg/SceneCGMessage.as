package com.yiTian.net.message.cg
{
   import com.utils.LongUtil;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.crossClanBattle.Model_CrossClanBattle;
   import flash.utils.ByteArray;
   
   public class SceneCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function SceneCGMessage()
      {
         super();
      }
      
      public static function CG_ENTER_SCENE(roleId:Number) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,roleId);
         SocketManager.send(MessageType.CG_ENTER_SCENE,bytebuff);
      }
      
      public static function CG_ENTER_SCENE_OK() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_ENTER_SCENE_OK,bytebuff);
      }
      
      public static function CG_ASK_CHANGE_SCENE(mapId:int, toX:int, toY:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(mapId);
         bytebuff.writeInt(toX);
         bytebuff.writeInt(toY);
         SocketManager.send(MessageType.CG_ASK_CHANGE_SCENE,bytebuff);
      }
      
      public static function CG_ASK_CHANGE_SCENE_OK() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_ASK_CHANGE_SCENE_OK,bytebuff);
      }
      
      public static function CG_ENTER_FUBEN(mapId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(mapId);
         SocketManager.send(MessageType.CG_ENTER_FUBEN,bytebuff);
      }
      
      public static function CG_ENTER_FUBEN_OK(mapId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(mapId);
         SocketManager.send(MessageType.CG_ENTER_FUBEN_OK,bytebuff);
      }
      
      public static function CG_MOVE(route:Array) : void
      {
         bytebuff.length = 0;
         bytebuff.writeShort(route.length);
         var i:int = 0;
         while(i < route.length)
         {
            bytebuff.writeShort(route[i][0]);
            bytebuff.writeShort(route[i][1]);
            i++;
         }
         SocketManager.send(MessageType.CG_MOVE,bytebuff);
      }
      
      public static function CG_STOP_MOVE(posX:int, posY:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeShort(posX);
         bytebuff.writeShort(posY);
         SocketManager.send(MessageType.CG_STOP_MOVE,bytebuff);
      }
      
      public static function CG_HEARTBEAT() : void
      {
         bytebuff.length = 0;
         var date:Date = new Date();
         var time:int = date.getTime() / 1000;
         bytebuff.writeInt(time);
         SocketManager.send(MessageType.CG_HEARTBEAT,bytebuff);
         if(Model_CrossClanBattle.port > 0 && SocketManager.tempSend != null)
         {
            SocketManager.tempSend(MessageType.CG_HEARTBEAT,bytebuff);
         }
      }
      
      public static function CG_COLLECT(npcId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(npcId);
         SocketManager.send(MessageType.CG_COLLECT,bytebuff);
      }
      
      public static function CG_LEVEA_FUBEN() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_LEVEA_FUBEN,bytebuff);
      }
      
      public static function CG_TO_NPC(type:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(type);
         SocketManager.send(MessageType.CG_TO_NPC,bytebuff);
      }
      
      public static function CG_USE_SXF(sceneId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(sceneId);
         SocketManager.send(MessageType.CG_USE_SXF,bytebuff);
      }
      
      public static function CG_SET_SEND_USE_YB() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_SET_SEND_USE_YB,bytebuff);
      }
   }
}

