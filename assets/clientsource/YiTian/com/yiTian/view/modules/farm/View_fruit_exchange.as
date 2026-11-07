package com.yiTian.view.modules.farm
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_fruit_exchange extends Panel
   {
      
      private var letIn_Button:Button;
      
      private var fruit_Button:Button;
      
      private var bought_item:BoughtItem;
      
      private var fruitId:uint;
      
      private var fruitNum:uint;
      
      private var IconName_text:MyTextField;
      
      private var introduceText:MyTextField;
      
      private var isFirstOpen:Boolean = true;
      
      public function View_fruit_exchange()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":307,
            "height":180
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":259,
            "height":130
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":31,
            "y":112,
            "width":245,
            "height":50
         },Global.Img_Cdm);
         this.introduceText = ComponentUtil.getTextField("",this,{
            "x":43,
            "y":118,
            "color":11904647,
            "size":12,
            "leading":4
         });
         this.introduceText.multiline = true;
         this.introduceText.htmlText = LangConfig.getWord("75",9);
         move = new Rectangle(0,0,246,38);
         this.letIn_Button = ComponentUtil.getButton(LangConfig.getWord("76",9),"Button_Four",this,{
            "x":154,
            "y":53,
            "textColor":16773818
         },Global.Img_Cdm);
         this.fruit_Button = ComponentUtil.getButton(LangConfig.getWord("63",9),"Button_Four",this,{
            "x":154,
            "y":79,
            "textColor":16773818
         },Global.Img_Cdm);
         this.IconName_text = ComponentUtil.getTextField("",this,{
            "x":42.2,
            "y":2.2
         });
         ComponentUtil.getButton("","Button_Close",this,{
            "x":273,
            "y":6,
            "textColor":16184781,
            "callBack":function(e:MouseEvent):void
            {
               visible = false;
            }
         },Global.Img_Cdm);
         this.bought_item = new BoughtItem();
         this.bought_item.x = 83;
         this.bought_item.y = 57;
         addChild(this.bought_item);
         this.bought_item.grid.doubleClickEnabled = true;
         this.letIn_Button.addEventListener(MouseEvent.CLICK,this.letInClickHandle);
         this.fruit_Button.addEventListener(MouseEvent.CLICK,this.fruitClickHandle);
         this.bought_item.grid.addEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandle);
         this.bought_item.grid.addEventListener(MouseEvent.DOUBLE_CLICK,this.doubleClickHandle);
      }
      
      private function fruitClickHandle(evt:MouseEvent) : void
      {
         if(Boolean(this.bought_item.grid.vo))
         {
            this.bought_item.grid.vo = null;
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("77",9));
         }
      }
      
      private function letInClickHandle(evt:MouseEvent) : void
      {
      }
      
      private function doubleClickHandle(event:MouseEvent) : void
      {
         var fruitGrid:View_Grid = event.target as View_Grid;
         fruitGrid.vo = null;
      }
      
      public function update(num:uint, id:uint) : void
      {
         var item:Vo_item = null;
         this.fruitNum = num;
         this.fruitId = id;
         if(Boolean(this.fruitId))
         {
            this.bought_item.grid.vo = null;
            item = new Vo_item();
            item.id = this.fruitId;
            item.count = this.fruitNum;
            item.Init_lib();
            this.bought_item.grid.vo = item;
         }
      }
      
      private function mouseUpHandle(evt:MouseEvent) : void
      {
         var dragGrid:View_Grid = null;
         var upGrid:View_Grid = evt.target as View_Grid;
         if(UIManager.isDrag)
         {
            dragGrid = UIManager.dragObj.grid;
            if(dragGrid.type == Enum_type_grid.BAG)
            {
               if(Boolean(dragGrid.vo as Vo_item) && ((dragGrid.vo as Vo_item).type == 360 || (dragGrid.vo as Vo_item).type == 150))
               {
                  upGrid.vo = dragGrid.vo;
                  this.fruitNum = upGrid.vo.count;
                  this.fruitId = upGrid.vo.id;
               }
            }
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.bought_item.grid.vo = null;
            if(this.isFirstOpen)
            {
               this.isFirstOpen = false;
               this.showBmp();
            }
         }
      }
      
      private function showBmp() : void
      {
         ComponentUtil.getBitmap("BT_GSDuiHuan",this,{
            "x":74,
            "y":5
         },Global.ShanZhuang_Imgsdm);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

import com.yiTian.view.comp.View_Grid;
import flash.display.Sprite;

class BoughtItem extends Sprite
{
   
   public var grid:View_Grid;
   
   public function BoughtItem()
   {
      super();
      this.grid = new View_Grid();
      this.grid.set_bmp_bg();
      this.grid.set_bmp_over();
      this.grid.set_bmp_select();
      this.grid.set_tf_count();
      this.grid.set_tf_info("");
      this.grid.x = 3;
      this.grid.y = 2;
      this.grid.type = 360;
      addChild(this.grid);
   }
}
