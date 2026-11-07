package com.yiTian.view.modules.vipBGift
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_vipBGift;
   import com.yiTian.data.model.Model_vipBGift;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.net.message.cg.VipBGiftCGMessage;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flashx.textLayout.formats.TextAlign;
   
   public class QiTianLB extends Sprite
   {
      
      private var _index:int;
      
      private var getButton:Button;
      
      private var getButtonLabel:MyTextField;
      
      private var gird:View_Grid;
      
      public function QiTianLB()
      {
         super();
         this.initUI();
      }
      
      private function initUI() : void
      {
         ComponentUtil.getBitmap("Frame_HGLB",this,{
            "x":0,
            "y":0
         },Global.WHHGdm);
         ComponentUtil.getBitmap("grid_ShangCheng",this,{
            "x":24,
            "y":33
         },Global.Img_Cdm);
         this.getButton = ComponentUtil.getButton("","Button_TwoBule91",this,{
            "x":13,
            "y":105,
            "textColor":16771436,
            "callBack":this.onClick
         },Global.Img_Cdm);
         this.getButtonLabel = ComponentUtil.getTextField("领取",this,{
            "x":22,
            "y":108,
            "color":16184781,
            "realWidth":70,
            "size":12,
            "leading":0,
            "align":TextAlign.CENTER
         });
         this.gird = new View_Grid(true);
         this.gird.set_bmp_over(true,"");
         ComponentUtil.setPropertie(this.gird,{
            "x":26,
            "y":35
         });
         this.addChild(this.gird);
      }
      
      private function onClick(evt:MouseEvent) : void
      {
         Model_vipBGift.curIndex = this.index;
         VipBGiftCGMessage.CG_VIPBG_GETGIFT(this.index);
      }
      
      public function toolFly() : void
      {
         if(Boolean(this.gird))
         {
            Tween.gridToBagBezierFuncDef(this.gird);
         }
      }
      
      public function setdata(state:int) : void
      {
         this.getButton.enabled = state == Enum_vipBGift.STATE_CAN;
         this.getButtonLabel.text = Enum_vipBGift.getButtonLabel(state,Model_vipBGift.curDate,this.index);
      }
      
      public function set index(value:int) : void
      {
         this._index = value;
         this.gird.empty();
         var vo2:Vo_item = new Vo_item();
         var ids:String = Data_lib.VIPhuigui[this.index][1];
         vo2.id = ids.split("_")[1];
         vo2.Init_lib();
         this.gird.set_bmp_over(true,"");
         this.gird.vo = vo2;
      }
      
      public function get index() : int
      {
         return this._index;
      }
   }
}

