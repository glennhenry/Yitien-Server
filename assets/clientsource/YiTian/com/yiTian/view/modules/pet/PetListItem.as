package com.yiTian.view.modules.pet
{
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   
   public class PetListItem extends Sprite
   {
      
      private var txt:MyTextField;
      
      private var grid:View_Grid;
      
      private var mouseOverBack:Bitmap;
      
      private var _type:String;
      
      private var _data:Object;
      
      private var isFirstOpen:Boolean = true;
      
      private var _isChoose:Boolean;
      
      public function PetListItem(type:String)
      {
         super();
         this._type = type;
         this.mouseOverBack = new Bitmap();
         this.mouseOverBack.bitmapData = ComponentUtil.getBitmapData("Pet_DYSelect");
         addChild(this.mouseOverBack);
         this.mouseOverBack.y = 7;
         this.mouseOverBack.alpha = 0;
         this.grid = new View_Grid();
         this.grid.type = Enum_type_grid.PET;
         this.grid.set_tf_count(false);
         this.grid.set_bmp_bg();
         this.grid.set_bmp_select();
         this.grid.set_bmp_over();
         addChild(this.grid);
         this.grid.isAutoLoad = false;
         this.grid.y = 10;
         this.grid.x = 10;
         this.txt = ComponentUtil.getTextField("",this,{
            "x":58,
            "y":15
         });
         var underlineTF:TextFormat = new TextFormat();
         underlineTF.underline = true;
         underlineTF.color = 13434624;
         this.mouseChildren = true;
         this.buttonMode = false;
         this.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         this.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
      }
      
      protected function buyHanlder(event:MouseEvent) : void
      {
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function update(value:Object) : void
      {
         this._data = value;
         var vo:Vo_item = new Vo_item();
         vo.id = value.id;
         vo.Init_lib();
         this.grid.vo = vo;
         this.grid.count = value.total;
         this.txt.htmlText = "<font color=\'" + this.getColor(value.id) + "\'>" + this.grid.vo.str_name + "   X " + value.total + "</font>";
         if(this.isFirstOpen)
         {
            this.setGridLoad();
            this.isFirstOpen = false;
         }
      }
      
      public function setGridLoad() : void
      {
         this.grid.isAutoLoad = true;
         this.grid.beginLoad();
      }
      
      private function getColor(voId:int) : String
      {
         var a:Array = null;
         if(this._type == PetPanel.XIZI)
         {
            a = XiZiPanel.idArr;
         }
         else if(this._type == PetPanel.NEIDAN)
         {
            a = NeiDanPanel.idArr;
         }
         else if(this._type == PetPanel.LIANHUA)
         {
            a = LianHuaPanel.idArr;
         }
         var value:int = a.indexOf(voId);
         if(value == 0)
         {
            return ColorConstant.getColorStr(ColorConstant.WHITE);
         }
         if(value == 1)
         {
            return ColorConstant.getColorStr(ColorConstant.GREEN);
         }
         if(value == 2)
         {
            return ColorConstant.getColorStr(ColorConstant.BLUE);
         }
         return "";
      }
      
      public function set choose(value:Boolean) : void
      {
         if(value)
         {
            this.mouseOverBack.alpha = 1;
         }
         else
         {
            this.mouseOverBack.alpha = 0;
         }
         this._isChoose = value;
      }
      
      private function onRollOut(e:MouseEvent) : void
      {
         if(this._isChoose)
         {
            return;
         }
         this.mouseOverBack.alpha = 0;
      }
      
      private function onRollOver(e:MouseEvent) : void
      {
         if(this._isChoose)
         {
            return;
         }
         this.mouseOverBack.alpha = 1;
      }
   }
}

