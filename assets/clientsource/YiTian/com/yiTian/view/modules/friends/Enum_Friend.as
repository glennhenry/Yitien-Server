package com.yiTian.view.modules.friends
{
   import com.yiTian.manager.LangConfig;
   
   public class Enum_Friend
   {
      
      private static var cl:Array;
      
      private static var lbTxt:Array;
      
      public static const QFRIEND:int = 7;
      
      public static const CHONGZHIPNGDIR:String = "resource/image/kfhd/chong.png";
      
      public static const CROSS_SERV_FRIEND:int = 9;
      
      public static const CROSS_SERV_HEAT:int = 10;
      
      public function Enum_Friend()
      {
         super();
      }
      
      public static function get closeLevel() : Array
      {
         if(!cl)
         {
            cl = [[0,LangConfig.getWord("23140",2)],[101,LangConfig.getWord("23141",2)],[301,LangConfig.getWord("23142",2)],[701,LangConfig.getWord("23143",2)],[1501,LangConfig.getWord("23144",2)],[3101,LangConfig.getWord("23145",2)],[6301,LangConfig.getWord("29246",2)],[12701,LangConfig.getWord("29247",2)],[25501,LangConfig.getWord("29248",2)]];
         }
         return cl;
      }
      
      public static function getTXT(num:int) : String
      {
         var index:int = closeLevel.length - 1;
         while(index >= 0)
         {
            if(num >= closeLevel[index][0])
            {
               return closeLevel[index][1];
            }
            index--;
         }
         return closeLevel[closeLevel.length - 1];
      }
      
      public static function get LIBAOTXT() : Array
      {
         var i:int = 0;
         if(!lbTxt)
         {
            lbTxt = [];
            i = 0;
            while(i < 4)
            {
               lbTxt.push(LangConfig.getWord((23150 + i).toString(),2));
               i += 1;
            }
         }
         return lbTxt;
      }
   }
}

