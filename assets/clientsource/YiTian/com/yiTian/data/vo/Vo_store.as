package com.yiTian.data.vo
{
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.utils.HtmlUtil;
   
   public class Vo_store
   {
      
      public static var SIGN:int = 0;
      
      public static var POSITION:int = 1;
      
      public static var WPID:int = 2;
      
      public static var TYPE:int = 3;
      
      public static var SOLD_NUM:int = 4;
      
      public static var PR_EPRICE:int = 5;
      
      public static var NOW_PRICE:int = 6;
      
      public static var PRICE_TYPE:int = 7;
      
      public static var JOB:int = 8;
      
      public static var LEFT_TIME:int = 9;
      
      public var sign:int;
      
      public var position:int;
      
      public var wpid:int;
      
      public var type:int;
      
      public var sold_num:int;
      
      public var pre_price:int;
      
      public var now_price:int;
      
      public var price_type:int;
      
      public var job:int;
      
      public var left_time:int;
      
      public var name:String;
      
      public var str_name:String;
      
      public var vo_value:Vo_valuable;
      
      public var isHot:int;
      
      public var boughtLimit:int;
      
      public var boughtLvl:int;
      
      public var jiJinGoodsId:int;
      
      public var paiXu:int;
      
      public function Vo_store()
      {
         super();
      }
      
      public function init_store() : void
      {
         var vo:Vo_item = null;
         var voE:Vo_equip = null;
         if(this.type == 1)
         {
            vo = new Vo_item();
            vo.id = this.wpid;
            vo.Init_lib();
            this.vo_value = vo;
            this.name = vo.str_name;
            this.str_name = HtmlUtil.font(vo.str_name,Model_shop.get_color_arr[vo.color - 1]);
         }
         else if(this.type == 2)
         {
            voE = new Vo_equip();
            voE.id = this.wpid;
            voE.Init_lib();
            this.name = voE.str_name;
            this.vo_value = voE;
            this.str_name = HtmlUtil.font(voE.str_name,Model_shop.get_color_arr[voE.color - 1]);
         }
      }
   }
}

