package com.yiTian.view.modules.wuXing
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   
   public class DanYaoItem extends Sprite
   {
      
      private static var selectFilter:Array = [new GlowFilter(16776960,1,8,8,2,1)];
      
      private var grid:View_Grid;
      
      private var bbB:Bitmap;
      
      private var tfNameCountTf:MyTextField;
      
      private var spBck:Sprite;
      
      private var type:int;
      
      private var _choose:Boolean;
      
      public function DanYaoItem()
      {
         super();
         this.bbB = ComponentUtil.getBitmap("Item_Back",this,{
            "x":0,
            "y":0
         },Global.WuXing_Imgsdm);
         this.spBck = new Sprite();
         this.spBck.graphics.beginFill(465693,0.1);
         this.spBck.graphics.drawRect(0,0,198,42);
         this.spBck.graphics.endFill();
         addChild(this.spBck);
         ComponentUtil.setPropertie(this.spBck,{
            "x":16,
            "y":8
         });
         mouseEnabled = true;
         buttonMode = true;
         this.grid = new View_Grid();
         this.grid.set_bmp_bg();
         this.grid.set_bmp_over(true,null);
         addChild(this.grid);
         ComponentUtil.setPropertie(this.grid,{
            "x":20,
            "y":12
         });
         this.tfNameCountTf = ComponentUtil.getTextField("丹药中文名称    x000",this,{
            "x":83,
            "y":20,
            "color":327424,
            "size":14,
            "leading":0,
            "bold":true
         });
         addEventListener(MouseEvent.MOUSE_OVER,function(e:MouseEvent):void
         {
            spBck.filters = selectFilter;
         });
         addEventListener(MouseEvent.MOUSE_OUT,function(e:MouseEvent):void
         {
            if(!_choose)
            {
               spBck.filters = [];
            }
         });
      }
      
      public function init(_type:int) : void
      {
         this.type = _type + 1;
         var id:int = int(Data_lib.Wuxing_t[this.type][0]);
         var vo:Vo_item = new Vo_item();
         vo.id = id;
         vo.Init_lib();
         this.grid.vo = vo;
      }
      
      public function update(_count:int) : void
      {
         var name:String = this.grid.vo.str_name;
         this.tfNameCountTf.htmlText = HtmlUtil.font(name + "x" + _count,WuXingMter.colorArr[this.type - 1]);
      }
      
      public function set choose(value:Boolean) : void
      {
         this._choose = value;
         if(value)
         {
            this.spBck.filters = selectFilter;
         }
         else
         {
            this.spBck.filters = [];
         }
      }
      
      public function get typeIndex() : int
      {
         return this.type - 1;
      }
   }
}

