package com.yiTian.data.config
{
   import com.yiTian.data.model.Model_XiaoZhao;
   
   public class Enum_XiaoZhao
   {
      
      public static const STATE_GET:int = 1;
      
      public static const STATE_NGET:int = 0;
      
      public static const COST:Array = [0,2,2,2,2,10,10,10,10,50,50];
      
      public static const PROPID:int = 123;
      
      public static const XPCOST:int = 20;
      
      public static const STATE_XIPAI:int = 0;
      
      public static const STATE_CZ:int = 1;
      
      public static const STATE_NXP:int = 2;
      
      public static const BTNLABEL:Array = ["洗 牌","重 置","洗 牌"];
      
      public static const BTNLABEL1:Array = ["洗牌","重置","洗牌"];
      
      public static const MAX_CARD:int = 10;
      
      private static var indexArr:Array = [1,2,3,4,5,6,7,8,9,10];
      
      private static var indexArr1:Array = [1,2,3,4,5,6,7,8,9,10];
      
      public function Enum_XiaoZhao()
      {
         super();
      }
      
      public static function nextCost() : int
      {
         return COST[Model_XiaoZhao.getOpenCount() + 1];
      }
      
      public static function randomIndex() : int
      {
         var f:int = int(Math.random() * indexArr.length);
         trace(f);
         var index:int = indexArr.splice(f,1);
         if(indexArr.length == 0)
         {
            indexArr = [1,2,3,4,5,6,7,8,9,10];
         }
         trace(index);
         return index;
      }
      
      public static function randomIndex1() : int
      {
         var f:int = int(Math.random() * indexArr1.length);
         trace(f);
         var index:int = indexArr1.splice(f,1);
         if(indexArr1.length == 0)
         {
            indexArr1 = [1,2,3,4,5,6,7,8,9,10];
         }
         trace(index);
         return index;
      }
   }
}

