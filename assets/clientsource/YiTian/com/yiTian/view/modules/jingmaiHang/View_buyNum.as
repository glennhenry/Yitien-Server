package com.yiTian.view.modules.jingmaiHang
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.yiTian.Global;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.MartCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class View_buyNum extends Panel
   {
      
      private var mm_txt:MyTextField;
      
      private var Button_OK:Button;
      
      private var Button_Cancel:Button;
      
      private var Number_Price_text:MyTextField;
      
      private var Number_Buy_text:MyTextField;
      
      private var yinliang:MyTextField;
      
      private var buy_num:int;
      
      private var mart_id:Number;
      
      private var price:int;
      
      private var price_type:int;
      
      private var totalPrice:int;
      
      public function View_buyNum()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
      }
      
      private function cancelHandle(e:MouseEvent) : void
      {
         this.visible = false;
      }
      
      private function sureHandle(e:MouseEvent) : void
      {
         var tem_num:int = int(this.Number_Buy_text.text);
         if(this.price_type == 1)
         {
            if(GameUnitManager.hero.silver < tem_num * this.price)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("8",0));
               return;
            }
         }
         else if(this.price_type == 2)
         {
            if(GameUnitManager.hero.money < tem_num * this.price)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("139",0));
               return;
            }
         }
         MartCGMessage.CG_BUY(this.mart_id,tem_num,UIManager.JMH_panel._mart_sold_buy._curPage);
         this.visible = false;
      }
      
      private function chaHandle(e:Event) : void
      {
         var tf:MyTextField = e.target as MyTextField;
         if(int(tf.text) > this.buy_num)
         {
            tf.text = String(this.buy_num);
         }
         else if(int(tf.text) < 1)
         {
            tf.text = "1";
         }
         this.getCost(this.price,int(tf.text));
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(!value)
         {
            this.reset();
         }
      }
      
      private function reset() : void
      {
         this.buy_num = 1;
         this.price = 1;
         this.mart_id = 0;
         this.price_type = 0;
      }
      
      public function update(tem_num:int, _martId:Number, good_price:int, _costType:int) : void
      {
         this.buy_num = tem_num;
         this.mart_id = _martId;
         this.price = good_price;
         this.price_type = _costType;
         this.Number_Buy_text.text = String(this.buy_num);
         var temStr:String = this.price_type == 1 ? LangConfig.getWord("124",0) : LangConfig.getWord("21",0);
         this.getCost(this.price,this.buy_num);
         this.yinliang.htmlText = HtmlUtil.font(temStr,"#afe4e4");
      }
      
      private function getCost(pric:int, num:int) : void
      {
         this.Number_Price_text.htmlText = HtmlUtil.font(Utils.getGapNum(String(pric * num)),"#f9ff00");
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

