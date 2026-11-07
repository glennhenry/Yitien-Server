package com.yiTian.view.modules.qqJinQuan
{
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Pool;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.guaji.BitmapBtn;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.events.SecurityErrorEvent;
   import flash.external.ExternalInterface;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.utils.getTimer;
   
   public class qqJinQuanConfig
   {
      
      public static var tipBtn:BitmapBtn;
      
      public function qqJinQuanConfig()
      {
         super();
      }
      
      public static function getRemainUrl() : String
      {
         return "http://s2.app100621282.qqopenapp.com/interface.php?op=discount&openid=" + Global.account + "&pfkey=" + Global.fpkey + "&openkey=" + Global.openkey + "&pf=" + Global._pf + "&r=" + getTimer();
      }
      
      public static function init() : void
      {
         if(GameUnitManager.hero.level >= 30 && (Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isIwan(Global.pf)))
         {
            load(getRemainUrl(),onDataComplete,URLLoaderDataFormat.TEXT,URLRequestMethod.GET);
         }
      }
      
      private static function onDataComplete(e:Event) : void
      {
         var infoTxt:String = e.target.data;
         var infos:Array = infoTxt.split("|");
         update(infos[0]);
      }
      
      public static function getDicArr() : Array
      {
         var lvKey:String = null;
         var bottomAndTopLv:Array = null;
         var heroLv:int = GameUnitManager.hero.level;
         for(lvKey in Data_lib.qqJinQuan)
         {
            bottomAndTopLv = lvKey.split("-");
            if(heroLv >= bottomAndTopLv[0] && heroLv <= bottomAndTopLv[1])
            {
               return Data_lib.qqJinQuan[lvKey];
            }
         }
         return null;
      }
      
      public static function update(param:Object = null) : void
      {
         var remain:int = int(param);
         if(remain >= 5)
         {
            if(!Global.qqJinQuanCtr)
            {
               return;
            }
            if(!tipBtn)
            {
               tipBtn = new BitmapBtn();
               tipBtn.init();
               tipBtn.setBgDir("resource/image/qqJinQuan/mainIcon.png");
               tipBtn.buttonMode = true;
               tipBtn.clickCallBack = btnClickHd;
            }
            UIManager.mainUiBtnContainer.addBTN(tipBtn);
         }
      }
      
      private static function btnClickHd(e:MouseEvent) : void
      {
         var pnl:View_qqJinQuanPanel = Singleton.getInstance(View_qqJinQuanPanel);
         if(!pnl.visible)
         {
            Global.delegate.dosomething(pnl,pnl.show);
         }
         else
         {
            Global.delegate.dosomething(pnl,pnl.hide);
         }
      }
      
      public static function load(url:String, complete:Function, dataFormat:String, method:String, error:Function = null, sucurityError:Function = null) : URLLoader
      {
         var urlLoader:UrlLoader2 = Pool.getObject(UrlLoader2);
         urlLoader.dataFormat = dataFormat;
         var urlReq:URLRequest = new URLRequest(url);
         urlReq.method = method;
         urlLoader.load(urlReq);
         urlLoader.complete = complete;
         urlLoader.addEventListener(Event.COMPLETE,loaderComplete);
         if(error != null)
         {
            urlLoader.addEventListener(IOErrorEvent.IO_ERROR,error);
         }
         if(sucurityError != null)
         {
            urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,sucurityError);
         }
         return urlLoader;
      }
      
      private static function loaderComplete(e:Event) : void
      {
         var loader:UrlLoader2 = e.target as UrlLoader2;
         if(loader.complete != null)
         {
            loader.complete(e);
         }
         loader.removeEventListener(Event.COMPLETE,loaderComplete);
      }
      
      public static function buyFromQQ(itemId:int) : void
      {
         var url:String = "http://token.app100621282.twsapp.com/buy_jinquan.php?openid=" + Global.account + "&openkey=" + Global.openkey + "&goodsid=" + itemId + "&fpkey=" + Global.fpkey + "&zoneid=" + Global.zoneid + "&pf=" + Global._pf + "&r=" + getTimer();
         load(url,buyLoaderLoadComplete,URLLoaderDataFormat.TEXT,URLRequestMethod.GET);
      }
      
      private static function buyLoaderLoadComplete(e:Event) : void
      {
         var arr:Array = null;
         var param:String = null;
         Utils.print(e.target.data);
         var tempItems:Array = (e.target.data as String).split("|");
         var len:int = int(tempItems.length);
         var i:int = 0;
         while(i < len)
         {
            arr = (tempItems[i] as String).match(/[\w]{1,15}=/i);
            trace(arr);
            if(Boolean(arr) && arr[0] == "url_params=")
            {
               param = (tempItems[i] as String).replace(arr[0],"");
               ExternalInterface.call("chongzhi",param);
               break;
            }
            i++;
         }
      }
   }
}

import flash.net.URLLoader;

class UrlLoader2 extends URLLoader
{
   
   public var complete:Function;
   
   public var error:Function;
   
   public function UrlLoader2()
   {
      super();
   }
}
