package com.yiTian.data.config
{
   public class Enum_TianmingJJ
   {
      
      public static const GY:int = 2;
      
      public static const LQ:int = 1;
      
      public static const TYPE_TM:Array = ["","仙","霸","力","虎","龙","圣","翼","神"];
      
      public function Enum_TianmingJJ()
      {
         super();
      }
      
      public static function getBroad(type:int, na:String, id:String = "") : String
      {
         if(type == 2)
         {
            return "<font color=\'#04ff00\'>" + na + "</font>" + "经过千锤百炼把<font color=\'#de45c7\'>" + TYPE_TM[int(id)] + "(冥级)</font>成功锤炼为<font color=\'#de45c7\'>" + TYPE_TM[int(id)] + "(帝级)</font>";
         }
         return "<font color=\'#04ff00\'>" + na + "</font>" + "天命投掷摇得<font color=\'#de45c7\'>吉星高照</font>，获得大量天命点！";
      }
      
      public static function get getTip() : String
      {
         var str:String = null;
         str = "1.投掷到<font color=\'#04ff00\'>1</font>个吉字获得<font color=\'#04ff00\'>50</font>天命点\n";
         str += "2.投掷到<font color=\'#04ff00\'>2</font>个吉字获得<font color=\'#04ff00\'>100</font>天命点\n";
         str += "3.投掷到<font color=\'#04ff00\'>3</font>个吉字获得<font color=\'#04ff00\'>200</font>天命点\n";
         str += "4.投掷到<font color=\'#04ff00\'>4</font>个吉字获得<font color=\'#04ff00\'>400</font>天命点\n";
         str += "5.投掷到<font color=\'#04ff00\'>5</font>个吉字获得<font color=\'#04ff00\'>800</font>天命点\n";
         str += "6.投掷到<font color=\'#04ff00\'>6</font>个吉字获得<font color=\'#04ff00\'>1500</font>天命点\n";
         str += "7.<font color=\'#04ff00\'>冥级天命</font>进阶为<font color=\'#04ff00\'>帝级天命</font>需要消耗<font color=\'#04ff00\'>15000</font>天命点\n";
         return str + "8.玩家可以花费<font color=\'#04ff00\'>20元宝</font>逆天改运，来改变不为吉的骰子\n";
      }
   }
}

