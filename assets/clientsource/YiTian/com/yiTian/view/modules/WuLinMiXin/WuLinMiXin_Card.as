package com.yiTian.view.modules.WuLinMiXin
{
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_WuLinMiXin;
   import com.yiTian.data.model.Model_WuLinMiXin;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.WulinmixinCGMessage;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.utils.Tween;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class WuLinMiXin_Card extends Sprite
   {
      
      public var id:int;
      
      public var status:int;
      
      private var spr:Sprite;
      
      private var tip:View_TalkTips;
      
      public function WuLinMiXin_Card(_id:int)
      {
         super();
         this.spr = new Sprite();
         this.spr.buttonMode = true;
         this.spr.mouseChildren = false;
         this.id = _id;
         this.init(this.id);
      }
      
      private function init(_id:int) : void
      {
         ComponentUtil.getBitmap("BG_WLTouXiang",this,{
            "x":4,
            "y":15
         },Global.WLMiXindm);
         ComponentUtil.getBitmap("TouXiang_" + _id,this.spr,{
            "x":0,
            "y":0
         },Global.WLMiXindm);
         ComponentUtil.getBitmap("BG_WLMingZi",this.spr,{
            "x":12,
            "y":67
         },Global.WLMiXindm);
         ComponentUtil.getTextField(Enum_WuLinMiXin.getNameByIndex(_id),this.spr,{
            "x":21,
            "y":69,
            "color":16776960,
            "size":12,
            "leading":0
         });
         this.addChild(this.spr);
         this.spr.addEventListener(MouseEvent.CLICK,this.openCard);
         this.spr.addEventListener(MouseEvent.ROLL_OVER,this.onOverOut);
         this.spr.addEventListener(MouseEvent.ROLL_OUT,this.onOverOut);
         this.tip = new View_TalkTips();
         this.tip.Init();
         this.tip.visible = false;
         addChild(this.tip);
      }
      
      private function showTip() : void
      {
         var h:int = 0;
         var _vo:Vo_wlMx = new Vo_wlMx();
         _vo.id = this.id + 1;
         _vo.init();
         this.tip.Show(_vo);
         var w:int = this.tip.width;
         h = this.tip.height;
         this.tip.x = this.spr.x - w + 20;
         this.tip.y = this.spr.y - h + 24;
      }
      
      private function openCard(e:MouseEvent) : void
      {
         trace("wulinmixinClick");
         if(Model_WuLinMiXin.freeOpenTimes > 0)
         {
            WulinmixinCGMessage.CG_OPEN_CARD(this.id + 1);
         }
         else
         {
            UIManager.wulinMXTips.UpdateTipsTxt();
            UIManager.wulinMXTips.show(function():void
            {
               if(GameUnitManager.hero.money < int(Data_lib.wulinmixin_cost[Model_WuLinMiXin.haveOpenTimes + 1][0]))
               {
                  UIManager.centerBroadcast.addMsg("元宝不足");
                  return;
               }
               WulinmixinCGMessage.CG_OPEN_CARD(id + 1);
            });
         }
      }
      
      private function onOverOut(e:MouseEvent) : void
      {
         trace("wulinmixinClick2222");
         if(e.type == MouseEvent.ROLL_OVER)
         {
            e.currentTarget.transform.colorTransform = Util.colorWhite2;
            this.showTip();
         }
         else
         {
            e.currentTarget.transform.colorTransform = Util.colorNomal;
            this.tip.visible = false;
         }
      }
      
      public function setStatus(_status:int, _playAnimation:Boolean = false) : void
      {
         this.status = _status;
         if(_playAnimation)
         {
            this.StartOpenAnimation();
            return;
         }
         if(_status == 0)
         {
            this.spr.buttonMode = false;
            this.spr.mouseEnabled = false;
            this.spr.alpha = 0;
         }
         else if(_status == 1)
         {
            Tween.stop(this.spr);
            this.spr.buttonMode = true;
            this.spr.mouseEnabled = true;
            this.spr.alpha = 1;
         }
      }
      
      private function StartOpenAnimation() : void
      {
         trace("****WuLinMiXin_Card" + this.id + "StartOpenAnimation");
         this.spr.buttonMode = false;
         this.spr.mouseEnabled = false;
         Tween.to(this.spr,1000,{"alpha":[1,0]});
      }
      
      public function flyToBag(dis:DisplayObject) : void
      {
         dis.x = (73 - dis.width) / 2 + 4;
         dis.y = (73 - dis.height) / 2 + 15;
         this.addChild(dis);
         ComboTweenStep.toBag(dis);
         this.removeChild(dis);
         dis = null;
      }
   }
}

