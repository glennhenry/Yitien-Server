package com.yiTian.view.modules.rechargeFeedback.reChangeBack
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.net.message.cg.RechargeFeedbackCGMessage;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   
   public class FBackItem extends Sprite
   {
      
      public static const RECEIVE:int = 1;
      
      public static const HAS_RECEIVED:int = 2;
      
      public static const NOT_ELIGIBLE:int = 0;
      
      private static var selectFilter:Array = [new GlowFilter(16776960,1,8,8,2,1)];
      
      private var bmpCard:Bitmap;
      
      private var btn:Button;
      
      private var type:int;
      
      private var _choose:Boolean;
      
      public function FBackItem()
      {
         super();
         this.bmpCard = ComponentUtil.getBitmap("Card_01",this,{
            "x":0,
            "y":0
         },Global.CZHKDLdm);
         this.btn = ComponentUtil.getButton("领取","Button_TwoBule91",this,{
            "x":11,
            "y":142,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn.callBack = function():void
         {
            RechargeFeedbackCGMessage.CG_GET_FEEDBACK(type);
         };
      }
      
      public function init(_type:int) : void
      {
         this.type = _type;
         this.bmpCard.bitmapData = ComponentUtil.getBitmapData("Card_0" + _type,Global.CZHKDLdm);
      }
      
      public function set choose(value:Boolean) : void
      {
         this._choose = value;
         if(value)
         {
            filters = selectFilter;
         }
         else
         {
            filters = [];
         }
      }
      
      public function get choose() : Boolean
      {
         return this._choose;
      }
      
      public function upBtn(status:int) : void
      {
         switch(status)
         {
            case RECEIVE:
               this.btn.enabled = true;
               break;
            case HAS_RECEIVED:
            case NOT_ELIGIBLE:
               this.btn.enabled = false;
         }
      }
   }
}

