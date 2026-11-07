package com.yiTian.view.modules.awardOnline
{
   public class AwardItemData
   {
      
      private static var instance:AwardItemData;
      
      public var dataArr:Array;
      
      public var id:int;
      
      public var nextTimeCount:int;
      
      public function AwardItemData()
      {
         super();
         if(Boolean(instance))
         {
            throw new Error("singlon error");
         }
         this.dataArr = new Array();
      }
      
      public static function getInstance() : AwardItemData
      {
         if(!instance)
         {
            instance = new AwardItemData();
         }
         return instance;
      }
   }
}

