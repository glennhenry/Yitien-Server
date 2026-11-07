package com.utils
{
   import flash.display.MovieClip;
   import flash.system.ApplicationDomain;
   
   public class ResObj
   {
      
      public var isLoad:Boolean;
      
      public var applicationDomain:ApplicationDomain;
      
      public var content:MovieClip;
      
      public var url:String;
      
      public var bitmapArr:Array;
      
      public var actionFrame:int;
      
      public var rect:Array;
      
      public var useCount:int;
      
      public var lastUseTime:int;
      
      public var way:int;
      
      public var isSpecial:Boolean;
      
      public var f:Array;
      
      public function ResObj()
      {
         super();
      }
      
      public function dispose() : void
      {
         var data:DisplayData = null;
         this.isLoad = false;
         this.isSpecial = false;
         this.applicationDomain = null;
         this.content = null;
         this.f = null;
         this.url = "";
         for each(data in this.bitmapArr)
         {
            data.p.dispose();
         }
         this.bitmapArr = [];
         this.rect = [];
         this.useCount = 0;
         this.lastUseTime = 0;
         this.way = 0;
      }
   }
}

