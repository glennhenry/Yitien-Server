package com.yiTian.manager
{
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_map_lib;
   import flash.utils.Dictionary;
   
   public class SceneConfig
   {
      
      private static var _instance:SceneConfig;
      
      public static const COMMON:int = 1;
      
      public static const WULIN:int = 2;
      
      public static const BZ_READY:int = 3;
      
      public static const BZ_BATTLE:int = 4;
      
      public static const KUNLUN:int = 5;
      
      public static const PATA:int = 6;
      
      public static const FISH:int = 7;
      
      public static const SIMPLEFUNBEN:int = 8;
      
      public static const BANGPLANT:int = 9;
      
      public static const WANANSI:int = 10;
      
      public static const HUNLI:int = 11;
      
      public static const KEJU:int = 12;
      
      public static const QIJU:int = 13;
      
      public static const BEACH:int = 14;
      
      public static const GMD:int = 15;
      
      public static const WORLDBOSS:int = 16;
      
      public static const PATA2:int = 17;
      
      public static const KFBZ_BATTLE:int = 18;
      
      public static const DSCL:int = 19;
      
      public static const AiDeBaoBao:int = 20;
      
      public static const BangShenShou:int = 21;
      
      public static const HUANGBANG:int = 22;
      
      public static const HOME:int = 23;
      
      public static const KuaFuPaiDui:int = 24;
      
      public static const CROSS_CAMP_BATTLE:int = 25;
      
      private var InDic:Dictionary;
      
      public function SceneConfig()
      {
         super();
         if(Boolean(_instance))
         {
            throw new Error("singleton error");
         }
         this.initInDic();
         _instance = this;
      }
      
      public static function getSceneType() : int
      {
         var sId:int = Global.sceneMap;
         if(sId >= 12301 && sId <= 12303)
         {
            return WULIN;
         }
         if(sId == 12401)
         {
            return BZ_READY;
         }
         if(sId >= 12402 && sId <= 12406)
         {
            return BZ_BATTLE;
         }
         if(sId == 12001)
         {
            return KUNLUN;
         }
         if(sId >= 12101 && sId <= 12105)
         {
            return PATA;
         }
         if(sId >= 12106 && sId <= 12110)
         {
            return PATA2;
         }
         if(sId == 12201)
         {
            return FISH;
         }
         if(sId == 14131 || sId == 14132 || sId == 14134 || sId == 14135 || sId == 14136 || sId == 14137)
         {
            return HOME;
         }
         if(sId == 12407)
         {
            return BANGPLANT;
         }
         if(sId >= 12111 && sId <= 12120)
         {
            return WANANSI;
         }
         if(sId == 14127)
         {
            return KFBZ_BATTLE;
         }
         if(sId == 14138)
         {
            return CROSS_CAMP_BATTLE;
         }
         if(sId == 14130)
         {
            return HUANGBANG;
         }
         if(sId == 14129)
         {
            return AiDeBaoBao;
         }
         if(sId >= 12410 && sId <= 12414)
         {
            return GMD;
         }
         if(Data_lib.map[sId][Enum_map_lib.TYPE] == 4)
         {
            return SIMPLEFUNBEN;
         }
         if(sId == 12304)
         {
            return HUNLI;
         }
         if(sId == 12305)
         {
            return KEJU;
         }
         if(sId == 12409)
         {
            return QIJU;
         }
         if(sId == 12202)
         {
            return BEACH;
         }
         if(sId == 14126)
         {
            return WORLDBOSS;
         }
         if(sId == 14128)
         {
            return DSCL;
         }
         if(sId == 12408)
         {
            return BangShenShou;
         }
         if(sId == 14133)
         {
            return KuaFuPaiDui;
         }
         return COMMON;
      }
      
      public static function getInstance() : SceneConfig
      {
         if(_instance)
         {
         }
         return _instance;
      }
      
      public function getRestrict(sceneMap:int, type:String) : int
      {
         var reg:RegExp = null;
         var mapArr:Array = Data_lib.map[sceneMap];
         if(mapArr[Enum_map_lib.RESTRICT] != null)
         {
            reg = new RegExp(type);
            return reg.test(mapArr[Enum_map_lib.RESTRICT] as String) ? 1 : 0;
         }
         return -1;
      }
      
      public function sceneOkExtraProgress(sceneMap:int, extraFlag:String = "", extraFun:Function = null, ... param) : void
      {
         var strArr:Array = null;
         var str:String = null;
         var mapArr:Array = Data_lib.map[sceneMap];
         if(!mapArr)
         {
            return;
         }
         if(Boolean(mapArr[Enum_map_lib.SCENEOKEXTRAPRO]))
         {
            strArr = (mapArr[Enum_map_lib.SCENEOKEXTRAPRO] as String).split("_");
            for each(str in strArr)
            {
               (this.InDic[str] as Function)(sceneMap);
               if(extraFun != null)
               {
                  extraFun.apply(str,param);
               }
            }
         }
      }
      
      private function initInDic() : void
      {
         this.InDic = new Dictionary();
         this.InDic["SEB"] = this.SEB;
      }
      
      private function SEB(sceneId:int) : void
      {
         if(Boolean(Data_lib.map[sceneId][Enum_map_lib.REAL_FB_TYPE]))
         {
            UIManager.mainUiBtnContainer.showLeaveBtn(Data_lib.map[sceneId][Enum_map_lib.REAL_FB_TYPE]);
         }
      }
   }
}

