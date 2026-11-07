package com.yiTian.manager
{
   import com.yiTian.Global;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.utils.getTimer;
   
   public class BlueDiaManager
   {
      
      public static var yearOrMonth:uint;
      
      public function BlueDiaManager()
      {
         super();
      }
      
      public static function buy() : void
      {
         var loadurl:String = "http://token.app100621282.twsapp.com/get_token.php?openid=" + Global.account + "&openkey=" + Global.openkey + "&fpkey=" + Global.fpkey + "&zoneid=" + Global.zoneid + "&pf=" + Global._pf + "&r=" + getTimer();
         var loader:URLLoader = new URLLoader();
         var url:URLRequest = new URLRequest(loadurl);
         url.method = URLRequestMethod.GET;
         loader.dataFormat = URLLoaderDataFormat.TEXT;
         loader.addEventListener(Event.COMPLETE,loaded);
         loader.load(url);
      }
      
      private static function loaded(e:Event) : void
      {
         if(e.target.data == null)
         {
            UIManager.centerBroadcast.addMsg("服务器繁忙，请稍等片刻");
            return;
         }
         ExternalInterface.call("nationalDayActive",e.target.data,Global.account,yearOrMonth);
      }
   }
}

