package com.yiTian.manager
{
   import com.utils.Util;
   import com.yiTian.Global;
   import flash.display.Stage;
   import flash.display.StageAlign;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.system.Security;
   
   public class StageManager
   {
      
      public function StageManager()
      {
         super();
      }
      
      public static function init(stage:Stage) : Boolean
      {
         if(!stage)
         {
            return false;
         }
         stage.frameRate = 30;
         stage.tabChildren = false;
         stage.align = StageAlign.TOP_LEFT;
         stage.scaleMode = StageScaleMode.NO_SCALE;
         stage.stageFocusRect = false;
         stage.addEventListener(Event.RESIZE,SceneManager.reSize);
         Security.allowDomain("*");
         Global.stage = stage;
         Util.stage = stage;
         return true;
      }
   }
}

