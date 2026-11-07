package com.yiTian.view.modules.KFHomeland
{
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_grid;
   
   public class Vo_HomeMall extends Vo_grid
   {
      
      private static const TYPECURRENCYS:int = 1;
      
      private static const COSTS:int = 2;
      
      private static const BOOMS:int = 4;
      
      private static const NAME:int = 5;
      
      private static const DESC:int = 6;
      
      public var cost:int;
      
      public var nameCurrency:String;
      
      public var picCurrency:String;
      
      public var boom:int;
      
      public var color:int;
      
      public var colorStr:String;
      
      public function Vo_HomeMall()
      {
         super();
      }
      
      public function Init_lib() : void
      {
         var arr:Array = Data_lib.kfjyshangpu[id];
         if(!arr || arr.length <= 0)
         {
            return;
         }
         this.cost = arr[COSTS];
         switch(int(arr[TYPECURRENCYS]))
         {
            case 16:
               this.picCurrency = "Icon_YuanBao";
               this.nameCurrency = Data_lib.attribute[int(arr[TYPECURRENCYS])][0];
               break;
            case 18:
               this.picCurrency = "Icon_YinZi";
               this.nameCurrency = "银子";
               break;
            case 29:
               this.picCurrency = "Icon_BangYin";
               this.nameCurrency = "银子";
               break;
            case 45:
               this.picCurrency = "Icon_JYB";
               this.nameCurrency = Data_lib.attribute[int(arr[TYPECURRENCYS])][0];
         }
         this.boom = int(arr[BOOMS]);
         str_name = String(arr[NAME]);
         str_describe = String(arr[DESC]);
         if(id == 45017)
         {
            this.color = 2;
         }
         else
         {
            this.color = int(Data_lib.kfjyjzflb[id][Enum_SortBuildins.COLOR_ATT]);
         }
         this.colorStr = VoHome.colorVec[this.color];
      }
   }
}

