package com.yiTian.utils
{
   import com.yiTian.Global;
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
   import flash.utils.setTimeout;
   
   public class SingleLoader
   {
      
      private static var decoder:Loader;
      
      private static var isDecoding:Boolean;
      
      private static var nowInfo:Object;
      
      private static var _deInter:int;
      
      private static var decInter:int;
      
      private static var decodeInter:int;
      
      private static var pool:Array = [];
      
      private static var urlMap:Dictionary = new Dictionary();
      
      private static var waitlist:Array = [];
      
      private static var request:URLRequest = new URLRequest();
      
      private static var decodelist:Array = [];
      
      public function SingleLoader()
      {
         super();
      }
      
      private static function init() : void
      {
         var loader:MyLoader = new MyLoader();
         loader.dataFormat = URLLoaderDataFormat.BINARY;
         loader.addEventListener(Event.COMPLETE,loadComplete);
         loader.addEventListener(ProgressEvent.PROGRESS,loadProgress);
         loader.addEventListener(IOErrorEvent.IO_ERROR,ioError);
         loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,sucurityError);
         pool.push(loader);
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
         Utils.print("singleloader IO ERROR",e.target.info.url);
      }
      
      private static function sucurityError(e:SecurityErrorEvent) : void
      {
         var _loader:MyLoader = e.target as MyLoader;
         _loader.close();
         pool.push(_loader);
         start();
         Utils.print("singleloader Security Error",e.target.info.url);
      }
      
      private static function httpStatus(e:HTTPStatusEvent) : void
      {
      }
      
      private static function openHandler(e:Event) : void
      {
      }
      
      public static function add(url:String, complete:Function, progress:Function = null, obj:Object = null, resType:String = "resUrl") : void
      {
         var info:Object;
         if(url == "")
         {
            try
            {
               throw new Error("singleAdd 空");
            }
            catch(e:Error)
            {
               Utils.print("singleAdd 空",e.getStackTrace(),e);
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
         info.obj = obj;
         info.isReload = false;
         if(Boolean(urlMap[info.url]))
         {
            urlMap[info.url].push(info);
         }
         else
         {
            urlMap[info.url] = [info];
            waitlist.push(info);
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
         var info:Object = waitlist.shift();
         loader.info = info;
         var resVer:String = Boolean(Global.config[info.resType]) ? Global.config[info.resType] : "";
         request.url = resVer + MassLoader.makePath(info.url);
         loader.load(request);
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
         Utils.print("singleloader loadComplete",info.url);
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
         _deInter = setTimeout(de,0,nowInfo.data);
         isDecoding = true;
      }
      
      private static function de(data:ByteArray) : void
      {
         clearTimeout(_deInter);
         decoder.loadBytes(data);
         decInter = setTimeout(reload,6000);
      }
      
      private static function decoderProgress(e:ProgressEvent) : void
      {
         if(e.bytesLoaded == e.bytesTotal)
         {
            decodeInter = setTimeout(reload,4000);
            Utils.print("decode full",nowInfo.url);
         }
      }
      
      private static function reload() : void
      {
         clearTimeout(decInter);
         clearTimeout(decodeInter);
         var info:Object = urlMap[nowInfo.url][0];
         info.isReload = true;
         waitlist.unshift(info);
         Utils.print("single reload ",nowInfo.url);
         isDecoding = false;
         decode();
         start();
      }
      
      private static function decoderComplete(e:Event) : void
      {
         var _info:Object = null;
         Utils.print("Singleloader decoderComplete",nowInfo.url);
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
