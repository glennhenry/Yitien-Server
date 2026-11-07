package com.yiTian.view.modules.crossClanBattle
{
   import com.yiTian.Global;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.cg.CrossClanBattleCGMessage;
   import com.yiTian.net.message.gc.AiDeBaoBaoGCMessage;
   import com.yiTian.net.message.gc.BabyGCMessage;
   import com.yiTian.net.message.gc.BagGCMessage;
   import com.yiTian.net.message.gc.BattleGCMessage;
   import com.yiTian.net.message.gc.BoatGCMessage;
   import com.yiTian.net.message.gc.BroadCastGCMessage;
   import com.yiTian.net.message.gc.BufferGCMessage;
   import com.yiTian.net.message.gc.ChatGCMessage;
   import com.yiTian.net.message.gc.CrossCampBattleGCMessage;
   import com.yiTian.net.message.gc.CrossClanBattleGCMessage;
   import com.yiTian.net.message.gc.CrossDartGCMessage;
   import com.yiTian.net.message.gc.HumanGCMessage;
   import com.yiTian.net.message.gc.KuaFuPaiDuiGCMessage;
   import com.yiTian.net.message.gc.PaoBiaoGCMessage;
   import com.yiTian.net.message.gc.PetGCMessage;
   import com.yiTian.net.message.gc.QuestGCMessage;
   import com.yiTian.net.message.gc.SceneGCMessage;
   import com.yiTian.net.message.gc.SkillGCMessage;
   import com.yiTian.net.message.gc.TeamGCMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.KFHomeland.HomeLandGCMessage;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.Socket;
   import flash.utils.ByteArray;
   import flash.utils.getTimer;
   
   public class CrossClanBattleSocket
   {
      
      public static var socket:Socket;
      
      private static var connectHandler:Function;
      
      public static var index:Array;
      
      private static var recvCache:ByteArray = new ByteArray();
      
      private static var recvArray:ByteArray = new ByteArray();
      
      private static var data:ByteArray = new ByteArray();
      
      public function CrossClanBattleSocket()
      {
         super();
      }
      
      public static function init() : void
      {
         socket = new Socket();
         socket.addEventListener(Event.CONNECT,connectStateHandler);
         socket.addEventListener(Event.CLOSE,connectStateHandler);
         socket.addEventListener(IOErrorEvent.IO_ERROR,errorHandler);
         socket.addEventListener(ProgressEvent.SOCKET_DATA,socketDataHandler);
         socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,securityErrorHandler);
         connectHandler = loginLoginServer;
         registerMessage();
      }
      
      public static function registerMessage() : void
      {
         new SceneGCMessage(index);
         new HumanGCMessage(index);
         new BagGCMessage(index);
         new SkillGCMessage(index);
         new BattleGCMessage(index);
         new ChatGCMessage(index);
         new TeamGCMessage(index);
         new BroadCastGCMessage(index);
         new PetGCMessage(index);
         new CrossClanBattleGCMessage(index);
         new AiDeBaoBaoGCMessage(index);
         new KuaFuPaiDuiGCMessage(index);
         new HomeLandGCMessage(index);
         new CrossCampBattleGCMessage(index);
         new BabyGCMessage(index);
         new CrossDartGCMessage(index);
         new PaoBiaoGCMessage(index);
         new QuestGCMessage(index);
         new BufferGCMessage(index);
         new BoatGCMessage(index);
      }
      
      public static function connect(host:String, port:int, isClose:Boolean = true) : void
      {
         View_loading.instance.begin();
         GameScene.instance.preFrameTime = getTimer();
         if(!socket)
         {
            init();
         }
         if(socket.connected && isClose)
         {
            socket.close();
         }
         else
         {
            connectHandler = loginLoginServer;
         }
         socket.connect(host,port);
         var data:Date = new Date();
         if(Global.lastTime == 0)
         {
            Global.lastTime = data.time;
         }
         Global.loginTime += "connect:" + (data.time - Global.lastTime) + "|";
         Global.lastTime = data.time;
      }
      
      private static function loginLoginServer() : void
      {
         connectHandler = loginGameServer;
         socket.writeMultiByte("GET / HTTP/1.1\r\nHost: " + Model_CrossClanBattle.ip + ":" + Model_CrossClanBattle.port + "\r\n\r\n","GBK");
         socket.flush();
         CrossClanBattleCGMessage.CG_CONNECT_SOCKET(Global.crossType,Global.crossParams,Model_CrossClanBattle.testNum,GameUnitManager.hero.id);
      }
      
      private static function loginGameServer() : void
      {
      }
      
      public static function connectStateHandler(e:Event) : void
      {
         if(e.type == Event.CONNECT)
         {
            View_loading.instance.end();
            Utils.print("跨服服务器连接成功");
            SocketManager.setChangeSocketFun(true);
            SocketManager.setKuafuSocketFun(true);
            connectHandler();
         }
         else if(e.type == Event.CLOSE)
         {
            connectHandler = loginLoginServer;
            socket.close();
         }
      }
      
      public static function socketDataHandler(e:ProgressEvent) : void
      {
         recvCache.length = 0;
         socket.readBytes(recvCache);
         recvCache.position = 0;
         if(recvArray.position == 0)
         {
            doMessage(recvCache);
            if(recvCache.bytesAvailable > 0)
            {
               recvArray.length = 0;
               recvArray.writeBytes(recvCache,recvCache.position,recvCache.bytesAvailable);
            }
         }
         else
         {
            recvCache.readBytes(recvArray,recvArray.length,recvCache.length);
            recvArray.position = 0;
            doMessage(recvArray);
            if(recvArray.bytesAvailable > 0)
            {
               data.length = 0;
               data.writeBytes(recvArray,recvArray.position,recvArray.bytesAvailable);
               recvArray.length = 0;
               recvArray.writeBytes(data);
            }
            else
            {
               recvArray.length = 0;
            }
         }
      }
      
      private static function doMessage(recv:ByteArray) : void
      {
         var len:int = 0;
         var cmd:int = 0;
         if(recv.bytesAvailable > 0 && recv.toString().indexOf("<?xml") == 0)
         {
            recv.length = 0;
         }
         while(recv.bytesAvailable >= 4)
         {
            len = recv.readInt();
            if(recv.bytesAvailable < len - 4)
            {
               recv.position -= 4;
               break;
            }
            cmd = recv.readInt();
            if(cmd != 5009 && cmd != 88888 && cmd != 11002 && cmd != 5004 && cmd != 5007 && cmd != 6007 && cmd != 6050 && cmd != 5035 && cmd != 5030 && cmd != 6672)
            {
               Utils.print("receive",cmd);
            }
            data.length = 0;
            data.writeBytes(recv,recv.position,len - 8);
            recv.position += len - 8;
            data.position = 0;
            if(Boolean(index[cmd]))
            {
               index[cmd](data);
            }
         }
      }
      
      public static function close() : void
      {
         socket.close();
      }
      
      public static function errorHandler(e:IOErrorEvent) : void
      {
         Utils.print("IOERROR");
         socket.close();
      }
      
      public static function securityErrorHandler(e:SecurityErrorEvent) : void
      {
         Utils.print("SUCURITY_ERROR");
         socket.close();
         CrossClanBattleSocket.connect(Model_CrossClanBattle.ip,Model_CrossClanBattle.port);
      }
   }
}

