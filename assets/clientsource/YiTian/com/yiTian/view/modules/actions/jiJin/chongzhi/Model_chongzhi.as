package com.yiTian.view.modules.actions.jiJin.chongzhi
{
   import com.yiTian.view.modules.actions.jiJin.FundMter;
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   
   public class Model_chongzhi
   {
      
      private static var func:Function;
      
      public function Model_chongzhi()
      {
         super();
      }
      
      public static function initData(callBack:Function) : void
      {
         func = callBack;
         var loader:URLLoader = new URLLoader();
         var url:URLRequest = new URLRequest("http://token.app100621282.twsapp.com/goodsprice.php");
         url.method = URLRequestMethod.GET;
         loader.dataFormat = URLLoaderDataFormat.TEXT;
         loader.addEventListener(Event.COMPLETE,loaded);
         loader.load(url);
      }
      
      private static function loaded(e:Event) : void
      {
         var datas:Array = [];
         var teapItems:Array = (e.target.data as String).split("|");
         var len:int = int(teapItems.length);
         var i:int = 0;
         while(i < len)
         {
            datas.push(teapItems[i].split("_"));
            i++;
         }
         update(datas);
      }
      
      private static function update(datas:Array) : void
      {
         var len:int = int(datas.length);
         var i:int = 0;
         while(i < len)
         {
            FundMter.chongZhiId.push(datas[i][0]);
            i++;
         }
         func();
      }
   }
}

