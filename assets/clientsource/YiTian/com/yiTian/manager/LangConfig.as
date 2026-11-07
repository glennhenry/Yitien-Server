package com.yiTian.manager
{
   import com.yiTian.data.Data_lib;
   
   public class LangConfig
   {
      
      public static const OK:int = 1;
      
      public function LangConfig()
      {
         super();
      }
      
      public static function getWord(id:String, langIndex:int, ... param) : String
      {
         if(!Data_lib["lang" + langIndex.toString()][id])
         {
            return "555";
         }
         var src:String = Data_lib["lang" + langIndex.toString()][id];
         return rep(src,param);
      }
      
      private static function rep(src:String, param:*) : String
      {
         var rg:String = null;
         var d:String = null;
         var len:int = int(param.length);
         if(len == 0)
         {
            return src;
         }
         var i:int = 0;
         while(i < len)
         {
            rg = "[{{]" + i.toString() + "[}}]";
            d = param[i];
            src = src.replace(new RegExp(rg,"g"),d);
            i += 1;
         }
         return src;
      }
      
      public static function getWordByExcl(id:String, excl:String, ... param) : String
      {
         if(!Data_lib[excl] || Boolean(Data_lib[excl][id]))
         {
            return "555";
         }
         var src:String = Data_lib[excl][id];
         return rep(src,param);
      }
      
      public static function reTxt(src:String, ... param) : String
      {
         var rg:String = null;
         var d:String = null;
         var len:int = int(param.length);
         if(len == 0)
         {
            return src;
         }
         var i:int = 0;
         while(i < len)
         {
            rg = "[{{]" + i.toString() + "[}}]";
            d = param[i];
            src = src.replace(new RegExp(rg,"g"),d);
            i += 1;
         }
         return src;
      }
   }
}

