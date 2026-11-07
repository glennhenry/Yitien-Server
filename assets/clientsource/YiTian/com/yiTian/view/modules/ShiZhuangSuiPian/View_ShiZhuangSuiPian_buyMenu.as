package com.yiTian.view.modules.ShiZhuangSuiPian
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.net.message.cg.ShiZhuangSuiPianCGMessage;
   import com.yiTian.view.Panel;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   import flash.text.TextFormatAlign;
   
   public class View_ShiZhuangSuiPian_buyMenu extends Panel
   {
      
      private static var _instance:View_ShiZhuangSuiPian_buyMenu;
      
      private var closeBtn:Button;
      
      private var clothes:MyTextField;
      
      private var clothesID:int;
      
      private var buyCountTxt:MyTextField;
      
      private var buyTotalMoneyTxt:MyTextField;
      
      private var buyBtn:Button;
      
      private var cencleBtn:Button;
      
      public function View_ShiZhuangSuiPian_buyMenu()
      {
         super();
         this.Init();
      }
      
      public static function get instance() : View_ShiZhuangSuiPian_buyMenu
      {
         if(!_instance)
         {
            _instance = new View_ShiZhuangSuiPian_buyMenu();
         }
         return _instance;
      }
      
      private function Init() : void
      {
         move = new Rectangle(0,0,308,30);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":308,
            "height":215
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":260,
            "height":130
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":150,
            "y":126,
            "width":60,
            "height":24
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":150,
            "y":90,
            "width":60,
            "height":24
         },Global.Img_Cdm);
         ComponentUtil.getTextField("兑换数量：                  个",this,{
            "x":80,
            "y":92,
            "color":11523767,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("兑换总价：                  块",this,{
            "x":80,
            "y":129,
            "color":11523767,
            "size":12,
            "leading":0
         });
         ComponentUtil.getBitmap("Title_DuiHuan",this,{
            "x":74,
            "y":5
         },Global.SuiPian_Imgsdm);
         this.clothes = ComponentUtil.getTextField("",this,{
            "x":110,
            "y":55,
            "color":14566855,
            "size":14,
            "leading":0
         });
         this.buyCountTxt = ComponentUtil.getTextField("",this,{
            "x":150,
            "y":92,
            "color":13424242,
            "size":12,
            "leading":0,
            "realWidth":60
         });
         this.buyCountTxt.type = TextFieldType.INPUT;
         this.buyCountTxt.align = TextFormatAlign.CENTER;
         this.buyCountTxt.restrict = "0-9";
         this.buyCountTxt.maxChars = 3;
         this.buyCountTxt.addEventListener(Event.CHANGE,this.updatePiecesCount);
         this.buyTotalMoneyTxt = ComponentUtil.getTextField("",this,{
            "x":150,
            "y":129,
            "color":13424242,
            "size":12,
            "leading":0,
            "realWidth":60
         });
         this.buyTotalMoneyTxt.align = TextFormatAlign.CENTER;
         this.buyBtn = ComponentUtil.getButton("兑换","Button_Four",this,{
            "x":57,
            "y":178,
            "textColor":16184781
         },Global.Img_Cdm);
         this.buyBtn.callBack = function():void
         {
            ShiZhuangSuiPianCGMessage.Buy(Data_lib.ShiZhuangSuiPian[clothesID][0],Number(buyCountTxt.text));
         };
         this.cencleBtn = ComponentUtil.getButton("取消","Button_Four",this,{
            "x":180,
            "y":178,
            "textColor":16184781
         },Global.Img_Cdm);
         this.cencleBtn.callBack = function():void
         {
            visible = false;
         };
         this.closeBtn = ComponentUtil.getButton("","Button_Close",this,{
            "x":274,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.closeBtn.callBack = function():void
         {
            visible = false;
         };
      }
      
      private function updatePiecesCount(e:Event) : void
      {
         if(int(this.buyCountTxt.text) > 99)
         {
            this.buyCountTxt.text = "99";
         }
         else if(int(this.buyCountTxt.text) == 0 || this.buyCountTxt.text == "")
         {
            this.buyCountTxt.text = "1";
         }
         this.setTxt();
      }
      
      public function Show(id:int) : void
      {
         this.visible = true;
         this.clothesID = id + 1;
         this.format();
      }
      
      private function format() : void
      {
         var vo:Vo_equip = new Vo_equip();
         vo.id = Data_lib.ShiZhuangSuiPian[this.clothesID][0];
         vo.Init_lib();
         this.clothes.text = vo.str_name;
         this.buyCountTxt.text = "1";
         Global.focus = this.buyCountTxt;
         this.buyCountTxt.setSelection(0,1);
         this.setTxt();
      }
      
      private function setTxt() : void
      {
         this.buyTotalMoneyTxt.text = String(Number(this.buyCountTxt.text) * Number(Data_lib.ShiZhuangSuiPian[this.clothesID][1].split("_")[1]));
      }
      
      override public function resetPosition() : void
      {
         this.x = (Global.stage.stageWidth - this.width) / 2;
         this.y = (Global.stage.stageHeight - this.height) / 2;
      }
   }
}

