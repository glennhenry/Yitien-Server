package com.yiTian.view.modules.map
{
   import com.yiTian.Global;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.LoginCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.utils.YTJSONParser;
   import com.yiTian.view.modules.roleHead.View_HeroHead;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.utils.getTimer;
   
   public class Model_GM_KF
   {
      
      private static var eff:Effect;
      
      private static var _time:String;
      
      private static var _sign:String;
      
      private static var _sign2:String;
      
      private static var uname:String;
      
      private static var lastTime:int;
      
      private static var urlResq:URLRequest = new URLRequest();
      
      private static var urlLoader:URLLoader = new URLLoader();
      
      public static var isShowEff:Boolean = false;
      
      public static var outOf_btn_call:Boolean = false;
      
      private static var uLoader:URLLoader = new URLLoader();
      
      private static var step:int = 1;
      
      private static var isSucceApply:Boolean = false;
      
      private static var temDPram:String = "";
      
      public function Model_GM_KF()
      {
         super();
      }
      
      public static function link(time:String, sign:String, sign2:String) : void
      {
         _time = time;
         _sign = sign;
         _sign2 = sign2;
         var uid:String = GameUnitManager.hero.id.toString();
         var sid:String = Global.zoneid.toString();
         urlResq.method = URLRequestMethod.POST;
         if(Global.pf == Enum_SPStr.CHITU)
         {
            uname = GameUnitManager.hero.name;
         }
         else
         {
            uname = encodeURI(GameUnitManager.hero.name);
         }
         var url:String = encodeURI("http://yt.kf.3737.com/yt_client.index.php?uname=" + View_HeroHead.playerName + "&sign=" + sign + "&sid=" + sid + "&time=" + time + "&uid=" + uid + "&openid=" + Global.account);
         Utils.print(url);
         if(!outOf_btn_call)
         {
            ExternalInterface.call("openkefuIFrame",url,700,500);
         }
      }
      
      public static function showEff(bool:Boolean) : void
      {
         if(bool)
         {
            if(!eff)
            {
               eff = EffectManager.addEffect("35014",UIManager.smallMap.Button_KF,1000,12,11,true);
            }
            isShowEff = true;
         }
         else
         {
            if(Boolean(eff))
            {
               EffectManager.removeEffect(eff);
            }
            eff = null;
            isShowEff = false;
         }
      }
      
      public static function firstCallOnGM() : void
      {
         lastTime = getTimer();
         outOf_btn_call = true;
      }
      
      private static function onCall(intereval:int) : void
      {
         var now:int = getTimer();
         if(now - lastTime >= 1000 * 300)
         {
            outOf_btn_call = true;
            LoginCGMessage.CG_GM_KEFU(encodeURI(View_HeroHead.playerName));
            lastTime = now;
         }
      }
      
      public static function callOnOuterWeb() : void
      {
         var __str:String = null;
         var url:String = "http://yt.kf.3737.com/yt_client.index.php?" + "uname=" + uname + "&sign=" + _sign + "&sid=" + Global.zoneid + "&time=" + _time + "&uid=" + GameUnitManager.hero.id + "&openid=" + Global.account + "&act=apilogin";
         urlResq.method = URLRequestMethod.POST;
         uLoader.dataFormat = URLLoaderDataFormat.TEXT;
         uLoader.addEventListener(Event.COMPLETE,comp);
         if(!isSucceApply)
         {
            urlResq.url = url;
            uLoader.load(urlResq);
            step = 1;
         }
         else
         {
            __str = "http://yt.kf.3737.com/yt_client.index.php?sinfo=" + temDPram + "&act=check&time=" + _time + "&sign=" + _sign2;
            urlResq.url = __str;
            uLoader.load(urlResq);
            step = 2;
         }
         Utils.print("请求客服系统：" + url);
      }
      
      private static function comp(e:Event) : void
      {
         var __str:String = null;
         var d:Object = null;
         var json:YTJSONParser = Singleton.getInstance(YTJSONParser);
         var opt:Object = json.parseStringToObject(e.target.data);
         Utils.print(e.target.data.toString());
         if(step == 1)
         {
            if(Boolean(opt) && opt.hasOwnProperty("s"))
            {
               if(opt.s == 1)
               {
                  if(opt.hasOwnProperty("d"))
                  {
                     temDPram = opt.d;
                     __str = "http://yt.kf.3737.com/yt_client.index.php?sinfo=" + opt.d + "&act=check&time=" + _time + "&sign=" + _sign2;
                     urlResq.url = __str;
                     uLoader.load(urlResq);
                     step = 2;
                     isSucceApply = true;
                  }
               }
            }
         }
         else if(step == 2)
         {
            if(Boolean(opt) && opt.hasOwnProperty("d"))
            {
               d = opt.d;
               if(d.hasOwnProperty("result"))
               {
                  if(d.result == "1")
                  {
                     showEff(true);
                  }
                  else
                  {
                     showEff(false);
                  }
               }
            }
         }
      }
   }
}

