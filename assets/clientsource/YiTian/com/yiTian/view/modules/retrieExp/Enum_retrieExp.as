package com.yiTian.view.modules.retrieExp
{
   import com.yiTian.manager.LangConfig;
   
   public class Enum_retrieExp
   {
      
      private static var txt:Array;
      
      public static const RETRIESOURCE:String = "lang/ch/JYZH_Imgs.swf";
      
      public static const DAYILY:int = 1;
      
      public static const FISH:int = 2;
      
      public static const KUNLUN:int = 3;
      
      public static const LQ1:int = 4;
      
      public static const LQ2:int = 5;
      
      public static const LQ3:int = 6;
      
      public static const PB1:int = 7;
      
      public static const PB2:int = 8;
      
      public static const PB3:int = 9;
      
      public static const TILI:int = 10;
      
      public static const TOKENID:Array = [46252,46253,46254,46255];
      
      public static const IMAGEDIR:Array = ["resource/image/extralPng/rcrw.png","resource/image/extralPng/rcrw.png","resource/image/extralPng/yu.png","resource/image/extralPng/kls.png","resource/image/extralPng/lqjx.png","resource/image/extralPng/lqjx.png","resource/image/extralPng/lqjx.png","resource/image/paobiao/icon.png","resource/image/paobiao/icon.png","resource/image/paobiao/icon.png","resource/image/extralPng/tlyc.png"];
      
      public function Enum_retrieExp()
      {
         super();
      }
      
      public static function get TXT() : Array
      {
         var sId:int = 0;
         var i:int = 0;
         if(!txt)
         {
            txt = [];
            sId = 23400;
            i = 0;
            while(i < 11)
            {
               txt.push(LangConfig.getWord((sId + i).toString(),2));
               i += 1;
            }
         }
         return txt;
      }
   }
}

