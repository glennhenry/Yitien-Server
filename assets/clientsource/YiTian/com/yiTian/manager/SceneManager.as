package com.yiTian.manager
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.scene.IScene;
   import flash.events.Event;
   
   public class SceneManager
   {
      
      public static var nowScene:IScene;
      
      public function SceneManager()
      {
         super();
      }
      
      public static function showScene(scene:Class) : void
      {
         if((scene as Object).instance == nowScene)
         {
            return;
         }
         clearCurScene();
         nowScene = (scene as Object).instance as IScene;
         Global.stage.addChildAt(nowScene,0);
         nowScene.show();
         nowScene.resize();
      }
      
      public static function clearCurScene() : void
      {
         if(nowScene is IScene)
         {
            (nowScene as IScene).dispose();
            Global.stage.removeChild(nowScene);
         }
         nowScene = null;
      }
      
      public static function reSize(e:Event) : void
      {
         var scene:IScene = Global.stage.getChildAt(0) as IScene;
         if(Boolean(scene))
         {
            scene.resize();
         }
         Global.control.sendNotification(Enum_MsgType.STAGE_RESIZE,null);
      }
   }
}

