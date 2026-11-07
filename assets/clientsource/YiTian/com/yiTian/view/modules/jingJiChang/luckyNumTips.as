package com.yiTian.view.modules.jingJiChang
{
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Sprite;
   
   public class luckyNumTips extends Sprite
   {
      
      public static const Wid:int = 298;
      
      public static const Hei:int = 185;
      
      private var giftId:int = 44785;
      
      private var _showTips:Boolean = false;
      
      private var check:CheckBox;
      
      public function luckyNumTips()
      {
         super();
      }
      
      public function init() : void
      {
         var grid:View_Grid = null;
         ComponentUtil.getBitmap("Back_XYTS",this,{
            "x":0,
            "y":0
         },Global.XXPPdm);
         var myTips:MyTextField = ComponentUtil.getTextField("",this,{
            "x":38,
            "y":36,
            "color":16776960,
            "size":12,
            "leading":3,
            "realWidth":220,
            "wordWrap":true,
            "multiline":true
         });
         myTips.htmlText = LangConfig.getWord("30134",3);
         grid = new View_Grid();
         addChild(grid);
         grid.x = 208;
         grid.y = 80;
         grid.type = Enum_type_grid.NO_DRAG;
         grid.set_bmp_bg();
         grid.set_bmp_over();
         grid.set_bmp_select();
         var vo:Vo_item = new Vo_item();
         vo.id = this.giftId;
         vo.Init_lib();
         grid.vo = vo;
         this.check = ComponentUtil.getCheckBox(LangConfig.getWord("30136",3),"CheckBox01",this,{
            "x":114,
            "y":133
         },Global.Img_Cdm);
         this.check.clickFun = this.showCheckTips;
         this.check.selected = true;
         this._showTips = this.check.selected;
      }
      
      private function showCheckTips(box:CheckBox) : void
      {
         this._showTips = box.selected;
      }
      
      public function get showTips() : Boolean
      {
         return this._showTips;
      }
      
      public function set showTips(boo:Boolean) : void
      {
         this.check.selected = boo;
         this._showTips = this.check.selected;
      }
   }
}

