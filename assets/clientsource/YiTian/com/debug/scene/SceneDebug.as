package com.debug.scene
{
   import com.debug.battle.BattleDebug;
   import com.utils.FontUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_scene_type;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.MapManager;
   import com.yiTian.manager.SceneManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.HumanHandler;
   import com.yiTian.net.handler.SceneHandler;
   import com.yiTian.scene.LoadingScene;
   import com.yiTian.utils.WorldConfig;
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.utils.ByteArray;
   
   public class SceneDebug
   {
      
      public function SceneDebug()
      {
         super();
      }
      
      public static function CG_ENTER_SCENE(body:ByteArray) : void
      {
         var loader:URLLoader;
         var url:String = "./resource/config/BattleData.txt";
         var request:URLRequest = new URLRequest(url);
         request.method = URLRequestMethod.GET;
         loader = new URLLoader();
         loader.dataFormat = URLLoaderDataFormat.TEXT;
         loader.addEventListener(Event.COMPLETE,function(evt:Event):void
         {
            (evt.currentTarget as URLLoader).removeEventListener(Event.COMPLETE,arguments.callee);
            initData(evt.currentTarget.data);
         });
         loader.load(request);
      }
      
      public static function CG_ENTER_SCENE_OK(body:ByteArray) : void
      {
         var job:int = 0;
         var sex:int = 0;
         var i:int = 0;
         while(i < 100)
         {
            job = Util.rnd(1,4);
            sex = Util.rnd(1,2);
            i++;
         }
      }
      
      private static function getWeapon(job:int) : int
      {
         if(job == 1)
         {
            return 90100;
         }
         if(job == 2)
         {
            return 90200;
         }
         if(job == 3)
         {
            return 90300;
         }
         if(job == 4)
         {
            return 90400;
         }
         return 0;
      }
      
      private static function initData(str:String) : void
      {
         trace(str);
         var arr:Array = str.split(/\r\n/gi);
         var roleStr:String = arr[0];
         roleStr = roleStr.replace(/[\[\];]/gi,"");
         BattleDebug.roleBody = roleStr.split(",");
         var skillStr:String = arr[1];
         skillStr = skillStr.replace(/[\[\];]/gi,"");
         BattleDebug.skillIds = skillStr.split(",");
         var sceneId:int = int(String(arr[2].replace(/[\[\];]/gi,"")).split(",")[0]);
         HumanHandler.GC_HERO_INFO(1,1,BattleDebug.roleBody[2],20,140,20,40,20,40,10001,"张无忌",4,"很好",1,"",1,1,0,0,0,0,0,0,0,0,0,0);
         if(sceneId >= 12101 && sceneId <= 12160)
         {
            GC_ENTER_FUBEN(1,sceneId,550,500);
         }
         else
         {
            SceneHandler.GC_ENTER_SCENE(1,sceneId,550,500);
         }
      }
      
      private static function GC_ENTER_FUBEN(result:int, sceneId:int, targetX:int, targetY:int) : void
      {
         var arr:Array = null;
         if(result == 1)
         {
            GameUnitManager.hero.global_x = targetX;
            GameUnitManager.hero.global_y = targetY;
            Global.sceneID = sceneId;
            Global.sceneType = Enum_scene_type.FUBEN;
            Global.isPata = true;
            Global.sceneMap = Global.sceneID;
            arr = [];
            arr.push(["resource/config/config",Data_lib.init,"资源配置文件"]);
            arr.push(["resource/config/worldConfig",WorldConfig.init,"全局地图配置文件"]);
            arr.push(["lang/" + Global.config.lang + "/Font.swf",function(info:Object):void
            {
               FontUtil.registerFont("hy",info.applicationDomain);
            },"字体"]);
            arr.push(["lang/" + Global.config.lang + "/UI.swf",UIManager.createUI,"游戏界面文件"]);
            arr.push(["mapRes/map/" + Global.sceneMap + "/config",MapManager.decodeConfig,"地图配置文件"]);
            arr.push(["mapRes/map/" + Global.sceneMap + "/" + Global.sceneMap + ".swf",MapManager.decodeThumb,"地图缩略图文件"]);
            LoadingScene.load(arr,SceneManager.showScene);
         }
      }
   }
}

