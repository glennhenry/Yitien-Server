package com.yiTian.view.modules.actions
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.net.message.cg.ActionsCGMessage;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Alert;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CardItem extends Sprite
   {
      
      private static var isLoad:Boolean = false;
      
      private var backCard:Bitmap;
      
      private var awardBm:Bitmap;
      
      private var awardBtn:Button;
      
      private var icon:Bitmap;
      
      public var type:int;
      
      private var bigType:int;
      
      private var _selected:Boolean;
      
      public function CardItem()
      {
         super();
         this.backCard = new Bitmap();
         this.awardBm = new Bitmap();
         this.icon = new Bitmap();
         addChild(this.backCard);
         addChild(this.awardBm);
         addChild(this.icon);
         this.icon = Utils.getLoadBitmap("resource/image/rechargeFeedback/1.png",this.icon);
         ComponentUtil.setPropertie(this.backCard,{
            "x":1,
            "y":1
         });
         ComponentUtil.setPropertie(this.awardBm,{
            "x":8 + 3,
            "y":8 - 22
         });
         ComponentUtil.setPropertie(this.icon,{
            "x":8 + 2 + 22,
            "y":8 - 21 + 53
         });
         this.awardBtn = ComponentUtil.getButton("","Button_LingQu",this,{
            "x":12,
            "y":116,
            "textColor":16184781
         },Global.HuiGuidm);
         this.awardBtn.addEventListener(MouseEvent.CLICK,this.cliHd);
      }
      
      private function loadComp() : void
      {
         SingleLoader.add("lang/ch/OldPlayerHuiGui.swf",function(info:Object):void
         {
            Global.HuiGuidm = info.applicationDomain;
            update();
         });
      }
      
      private function cliHd(e:MouseEvent) : void
      {
         var str:String = null;
         if(this.bigType == 3)
         {
            str = "<font color=\'#ffffff\'>是否确定领取该礼包奖励</font><br/><font color=\'#0bc488\'>(所有礼包只能领取一个)</font>";
            View_Alert.show(str,View_Alert.OK_CANCAL,function():void
            {
               ActionsCGMessage.CG_GETAWARD_BACKPLAYER(bigType,type);
            });
         }
         else
         {
            ActionsCGMessage.CG_GETAWARD_BACKPLAYER(this.bigType,this.type);
         }
      }
      
      public function setData(_type:int, _bigType:int) : void
      {
         this.type = _type;
         this.bigType = _bigType;
         if(!isLoad)
         {
            this.loadComp();
         }
         else
         {
            this.update();
         }
      }
      
      public function setBtnEnable(value:int) : void
      {
         if(value == 0)
         {
            this.awardBtn.enabled = false;
         }
         else if(value == 1)
         {
            this.awardBtn.enabled = true;
         }
         else if(value == 2)
         {
            this.awardBtn.enabled = false;
         }
      }
      
      public function setFilter(value:Boolean) : void
      {
         if(value)
         {
            this.backCard.filters = Util.glowBigFFff00;
         }
         else
         {
            this.backCard.filters = [];
         }
      }
      
      public function set selected(value:Boolean) : void
      {
         this._selected = value;
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      public function secc() : void
      {
         this.awardBtn.enabled = false;
         ComboTweenStep.toBag(this.icon,this.icon.x,this.icon.y,null,"bsToBag");
      }
      
      private function update() : void
      {
         this.backCard.bitmapData = ComponentUtil.getBitmapData("Back_CardOpend",Global.HuiGuidm);
         if(this.bigType == 1)
         {
            if(this.type == 1)
            {
               this.awardBm.bitmapData = ComponentUtil.getBitmapData("Text_OnLine01",Global.HuiGuidm);
               this.icon = Utils.getLoadBitmap("resource/image/rechargeFeedback/1.png",this.icon);
            }
            else if(this.type == 2)
            {
               this.awardBm.bitmapData = ComponentUtil.getBitmapData("Text_OnLine02",Global.HuiGuidm);
               this.icon = Utils.getLoadBitmap("resource/image/rechargeFeedback/2.png",this.icon);
            }
            else if(this.type == 3)
            {
               this.awardBm.bitmapData = ComponentUtil.getBitmapData("Text_OnLine03",Global.HuiGuidm);
               this.icon = Utils.getLoadBitmap("resource/image/rechargeFeedback/3.png",this.icon);
            }
         }
         else if(this.bigType == 2)
         {
            if(this.type == 1)
            {
               this.awardBm.bitmapData = ComponentUtil.getBitmapData("Text_LeiJi100",Global.HuiGuidm);
               this.icon = Utils.getLoadBitmap("resource/image/rechargeFeedback/4.png",this.icon);
            }
            else if(this.type == 2)
            {
               this.awardBm.bitmapData = ComponentUtil.getBitmapData("Text_LeiJi1000",Global.HuiGuidm);
               this.icon = Utils.getLoadBitmap("resource/image/rechargeFeedback/5.png",this.icon);
            }
            else if(this.type == 3)
            {
               this.awardBm.bitmapData = ComponentUtil.getBitmapData("Text_LeiJi5000",Global.HuiGuidm);
               this.icon = Utils.getLoadBitmap("resource/image/rechargeFeedback/6.png",this.icon);
            }
         }
         else if(this.bigType == 3)
         {
            if(this.type == 1)
            {
               this.awardBm.bitmapData = ComponentUtil.getBitmapData("Text_TQ100",Global.HuiGuidm);
               this.icon = Utils.getLoadBitmap("resource/image/rechargeFeedback/1.png",this.icon);
            }
            else if(this.type == 2)
            {
               this.awardBm.bitmapData = ComponentUtil.getBitmapData("Text_TQ1000",Global.HuiGuidm);
               this.icon = Utils.getLoadBitmap("resource/image/rechargeFeedback/2.png",this.icon);
            }
            else if(this.type == 3)
            {
               this.awardBm.bitmapData = ComponentUtil.getBitmapData("Text_TQ10000",Global.HuiGuidm);
               this.icon = Utils.getLoadBitmap("resource/image/rechargeFeedback/3.png",this.icon);
            }
            else if(this.type == 4)
            {
               this.awardBm.bitmapData = ComponentUtil.getBitmapData("Text_TQ50000",Global.HuiGuidm);
               this.icon = Utils.getLoadBitmap("resource/image/rechargeFeedback/4.png",this.icon);
            }
            else if(this.type == 5)
            {
               this.awardBm.bitmapData = ComponentUtil.getBitmapData("Text_TQ100000",Global.HuiGuidm);
               this.icon = Utils.getLoadBitmap("resource/image/rechargeFeedback/5.png",this.icon);
            }
            this.awardBm.x = 4;
         }
      }
   }
}

