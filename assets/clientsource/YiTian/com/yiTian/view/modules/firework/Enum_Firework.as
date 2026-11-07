package com.yiTian.view.modules.firework
{
   import com.yiTian.data.Data_lib;
   
   public class Enum_Firework
   {
      
      public static var index:int = 0;
      
      public function Enum_Firework()
      {
         super();
      }
      
      public static function getBroad(name:String, index:int) : String
      {
         return "<font color=\'#04ff00\'>" + name + "<font color = \'#ffff00\'>" + Data_lib.yanhua[index][0] + "</font></font>";
      }
   }
}

