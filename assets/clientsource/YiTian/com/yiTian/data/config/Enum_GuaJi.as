package com.yiTian.data.config
{
   import com.utils.ColorConstant;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.HtmlUtil;
   
   public class Enum_GuaJi
   {
      
      private static var _lqNameArr:Array;
      
      private static var _lqHtlmName:Array;
      
      private static var _lqHtlmName12:Array;
      
      public static const GUAJISOURCE:String = "lang/ch/GuaJi_Imgs.swf";
      
      public static const NOTGJ:int = 0;
      
      public static const DANREN:int = 1;
      
      public static const WAWA:int = 2;
      
      public static const TONGXING:int = 3;
      
      public static const YIXING:int = 4;
      
      public static const SHUANGXIUADDPERCENT:Array = [0,0,50,30,50];
      
      public static const BAISE:int = 0;
      
      public static const ZISE:int = 1;
      
      public static const LANSE:int = 2;
      
      public static const LVSE:int = 3;
      
      public static const LINGQIADDPERCENT:Array = [0,30,20,10];
      
      public static const LINGQIPOS:Array = [0,5,30,100];
      
      public function Enum_GuaJi()
      {
         super();
      }
      
      public static function get LINGQINAME() : Array
      {
         var id:int = 0;
         var i:int = 0;
         if(!_lqNameArr)
         {
            id = 29040;
            _lqNameArr = [];
            i = 0;
            while(i < 4)
            {
               _lqNameArr.push(LangConfig.getWord((id + i).toString(),2));
               i += 1;
            }
         }
         return _lqNameArr;
      }
      
      public static function get LINGQIHTMLNAME() : Array
      {
         if(!_lqHtlmName)
         {
            _lqHtlmName = [HtmlUtil.font(LINGQINAME[0],ColorConstant.getColorStr(ColorConstant.WHITE),14),HtmlUtil.font(LINGQINAME[1],ColorConstant.getColorStr(ColorConstant.PURPLE),14),HtmlUtil.font(LINGQINAME[2],ColorConstant.getColorStr(ColorConstant.BLUE),14),HtmlUtil.font(LINGQINAME[3],ColorConstant.getColorStr(ColorConstant.GREEN),14)];
         }
         return _lqHtlmName;
      }
      
      public static function get LINGQIHTMLNAME12() : Array
      {
         if(!_lqHtlmName12)
         {
            _lqHtlmName12 = [HtmlUtil.font(LINGQINAME[0],ColorConstant.getColorStr(ColorConstant.WHITE)),HtmlUtil.fontNoSize(LINGQINAME[1],ColorConstant.getColorStr(ColorConstant.PURPLE)),HtmlUtil.fontNoSize(LINGQINAME[2],ColorConstant.getColorStr(ColorConstant.BLUE)),HtmlUtil.fontNoSize(LINGQINAME[3],ColorConstant.getColorStr(ColorConstant.GREEN))];
         }
         return _lqHtlmName12;
      }
   }
}

