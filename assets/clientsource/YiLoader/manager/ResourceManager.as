package manager
{
   import com.utils.DisplayData;
   import com.utils.ResObj;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   
   public class ResourceManager
   {
      
      public static var resourceIndex:Dictionary;
      
      public function ResourceManager()
      {
         super();
      }
      
      public static function load(url:String, level:int = 1) : void
      {
         if(!resourceIndex[url])
         {
            resourceIndex[url] = new ResObj();
         }
         if(Boolean(resourceIndex[url].isLoad))
         {
            return;
         }
         MassLoader.add(url,function(info:Object):void
         {
            var resObj:ResObj = null;
            try
            {
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
            }
            catch(e:Error)
            {
               throw new Error(info.url,e.getStackTrace());
            }
         },null,level,null,"modelUrl");
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
               throw new Error(res.url,e.getStackTrace());
            }
         }
         return res.bitmapArr[index];
      }
      
      public static function dispose() : void
      {
         var resObj:ResObj = null;
         for each(resObj in resourceIndex)
         {
            if(resObj.isLoad)
            {
               delete resourceIndex[resObj.url];
               resObj.dispose();
            }
         }
      }
   }
}

