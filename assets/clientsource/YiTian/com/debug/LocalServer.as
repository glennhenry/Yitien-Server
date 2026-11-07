package com.debug
{
   import com.debug.battle.BattleDebug;
   import com.debug.login.LoginDebug;
   import com.debug.scene.SceneDebug;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class LocalServer
   {
      
      public function LocalServer()
      {
         super();
      }
      
      public static function doMessage(cmd:Number, body:ByteArray) : void
      {
         switch(cmd)
         {
            case MessageType.CG_ASK_LOGIN:
               LoginDebug.CG_ASK_LOGIN(body);
               break;
            case MessageType.CG_ASK_CHARLIST:
               LoginDebug.CG_ASK_CHARLIST(body);
               break;
            case MessageType.CG_ENTER_SCENE:
            case MessageType.CG_ENTER_FUBEN:
               SceneDebug.CG_ENTER_SCENE(body);
               break;
            case MessageType.CG_ENTER_SCENE_OK:
               SceneDebug.CG_ENTER_SCENE_OK(body);
               break;
            case MessageType.CG_BATTLE:
               BattleDebug.CG_BATTLE(body);
         }
      }
   }
}

