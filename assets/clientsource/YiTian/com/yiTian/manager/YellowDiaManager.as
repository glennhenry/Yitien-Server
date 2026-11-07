package com.yiTian.manager
{
   import com.yiTian.Global;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.yellowDiamond.View_hzTribute;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.utils.getTimer;
   
   public class YellowDiaManager
   {
      
      private static var _discountId:String;
      
      private static var _isNewPort:Boolean;
      
      private static var _isSuperYD:Boolean = false;
      
      private static var _isLZFuLi:Boolean = false;
      
      public function YellowDiaManager()
      {
         super();
      }
      
      public static function buy(isSuperYD:Boolean = false, isNewPort:Boolean = false, discountId:String = "0") : void
      {
         _isSuperYD = isSuperYD;
         _isNewPort = isNewPort;
         _discountId = discountId;
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
         Utils.print("yellow buy",e.target.data);
         Utils.print(View_hzTribute.sendType);
         if(e.target.data == null || e.target.data == "")
         {
            UIManager.centerBroadcast.addMsg("服务器繁忙，请稍等片刻");
            return;
         }
         var pf:String = "";
         if(_isSuperYD)
         {
            pf = "XXJZGHH";
         }
         else
         {
            pf = "";
         }
         if(_isNewPort)
         {
            ExternalInterface.call("GameOpenVipGift",e.target.data,Global.account,View_hzTribute.sendType,pf,_discountId);
         }
         else
         {
            ExternalInterface.call("openVipGift",e.target.data,Global.account,View_hzTribute.sendType,pf);
         }
      }
      
      public static function remindBuy(isSuperYD:Boolean = false) : void
      {
         _isSuperYD = isSuperYD;
         var loadurl:String = "http://token.app100621282.twsapp.com/get_token.php?openid=" + Global.account + "&openkey=" + Global.openkey + "&fpkey=" + Global.fpkey + "&zoneid=" + Global.zoneid + "&pf=" + Global._pf + "&r=" + getTimer();
         var loader:URLLoader = new URLLoader();
         var url:URLRequest = new URLRequest(loadurl);
         url.method = URLRequestMethod.GET;
         loader.dataFormat = URLLoaderDataFormat.TEXT;
         loader.addEventListener(Event.COMPLETE,loaded1);
         loader.load(url);
      }
      
      private static function loaded1(e:Event) : void
      {
         Utils.print("yellow buy",e.target.data);
         Utils.print(View_hzTribute.sendType);
         if(e.target.data == null || e.target.data == "")
         {
            UIManager.centerBroadcast.addMsg("服务器繁忙，请稍等片刻");
            return;
         }
         var pf:String = "";
         if(_isSuperYD)
         {
            pf = "XXJZGHH";
         }
         else
         {
            pf = "";
         }
         if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isIwan(Global.pf))
         {
            ExternalInterface.call("dailyVipGift",e.target.data,Global.account,View_hzTribute.sendType,pf);
         }
         else
         {
            ExternalInterface.call("dailyVipGift",e.target.data,Global.account,"self",pf);
         }
      }
   }
}

