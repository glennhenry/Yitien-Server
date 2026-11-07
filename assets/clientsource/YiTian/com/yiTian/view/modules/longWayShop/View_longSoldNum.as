package com.yiTian.view.modules.longWayShop
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.Panel;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFieldType;
   import flash.text.TextFormatAlign;
   
   public class View_longSoldNum extends Panel
   {
      
      private var Number_text:MyTextField;
      
      private var Button_Sold:Button;
      
      private var Button_Cancel:Button;
      
      private var shape:Shape;
      
      private var sld_item:SoldItem;
      
      private var back:Sprite;
      
      private var vo:Vo_valuable;
      
      private var _upgrid_index:int;
      
      private var Max:int;
      
      public function View_longSoldNum()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         this.shape = ComponentUtil.getShape(Global.stage.stageWidth,Global.stage.stageHeight,0,0.2);
         addChildAt(this.shape,0);
         this.back = new Sprite();
         addChild(this.back);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.back,{
            "x":0,
            "y":0,
            "width":304,
            "height":210
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.back,{
            "x":24,
            "y":40,
            "width":256,
            "height":130
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this.back,{
            "x":130,
            "y":119,
            "width":80,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_Prompt",this.back,{
            "x":75,
            "y":6
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60207",6),this.back,{
            "x":65,
            "y":120,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getButton("","Button_Close",this,{
            "x":270,
            "y":6,
            "textColor":16184781,
            "callBack":function(e:MouseEvent):void
            {
               visible = false;
            }
         },Global.Img_Cdm);
         this.sld_item = new SoldItem();
         this.sld_item.x = 80;
         this.sld_item.y = 58;
         addChild(this.sld_item);
         this.Number_text = ComponentUtil.getTextField("1",this,{
            "x":140,
            "y":120,
            "color":16184781,
            "size":12,
            "leading":0,
            "realWidth":55
         });
         this.Number_text.align = TextFormatAlign.CENTER;
         this.Button_Sold = ComponentUtil.getButton(LangConfig.getWord("15",0),"Button_Four",this,{
            "x":60,
            "y":175,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_Cancel = ComponentUtil.getButton(LangConfig.getWord("5",0),"Button_Four",this,{
            "x":170,
            "y":175,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Number_text.type = TextFieldType.INPUT;
         this.Number_text.maxChars = 2;
         this.Number_text.restrict = ".0-9";
         this.Number_text.addEventListener(Event.CHANGE,this.changedHandle);
         this.Button_Sold.addEventListener(MouseEvent.CLICK,this.soldHandle);
         this.Button_Cancel.addEventListener(MouseEvent.CLICK,this.cancelHandle);
      }
      
      private function cancelHandle(e:MouseEvent) : void
      {
         this.visible = false;
         this.dispose();
      }
      
      private function changedHandle(e:Event) : void
      {
         var tf:MyTextField = e.target as MyTextField;
         if(int(tf.text) > this.Max)
         {
            tf.text = String(this.Max);
         }
         else if(int(tf.text) < 1)
         {
            tf.text = String(1);
         }
      }
      
      public function update(_vo:Vo_valuable, _index:int = 0) : void
      {
         this.vo = _vo;
         this.Max = this.vo.count;
         this.Number_text.text = String(this.Max);
         this.sld_item.update(_vo);
         this._upgrid_index = _index;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
      }
      
      public function soldHandle(e:MouseEvent) : void
      {
         UIManager.long_way_shop.update_sold_item(this.vo,int(this.Number_text.text),int(this.Number_text.text) * this.vo.price,this._upgrid_index);
         this.visible = false;
         this.dispose();
      }
      
      private function dispose() : void
      {
         this.Number_text.text = "1";
         this.sld_item.grid.vo = null;
      }
      
      override public function resetPosition() : void
      {
         var temX:int = 0;
         var temY:int = 0;
         this.shape.width = Global.stage.stageWidth;
         this.shape.height = Global.stage.stageHeight;
         this.back.x = (Global.stage.stageWidth - this.back.width) / 2;
         this.back.y = (Global.stage.stageHeight - this.back.height) / 2;
         temX = (Global.stage.stageWidth - this.back.width) / 2;
         temY = (Global.stage.stageHeight - this.back.height) / 2;
         this.sld_item.x = temX + 80;
         this.sld_item.y = temY + 58;
         this.Number_text.x = temX + 140;
         this.Number_text.y = temY + 120;
         this.Button_Sold.x = temX + 60;
         this.Button_Sold.y = temY + 175;
         this.Button_Cancel.x = temX + 170;
         this.Button_Cancel.y = temY + 175;
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.data.model.Model_shop;
import com.yiTian.data.vo.Vo_grid;
import com.yiTian.data.vo.Vo_valuable;
import com.yiTian.manager.LangConfig;
import com.yiTian.view.comp.View_Grid;
import flash.display.Sprite;

class SoldItem extends Sprite
{
   
   public var IconName_text:MyTextField;
   
   public var grid:View_Grid;
   
   public function SoldItem()
   {
      super();
      this.IconName_text = ComponentUtil.getTextField(LangConfig.getWord("11",0),this,{
         "x":44.05,
         "y":2.2
      });
      this.grid = new View_Grid();
      this.grid.set_bmp_bg();
      this.grid.set_bmp_over();
      this.grid.set_bmp_select();
      this.grid.x = 3;
      this.grid.y = 2;
      addChild(this.grid);
   }
   
   public function update(vo:Vo_grid) : void
   {
      this.grid.vo = vo;
      this.IconName_text.textColor = Model_shop.getColorArr[(vo as Vo_valuable).color - 1];
      this.IconName_text.htmlText = vo.str_name;
   }
}
