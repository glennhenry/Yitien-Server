package com.yiTian.view.modules.hapStone
{
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.utils.HtmlUtil;
   
   public class Vo_hapStone
   {
      
      public var vo:Vo_valuable;
      
      public var itemSellCount:int;
      
      public var index:int;
      
      public var name:String;
      
      public var color:int;
      
      public var jifen:int;
      
      public var isLight:int = 0;
      
      public function Vo_hapStone()
      {
         super();
      }
      
      public function init(id:int) : void
      {
         var _vo:Vo_equip = null;
         var __vo:Vo_item = null;
         if(id > 50000)
         {
            _vo = new Vo_equip();
            _vo.id = id;
            _vo.Init_lib();
            this.vo = _vo as Vo_valuable;
         }
         else
         {
            __vo = new Vo_item();
            __vo.id = id;
            __vo.Init_lib();
            this.vo = __vo as Vo_valuable;
         }
         this.color = this.vo.color;
         this.name = HtmlUtil.font(this.vo.str_name,Model_shop.get_color_arr[this.color - 1]);
      }
   }
}

