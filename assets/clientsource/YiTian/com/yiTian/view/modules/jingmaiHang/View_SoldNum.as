package com.yiTian.view.modules.jingmaiHang
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.model.Model_mart;
   import com.yiTian.data.vo.Vo_grid;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.MartCGMessage;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class View_SoldNum extends Panel
   {
      
      private var grid:View_Grid;
      
      private var okBtn:Button;
      
      private var cancelBtn:Button;
      
      private var tf:MyTextField;
      
      private var tfSoldWp:MyTextField;
      
      private var tfSoldNum:MyTextField;
      
      private var back:DisplayObject;
      
      private var _max:int;
      
      private var _martId:Number = 0;
      
      private var _vec:Vector.<Vo_valuable>;
      
      private var _vo:Vo_grid;
      
      private var isGetFood:Boolean = false;
      
      private var gridId:int;
      
      public function View_SoldNum()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
      }
      
      private function cliHandle(e:MouseEvent) : void
      {
         this.setGrey(true);
      }
      
      private function changeHandle(e:Event) : void
      {
         var t_f:MyTextField = e.target as MyTextField;
         if(int(t_f.text) > this._max)
         {
            t_f.text = String(this._max);
         }
         if(int(this.tf.text) > Model_mart.max)
         {
            t_f.text = String(Model_mart.max);
         }
         if(int(this.tf.text) > 99)
         {
            t_f.text = String(99);
         }
         if(int(this.tf.text) < 1)
         {
            this.tf.text = "1";
         }
      }
      
      private function okHandle(e:MouseEvent) : void
      {
         if(this.isGetFood)
         {
            MartCGMessage.CG_SOLD(this._martId,int(this.tf.text),this.gridId,UIManager.JMH_panel._mart_sold_buy._curPage);
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("391",0));
         }
      }
      
      private function cancelHandle(e:MouseEvent) : void
      {
         this.visible = false;
      }
      
      public function updata(maxNum:int, vo:Vo_grid, martId:Number, vec:Vector.<Vo_valuable>) : void
      {
         this._vec = vec;
         this._max = maxNum;
         this._martId = martId;
         this.grid.vo = vo;
         this.setGrey(true);
         this._vo = vo;
         this.tf.text = "1";
      }
      
      public function setGrey(value:Boolean) : void
      {
         this.grid.set_grey(value);
         if(value)
         {
            this.isGetFood = false;
         }
         else
         {
            this.isGetFood = true;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.tfSoldWp.text = LangConfig.getWord("386",0);
            this.tfSoldNum.text = LangConfig.getWord("387",0);
            UIManager.bagPanel.visible = true;
         }
      }
      
      private function upHandle(e:MouseEvent) : void
      {
         var dragGrid:View_Grid = null;
         var upGrid:View_Grid = e.target as View_Grid;
         if(UIManager.isDrag)
         {
            dragGrid = UIManager.dragObj.grid;
            if(dragGrid.type == Enum_type_grid.BAG)
            {
               this.add_mart_goods(dragGrid);
            }
         }
      }
      
      public function add_mart_goods(_grid:View_Grid) : void
      {
         var temp:Vo_valuable = null;
         if(_grid.vo is Vo_valuable)
         {
            temp = _grid.vo as Vo_valuable;
         }
         if(temp.bBind || temp.id != this._vo.id)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("392",0));
            return;
         }
         this.grid.vo = temp;
         this.tf.text = temp.count > this._max ? String(this._max) : String(temp.count);
         this._max = temp.count;
         if(int(this.tf.text) < 1)
         {
            this.tf.text = "1";
            this._max = 1;
         }
         this.setGrey(false);
         this.gridId = this.grid.vo.gridId;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2 - 270;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

