package com.yiTian.view.modules.activity
{
   import com.yiTian.data.Data_lib;
   import flash.utils.Dictionary;
   
   public class CJInfo
   {
      
      private static var instance:CJInfo;
      
      public var itemList1:Array;
      
      public var itemList2:Array;
      
      public var comboDay:int = 1;
      
      public var state1:int = -1;
      
      public var arr1:Array;
      
      public var nxtFreName:String = "";
      
      public var nextFreDay:int = -1;
      
      public var state2:int = -1;
      
      public var arr2:Array;
      
      public function CJInfo()
      {
         super();
         if(Boolean(instance))
         {
            throw new Error("singlon error");
         }
         this.init();
         instance = this;
      }
      
      public static function getInstance() : CJInfo
      {
         if(instance)
         {
         }
         return instance;
      }
      
      private function init() : void
      {
         var arr:Array = null;
         var arr2:Array = null;
         this.itemList1 = new Array();
         var dic:Dictionary = Data_lib.cj_award1;
         for each(arr in dic)
         {
            this.itemList1.push(arr);
         }
         this.itemList2 = new Array();
         dic = Data_lib.cj_award2;
         for each(arr2 in dic)
         {
            this.itemList2.push(arr2);
         }
      }
   }
}

