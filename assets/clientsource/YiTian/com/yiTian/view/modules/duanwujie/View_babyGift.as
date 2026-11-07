package com.yiTian.view.modules.duanwujie
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.TipManager;
   import com.yiTian.net.message.cg.BabyGiftCGMessage;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.tip.tips.View_Item;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class View_babyGift extends Panel123
   {
      
      private static var _instance:View_babyGift;
      
      private var _button:Button;
      
      private var _tip:Sprite;
      
      private var _viewTip:View_Item;
      
      private var _clearId:int;
      
      private var _centerPoint:Point;
      
      public function View_babyGift()
      {
         super();
         regResource("lang/ch/NSHS.swf","NSHSdm");
      }
      
      public static function get instance() : View_babyGift
      {
         if(!_instance)
         {
            _instance = new View_babyGift();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         var voItem:Vo_item = null;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":458,
            "height":308
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":24,
            "y":40,
            "width":410,
            "height":259
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_WXPrompt",this,{
            "x":149,
            "y":5
         },Global.Img_Cdm);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":423,
            "y":6,
            "textColor":16771436,
            "callBack":function():void
            {
               visible = false;
            }
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":34,
            "y":50,
            "width":390,
            "height":211
         },Global.NSHSdm);
         ComponentUtil.getBitmap("Back_ETLB",this,{
            "x":39,
            "y":55
         },Global.NSHSdm);
         this._button = ComponentUtil.getButton("领取奖励","Button_TwoBule91",this,{
            "x":184,
            "y":265,
            "textColor":16771436,
            "callBack":function():void
            {
               BabyGiftCGMessage.CG_ETLB_GETAWARD();
            }
         },Global.Img_Cdm);
         voItem = new Vo_item();
         voItem.id = 45622;
         voItem.Init_lib();
         this._viewTip = new View_Item();
         addChild(this._viewTip);
         this._viewTip.Init();
         this._viewTip.Show(voItem);
         this._viewTip.x = (458 - this._viewTip.width) * 0.5;
         this._viewTip.y = (308 - this._viewTip.height) * 0.5;
         this._centerPoint = new Point(this._viewTip.x,this._viewTip.y);
         this._tip = new Sprite();
         addChild(this._tip);
         this._tip.addEventListener(MouseEvent.MOUSE_OVER,this.onOver);
         this._tip.addEventListener(MouseEvent.MOUSE_OUT,this.onOut);
         this._tip.graphics.beginFill(0,0);
         this._tip.graphics.drawRect(0,0,50,50);
         this._tip.graphics.endFill();
         this._tip.x = 260;
         this._tip.y = 55;
         this.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      protected function onClick(event:MouseEvent) : void
      {
         if(this._viewTip.scaleX == 1)
         {
            this.moveEff();
            this.removeEventListener(MouseEvent.CLICK,this.onClick);
         }
      }
      
      private function onOver(e:MouseEvent) : void
      {
         var point:Point = null;
         point = this.localToGlobal(new Point(e.target.x,e.target.y));
         var vo:Vo_item = new Vo_item();
         vo.id = 45622;
         vo.Init_lib();
         TipManager.update(vo);
         TipManager.view_tip.x = point.x + e.target.width / 2;
         TipManager.view_tip.y = point.y + e.target.height / 2;
      }
      
      private function onOut(e:MouseEvent) : void
      {
         TipManager.hide();
      }
      
      public function set status(state:int) : void
      {
         switch(state)
         {
            case 0:
               this._button.enabled = true;
               this._button.label = "领取奖励";
               break;
            case 1:
               this._button.enabled = false;
               this._button.label = "已领取";
               break;
            case 2:
               this._button.enabled = false;
               this._button.label = "领取奖励";
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.addEventListener(MouseEvent.CLICK,this.onClick);
            var _temp_1:* = this._viewTip;
            this._viewTip.scaleY = 1;
            _temp_1.scaleX = 1;
            this._viewTip.x = (458 - this._viewTip.width) * 0.5;
            this._viewTip.y = (308 - this._viewTip.height) * 0.5;
            this._clearId = setTimeout(function():void
            {
               moveEff();
            },5000);
         }
         else
         {
            this.removeEventListener(MouseEvent.CLICK,this.onClick);
            clearTimeout(this._clearId);
         }
      }
      
      private function moveEff() : void
      {
         if(Boolean(this._viewTip))
         {
            Tween.to(this._viewTip,300,{
               "x":[this._centerPoint.x,this._tip.x + this._tip.width / 2],
               "y":[this._centerPoint.y,this._tip.y + this._tip.height / 2],
               "scaleX":[1,0],
               "scaleY":[1,0]
            },null);
         }
         this._tip.mouseEnabled = true;
         clearTimeout(this._clearId);
      }
   }
}

