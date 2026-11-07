package com.yiTian.view.modules.kuafujingjichang
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.net.message.cg.KuaFuJingJiChangCGMessage;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFieldType;
   import flashx.textLayout.formats.TextAlign;
   
   public class XiaYiItem extends Sprite
   {
      
      public static var grid:View_Grid;
      
      public static var input_num:int = 1;
      
      public var back:Bitmap;
      
      public var props:MyTextField;
      
      public var integral:MyTextField;
      
      public var num:MyTextField;
      
      public var upBtn:Button;
      
      public var downBtn:Button;
      
      public var exchangeBtn:Button;
      
      public var needTitle:MyTextField;
      
      public var id:int;
      
      public function XiaYiItem()
      {
         super();
         this.back = ComponentUtil.getBitmap("Item_Back",this,{
            "x":0,
            "y":0
         },Global.LeiTai_Imgsdm);
         this.props = ComponentUtil.getTextField("道具中文名称",this,{
            "x":74,
            "y":2,
            "color":3394815,
            "size":14,
            "leading":0,
            "realWidth":100
         });
         this.props.align = TextAlign.CENTER;
         ComponentUtil.getBitmap("grid_ShangCheng",this,{
            "x":12,
            "y":37
         },Global.Img_Cdm);
         ComponentUtil.getTextField("售价：",this,{
            "x":87,
            "y":41,
            "color":14662240,
            "size":14,
            "leading":0
         });
         ComponentUtil.getScaleBitmap("Text_Back",[6,6,4,4],this,{
            "x":123,
            "y":40,
            "width":70,
            "height":24
         },Global.Img_Cdm);
         this.integral = ComponentUtil.getTextField("000000",this,{
            "x":128,
            "y":43,
            "color":16383744,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("侠义值",this,{
            "x":191,
            "y":42,
            "color":14662240,
            "size":14,
            "leading":0
         });
         ComponentUtil.getScaleBitmap("Text_Back",[6,6,4,4],this,{
            "x":91,
            "y":81,
            "width":60,
            "height":25
         },Global.Img_Cdm);
         this.num = ComponentUtil.getTextField("1",this,{
            "x":94,
            "y":84,
            "color":16383744,
            "size":12,
            "leading":0,
            "realWidth":30,
            "realHeight":20
         });
         this.num.align = TextAlign.CENTER;
         this.num.type = TextFieldType.INPUT;
         this.num.maxChars = 3;
         this.num.restrict = "0-9";
         this.num.addEventListener(Event.CHANGE,this.changedHandle);
         this.upBtn = ComponentUtil.getButton("","Button_NumUp",this,{
            "x":130,
            "y":84,
            "textColor":16184781
         },Global.Img_Cdm);
         this.downBtn = ComponentUtil.getButton("","Button_NumDown",this,{
            "x":130,
            "y":93,
            "textColor":16184781
         },Global.Img_Cdm);
         this.exchangeBtn = ComponentUtil.getButton("兑换","Button_Change",this,{
            "x":161,
            "y":78,
            "textColor":16184781
         },Global.LeiTai_Imgsdm);
         this.needTitle = ComponentUtil.getTextField("需要获得称号中文中文",this,{
            "x":87,
            "y":61,
            "color":10027008,
            "size":14,
            "leading":0
         });
         grid = new View_Grid(true);
         grid.type = Enum_type_grid.SHOP;
         grid.set_bmp_over(true,null);
         grid.set_bmp_select();
         addChild(grid);
         grid.y = 38;
         grid.x = 13;
         this.upBtn.addEventListener(MouseEvent.CLICK,this.upClick);
         this.downBtn.addEventListener(MouseEvent.CLICK,this.downClick);
         this.exchangeBtn.addEventListener(MouseEvent.CLICK,this.exchangeBtnClick);
      }
      
      private function upClick(e:MouseEvent) : void
      {
         if(int(this.num.text) < 99)
         {
            this.num.text = (int(this.num.text) + 1).toString();
         }
         if(int(this.num.text) * int(this.integral.text) > KuaFuJJCVO.wuxiazhi)
         {
            this.num.text = int(KuaFuJJCVO.wuxiazhi / int(this.integral.text)).toString();
         }
         if(this.num.text == "0")
         {
            this.num.text = "1";
         }
      }
      
      private function downClick(e:MouseEvent) : void
      {
         if(int(this.num.text) > 0)
         {
            this.num.text = (int(this.num.text) - 1).toString();
         }
         if(this.num.text == "0")
         {
            this.num.text = "1";
         }
      }
      
      private function changedHandle(e:Event) : void
      {
         this.num = e.target as MyTextField;
         if(int(this.num.text) <= 0)
         {
            this.num.text = "1";
         }
         else if(int(this.num.text) > 99)
         {
            this.num.text = "99";
         }
         if(int(this.num.text) * int(this.integral.text) > KuaFuJJCVO.wuxiazhi)
         {
            this.num.text = int(KuaFuJJCVO.wuxiazhi / int(this.integral.text)).toString();
         }
         if(this.num.text == "0")
         {
            this.num.text = "1";
         }
         this.num.setSelection(this.num.text.length,this.num.text.length);
         input_num = int(this.num.text);
      }
      
      private function exchangeBtnClick(e:MouseEvent) : void
      {
         KuaFuJingJiChangCGMessage.CG_SHOP_XIAYI(this.id,int(this.num.text));
      }
   }
}

