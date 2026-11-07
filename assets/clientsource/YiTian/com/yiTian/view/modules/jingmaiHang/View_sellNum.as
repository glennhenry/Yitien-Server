package com.yiTian.view.modules.jingmaiHang
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.yiTian.Global;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.MartCGMessage;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class View_sellNum extends Panel
   {
      
      public var _grid:View_Grid;
      
      private var Button_OK:Button;
      
      private var Button_Cancel:Button;
      
      public var Sold_Number_text:MyTextField;
      
      private var max_num:int;
      
      private var mart_id:Number = 0;
      
      private var price_eve:int;
      
      private var pri_type:int;
      
      public function View_sellNum()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
      }
      
      private function changeHandle(e:Event) : void
      {
         var tf:MyTextField = e.target as MyTextField;
         if(int(tf.text) > this.max_num)
         {
            tf.text = String(this.max_num);
         }
         else if(int(tf.text) < 1)
         {
            tf.text = "1";
         }
      }
      
      public function update(_gri:View_Grid, _num:int, _mart_id:Number, _price:int, _pri_type:int) : void
      {
         this._grid.vo = _gri.vo;
         this.max_num = _num;
         this.mart_id = _mart_id;
         this.price_eve = _price;
         this.pri_type = _pri_type;
         this.Sold_Number_text.text = String(this.max_num);
      }
      
      private function OKHandle(e:MouseEvent) : void
      {
         var tem_num:int = 0;
         tem_num = int(this.Sold_Number_text.text);
         if(this.pri_type == 1)
         {
            if(GameUnitManager.hero.silver < tem_num * this.price_eve)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("8",0));
               return;
            }
         }
         else if(this.pri_type == 2)
         {
            if(GameUnitManager.hero.money < tem_num * this.price_eve)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("139",0));
               return;
            }
         }
         visible = false;
         MartCGMessage.CG_BUY(this.mart_id,tem_num,UIManager.JMH_panel._mart_sold_buy._curPage);
      }
      
      private function cloHandle(e:MouseEvent) : void
      {
         this.dispose();
      }
      
      public function dispose() : void
      {
         visible = false;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

