package com.yiTian.view.modules.QT
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.QTSignCGMessage;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.sign.Enum_Sign;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class Child_SignRewardItem1 extends Sprite
   {
      
      private var txtDes:MyTextField;
      
      private var grid:View_Grid;
      
      private var numOneIcon:Bitmap;
      
      private var numTwoIcon:Bitmap;
      
      private var getIcon:Bitmap;
      
      private var id:int;
      
      private var _status:int = -1;
      
      public function Child_SignRewardItem1()
      {
         super();
         ComponentUtil.getBitmap("Gift",this,{
            "x":13,
            "y":33
         },Global.QTSIGNdm);
         this.numOneIcon = ComponentUtil.getBitmap("Num_0",this,{
            "x":37,
            "y":74
         },Global.QTSIGNdm);
         this.numTwoIcon = ComponentUtil.getBitmap("Num_0",this,{
            "x":45,
            "y":74
         },Global.QTSIGNdm);
         this.getIcon = ComponentUtil.getBitmap("Text_Got",this,{
            "x":0,
            "y":30
         },Global.QTSIGNdm);
         this.getIcon.visible = false;
         this.buttonMode = true;
         this.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      public function changeStatus() : void
      {
         this._status = 2;
         this.filters = [];
      }
      
      public function update(status:int, data:Array) : void
      {
         var _id:int = int(data[2]);
         var _voI:Vo_item = new Vo_item();
         _voI.id = _id;
         _voI.Init_lib();
         _voI.bBind = data[3];
         TipManager.bind(this,_voI.str_describe);
         this.id = int(data[0]);
         this.setNumBitmap(data[1]);
         if(status == Enum_Sign.HAS_GET)
         {
            this.getIcon.visible = true;
         }
         else
         {
            this.getIcon.visible = false;
         }
         if(status == Enum_Sign.CAN_GET)
         {
            this.filters = Util.glowBigFFff00;
         }
         else
         {
            this.filters = [];
         }
         this._status = status;
      }
      
      private function setNumBitmap(num:int) : void
      {
         var ge:int = 0;
         var shi:int = int(num / 10);
         ge = num % 10;
         if(shi > 0)
         {
            this.numOneIcon.bitmapData = ComponentUtil.getBitmapData("Num_" + shi,Global.QTSIGNdm);
            this.numOneIcon.visible = true;
            this.numTwoIcon.bitmapData = ComponentUtil.getBitmapData("Num_" + ge,Global.QTSIGNdm);
            this.numTwoIcon.x = 46;
            return;
         }
         this.numOneIcon.visible = false;
         this.numTwoIcon.bitmapData = ComponentUtil.getBitmapData("Num_" + ge,Global.QTSIGNdm);
         this.numTwoIcon.x = 39;
      }
      
      private function onClick(e:MouseEvent) : void
      {
         var msg:String = null;
         if(this._status == 0)
         {
            msg = "抱歉，签到次数不符合领取礼包";
         }
         else if(this._status == 2)
         {
            msg = "已经领取过该礼包，不能再重复领取";
         }
         if(this._status == 1)
         {
            QTSignCGMessage.CG_QTSign_AWARD(this.id - 1);
            Model_qtSign.AWARD_INDEX = this.id - 1;
            Model_qtSign.rewardIconIndex = this.id - 1;
         }
         if(msg != null)
         {
            UIManager.centerBroadcast.addMsg(msg);
         }
      }
   }
}

