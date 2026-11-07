package com.yiTian.view.modules.ZaHuoDian
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.data.vo.Vo_grid;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_IconsPanel extends Sprite
   {
      
      public var IconName_text:MyTextField;
      
      private var Buy_text:MyTextField;
      
      private var Price_text:MyTextField;
      
      private var back_m:DisplayObject;
      
      private var _price:int;
      
      public var grid:View_Grid;
      
      private var _gridId:int;
      
      public var _textColor:int;
      
      public function View_IconsPanel()
      {
         super();
         this.IconName_text = ComponentUtil.getTextField(LangConfig.getWord("13",0),this,{
            "x":42.2,
            "y":2.2
         });
         this.Buy_text = ComponentUtil.getTextField(LangConfig.getWord("96",0),this,{
            "x":42.2,
            "y":21.5
         });
         this.Price_text = ComponentUtil.getTextField("999",this,{
            "x":76.45,
            "y":21.5
         });
         this.Buy_text.textColor = 16043313;
         this.grid = new View_Grid();
         this.grid.type = Enum_type_grid.SHOP;
         this.grid.set_bmp_bg();
         this.grid.set_bmp_over(true,null);
         this.grid.set_bmp_select();
         this.grid.x = 1.15 + 2;
         this.grid.y = 4;
         this.grid.index = this._gridId;
         this.grid.addEventListener(MouseEvent.CLICK,View_ZaHuoDianPanel.buyShop);
         addChild(this.grid);
      }
      
      public function set price(_pri:int) : void
      {
         this._price = _pri;
         this.Price_text.text = String(this._price);
      }
      
      public function get price() : int
      {
         return this._price;
      }
      
      public function set gridId(griId:int) : void
      {
         this._gridId = griId;
      }
      
      public function get gridId() : int
      {
         return this._gridId;
      }
      
      public function set grid_icon(_item:Vo_grid) : void
      {
         (this.grid as View_Grid).vo = _item;
      }
      
      public function get grid_icon() : Vo_grid
      {
         return (this.grid as View_Grid).vo;
      }
      
      override public function set name(value:String) : void
      {
         super.name = value;
         this.IconName_text.textColor = Model_shop.getColorArr[this._textColor - 1];
         this.IconName_text.text = value;
      }
      
      override public function get name() : String
      {
         return super.name;
      }
   }
}

