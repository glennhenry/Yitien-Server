package com.yiTian.view.modules.chatM.face
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class Model_face
   {
      
      private static var isRunning:Boolean;
      
      private static var lasttime:int;
      
      public static var data:Array = [];
      
      public static var startEndArr:Array = [[37,72],[73,108],[109,144],[145,180],[181,216],[217,252]];
      
      public static var chatRoleHasOwnedFaceInfo:Dictionary = new Dictionary();
      
      public static var dmDic:Dictionary = new Dictionary();
      
      public static const MSG_TIPS_FACE:String = "msg_tips_face";
      
      public function Model_face()
      {
         super();
      }
      
      public static function counts() : void
      {
         var time:int = 0;
         var bool:Boolean = false;
         var i:int = 0;
         while(i < data.length)
         {
            time = int(data[i][1]);
            if(time > 0)
            {
               bool = true;
               break;
            }
            i++;
         }
         if(bool && !isRunning)
         {
            lasttime = getTimer();
            isRunning = true;
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,run);
         }
      }
      
      private static function run(intereval:int) : void
      {
         var i:int = 0;
         var key:int = 0;
         var now:int = getTimer();
         if(now - lasttime >= 1000)
         {
            lasttime = now;
            i = data.length - 1;
            while(i >= 0)
            {
               key = int(data[i][0]);
               var _loc5_:* = data[i];
               var _loc7_:Number = _loc5_[1] - 1;
               _loc5_[1] = _loc7_;
               if(data.length > 0)
               {
                  Global.control.sendNotification(MSG_TIPS_FACE,{
                     "index":key,
                     "time":data[i][1]
                  });
               }
               if(data[i][1] <= 0)
               {
                  data.splice(i,1);
               }
               if(data.length == 0)
               {
                  Global.control.sendNotification(ExtralFace.MSG_EEE,null);
                  Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,run);
                  isRunning = false;
               }
               i--;
            }
         }
      }
   }
}

