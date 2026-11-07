package com.utils
{
   import flash.display.DisplayObject;
   import flash.system.ApplicationDomain;
   
   public class SwfItemVo
   {
      
      public var dm:ApplicationDomain;
      
      public var content:DisplayObject;
      
      public function SwfItemVo(dm:ApplicationDomain, content:DisplayObject)
      {
         super();
         this.dm = dm;
         this.content = content;
      }
   }
}

