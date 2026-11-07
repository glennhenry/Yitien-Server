package com.yiTian.data.model
{
   import com.yiTian.data.vo.Vo_treasureBowl_role;
   
   public class Model_treasureBowl
   {
      
      private static var _instace:Model_treasureBowl;
      
      public var todayPlayerCount:uint;
      
      public var todayMoney:uint;
      
      public var myConsume:uint;
      
      public var roles:Vector.<Vo_treasureBowl_role>;
      
      public function Model_treasureBowl()
      {
         super();
      }
      
      public static function get instace() : Model_treasureBowl
      {
         if(!_instace)
         {
            _instace = new Model_treasureBowl();
         }
         return _instace;
      }
      
      public function getRoleVo(index:uint) : Vo_treasureBowl_role
      {
         if(index >= this.roles.length)
         {
            return null;
         }
         return this.roles[index];
      }
   }
}

