package com.utils
{
   import flash.system.ApplicationDomain;
   import flash.utils.Dictionary;
   
   public class DmManager
   {
      
      public static var Scenedm:ApplicationDomain;
      
      public static var Img_Cdm:ApplicationDomain;
      
      public static var New_Imgsdm:ApplicationDomain;
      
      public static var guideMMdm:ApplicationDomain;
      
      private static var swfs:Dictionary = new Dictionary();
      
      public static var uiByteData:Dictionary = new Dictionary();
      
      public function DmManager()
      {
         super();
      }
      
      public static function addSwfItem(id:String, swfitemvo:SwfItemVo) : void
      {
         if(swfs[id] == null)
         {
            swfs[id] = swfitemvo;
         }
      }
      
      public static function getSwfItem(id:String) : SwfItemVo
      {
         return swfs[id];
      }
   }
}

