package com.yiTian.view.modules.KFHomeland
{
   import com.utils.LongUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.utils.Utils;
   import flash.utils.ByteArray;
   
   public class HomeLandCGMessage
   {
      
      private static var byteBuff:ByteArray = new ByteArray();
      
      public function HomeLandCGMessage()
      {
         super();
      }
      
      public static function CG_ENTER_HOME_SCENE(serverId:int, crossType:String, id:String) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(serverId);
         byteBuff.writeUTF(crossType);
         byteBuff.writeUTF(id);
         SocketManager.send(MessageType.CG_ENTER_HOME_SCENE,byteBuff);
      }
      
      public static function CG_BUY_HOMELAND() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_BUY_HOMELAND,byteBuff);
      }
      
      public static function CG_ENTER_HOMELAND(id:Number, type:int, zone:int) : void
      {
         byteBuff.length = 0;
         LongUtil.writeLong(byteBuff,id);
         Utils.print("144003  ",id,GameUnitManager.hero.id);
         byteBuff.writeByte(type);
         byteBuff.writeInt(zone);
         byteBuff.writeInt(VoHome.heroS);
         var isLocal:int = 1;
         if(Global.isInHome)
         {
            isLocal = 2;
         }
         byteBuff.writeByte(isLocal);
         SocketManager.send(MessageType.CG_ENTER_HOMELAND,byteBuff);
      }
      
      public static function CG_INNER_HOMELAND() : void
      {
         byteBuff.length = 0;
         LongUtil.writeLong(byteBuff,VoHome.visitHomeRoleId);
         SocketManager.send(MessageType.CG_INNER_HOMELAND,byteBuff);
      }
      
      public static function CG_BUILD_HOMELAND(type:int, zone:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         byteBuff.writeInt(zone);
         SocketManager.send(MessageType.CG_BUILD_HOMELAND,byteBuff);
      }
      
      public static function CG_SOREBUILD_HOMELAND(level:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(level);
         byteBuff.writeByte(VoHome.isOut);
         byteBuff.writeInt(VoHome.heroS);
         SocketManager.send(MessageType.CG_SOREBUILD_HOMELAND,byteBuff);
      }
      
      public static function CG_VISIT_OUT_HOMELAND() : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(VoHome.heroS);
         byteBuff.writeByte(VoHome.isOut);
         SocketManager.send(MessageType.CG_VISIT_OUT_HOMELAND,byteBuff);
      }
      
      public static function CG_SURE_BUILDING(id:int, xGrid:int, yGrid:int, orien:int, canSit:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(id);
         byteBuff.writeInt(xGrid);
         byteBuff.writeInt(yGrid);
         byteBuff.writeByte(orien);
         byteBuff.writeInt(VoHome.heroS);
         byteBuff.writeInt(VoHome.isOut);
         LongUtil.writeLong(byteBuff,GameUnitManager.hero.id);
         byteBuff.writeByte(canSit);
         SocketManager.send(MessageType.CG_SURE_BUILDING,byteBuff);
      }
      
      public static function CG_DISMANTLE(id:int, xGrid:int, yGrid:int, orien:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(id);
         byteBuff.writeInt(xGrid);
         byteBuff.writeInt(yGrid);
         byteBuff.writeByte(orien);
         byteBuff.writeInt(VoHome.heroS);
         byteBuff.writeInt(VoHome.isOut);
         LongUtil.writeLong(byteBuff,GameUnitManager.hero.id);
         SocketManager.send(MessageType.CG_DISMANTLE,byteBuff);
      }
      
      public static function CG_BUY_SKIN(id:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(id);
         byteBuff.writeInt(VoHome.heroS);
         byteBuff.writeInt(VoHome.isOut);
         Utils.print("144019",VoHome.isOut);
         SocketManager.send(MessageType.CG_BUY_SKIN,byteBuff);
      }
      
      public static function CG_USE_SKIN(id:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(id);
         byteBuff.writeInt(VoHome.heroS);
         byteBuff.writeByte(VoHome.isOut);
         Utils.print("144021",VoHome.isOut);
         SocketManager.send(MessageType.CG_USE_SKIN,byteBuff);
      }
      
      public static function CG_ENTER_MALL() : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(VoHome.heroS);
         SocketManager.send(MessageType.CG_ENTER_MALL,byteBuff);
      }
      
      public static function CG_REFRESH_MALL() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_REFRESH_MALL,byteBuff);
      }
      
      public static function CG_BUY_MALL(id:int, _index:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(VoHome.heroS);
         byteBuff.writeInt(id);
         byteBuff.writeByte(_index);
         SocketManager.send(MessageType.CG_BUY_MALL,byteBuff);
      }
      
      public static function CG_CLEAN_HOMELAND(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_CLEAN_HOMELAND,byteBuff);
      }
      
      public static function CG_FIRENDLIST_HOMELAND(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         byteBuff.writeInt(VoHome.heroS);
         SocketManager.send(MessageType.CG_FIRENDLIST_HOMELAND,byteBuff);
      }
      
      public static function CG_EXIT_HOMELAND() : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(VoHome.isOut);
         byteBuff.writeInt(VoHome.heroS);
         SocketManager.send(MessageType.CG_EXIT_HOMELAND,byteBuff);
      }
      
      public static function CG_GLOBAL_TEAM_VISITHOME() : void
      {
         byteBuff.length = 0;
         LongUtil.writeLong(byteBuff,VoHome.visitHomeRoleId);
         byteBuff.writeInt(VoHome.heroS);
         SocketManager.send(MessageType.CG_GLOBAL_TEAM_VISITHOME,byteBuff);
      }
      
      public static function CG_LOCAL_TEAM_VISITHOME() : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(VoHome.heroS);
         SocketManager.send(MessageType.CG_LOCAL_TEAM_VISITHOME,byteBuff);
      }
      
      public static function CG_START_BUILD() : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(VoHome.isOut);
         SocketManager.send(MessageType.CG_START_BUILD,byteBuff);
      }
      
      public static function CG_GLOBAL_TEAM_OTHERHOME() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_GLOBAL_TEAM_OTHERHOME,byteBuff);
      }
      
      public static function CG_ASK_GETGOODS(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_ASK_GETGOODS,byteBuff);
      }
      
      public static function CG_ASK_SURE_GET(type:int, ind:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         byteBuff.writeByte(ind);
         SocketManager.send(MessageType.CG_ASK_SURE_GET,byteBuff);
      }
      
      public static function CG_CLICK_DANQI() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_CLICK_DANQI,byteBuff);
      }
   }
}

