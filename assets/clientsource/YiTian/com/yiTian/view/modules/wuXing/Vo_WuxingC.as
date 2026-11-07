package com.yiTian.view.modules.wuXing
{
   import com.yiTian.data.Data_lib;
   import com.yiTian.utils.HtmlUtil;
   
   public class Vo_WuxingC
   {
      
      public static var EM_LVL:int = 0;
      
      public static var EM_TOTALWORTH:int = 1;
      
      public static var EM_ADDATTRI:int = 2;
      
      public var lvl:int;
      
      public var totalWorth:int;
      
      public var addAttri:int;
      
      public var nexAttri:int;
      
      public var nextLv:int;
      
      public function Vo_WuxingC()
      {
         super();
      }
      
      public function initLib(layer:int) : void
      {
         if(layer > 0)
         {
            this.lvl = Data_lib.Wuxing_s[layer][0];
            this.nextLv = this.lvl + 1;
            this.addAttri = Data_lib.Wuxing_s[layer][2];
            if(layer <= 10)
            {
               this.nexAttri = Data_lib.Wuxing_s[layer + 1][2];
            }
         }
      }
      
      public function getLevel(__lvl:int) : String
      {
         if(__lvl == 0)
         {
            return "待激活";
         }
         return "第" + HtmlUtil.font(__lvl.toString(),"#04ff00") + "重";
      }
   }
}

