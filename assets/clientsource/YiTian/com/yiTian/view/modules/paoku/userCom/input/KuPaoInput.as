package com.yiTian.view.modules.paoku.userCom.input
{
   public class KuPaoInput
   {
      
      private static var _instance:KuPaoInput;
      
      public function KuPaoInput()
      {
         super();
      }
      
      public static function get instance() : KuPaoInput
      {
         return _instance = _instance || new KuPaoInput1();
      }
      
      public function resume() : void
      {
      }
      
      public function pause() : void
      {
      }
      
      public function matchKeyLinks(keys:Array) : Boolean
      {
         return false;
      }
      
      public function isPressUp() : Boolean
      {
         return false;
      }
      
      public function isPressDown() : Boolean
      {
         return false;
      }
      
      public function isPressJump() : Boolean
      {
         return false;
      }
      
      public function isPressFloat() : Boolean
      {
         return false;
      }
      
      public function clearKeys() : void
      {
      }
   }
}

