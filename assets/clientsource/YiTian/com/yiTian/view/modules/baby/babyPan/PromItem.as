package com.yiTian.view.modules.baby.babyPan
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BabyCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.baby.babyManager.Model_baby;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   
   public class PromItem extends Sprite
   {
      
      private var icon:Bitmap = new Bitmap();
      
      private var prom_type:int;
      
      private var btn:Button;
      
      private var tfName:MyTextField;
      
      private var grid:View_Grid;
      
      private var vo:Vo_item;
      
      private var iconLf:Bitmap = new Bitmap();
      
      private var tt:MyTextField;
      
      public function PromItem(__type:int = -1)
      {
         super();
         this.prom_type = __type;
         addChild(this.icon);
         this.icon.alpha = 0;
         this.icon.x = 13;
      }
      
      public function init(id:uint) : void
      {
         this.btn = ComponentUtil.getButton("","Button_ZNSJ",this,{
            "y":-2,
            "x":178
         },Global.ZNdm);
         if(this.prom_type != -1)
         {
            this.iconLf.bitmapData = ComponentUtil.getBitmapData("Iocn_CiShu",Global.ZNdm);
            this.btn.addChild(this.iconLf);
            this.tt = ComponentUtil.getTextField("",this.btn,{
               "x":7.3,
               "y":-1,
               "color":16383744
            },TextFieldAutoSize.CENTER);
         }
         this.vo = new Vo_item();
         this.vo.id = id;
         this.vo.Init_lib();
         this.grid = new View_Grid();
         this.grid.set_bmp_bg();
         this.grid.set_bmp_over(true,null);
         addChild(this.grid);
         this.grid.vo = this.vo;
         ComponentUtil.setPropertie(this.grid,{
            "x":26,
            "y":3
         });
         this.tfName = ComponentUtil.getTextField("",this,{
            "x":this.grid.x + 45,
            "y":11
         });
         this.tfName.htmlText = HtmlUtil.font(this.vo.str_name + " X " + CommandManager.get_bag_count(id),Model_shop.get_color_arr[this.vo.color - 1]);
         this.icon.bitmapData = ComponentUtil.getBitmapData("Pet_DYSelect");
         addEventListener(MouseEvent.ROLL_OVER,this.over);
         addEventListener(MouseEvent.ROLL_OUT,this.out);
         this.btn.addEventListener(MouseEvent.CLICK,this.btnClick);
         Global.control.registerCallBack(Enum_MsgType.BAG_UPDATE,this.update);
      }
      
      private function btnClick(e:MouseEvent) : void
      {
         if(CommandManager.get_bag_count(this.vo.id) <= 0)
         {
            UIManager.centerBroadcast.addMsg("背包内没有所需的" + this.vo.str_name,1);
            return;
         }
         if(this.prom_type == -1)
         {
            if(Model_baby.baby_meiLi_lvl == Data_lib.meiLiValue.getLength())
            {
               UIManager.centerBroadcast.addMsg("魅力度已达最高值，无法喂养");
               return;
            }
            BabyCGMessage.CG_USE_MEILI_BOTTLE();
         }
         else
         {
            if(Model_baby.leftTimes <= 0)
            {
               UIManager.centerBroadcast.addMsg("今日培养次数已满",1);
               return;
            }
            if(Child_babyPY.nowCheck.isFull_lvl)
            {
               UIManager.centerBroadcast.addMsg("该属性已满级",1);
               return;
            }
            Model_baby.baba_type_choose = Child_babyPY.nowCheck.type + 1;
            BabyCGMessage.CG_BABY_PEIYANG_ISFIRST(this.tabIndex);
         }
      }
      
      public function updateLeftTimes() : void
      {
         this.tt.htmlText = Model_baby.leftTimes.toString();
      }
      
      private function over(e:MouseEvent) : void
      {
         this.icon.alpha = 1;
      }
      
      private function out(e:MouseEvent) : void
      {
         this.icon.alpha = 0;
      }
      
      private function update() : void
      {
         this.tfName.htmlText = HtmlUtil.font(this.vo.str_name + " X " + CommandManager.get_bag_count(this.vo.id),Model_shop.get_color_arr[this.vo.color - 1]);
      }
   }
}

