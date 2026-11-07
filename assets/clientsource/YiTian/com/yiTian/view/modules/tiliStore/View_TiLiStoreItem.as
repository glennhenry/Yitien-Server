package com.yiTian.view.modules.tiliStore
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.model.Model_tiliStore;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.message.cg.TiLiCGMessage;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_TiLiStoreItem extends Sprite
   {
      
      public static var canBought:Boolean;
      
      private var grid:View_Grid;
      
      private var nameTxt:MyTextField;
      
      private var priceTxt:MyTextField;
      
      private var boughtBtn:Button;
      
      private var _index:int;
      
      private var type:int;
      
      public function View_TiLiStoreItem()
      {
         super();
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":0,
            "y":0,
            "width":150,
            "height":175
         },Global.Img_Cdm);
         this.nameTxt = ComponentUtil.getTextField("",this,{
            "x":36,
            "y":10,
            "color":14566855
         });
         this.priceTxt = ComponentUtil.getTextField("",this,{
            "x":50,
            "y":110,
            "color":11904647
         });
         this.boughtBtn = ComponentUtil.getButton(LangConfig.getWord("93",0),"Button_Five",this,{
            "x":29,
            "y":134,
            "textColor":16184781
         },Global.Img_Cdm);
         this.grid = new View_Grid(true);
         this.grid.type = Enum_type_grid.SHOP;
         this.grid.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
         this.grid.set_bmp_over(true,null);
         this.grid.set_bmp_select(View_Grid.GRID_BIGGEST_DOWN);
         this.grid.x = 41;
         this.grid.y = 36;
         this.grid.type = Enum_type_grid.STORE;
         addChild(this.grid);
         this.boughtBtn.callBack = this.funcHandle;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.setBtn(canBought > 0);
         }
      }
      
      public function set index(_value:int) : void
      {
         this._index = _value;
      }
      
      public function get index() : int
      {
         return this._index;
      }
      
      public function setBtn(value:Boolean) : void
      {
         this.boughtBtn.enabled = value;
         this.boughtBtn.useHandCursor = value;
         this.boughtBtn.buttonMode = value;
      }
      
      public function initStoreData(wpid:int, nameStr:String, price:int, _type:int) : void
      {
         this.type = _type;
         var temVo:Vo_item = new Vo_item();
         temVo.id = wpid;
         temVo.Init_lib();
         temVo.str_name = nameStr;
         this.grid.vo = temVo;
         this.nameTxt.htmlText = nameStr;
         this.priceTxt.text = String(price) + LangConfig.getWord("21",0);
      }
      
      private function funcHandle(e:MouseEvent) : void
      {
         Model_tiliStore._boughtIndex = this.index;
         if(this.type == 1)
         {
            TiLiCGMessage.TiliBought(3);
         }
         else if(this.type == 3)
         {
            TiLiCGMessage.TiliBought(1);
         }
         else
         {
            TiLiCGMessage.TiliBought(2);
         }
      }
   }
}

