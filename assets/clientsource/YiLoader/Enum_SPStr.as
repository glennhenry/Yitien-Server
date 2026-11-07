package
{
   public class Enum_SPStr
   {
      
      public static const QZONE:String = "qzone";
      
      public static const PENGYOU:String = "pengyou";
      
      public static const QQGAME:String = "qqgame";
      
      public static const QQJIA:String = "qplus";
      
      public static const QQ3366:String = "3366";
      
      public static const WEIBO:String = "tapp";
      
      public static const CHITU:String = "box";
      
      public static const AIWAN:String = "union-10029-24";
      
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
         return pf == "union-10029-24" || pf == "union-10042-69" || pf == "union-10042-70" || pf == "union-10042-76" || pf == "union-10042-78" || pf == "union-10029-136" || pf == "union-10029-137" || pf == "union-10029-140";
      }
   }
}

