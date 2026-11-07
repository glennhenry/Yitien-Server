package com.yiTian.view.modules.mainUIBtnContainer
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class hideMenuListItem extends Sprite
   {
      
      private var _sortId:int;
      
      private var _id:int;
      
      private var _status:int = -1;
      
      private var prizeTxt:MyTextField;
      
      private var timeTxt:MyTextField;
      
      private var notStart:Bitmap;
      
      private var isOver:Bitmap;
      
      private var enterBtn:Button;
      
      private var btnEff:Effect;
      
      private var countBm:Bitmap;
      
      private var countTxt:MyTextField;
      
      public function hideMenuListItem()
      {
         super();
         ComponentUtil.getBitmap("Back_ZKSS",this,{
            "x":0,
            "y":2
         },Global.Img_Cdm);
         this.enterBtn = ComponentUtil.getButton("进入","Button_JYAN",this,{
            "x":326,
            "y":21,
            "textColor":16771436
         },Global.Img_Cdm);
         this.notStart = ComponentUtil.getBitmap("Icon_WKS",this,{
            "x":338,
            "y":18
         },Global.Img_Cdm);
         this.isOver = ComponentUtil.getBitmap("Icon_YJS",this,{
            "x":338,
            "y":18
         },Global.Img_Cdm);
         this.prizeTxt = ComponentUtil.getTextField("奖励：XXXX",this,{
            "x":73,
            "y":12,
            "color":16383744,
            "size":14,
            "leading":0
         });
         this.timeTxt = ComponentUtil.getTextField("开启时间：XXXX",this,{
            "x":73,
            "y":39,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.enterBtn.visible = false;
         this.notStart.visible = true;
         this.isOver.visible = false;
         this.enterBtn.callBack = this.onEnterClick;
      }
      
      public function setType(sortId:int, tableId:int, iconPath:String, prize:String, time:String) : void
      {
         this._sortId = sortId;
         this._id = tableId;
         addChild(Utils.getLoadBitmap(iconPath,null,{
            "x":6,
            "y":3
         }));
         this.prizeTxt.text = prize;
         this.timeTxt.text = time;
         this.countBm = ComponentUtil.getBitmap("cishu_tis",this,{
            "x":8,
            "y":-1
         },Global.New_Imgsdm);
         this.countBm.visible = false;
         this.countTxt = ComponentUtil.getTextField("",this,{
            "size":11,
            "color":16771584,
            "x":this.countBm.x + this.countBm.width / 2 - 2.5,
            "y":2
         },"center");
      }
      
      public function setStatus(flag:int, showEff:* = null) : void
      {
         if(flag != -1)
         {
            this._status = flag;
         }
         switch(flag)
         {
            case 0:
               this.enterBtn.visible = false;
               this.notStart.visible = true;
               this.isOver.visible = false;
               break;
            case 1:
               this.enterBtn.visible = true;
               this.notStart.visible = false;
               this.isOver.visible = false;
               break;
            case 2:
               this.enterBtn.visible = false;
               this.notStart.visible = false;
               this.isOver.visible = true;
         }
         if(this.enterBtn.visible && showEff == 1)
         {
            if(!this.btnEff)
            {
               this.btnEff = EffectManager.addEffect("35075",this,1000,365,35,true);
            }
         }
         else if(showEff == 0 || !this.enterBtn.visible)
         {
            if(Boolean(this.btnEff))
            {
               EffectManager.removeEffect(this.btnEff);
               this.btnEff = null;
            }
         }
      }
      
      private function onEnterClick(e:MouseEvent) : void
      {
         Global.control.sendNotification(Enum_mainUIBtn_hide.CLICK_ENTER,this.id);
      }
      
      public function setCount(count:int) : void
      {
         if(count < 1)
         {
            this.countBm.visible = false;
            this.countTxt.text = "";
         }
         else
         {
            this.countBm.visible = true;
            this.countTxt.text = count.toString();
         }
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get status() : int
      {
         return this._status;
      }
      
      public function get sortId() : int
      {
         return this._sortId;
      }
   }
}

