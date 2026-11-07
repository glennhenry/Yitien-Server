package com.yiTian.view.modules.vip
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.VIPCGMessage;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.pet.NeiDanPanel;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFormatAlign;
   
   public class OpenVipItem extends Sprite
   {
      
      private var txtName:MyTextField;
      
      private var txtPrice:MyTextField;
      
      private var txtNums:MyTextField;
      
      private var btnPlus:Button;
      
      private var btnMinus:Button;
      
      private var btnBuy:Button;
      
      private var grid:View_Grid;
      
      private var _id:int;
      
      private var _price:int;
      
      public var type:int;
      
      private var enterNumber:int = 1;
      
      public function OpenVipItem(strName:String, price:int, id:int)
      {
         super();
         this._id = id;
         this._price = price;
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":0,
            "y":0,
            "width":140,
            "height":190
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":41,
            "y":127,
            "width":56,
            "height":21
         },Global.Img_Cdm);
         this.txtName = ComponentUtil.getTextField("",this,{
            "x":37,
            "y":6,
            "color":16711935,
            "leading":0
         });
         this.txtName.realWidth = 67;
         this.txtName.align = TextFormatAlign.CENTER;
         this.txtName.htmlText = strName;
         this.txtPrice = ComponentUtil.getTextField("",this,{
            "x":21,
            "y":102,
            "color":16773818,
            "size":12,
            "leading":0
         });
         this.txtPrice.realWidth = 96;
         this.txtPrice.align = TextFormatAlign.CENTER;
         this.txtPrice.htmlText = LangConfig.getWord("10415",1,price);
         this.txtNums = ComponentUtil.getTextField("0000",this,{
            "x":49,
            "y":128,
            "color":14013822,
            "size":12,
            "leading":0
         });
         this.txtNums.realWidth = 38;
         this.txtNums.align = TextFormatAlign.CENTER;
         this.txtNums.text = "1";
         this.btnMinus = ComponentUtil.getButton("","Button_NumberDown",this,{
            "x":19,
            "y":128,
            "textColor":16184781,
            "name":"Minus"
         },Global.Img_Cdm);
         this.btnPlus = ComponentUtil.getButton("","Button_NumberUp",this,{
            "x":99,
            "y":128,
            "textColor":16184781,
            "name":"Plus"
         },Global.Img_Cdm);
         this.btnMinus.addEventListener(MouseEvent.CLICK,this.chanNumHandle);
         this.btnPlus.addEventListener(MouseEvent.CLICK,this.chanNumHandle);
         this.btnBuy = ComponentUtil.getButton(LangConfig.getWord("10416",1),"Button_Five",this,{
            "x":24,
            "y":155,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btnBuy.addEventListener(MouseEvent.CLICK,this.buyHandler);
      }
      
      protected function buyHandler(e:MouseEvent) : void
      {
         var newItem:Vo_item = null;
         var oldItem:Vo_item = null;
         var vip:int = GameUnitManager.hero.vip;
         if(this.enterNumber * this._price > GameUnitManager.hero.money)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10044",1));
         }
         else if(vip > 0)
         {
            if(vip == UIManager.openVipPanel.vecId.indexOf(this._id) + 1)
            {
               VIPCGMessage.CG_BUY_VIP(this.type,this.enterNumber);
            }
            else
            {
               oldItem = new Vo_item();
               oldItem.id = UIManager.openVipPanel.vecId[vip - 1];
               oldItem.Init_lib();
               newItem = this.grid.vo as Vo_item;
               View_Alert.show(LangConfig.getWord("10417",1,NeiDanPanel.getColor(newItem.lv + 1),newItem.str_name,NeiDanPanel.getColor(oldItem.lv + 1),oldItem.str_name),View_Alert.OK_CANCAL,this.okCallBack);
            }
         }
         else
         {
            VIPCGMessage.CG_BUY_VIP(this.type,this.enterNumber);
         }
      }
      
      private function okCallBack() : void
      {
         VIPCGMessage.CG_BUY_VIP(this.type,this.enterNumber);
      }
      
      protected function chanNumHandle(e:MouseEvent = null) : void
      {
         this.enterNumber = int(this.txtNums.text);
         if(e.target.name == "Plus")
         {
            ++this.enterNumber;
         }
         else if(e.target.name == "Minus")
         {
            --this.enterNumber;
            if(this.enterNumber <= 1)
            {
               this.enterNumber = 1;
            }
         }
         this.txtNums.text = String(this.enterNumber);
      }
      
      public function init() : void
      {
         var vo:Vo_item = null;
         if(!this.grid)
         {
            this.grid = new View_Grid(true);
            this.grid.set_bmp_bg("resource/image/iconBg/bg65.png");
            this.grid.set_bmp_select();
            this.grid.set_bmp_over(true,"resource/image/iconBg/grid_ShangCheng_over.png");
            this.grid.set_tf_count(false,false,false);
            this.grid.x = 37;
            this.grid.y = 30;
            addChild(this.grid);
            vo = new Vo_item();
            vo.id = this._id;
            vo.Init_lib();
            vo.bgIndex = this._id;
            vo.bgIndex = vo.lv + 1;
            this.grid.vo = vo;
         }
      }
   }
}

