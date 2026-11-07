package com.yiTian.view.modules.ShiZhuangSuiPian
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.Enum_ShiZhuangSuiPian;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   
   public class ShiZhuangSuiPian_itemList extends Sprite
   {
      
      public var id:int;
      
      private var clothes:MyTextField;
      
      private var cost:MyTextField;
      
      public var grid:View_Grid;
      
      private var libData:Array = [];
      
      public function ShiZhuangSuiPian_itemList()
      {
         super();
         this.Init();
      }
      
      private function Init() : void
      {
         var k:* = undefined;
         var o:Array = null;
         var o2:Array = null;
         ComponentUtil.getScaleBitmap("ListBack_Bule02",[12,12,1,1],this,{
            "x":0,
            "y":0,
            "width":190,
            "height":60
         },Global.Img_Cdm);
         ComponentUtil.getTextField("时装碎片：",this,{
            "x":60,
            "y":33,
            "color":13424242,
            "size":12,
            "leading":0
         });
         this.clothes = ComponentUtil.getTextField("",this,{
            "x":60,
            "y":10,
            "color":14566855,
            "size":12,
            "leading":0
         });
         this.cost = ComponentUtil.getTextField("",this,{
            "x":122,
            "y":33,
            "color":16383744,
            "size":12,
            "leading":0
         });
         this.cost.autoSize = TextFieldAutoSize.LEFT;
         for(k in Data_lib.ShiZhuangSuiPian)
         {
            o = Data_lib.ShiZhuangSuiPian[k];
            o2 = o.concat();
            o2.unshift(Number(k));
            this.libData.push(o2);
         }
         this.libData.sortOn("0",Array.NUMERIC);
      }
      
      public function setItem(index:int, curPage:int) : void
      {
         var vo:Vo_equip = null;
         if(curPage * 10 + index > this.libData.length - 1)
         {
            this.visible = false;
            return;
         }
         if(!this.grid)
         {
            this.grid = new View_Grid();
            this.grid.set_bmp_bg();
            this.grid.set_bmp_over();
            this.grid.isAutoLoad = true;
            this.grid.set_bmp_select();
            this.grid.type = Enum_type_grid.STORE;
            this.grid.buttonMode = true;
            this.grid.addEventListener(MouseEvent.CLICK,this.onBuy);
            this.grid.x = 11;
            this.grid.y = 13;
         }
         else
         {
            this.grid.bSelect = false;
         }
         vo = new Vo_equip();
         vo.id = this.libData[curPage * 10 + index][1];
         vo.Init_lib();
         vo.bBind = true;
         this.grid.vo = vo;
         if(!this.grid.stage)
         {
            this.addChild(this.grid);
         }
         this.visible = true;
         this.clothes.text = vo.str_name;
         this.cost.text = String(this.libData[curPage * 10 + index][2]).split("_")[1];
      }
      
      private function onBuy(e:MouseEvent) : void
      {
         Global.control.sendNotification(Enum_ShiZhuangSuiPian.CLICK_GRID,this.id);
      }
   }
}

