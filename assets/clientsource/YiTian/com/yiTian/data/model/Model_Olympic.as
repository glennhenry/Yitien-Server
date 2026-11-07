package com.yiTian.data.model
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.scene.GameScene;
   import flash.utils.getTimer;
   
   public class Model_Olympic
   {
      
      private static var _serverTime:int;
      
      private static var _leftTime:int;
      
      private static var _lastTime:int;
      
      private static var _beginTime:int;
      
      public function Model_Olympic()
      {
         super();
      }
      
      public static function setTime(time:int) : void
      {
         _serverTime = time;
         if(_serverTime != 0)
         {
            _beginTime = getTimer();
            if(!GameScene.instance.hasFrameCallBack(run))
            {
               GameScene.instance.addFrameCallBack(run);
            }
         }
      }
      
      private static function run() : void
      {
         var now:int = getTimer();
         var goTime:int = (now - _beginTime) / 1000;
         if(goTime != _lastTime)
         {
            _lastTime = goTime;
            _leftTime = _serverTime - _lastTime;
            Global.control.sendNotification(Enum_MsgType.OLYMPIC_UPDATE,null);
            if(_leftTime <= 0)
            {
               GameScene.instance.removeFrameCallBack(run);
            }
         }
      }
      
      public static function get leftTime() : int
      {
         return _leftTime;
      }
   }
}

