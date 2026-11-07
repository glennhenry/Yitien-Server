package com.yiTian.utils
{
   import com.yiTian.Global;
   import com.yiTian.ResourceVersionConfig;
   import com.yiTian.command.Enum_MsgType;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   
   public class MassLoader
   {
      
      private static var decoder:Loader;
      
      private static var isDecoding:Boolean;
      
      private static var nowInfo:Object;
      
      private static var decInter:int;
      
      private static var decodeInter:int;
      
      private static var reloadTimes:int;
      
      public static const LEVEL0:int = 0;
      
      public static const LEVEL1:int = 1;
      
      public static const LEVEL2:int = 2;
      
      public static const LEVEL3:int = 3;
      
      public static const LEVEL4:int = 4;
      
      public static const LEVEL5:int = 5;
      
      public static const LEVEL6:int = 6;
      
      public static const LEVEL7:int = 7;
      
      public static const LEVEL8:int = 8;
      
      public static const LEVEL9:int = 9;
      
      private static var pool:Array = [];
      
      private static var urlMap:Dictionary = new Dictionary();
      
      private static var waitlist:Array = [];
      
      private static var request:URLRequest = new URLRequest();
      
      private static var decodelist:Array = [];
      
      public function MassLoader()
      {
         super();
      }
      
      private static function init() : void
      {
         var loader:MyLoader = null;
         var i:int = 0;
         while(i < 2)
         {
            loader = new MyLoader();
            loader.dataFormat = URLLoaderDataFormat.BINARY;
            loader.addEventListener(Event.COMPLETE,loadComplete);
            loader.addEventListener(ProgressEvent.PROGRESS,loadProgress);
            loader.addEventListener(IOErrorEvent.IO_ERROR,ioError);
            loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,sucurityError);
            pool.push(loader);
            i++;
         }
         decoder = new Loader();
         decoder.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,decoderProgress);
         decoder.contentLoaderInfo.addEventListener(Event.COMPLETE,decoderComplete);
      }
      
      private static function ioError(e:IOErrorEvent) : void
      {
         var _loader:MyLoader = e.target as MyLoader;
         _loader.close();
         pool.push(_loader);
         start();
         Utils.print("massloader IO ERROR",makePath(e.target.info.url),e.text);
      }
      
      private static function sucurityError(e:SecurityErrorEvent) : void
      {
         var _loader:MyLoader = e.target as MyLoader;
         _loader.close();
         pool.push(_loader);
         start();
         Utils.print("massloader Security Error",e.target.info.url);
      }
      
      private static function httpStatus(e:HTTPStatusEvent) : void
      {
      }
      
      private static function openHandler(e:Event) : void
      {
      }
      
      public static function add(url:String, complete:Function, progress:Function = null, level:int = 2, obj:Object = null, resType:String = "resUrl") : void
      {
         var info:Object;
         if(url == "")
         {
            try
            {
               throw new Error("massAdd 空");
            }
            catch(e:Error)
            {
               Utils.print("massAdd 空",e.getStackTrace(),e);
            }
            return;
         }
         if(!decoder)
         {
            init();
         }
         info = {};
         info.url = url;
         info.resType = resType;
         info.complete = complete;
         info.progress = progress;
         info.isReload = false;
         info.level = level;
         info.obj = obj;
         if(Boolean(urlMap[info.url]))
         {
            urlMap[info.url].push(info);
            if(int(urlMap[info.url][0].level) > level)
            {
               urlMap[info.url][0].level = level;
            }
         }
         else
         {
            urlMap[info.url] = [info];
            waitlist.unshift(info);
         }
         start();
      }
      
      public static function stop(loader:Object) : void
      {
         if(!(loader is MyLoader))
         {
            return;
         }
         var myLoader:MyLoader = loader as MyLoader;
         myLoader.close();
         var info:Object = myLoader.info;
         delete urlMap[info.url];
         pool.push(myLoader);
         start();
      }
      
      private static function start() : void
      {
         if(!pool.length || !waitlist.length)
         {
            return;
         }
         var loader:MyLoader = pool.pop();
         waitlist.sortOn("level",Array.NUMERIC);
         var info:Object = waitlist.shift();
         loader.info = info;
         var resVer:String = Boolean(Global.config[info.resType]) ? Global.config[info.resType] : "";
         request.url = resVer + makePath(info.url);
         loader.load(request);
         if(info.level == LEVEL6)
         {
            Global.control.sendNotification(Enum_MsgType.MUSIC_PLAY,null);
         }
      }
      
      public static function makePath(path:String) : String
      {
         var postfix:String = null;
         var token:String = null;
         var newPath:String = null;
         if(!ResourceVersionConfig.isRelease)
         {
            return path + "?" + getTimer();
         }
         if(!ResourceVersionConfig.urlDic[path])
         {
            return path;
         }
         var version:int = int(ResourceVersionConfig.urlDic[path]);
         version = version <= 1 ? 1 : version;
         if(path == Global.ConfigRs && Boolean(Global.VarsiongConfigCtl))
         {
            version = int(Global.VarsiongConfigCtl);
         }
         if(path == "resource/config/config2.xml")
         {
            version = int(Global.HD2VarsionCrl);
         }
         var result:Array = path.match(/\.(\w){0,4}/);
         if(result != null)
         {
            postfix = result[0];
            token = "_v" + version + postfix;
            return path.replace(postfix,token);
         }
         return path + "_v" + version;
      }
      
      private static function loadProgress(e:ProgressEvent) : void
      {
         var _info:Object = null;
         var loader:MyLoader = e.target as MyLoader;
         var info:Object = loader.info;
         var list:Array = urlMap[info.url];
         var len:int = int(list.length);
         var i:int = len - 1;
         while(i >= 0)
         {
            _info = list[i];
            if(_info.progress != null)
            {
               _info.progress(e);
            }
            i--;
         }
      }
      
      private static function loadComplete(e:Event) : void
      {
         var list:Array = null;
         var _info:Object = null;
         var loader:MyLoader = e.target as MyLoader;
         var info:Object = loader.info;
         info.data = loader.data;
         var ext:String = String(info.url).substr(String(info.url).length - 3,3);
         if(ext == "swf" || ext == "png" || ext == "jpg")
         {
            decodelist.push(info);
            decode();
         }
         else
         {
            list = urlMap[info.url];
            while(Boolean(list.length))
            {
               _info = list.shift();
               if(_info.complete != null)
               {
                  _info.complete(_info);
               }
            }
            delete urlMap[info.url];
         }
         pool.push(loader);
         start();
      }
      
      private static function decode() : void
      {
         if(isDecoding || !decodelist.length)
         {
            return;
         }
         nowInfo = decodelist.shift();
         reloadTimes = 0;
         de(nowInfo.data);
         isDecoding = true;
      }
      
      private static function de(data:ByteArray) : void
      {
         decoder.loadBytes(data);
         ++reloadTimes;
         decInter = setTimeout(reload,6000);
      }
      
      private static function decoderProgress(e:ProgressEvent) : void
      {
         if(e.bytesLoaded == e.bytesTotal)
         {
            decodeInter = setTimeout(reload,4000);
         }
      }
      
      private static function reload() : void
      {
         var info:Object = null;
         clearTimeout(decInter);
         clearTimeout(decodeInter);
         Utils.print("mass reload reloadTiems" + reloadTimes,nowInfo.url);
         if(reloadTimes > 2)
         {
            info = urlMap[nowInfo.url][0];
            info.isReload = true;
            info.level = LEVEL9;
            waitlist.push(info);
            isDecoding = false;
            decode();
            start();
         }
         else
         {
            de(nowInfo.data);
         }
      }
      
      private static function decoderComplete(e:Event) : void
      {
         var _info:Object = null;
         clearTimeout(decInter);
         clearTimeout(decodeInter);
         var list:Array = urlMap[nowInfo.url];
         while(Boolean(list.length))
         {
            _info = list.shift();
            _info.content = decoder.contentLoaderInfo.content;
            _info.applicationDomain = decoder.contentLoaderInfo.applicationDomain;
            if(_info.complete != null)
            {
               _info.complete(_info);
            }
         }
         delete urlMap[nowInfo.url];
         isDecoding = false;
         decode();
      }
      
      public static function dispose() : void
      {
         var waitItem:Object = null;
         var len:int = int(waitlist.length);
         var i:int = len - 1;
         while(i >= 0)
         {
            waitItem = waitlist[i];
            if(waitItem.level == LEVEL6)
            {
               waitlist.splice(i,1);
               delete urlMap[waitItem.url];
            }
            i--;
         }
      }
   }
}

import flash.net.URLLoader;

class MyLoader extends URLLoader
{
   
   public var info:Object;
   
   public function MyLoader()
   {
      super();
   }
}
