package com.yiTian.view.modules.paoku.userCom.role.state
{
   public class KuPaoRoleStates
   {
      
      public static const ST_STAND:int = 0;
      
      public static const ST_RUN:int = 1;
      
      public static const ST_JUMP:int = 2;
      
      public static const ST_FLOAT:int = 3;
      
      public static const ST_DIEFLOAT:int = 4;
      
      public static const ST_DIE:int = 5;
      
      public static var stNames:Array = ["stand","run","jump","float","dieFloat","die"];
      
      public function KuPaoRoleStates()
      {
         super();
      }
      
      public static function getStateName(st:int) : String
      {
         return stNames[st];
      }
   }
}

