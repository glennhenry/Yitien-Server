package com.yiTian.scene
{
   import com.ui.controls.MyTextField;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.events.ProgressEvent;
   import flash.events.TextEvent;
   import flash.external.ExternalInterface;
   import flash.utils.getTimer;
   
   public class LoadingScene
   {
      
      public static var temBG:Bitmap;
      
      public static var temBar:Bitmap;
      
      public static var temBarBg:Bitmap;
      
      public static var partProgress:MyTextField;
      
      public static var totalProgress:MyTextField;
      
      public static var loadEff:Bitmap;
      
      private static var curListItem:LoadItem;
      
      private static var _curLength:int;
      
      private static var _totLength:int;
      
      private static var lastLoad:int;
      
      private static var lastTime:int;
      
      private static var loadSpeed:Number;
      
      private static var list:Array = [];
      
      public static var canLoad:Boolean = true;
      
      private static var isLoading:Boolean = false;
      
      public function LoadingScene()
      {
         super();
      }
      
      public static function setProperty(loadCopyFrom:Object) : void
      {
         temBG = loadCopyFrom["temBG"];
         temBar = loadCopyFrom["temBar"];
         temBarBg = loadCopyFrom["temBarBg"];
         partProgress = loadCopyFrom["partProgress"];
         totalProgress = loadCopyFrom["totalProgress"];
         loadEff = loadCopyFrom["loadEff"];
      }
      
      private static function onRefresh(e:TextEvent) : void
      {
         ExternalInterface.call("eval","window.location.reload()");
      }
      
      public static function load(arr:Array, fun:Function = null, data:Object = null) : void
      {
         var listItem:LoadItem = new LoadItem();
         listItem.loaderList = arr;
         listItem.compFun = fun;
         listItem.data = data;
         list.push(listItem);
         if(canLoad && !isLoading)
         {
            start();
         }
      }
      
      public static function start() : void
      {
         canLoad = true;
         isLoading = true;
         _start();
      }
      
      private static function _start() : void
      {
         if(Boolean(list.length))
         {
            curListItem = list.shift();
            _totLength = curListItem.loaderList.length;
            _curLength = 0;
            _load();
         }
         else
         {
            isLoading = false;
         }
      }
      
      private static function _load() : void
      {
         var res:Array = null;
         var resType:String = null;
         if(Boolean(curListItem.loaderList.length))
         {
            res = curListItem.loaderList.shift();
            if(Boolean(totalProgress))
            {
               totalProgress.text = res[2] + "   (" + _curLength + "/" + _totLength + ")";
            }
            Utils.print("开始加载资源:[" + res[0] + "]" + getTimer() + "|");
            if(res[0] != "")
            {
               resType = Boolean(res[4]) ? res[4] : Enum_resType.RES_URL;
               SingleLoader.add(res[0],function(info:Object):void
               {
                  Utils.print("资源加载完毕:[" + info.url + "]" + getTimer() + "|");
                  info.obj[1](info);
                  ++_curLength;
                  _load();
               },progressEvent,res,resType);
               lastTime = getTimer();
               lastLoad = 0;
            }
            else
            {
               res[1]();
               ++_curLength;
               _load();
            }
         }
         else
         {
            if(curListItem.compFun != null)
            {
               curListItem.compFun();
            }
            _start();
         }
      }
      
      private static function progressEvent(e:ProgressEvent) : void
      {
         if(lastLoad != 0)
         {
            loadSpeed = e.bytesLoaded / (getTimer() - lastTime);
         }
         var speedStr:String = Boolean(loadSpeed) ? loadSpeed.toFixed(1) + "kb/s" : "";
         lastLoad = e.bytesLoaded;
         var progressNum:Number = e.bytesLoaded / e.bytesTotal;
         if(Boolean(temBar))
         {
            temBar.scaleX = progressNum;
         }
         if(Boolean(partProgress))
         {
            partProgress.text = uint(progressNum * 100) + "%";
         }
         if(Boolean(loadEff))
         {
            loadEff["px"] = temBar.x + temBar.width + 5;
            loadEff["py"] = temBar.y + 7;
         }
      }
      
      public static function dispose() : void
      {
         temBG = null;
         temBar = null;
         temBarBg = null;
         partProgress = null;
         totalProgress = null;
         loadEff = null;
      }
   }
}

class LoadItem
{
   
   public var loaderList:Array;
   
   public var compFun:Function;
   
   public var data:Object;
   
   public function LoadItem()
   {
      super();
   }
}
