package com.yiTian.view.modules.pet
{
   import com.yiTian.data.Data_lib;
   import com.yiTian.utils.HtmlUtil;
   
   public class Model_neiDan
   {
      
      public static var colorArr:Array = ["ffffff","04ff00","33CCFF","de45c7","ff7700","81ea86","813dff","f0ac82"];
      
      public function Model_neiDan()
      {
         super();
      }
      
      private static function getData(index:int, len:int) : String
      {
         var key:int = index + 9 > 13 ? 13 : int(index + 9);
         var typeDan:String = Data_lib.petNeiDan[key][2];
         var addAtt:int = int(Data_lib.petNeiDan[key][6]);
         if(len > 5 && index == len - 1)
         {
            return "";
         }
         var color:String = index < len - 1 ? getColor(index + 10) : "#999999";
         return HtmlUtil.font("三种内丹进阶为" + typeDan + " 伤害加成" + addAtt + "%\n",color);
      }
      
      public static function getColor(lvl:int) : String
      {
         var _array:Array = Data_lib.petNeiDan.toArray();
         return "#" + colorArr[_array[lvl - 7][10] - 1];
      }
      
      public static function add_str(len:int) : String
      {
         var str:String = "";
         var i:int = 0;
         while(i < len)
         {
            str += getData(i,len);
            i++;
         }
         return str;
      }
   }
}

