package manager
{
   import com.ui.controls.TapperEvent;
   import com.utils.LongUtil;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.external.ExternalInterface;
   import flash.net.Socket;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.ByteArray;
   import flash.utils.getTimer;
   import net.LoginCGMessage;
   import net.LoginGCMessage;
   import view.OffLineTip;
   
   public class SocketManager
   {
      
      public static var socket:Socket;
      
      private static var connectHandler:Function;
      
      public static var send:Function;
      
      public static var receive:Function;
      
      private static var _lastRandValue:int;
      
      private static var recvCache:ByteArray = new ByteArray();
      
      private static var recvArray:ByteArray = new ByteArray();
      
      private static var data:ByteArray = new ByteArray();
      
      public static var index:Array = [];
      
      public function SocketManager()
      {
         super();
      }
      
      public static function init() : void
      {
         LongUtil.initConverDic();
         socket = new Socket();
         socket.addEventListener(Event.CONNECT,connectStateHandler);
         socket.addEventListener(Event.CLOSE,connectStateHandler);
         socket.addEventListener(IOErrorEvent.IO_ERROR,errorHandler);
         socket.addEventListener(ProgressEvent.SOCKET_DATA,socketDataHandler);
         socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,securityErrorHandler);
         connectHandler = loginLoginServer;
         send = sendServer;
         receive = socketDataHandler;
         registerMessage();
      }
      
      public static function registerMessage() : void
      {
         new LoginGCMessage(index);
      }
      
      public static function connect(host:String, port:int, isClose:Boolean = true) : void
      {
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
      }
      
      private static function getRamdon() : int
      {
         _lastRandValue += 1;
         if(_lastRandValue > 127)
         {
            _lastRandValue = 0;
         }
         return _lastRandValue;
      }
      
      private static function sendServer(cmd:int, body:ByteArray) : void
      {
         var evt:TapperEvent = null;
         var answer:int = 0;
         var random:int = 0;
         var rel:int = 0;
         var i:int = 0;
         var answer2:int = 0;
         var cmdAndKey:int = 0;
         var moveKey:int = 0;
         var moveAbs:int = 0;
         var relIt:int = 0;
         var randomItem:int = 0;
         var last:int = 0;
         var cmdIt:int = 0;
         var keyIt:int = 0;
         var ranIt:int = 0;
         var cmdkeyIt:int = 0;
         if(socket.connected)
         {
            evt = new TapperEvent("客户端发送");
            evt.param = [cmd,body];
            Global.stage.dispatchEvent(evt);
            socket.writeInt(body.length + 12);
            random = getRamdon();
            rel = (cmd << 5) + Global.key;
            i = 0;
            while(i < 8)
            {
               relIt = rel >> 3 * i & 7;
               randomItem = random >> i & 1;
               last = (randomItem << 3) + relIt << 4 * i;
               answer += last;
               i++;
            }
            i = 0;
            while(i < 5)
            {
               cmdIt = cmd >> 3 * i & 7;
               keyIt = Global.key >> i & 1;
               ranIt = random >> i & 1;
               if(Boolean(ranIt))
               {
                  cmdkeyIt = (keyIt << 3) + cmdIt << 4 * i;
               }
               else
               {
                  cmdkeyIt = (cmdIt << 1) + keyIt << 4 * i;
               }
               cmdAndKey += cmdkeyIt;
               i++;
            }
            cmdAndKey += cmd >> 15 << 20;
            moveKey = random >> 5;
            moveAbs = 32 - moveKey;
            answer2 = (cmdAndKey << moveKey) + (random << moveAbs >> moveAbs) + (random >> moveKey << 24 + moveKey);
            socket.writeInt(answer2);
            socket.writeInt(answer);
            if(cmd != 5027 && cmd != 5008)
            {
               Utils.print("sendServer",cmd);
            }
            socket.writeBytes(body);
            socket.flush();
         }
      }
      
      private static function loginLoginServer() : void
      {
         socket.writeMultiByte("GET / HTTP/1.1\r\nHost: " + Global.config.ip + ":" + Global.config.port + "\r\n\r\n","GBK");
         socket.flush();
         LoginCGMessage.CG_ASK_LOGIN(Global.account,Global.fcm,Global.openkey,Global.invkey,Global.itime,Global.iopenid,Global.zoneid,Global._pf,Global.fpkey,Global.user_source,Global.contract_id,Global.app_custom,Global.fd,Global.via,Global.seqid,Global.adtag);
      }
      
      public static function connectStateHandler(e:Event) : void
      {
         if(e.type == Event.CONNECT)
         {
            Utils.print("连接成功");
            connectHandler();
         }
         else if(e.type == Event.CLOSE)
         {
            socket.close();
            OffLineTip.getInstance().show(Model_initStr.OFFLINETIP,function():void
            {
               if(Global._pf == Enum_SPStr.GUANWANG)
               {
                  navigateToURL(new URLRequest("http://yi.qq.com/server/website/startgame.shtml"),"_blank");
               }
               else
               {
                  ExternalInterface.call("eval","window.location.reload()");
               }
            });
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
         var evt:TapperEvent = null;
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
            Utils.print("time:",getTimer(),"receive",cmd);
            data.length = 0;
            data.writeBytes(recv,recv.position,len - 8);
            recv.position += len - 8;
            data.position = 0;
            evt = new TapperEvent("服务端返回");
            evt.param = [cmd,data];
            Global.stage.dispatchEvent(evt);
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
         Utils.print("socket IOERROR");
         socket.close();
      }
      
      public static function securityErrorHandler(e:SecurityErrorEvent) : void
      {
         Utils.print("SUCURITY_ERROR");
         socket.close();
         SocketManager.connect(Global.config.ip,Global.config.port);
      }
   }
}

