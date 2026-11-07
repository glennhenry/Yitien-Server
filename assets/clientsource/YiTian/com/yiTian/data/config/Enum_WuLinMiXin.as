package com.yiTian.data.config
{
   public class Enum_WuLinMiXin
   {
      
      private static var NameArray:Array;
      
      public function Enum_WuLinMiXin()
      {
         super();
      }
      
      public static function getNameByIndex(_id:int) : String
      {
         if(!NameArray)
         {
            NameArray = ["杨又菱","丁淑瑶","纪霏儿","张无极","鹤问玄","银簪婆婆","宋元乔","朱元璋","张三疯","鹿倚山","赵茗","殷翎"];
         }
         return NameArray[_id];
      }
   }
}

