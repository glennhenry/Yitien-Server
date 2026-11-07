package com.utils
{
   import flash.system.ApplicationDomain;
   import flash.text.Font;
   
   public class FontUtil
   {
      
      public function FontUtil()
      {
         super();
      }
      
      public static function registerFont(fontLibName:String, dm:ApplicationDomain) : void
      {
         var fontClass:Class = dm.getDefinition(fontLibName) as Class;
         Font.registerFont(fontClass);
      }
   }
}

