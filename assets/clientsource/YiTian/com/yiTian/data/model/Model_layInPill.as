package com.yiTian.data.model
{
   import com.yiTian.gameUnit.magic.Effect;
   
   public class Model_layInPill
   {
      
      private static var _instace:Model_layInPill;
      
      public var pillLvevl:int = 40;
      
      public var currentExp:String;
      
      public var highestExp:String;
      
      public var eff:Effect;
      
      public function Model_layInPill()
      {
         super();
      }
      
      public static function get instance() : Model_layInPill
      {
         if(!_instace)
         {
            _instace = new Model_layInPill();
         }
         return _instace;
      }
   }
}

