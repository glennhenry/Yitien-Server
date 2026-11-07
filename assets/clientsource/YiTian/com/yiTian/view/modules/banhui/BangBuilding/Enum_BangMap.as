package com.yiTian.view.modules.banhui.BangBuilding
{
   import com.yiTian.manager.LangConfig;
   
   public class Enum_BangMap
   {
      
      private static var bn:Array;
      
      private static var tipStrArr:Array;
      
      private static var bTipTxtArr:Array;
      
      public static const MainTownUpdateCost:Array = [0,6000,20000,40000,90000,150000,250000,300000,400000,550000];
      
      public static const FishBoundUpdateCost:Array = [0,1200,4000,8000,20000,30000,45000,65000,85000,110000];
      
      public static const ShopUpdateCost:Array = [0,1200,4000,8000,20000,30000,45000,65000,85000,110000];
      
      public static const BarUpdateCost:Array = [0,1200,4000,8000,20000,30000,45000,65000,85000,110000];
      
      public static const MoneyTreeUpdateCost:Array = [0,1200,4000,8000,20000,30000,45000,65000,85000,110000];
      
      public static const BANGCREATECOST:int = 30000;
      
      public function Enum_BangMap()
      {
         super();
      }
      
      public static function get BulidingNameArr() : Array
      {
         var id:int = 0;
         var i:int = 0;
         if(!bn)
         {
            bn = [""];
            id = 22601;
            i = 0;
            while(i < 5)
            {
               bn.push(LangConfig.getWord((id + i).toString(),2));
               i += 1;
            }
         }
         return bn;
      }
      
      public static function get TipStringArr() : Array
      {
         var id:int = 0;
         var i:int = 0;
         if(!tipStrArr)
         {
            tipStrArr = [""];
            id = 22611;
            i = 0;
            while(i < 5)
            {
               tipStrArr.push(LangConfig.getWord((id + i).toString(),2));
               i += 1;
            }
         }
         return tipStrArr;
      }
      
      public static function get BubbleTipText() : Array
      {
         var id:int = 0;
         var i:int = 0;
         if(!bTipTxtArr)
         {
            id = 22631;
            bTipTxtArr = [];
            i = 0;
            while(i < 5)
            {
               bTipTxtArr.push(LangConfig.getWord((id + i).toString(),2));
               i += 1;
            }
         }
         return bTipTxtArr;
      }
   }
}

