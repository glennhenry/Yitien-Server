package com.yiTian.data.config
{
   import com.yiTian.manager.LangConfig;
   
   public class Enum_TianMing
   {
      
      public static const TIANMINGSOURCE:String = "lang/ch/TianMing_Imgs.swf";
      
      public static const TIANMINGGRID_TYPE:Array = [LangConfig.getWord("80101",8),LangConfig.getWord("80102",8),LangConfig.getWord("80103",8),LangConfig.getWord("80104",8),LangConfig.getWord("80105",8)];
      
      public static const FIRSTID:int = 47101;
      
      public static const TIANMING_MAXLEVEL:int = 15;
      
      public static const ZHUFU_MAXLEVEL:int = 40;
      
      public static const TIANFU_MAXLEVEL:int = 40;
      
      public static const TAOZHUANG_MAXLEVEL:int = 40;
      
      public static const TYPE_EXP:Array = [10,20,40,240,480];
      
      public static const TYPE_EXP_EXP:Array = [50,100,200,500,800];
      
      public static const OPEN_LEVEL:Array = [1,10,20,30,50];
      
      public static const FRUIT_FIRST_ID:int = 46933;
      
      public static const FRUIT_VALUE:Array = [10,80,500];
      
      public static const TIANFUDAN_EXP:int = 30;
      
      public static const DIJIE:int = 5;
      
      public static const DJEFFECTID:String = "35311";
      
      public static const DJFirstID:int = 45297;
      
      public static const DJENDID:int = 45304;
      
      public static const ENDID:int = 47140;
      
      public function Enum_TianMing()
      {
         super();
      }
      
      public static function isDJ(id:int) : Boolean
      {
         if(id >= Enum_TianMing.DJFirstID && id <= Enum_TianMing.DJENDID)
         {
            return true;
         }
         return false;
      }
   }
}

