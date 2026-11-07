package com.yiTian.view.modules.activityGuide
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.vo.Vo_store;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.DailyActCGMessage;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFieldType;
   import flashx.textLayout.formats.TextAlign;
   
   public class Child_MoreBuyItem extends Sprite
   {
      
      private var txtName:MyTextField;
      
      private var txtOldPrice:MyTextField;
      
      private var txtNowPrice:MyTextField;
      
      private var txtInput:MyTextField;
      
      private var grid:View_Grid;
      
      private var btnUp:Button;
      
      private var btnDown:Button;
      
      private var btnBuy:Button;
      
      private var id:int;
      
      private var sign:int;
      
      private var price:int;
      
      public function Child_MoreBuyItem()
      {
         var shape:Shape;
         super();
         ComponentUtil.getBitmap("Back_ZKLB",this,{
            "x":0,
            "y":0
         },Global.WuYue_Imgsdm);
         this.btnBuy = ComponentUtil.getButton("","Button_Buy",this,{
            "x":55,
            "y":144,
            "textColor":16771436
         },Global.WuYue_Imgsdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":5,
            "y":145,
            "width":48,
            "height":24
         },Global.Img_Cdm);
         ComponentUtil.getTextField("购买",this,{
            "x":67,
            "y":148,
            "color":16777036,
            "size":12,
            "leading":0
         });
         this.txtInput = ComponentUtil.getTextField("1",this,{
            "x":1,
            "y":147,
            "color":16772287,
            "size":12,
            "leading":0,
            "align":TextAlign.CENTER,
            "maxChars":3,
            "type":TextFieldType.INPUT,
            "realWidth":34,
            "realHeight":18
         });
         this.btnDown = ComponentUtil.getButton("","Button_Ndown",this,{
            "x":33,
            "y":157,
            "textColor":16771436,
            "name":"down"
         },Global.WuYue_Imgsdm);
         this.btnUp = ComponentUtil.getButton("","Button_Nup",this,{
            "x":33,
            "y":146,
            "textColor":16771436,
            "name":"up"
         },Global.WuYue_Imgsdm);
         this.txtName = ComponentUtil.getTextField("礼包中文名称",this,{
            "x":1,
            "y":3,
            "color":16742144,
            "size":12,
            "leading":0,
            "align":TextAlign.CENTER,
            "realWidth":106
         });
         ComponentUtil.getTextField("原价：",this,{
            "x":9,
            "y":104,
            "color":13225871,
            "size":12,
            "leading":3
         });
         ComponentUtil.getTextField("售价：",this,{
            "x":9,
            "y":123,
            "color":13225871,
            "size":12,
            "leading":3
         });
         this.txtOldPrice = ComponentUtil.getTextField("1258元宝",this,{
            "x":43,
            "y":105,
            "color":16776960,
            "size":12,
            "leading":3
         });
         this.txtNowPrice = ComponentUtil.getTextField("888 元宝",this,{
            "x":43,
            "y":124,
            "color":16776960,
            "size":12,
            "leading":3
         });
         shape = new Shape();
         this.addChild(shape);
         shape.graphics.clear();
         shape.graphics.lineStyle(2,16711680,1);
         shape.graphics.moveTo(this.txtOldPrice.x,this.txtOldPrice.y + this.txtOldPrice.height / 2 - 6);
         shape.graphics.lineTo(this.txtOldPrice.x + this.txtOldPrice.width,this.txtOldPrice.y + this.txtOldPrice.height / 2 + 8);
         this.txtInput.addEventListener(Event.CHANGE,this.changedHandle);
         this.btnUp.callBack = this.btnDown.callBack = this.btnChangeHd;
         this.btnBuy.callBack = this.buyHd;
         this.grid = new View_Grid(true);
         this.grid.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
         this.grid.set_bmp_over(true,View_Grid.GRID_BIGGEST_OVER);
         this.grid.set_bmp_select(View_Grid.GRID_BIGGEST_DOWN);
         this.grid.type = Enum_type_grid.STORE;
         this.grid.mouseEnabled = true;
         this.grid.buttonMode = true;
         ComponentUtil.setPropertie(this.grid,{
            "x":20,
            "y":32
         });
         addChild(this.grid);
         addEventListener(MouseEvent.MOUSE_OVER,function(e:MouseEvent):void
         {
            filters = Util.glowFFff00;
         });
         addEventListener(MouseEvent.MOUSE_OUT,function(e:MouseEvent):void
         {
            filters = [];
         });
      }
      
      private function changedHandle(e:Event) : void
      {
         var tf:MyTextField = e.target as MyTextField;
         var num:int = int(tf.text);
         num = num > 99 ? 99 : num;
         num = num < 1 ? 1 : num;
         tf.text = num.toString();
      }
      
      private function btnChangeHd(e:MouseEvent) : void
      {
         var _counts:int = int(this.txtInput.text);
         switch(e.target.name)
         {
            case "up":
               _counts++;
               _counts = _counts > 99 ? 99 : _counts;
               break;
            case "down":
               _counts--;
               _counts = _counts < 1 ? 1 : _counts;
         }
         this.txtInput.text = _counts.toString();
      }
      
      public function update(vo:Vo_store, _type:int) : void
      {
         this.id = vo.wpid;
         this.sign = vo.sign;
         this.price = vo.now_price;
         this.txtName.htmlText = vo.str_name;
         this.txtOldPrice.htmlText = vo.pre_price + " 元宝";
         this.txtNowPrice.htmlText = vo.now_price + " 元宝";
         this.txtInput.text = "1";
         this.grid.vo = vo.vo_value;
      }
      
      private function buyHd(e:MouseEvent) : void
      {
         if(int(this.txtInput.text) * this.price > GameUnitManager.hero.money)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("9",0) + "</font></a>");
            return;
         }
         DailyActCGMessage.CG_ACTIVITY_BUY(this.id,int(this.txtInput.text));
      }
   }
}

