package com.debug.login
{
   import com.yiTian.view.modules.loading.View_loading;
   import flash.utils.ByteArray;
   
   public class LoginDebug
   {
      
      public function LoginDebug()
      {
         super();
      }
      
      public static function CG_ASK_LOGIN(body:ByteArray) : void
      {
         View_loading.instance.end();
      }
      
      public static function CG_ASK_CHARLIST(body:ByteArray) : void
      {
      }
   }
}

