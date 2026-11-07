package com.yiTian.manager
{
   import com.utils.DmManager;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.view.comp.View_Alert;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class LoadManager
   {
      
      private static var timeFlag1:int;
      
      private static var timeFlag2:int;
      
      private static var timeFlag3:int;
      
      public function LoadManager()
      {
         super();
      }
      
      public static function loadResource() : void
      {
         UIManager.heroHead.loadHeroHead();
         timeFlag1 = setTimeout(loadMusic,100);
         timeFlag2 = setTimeout(loadBattle,30000);
         timeFlag3 = setTimeout(loadFlash,120000);
      }
      
      public static function loadFirst() : void
      {
         MassLoader.add("lang/" + Global.config.lang + "/guideMM.swf",function(info:Object):void
         {
            if(!Global.guideMM)
            {
               Global.guideMM = info.applicationDomain;
            }
            if(!DmManager.guideMMdm)
            {
               DmManager.guideMMdm = info.applicationDomain;
            }
         },null,MassLoader.LEVEL0);
         MassLoader.add("lang/" + Global.config.lang + "/Alert.swf",function(info:Object):void
         {
            if(!View_Alert.alertDm)
            {
               View_Alert.alertDm = info.applicationDomain;
            }
         },null,MassLoader.LEVEL1);
      }
      
      private static function loadMusic() : void
      {
         clearTimeout(timeFlag1);
         ResourceManager.load("modelRes/magic/35070.swf",MassLoader.LEVEL3);
         ResourceManager.load("modelRes/magic/35003.swf",MassLoader.LEVEL3);
         MassLoader.add("mapRes/mp3/music.swf",function(info:Object):void
         {
            Global.musicDm = info.applicationDomain;
         },null,MassLoader.LEVEL8,null,Enum_resType.MAP_URL);
      }
      
      private static function loadBattle() : void
      {
         clearTimeout(timeFlag2);
         if(GameUnitManager.hero.level < 15)
         {
            ResourceManager.load("modelRes/magic/50001.swf",MassLoader.LEVEL7);
         }
      }
      
      private static function loadFlash() : void
      {
         clearTimeout(timeFlag3);
         if(GameUnitManager.hero.level < 18)
         {
            ResourceManager.load("modelRes/magic/50003.swf",MassLoader.LEVEL8);
            ResourceManager.load("modelRes/magic/3" + Enum_job.getBaseJob(GameUnitManager.hero.job) + "901.swf",MassLoader.LEVEL8);
         }
         if(GameUnitManager.hero.level < 25)
         {
            ResourceManager.load("modelRes/magic/35901.swf",MassLoader.LEVEL8);
         }
      }
   }
}

