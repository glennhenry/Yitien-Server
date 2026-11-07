package com.yiTian.view.modules.fishing
{
   import com.yiTian.command.BindObj;
   import flash.utils.Dictionary;
   
   public class Model_fishing
   {
      
      private static var instance:Model_fishing;
      
      public var fishPlayerArr:Array;
      
      public var currentRiverId:int;
      
      public var myFishArr:Array;
      
      public var xiaGanTime:int;
      
      public var isFishing:Boolean = false;
      
      public var fishingPlayerDic:Dictionary;
      
      public var fishRoomInfo:BindObj = new BindObj();
      
      public var roomMaxPage:int = 2;
      
      public var roomMaxPage2:int = 5;
      
      public function Model_fishing()
      {
         super();
         if(Boolean(instance))
         {
            throw new Error("singlon error");
         }
         instance = this;
         this.init();
      }
      
      public static function getInstance() : Model_fishing
      {
         if(instance)
         {
         }
         return instance;
      }
      
      private function init() : void
      {
         this.fishPlayerArr = new Array();
         this.fishingPlayerDic = new Dictionary();
      }
      
      public function cleanFishingPlayerDic() : void
      {
         var key:String = null;
         for(key in this.fishingPlayerDic)
         {
            if(Boolean(this.fishingPlayerDic[key]))
            {
               delete this.fishingPlayerDic[key];
            }
         }
      }
   }
}

