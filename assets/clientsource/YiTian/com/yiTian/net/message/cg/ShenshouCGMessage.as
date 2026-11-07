package com.yiTian.net.message.cg
{
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_map_lib;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class ShenshouCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function ShenshouCGMessage()
      {
         super();
      }
      
      public static function CG_SHEN_SHOU() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_SHEN_SHOU,bytebuff);
      }
      
      public static function CG_TIAO_ZHAN() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_TIAO_ZHAN,bytebuff);
      }
      
      public static function CG_ENTER_BEAST() : void
      {
         if(!GameUnitManager.hero.partyId)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30036",3));
            return;
         }
         if(Boolean(Model_team.isTeam[GameUnitManager.hero.id]))
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30033",3));
            return;
         }
         if(Global.sceneMap == 12408)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30053",3));
            return;
         }
         if(Data_lib.map[Global.sceneMap][Enum_map_lib.TYPE] != 3 || Global.sceneMap == 12304 || Global.sceneMap == 12305)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30034",3));
            return;
         }
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_ENTER_BEAST,bytebuff);
      }
      
      public static function CG_FEED_BEAST(t:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(t);
         SocketManager.send(MessageType.CG_FEED_BEAST,bytebuff);
      }
      
      public static function CG_FEED_LEVEL() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_FEED_LEVEL,bytebuff);
      }
      
      public static function CG_SSBX_BEGIN_COLLECT(id:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(id);
         SocketManager.send(MessageType.CG_SSBX_BEGIN_COLLECT,bytebuff);
      }
      
      public static function CG_SSBX_END_COLLECT(id:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(id);
         SocketManager.send(MessageType.CG_SSBX_END_COLLECT,bytebuff);
      }
      
      public static function CG_SSBX_BREAK_COLLECT(id:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(id);
         SocketManager.send(MessageType.CG_SSBX_BREAK_COLLECT,bytebuff);
      }
      
      public static function CG_GONG_JI_SHENSHOU(id:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(id);
         SocketManager.send(MessageType.CG_GONG_JI_SHENSHOU,bytebuff);
      }
   }
}

