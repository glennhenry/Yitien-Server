package com.yiTian.manager
{
   import com.utils.DisplayData;
   import com.utils.ResObj;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.utils.Utils;
   import flash.events.ProgressEvent;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   
   public class ResourceManager
   {
      
      public static var resourceIndex:Dictionary;
      
      private static var registerResourceDic:Dictionary = new Dictionary();
      
      public function ResourceManager()
      {
         super();
      }
      
      public static function hasLoaded(url:String) : Boolean
      {
         var resObj:ResObj = resourceIndex[url];
         if(Boolean(resObj) && resObj.isLoad)
         {
            return true;
         }
         return false;
      }
      
      public static function load(url:String, level:int = 5) : void
      {
         if(!resourceIndex[url])
         {
            resourceIndex[url] = new ResObj();
         }
         if(Boolean(resourceIndex[url].isLoad))
         {
            return;
         }
         MassLoader.add(url,setSource,null,level,null,Enum_resType.MODEL_URL);
      }
      
      public static function addCount(url:String) : void
      {
         var resObj:ResObj = resourceIndex[url];
         if(!resObj)
         {
            return;
         }
         resObj.useCount += 1;
         resObj.lastUseTime = getTimer();
      }
      
      public static function registerResource(url:String, func:Function) : void
      {
         registerResourceDic[url] = url;
         Global.control.registerCallBack(url,func);
      }
      
      public static function useComplete(url:String) : void
      {
         var resObj:ResObj = resourceIndex[url];
         if(Boolean(resObj))
         {
            resObj.useCount -= 1;
         }
      }
      
      private static function loadProgress(e:ProgressEvent) : void
      {
         if(e.currentTarget.info.url == "modelRes/magic/50001.swf")
         {
            trace("加载渔夫",e.bytesLoaded / e.bytesTotal);
         }
      }
      
      public static function setSource(info:Object) : void
      {
         var resObj:ResObj = null;
         try
         {
            if(!resourceIndex[info.url])
            {
               resourceIndex[info.url] = new ResObj();
            }
            if(Boolean(resourceIndex[info.url].isLoad))
            {
               return;
            }
            info.content.init();
            resObj = resourceIndex[info.url];
            resObj.url = info.url;
            resObj.applicationDomain = info.applicationDomain;
            resObj.rect = info.content.rect;
            resObj.actionFrame = info.content.actionFrame;
            resObj.way = info.content.way;
            if(resObj.actionFrame * resObj.way > resObj.rect.length)
            {
               resObj.isSpecial = true;
               resObj.f = info.content.f;
            }
            resObj.bitmapArr = [];
            resObj.isLoad = true;
            if(Boolean(registerResourceDic[resObj.url]))
            {
               Global.control.sendNotification(registerResourceDic[resObj.url],null);
               delete registerResourceDic[resObj.url];
            }
         }
         catch(e:Error)
         {
            Utils.print(e.getStackTrace());
            throw new Error(info.url,e.getStackTrace());
         }
      }
      
      public static function find(res:ResObj, index:int) : DisplayData
      {
         var data:DisplayData = null;
         var tem:Class = null;
         if(!res.bitmapArr[index])
         {
            try
            {
               data = new DisplayData();
               tem = res.applicationDomain.getDefinition("_" + index) as Class;
               data.p = new tem(res.rect[index][2],res.rect[index][3]);
               data.x = res.rect[index][0];
               data.y = res.rect[index][1];
               res.bitmapArr[index] = data;
            }
            catch(e:Error)
            {
               Utils.print(e.getStackTrace());
               throw new Error(res.url,e.getStackTrace());
            }
         }
         return res.bitmapArr[index];
      }
      
      public static function dispose() : void
      {
         var resObj:ResObj = null;
         var arr:Array = null;
         var now:int = getTimer();
         for each(resObj in resourceIndex)
         {
            if(resObj.isLoad)
            {
               arr = resObj.url.split("/");
               if(arr[1] != "magic")
               {
                  if(resObj.useCount <= 0 && now - resObj.lastUseTime > 300000)
                  {
                     delete resourceIndex[resObj.url];
                     resObj.dispose();
                  }
               }
            }
         }
      }
   }
}

