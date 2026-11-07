package com.yiTian.view.modules.KFHomeland
{
   public class VoHome
   {
      
      public static var isCreatHome:int;
      
      public static var myHomeMapId:int;
      
      public static var isMyHome:int;
      
      public static var isActivity:Boolean;
      
      public static var homeMoney:Number;
      
      public static var boom:int;
      
      public static var clean:int;
      
      public static var dismantSymbol:int;
      
      public static var isOut:int;
      
      public static var heroS:int;
      
      public static var visitRoleS:int;
      
      public static var visitHomeRoleId:Number;
      
      public static var outHomeBuildInfoArr:Array;
      
      public static var innerHomeBuildInfoArr:Array;
      
      public static var outBuildVec:Vector.<CreatedBuildings>;
      
      public static var innerBuildVec:Vector.<CreatedBuildings>;
      
      public static var isDismant:Boolean = false;
      
      public static var colorVec:Vector.<String> = new <String>["#000000","#ffffff","#04ff00","#33CCFF","#de45c7","#ff7700"];
      
      private static var carpetIdVec:Vector.<Number> = new <Number>[80031,80032,80033,80034,80035,81021,81022,81023,81024,81025,82021,82022,82023,82024,82025];
      
      public function VoHome()
      {
         super();
      }
      
      public static function checkIsCarpet(id:int) : Boolean
      {
         var i:int = 0;
         while(i < carpetIdVec.length)
         {
            if(carpetIdVec[i] == id)
            {
               return true;
            }
            i++;
         }
         return false;
      }
   }
}

