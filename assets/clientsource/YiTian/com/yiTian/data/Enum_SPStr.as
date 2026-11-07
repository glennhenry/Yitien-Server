package com.yiTian.data
{
   import com.yiTian.Global;
   
   public class Enum_SPStr
   {
      
      public static const QZONE:String = "qzone";
      
      public static const PENGYOU:String = "pengyou";
      
      public static const QQGAME:String = "qqgame";
      
      public static const QQJIA:String = "qplus";
      
      public static const QQ3366:String = "3366";
      
      public static const WEIBO:String = "tapp";
      
      public static const AIWAN:String = "union-10029-24";
      
      public static const CHITU:String = "box";
      
      public static const GUANWANG:String = "website";
      
      public function Enum_SPStr()
      {
         super();
      }
      
      public static function isUnion(pf:String) : Boolean
      {
         if(Enum_SPStr.isIwan(Global.pf))
         {
            return false;
         }
         return pf.indexOf("union") != -1;
      }
      
      public static function isIwan(pf:String) : Boolean
      {
         return pf.indexOf("union-10029-2") != -1;
      }
      
      public static function isJiangHu() : Boolean
      {
         return Global._pf.indexOf("*") != -1;
      }
      
      public static function isPartUnion() : Boolean
      {
         return Global.pf == "union-10042-15" || Global.pf == "union-10042-16";
      }
      
      public static function isTencent(pf:String) : Boolean
      {
         return pf == QZONE || pf == PENGYOU || pf == QQGAME || pf == QQJIA || pf == QQ3366 || pf == WEIBO || Enum_SPStr.isIwan(Global.pf);
      }
   }
}

