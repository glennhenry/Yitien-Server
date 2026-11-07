package com.yiTian.data.model
{
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.SceneConfig;
   
   public class Model_CrossDart
   {
      
      public static var isACTime:Boolean;
      
      public static var timeOn:Boolean;
      
      public static var inCrossScence:Boolean;
      
      public static var status:int;
      
      public static var questId:int;
      
      public static const TYPE_GO:int = 1;
      
      public static const TYPE_YES:int = 2;
      
      public static const TYPE_NPC:int = 3;
      
      public static const TYPE_SB:int = 4;
      
      public static const TYPE_ICON:int = 5;
      
      public static const STATUS_ING:int = 0;
      
      public static const STATUS_NO:int = 0;
      
      public static var times:int = 3;
      
      public function Model_CrossDart()
      {
         super();
      }
      
      public static function isCross() : Boolean
      {
         if(GameUnitManager.hero.level >= 70 && SceneConfig.getSceneType() == SceneConfig.COMMON)
         {
            return true;
         }
         return false;
      }
   }
}

