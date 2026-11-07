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
   
   public class Child_BuyItem extends Sprite
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
      
      public function Child_BuyItem()
      {
         var shape:Shape;
         super();
         ComponentUtil.getBitmap("Back_Item",this,{
            "x":0,
            "y":0
         },Global.WuYue_Imgsdm);
         this.txtName = ComponentUtil.getTextField("道具中文名称",this,{
            "x":10,
            "y":3,
            "color":16744192,
            "size":12,
            "leading":0,
            "align":TextAlign.CENTER,
            "realWidth":200
         });
         ComponentUtil.getTextField("原价：",this,{
            "x":89,
            "y":41,
            "color":13424242,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("售价：",this,{
            "x":89,
            "y":62,
            "color":13424242,
            "size":12,
            "leading":0
         });
         this.txtOldPrice = ComponentUtil.getTextField("00000元宝",this,{
            "x":127,
            "y":41,
            "color":16383744,
            "size":12,
            "leading":0
         });
         this.txtNowPrice = ComponentUtil.getTextField("00000元宝",this,{
            "x":127,
            "y":62,
            "color":16383744,
            "size":12,
            "leading":0
         });
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":89,
            "y":87,
            "width":46,
            "height":26
         },Global.Img_Cdm);
         this.txtInput = ComponentUtil.getTextField("0",this,{
            "x":88,
            "y":91,
            "color":13424242,
            "size":12,
            "leading":0,
            "align":TextAlign.CENTER,
            "maxChars":3,
            "type":TextFieldType.INPUT,
            "realWidth":34,
            "realHeight":18
         });
         this.btnUp = ComponentUtil.getButton("","Button_Nup",this,{
            "x":114,
            "y":89,
            "textColor":16184781,
            "name":"up"
         },Global.WuYue_Imgsdm);
         this.btnDown = ComponentUtil.getButton("","Button_Ndown",this,{
            "x":114,
            "y":100,
            "textColor":16184781,
            "name":"down"
         },Global.WuYue_Imgsdm);
         this.btnBuy = ComponentUtil.getButton("购买","Button_Buy",this,{
            "x":139,
            "y":86,
            "textColor":16184781
         },Global.WuYue_Imgsdm);
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
            "x":12,
            "y":42
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

