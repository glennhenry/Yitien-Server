package com.yiTian.view.modules.wuXing
{
   import com.yiTian.data.Data_lib;
   
   public class Vo_wuXing
   {
      
      public static const EM_TYPESTR:int = 0;
      
      public static const EM_XIUXINGWORTH:int = 1;
      
      public static const EM_SHUXINGDESCRIP:int = 2;
      
      public static const EM_ADDTYPESTR:int = 5;
      
      public var typeIndex:int;
      
      public var xiuXingWorthLv:int;
      
      public var addTypeStr:String;
      
      public var descrip:String;
      
      public var nextLv:int;
      
      public var nextLvAttr:String;
      
      public function Vo_wuXing()
      {
         super();
      }
      
      public function initLib(id:int) : void
      {
         if(id == 0)
         {
            return;
         }
         this.typeIndex = Data_lib.Wuxing_f[id][EM_TYPESTR];
         this.xiuXingWorthLv = Data_lib.Wuxing_f[id][EM_XIUXINGWORTH];
         this.addTypeStr = Data_lib.Wuxing_f[id][EM_ADDTYPESTR];
         this.descrip = Data_lib.Wuxing_f[id][EM_SHUXINGDESCRIP];
         var lvl:int = this.xiuXingWorthLv + 1;
         if(lvl == 0)
         {
            this.nextLv = -1;
            this.nextLvAttr = "已满级";
         }
         else
         {
            this.nextLv = lvl;
            if(lvl <= 100)
            {
               this.nextLvAttr = Data_lib.Wuxing_f[id + 1][EM_ADDTYPESTR];
            }
            else
            {
               this.nextLvAttr = "已满级";
            }
         }
      }
   }
}

