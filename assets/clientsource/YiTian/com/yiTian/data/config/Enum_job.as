package com.yiTian.data.config
{
   import com.yiTian.manager.LangConfig;
   
   public class Enum_job
   {
      
      private static var _TXT:Array;
      
      private static var _COLORTXT:Array;
      
      public static const JOBCOLOR:Array = ["BD3939","4B8CA0","63902D","95508C","D8D8D8","BD3939","BD3939","4B8CA0","4B8CA0","63902D","63902D","95508C","95508C","D8D8D8","D8D8D8"];
      
      public static const JOBCOLORV:Array = [12400953,4951200,6524973,9785484,14211288,12400953,12400953,4951200,4951200,6524973,6524973,9785484,9785484];
      
      public static const TIAN_DAO:int = 1;
      
      public static const XIAO_YAO:int = 2;
      
      public static const YI_XIAN:int = 3;
      
      public static const CHI_KE:int = 4;
      
      public static const ALL:int = 5;
      
      public static const TIAN_DAO_Z:int = 6;
      
      public static const TIAN_DAO_X:int = 7;
      
      public static const XIAO_YAO_Z:int = 8;
      
      public static const XIAO_YAO_X:int = 9;
      
      public static const YI_XIAN_Z:int = 10;
      
      public static const YI_XIAN_X:int = 11;
      
      public static const CHI_KE_Z:int = 12;
      
      public static const CHI_KE_X:int = 13;
      
      public function Enum_job()
      {
         super();
      }
      
      public static function getJob(jobIndex:int) : String
      {
         return TXT[Enum_job.getBaseJob(jobIndex) - 1];
      }
      
      public static function getColorJob(job:int) : String
      {
         return COLORTXT[Enum_job.getBaseJob(job) - 1];
      }
      
      public static function get TXT() : Array
      {
         if(!_TXT)
         {
            _TXT = [LangConfig.getWord("10036",1),LangConfig.getWord("10037",1),LangConfig.getWord("10038",1),LangConfig.getWord("10039",1),LangConfig.getWord("10040",1)];
         }
         return _TXT;
      }
      
      public static function get COLORTXT() : Array
      {
         if(!_COLORTXT)
         {
            _COLORTXT = ["<font color=\'#BD3939\'>" + LangConfig.getWord("10036",1) + "</font>","<font color=\'#4B8CA0\'>" + LangConfig.getWord("10037",1) + "</font>","<font color=\'#63902D\'>" + LangConfig.getWord("10038",1) + "</font>","<font color=\'#95508C\'>" + LangConfig.getWord("10039",1) + "</font>","<font color=\'#ffffff\'>" + LangConfig.getWord("10040",1) + "</font>"];
         }
         return _COLORTXT;
      }
      
      public static function getBaseJob(jobIndex:uint) : uint
      {
         if(jobIndex <= 5)
         {
            return jobIndex;
         }
         return (jobIndex - 4) / 2;
      }
      
      public static function getChildWay(jobIndex:uint) : uint
      {
         if(jobIndex <= 5)
         {
            return 0;
         }
         return jobIndex % 2 + 1;
      }
      
      public static function getChildJobZ(baseJobIndex:uint) : uint
      {
         return baseJobIndex * 2 + 4;
      }
      
      public static function getChildJobX(baseJobIndex:uint) : uint
      {
         return baseJobIndex * 2 + 5;
      }
      
      public static function getJobColorStr(str:String, job:uint) : String
      {
         return "<font color=\'#" + JOBCOLOR[getBaseJob(job) - 1] + "\'>" + str + "</font>";
      }
      
      public static function getJobWayLabel(v:uint, c:Boolean = false) : String
      {
         var r:String = null;
         var way:uint = getChildWay(v);
         switch(way)
         {
            case 1:
               r = "正";
               break;
            case 2:
               r = "邪";
               break;
            default:
               r = "";
         }
         if(r != "")
         {
            r = "[" + r + "]";
         }
         if(c && r != "")
         {
            r = getJobColorStr(r,v);
         }
         return r;
      }
      
      public static function getMenPai(jobIndex:int, c:Boolean = true) : String
      {
         var baseJob:int = int(getBaseJob(jobIndex));
         var name:String = c ? Enum_job.getJobColorStr(Enum_job.TXT[baseJob - 1],baseJob) : Enum_job.TXT[baseJob - 1];
         return jobIndex >= 6 ? name + Enum_job.getJobWayLabel(jobIndex,c) : name;
      }
   }
}

