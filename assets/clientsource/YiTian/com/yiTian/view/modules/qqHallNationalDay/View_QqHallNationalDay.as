package com.yiTian.view.modules.qqHallNationalDay
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_qq_hall_national_day;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.BlueDiaManager;
   import com.yiTian.net.message.cg.QqHallNationalDayCGMessage;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class View_QqHallNationalDay extends Panel
   {
      
      private var bg:Bitmap;
      
      private var enterBtn:Button;
      
      private var getGoldBtn:Button;
      
      private var getBronzeBtn:Button;
      
      private var openYearBtn:Button;
      
      private var openMonthBtn:Button;
      
      private var goldGiftArea:View_Grid;
      
      private var bronzeGiftArea:View_Grid;
      
      private var goldGotBtn:Bitmap;
      
      private var bronzesGotBtn:Bitmap;
      
      private var isLoadCom:Boolean;
      
      public function View_QqHallNationalDay()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":0,
            "y":0,
            "width":656,
            "height":493
         },Global.Img_Cdm);
         this.bg = new Bitmap();
         this.addChild(this.bg);
         move = new Rectangle(0,0,630,100);
         CloseButton = ComponentUtil.getButton("","Red_Close",this,{
            "x":615,
            "y":25,
            "textColor":16184781
         },Global.Img_Cdm);
      }
      
      override public function set visible(value:Boolean) : void
      {
         var vo:Vo_item = null;
         super.visible = value;
         if(value)
         {
            if(!this.bg.bitmapData)
            {
               Utils.loadTitle("lang/ch/DaTingGuoQing_Imgs.swf","HuoDongBG",this.bg,{
                  "x":10,
                  "y":10
               },null,this.onLoadCom);
            }
            if(!this.goldGiftArea)
            {
               this.goldGiftArea = new View_Grid();
               this.goldGiftArea.alpha = 0;
               this.goldGiftArea.set_bmp_over();
               this.goldGiftArea.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
               this.addChild(this.goldGiftArea);
               this.goldGiftArea.x = 55;
               this.goldGiftArea.y = 220;
               vo = new Vo_item();
               vo.id = 46503;
               vo.Init_lib();
               this.goldGiftArea.vo = vo;
            }
            if(!this.bronzeGiftArea)
            {
               this.bronzeGiftArea = new View_Grid();
               this.bronzeGiftArea.alpha = 0;
               this.bronzeGiftArea.set_bmp_over();
               this.bronzeGiftArea.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
               this.addChild(this.bronzeGiftArea);
               this.bronzeGiftArea.x = 380;
               this.bronzeGiftArea.y = 220;
               vo = new Vo_item();
               vo.id = 46502;
               vo.Init_lib();
               this.bronzeGiftArea.vo = vo;
            }
         }
      }
      
      private function onLoadCom() : void
      {
         this.isLoadCom = true;
         if(!this.enterBtn)
         {
            this.enterBtn = ComponentUtil.getButton("","Button_Enter",this,{
               "x":215,
               "y":406,
               "textColor":16184781
            },Utils.swfPool["lang/ch/DaTingGuoQing_Imgs.swf"]);
            this.enterBtn.addEventListener(MouseEvent.CLICK,this.onClickEnterBtn);
         }
         if(!this.getGoldBtn)
         {
            this.getGoldBtn = ComponentUtil.getButton("","Button_Get",this,{
               "x":148,
               "y":259 + 7,
               "textColor":16184781
            },Utils.swfPool["lang/ch/DaTingGuoQing_Imgs.swf"]);
            this.getGoldBtn.addEventListener(MouseEvent.CLICK,this.onClickGetGoldBtn);
         }
         if(!this.getBronzeBtn)
         {
            this.getBronzeBtn = ComponentUtil.getButton("","Button_Get",this,{
               "x":459,
               "y":259 + 7,
               "textColor":16184781
            },Utils.swfPool["lang/ch/DaTingGuoQing_Imgs.swf"]);
            this.getBronzeBtn.addEventListener(MouseEvent.CLICK,this.onClickGetBronzeBtn);
         }
         if(!this.openYearBtn)
         {
            this.openYearBtn = ComponentUtil.getButton("","Button_Year",this,{
               "x":147,
               "y":218 + 7,
               "textColor":16184781
            },Utils.swfPool["lang/ch/DaTingGuoQing_Imgs.swf"]);
            this.openYearBtn.addEventListener(MouseEvent.CLICK,this.onClickOpenYearBtn);
         }
         if(!this.openMonthBtn)
         {
            this.openMonthBtn = ComponentUtil.getButton("","Button_Month",this,{
               "x":458,
               "y":218 + 7,
               "textColor":16184781
            },Utils.swfPool["lang/ch/DaTingGuoQing_Imgs.swf"]);
            this.openMonthBtn.addEventListener(MouseEvent.CLICK,this.onClickOpenMonthBtn);
         }
         if(!this.goldGotBtn)
         {
            this.goldGotBtn = ComponentUtil.getBitmap("Button_Gotted",this,{
               "x":148,
               "y":259 + 7
            },Utils.swfPool["lang/ch/DaTingGuoQing_Imgs.swf"]);
         }
         if(!this.bronzesGotBtn)
         {
            this.bronzesGotBtn = ComponentUtil.getBitmap("Button_Gotted",this,{
               "x":459,
               "y":259 + 7
            },Utils.swfPool["lang/ch/DaTingGuoQing_Imgs.swf"]);
         }
         this.update();
      }
      
      private function onClickOpenMonthBtn(event:MouseEvent) : void
      {
         BlueDiaManager.yearOrMonth = 1;
         BlueDiaManager.buy();
      }
      
      private function onClickOpenYearBtn(event:MouseEvent) : void
      {
         BlueDiaManager.yearOrMonth = 2;
         BlueDiaManager.buy();
      }
      
      private function onClickGetBronzeBtn(event:MouseEvent) : void
      {
         if(Model_qq_hall_national_day.instace.canGetMonthGift == false)
         {
            return;
         }
         QqHallNationalDayCGMessage.cg_get_gift(1);
      }
      
      private function onClickGetGoldBtn(event:MouseEvent) : void
      {
         if(Model_qq_hall_national_day.instace.canGetYearGift == false)
         {
            return;
         }
         QqHallNationalDayCGMessage.cg_get_gift(2);
      }
      
      private function onClickEnterBtn(event:MouseEvent) : void
      {
         navigateToURL(new URLRequest("http://gamevip.qq.com/act/a20120921lit/index.html?ADTAG=IED.YT.BADGE"));
      }
      
      public function update(type:uint = 0) : void
      {
         var p:Point = null;
         if(this.isLoadCom == false)
         {
            return;
         }
         if(type == 1 || type == 0)
         {
            if(Model_qq_hall_national_day.instace.isMonthBlueDia)
            {
               if(Model_qq_hall_national_day.instace.canGetMonthGift)
               {
                  this.getBronzeBtn.visible = true;
                  this.getBronzeBtn.enabled = true;
                  this.bronzesGotBtn.visible = false;
               }
               else
               {
                  this.getBronzeBtn.visible = false;
                  this.getBronzeBtn.enabled = false;
                  this.bronzesGotBtn.visible = true;
               }
            }
            else
            {
               this.getBronzeBtn.visible = true;
               this.getBronzeBtn.enabled = false;
               this.bronzesGotBtn.visible = false;
            }
         }
         if(type == 2 || type == 0)
         {
            if(Model_qq_hall_national_day.instace.isYearBuleDia)
            {
               if(Model_qq_hall_national_day.instace.canGetYearGift)
               {
                  this.getGoldBtn.visible = true;
                  this.getGoldBtn.enabled = true;
                  this.goldGotBtn.visible = false;
               }
               else
               {
                  this.getGoldBtn.visible = false;
                  this.getGoldBtn.enabled = false;
                  this.goldGotBtn.visible = true;
               }
            }
            else
            {
               this.getGoldBtn.visible = true;
               this.getGoldBtn.enabled = false;
               this.goldGotBtn.visible = false;
            }
         }
         if(type == 1)
         {
            p = localToGlobal(new Point(this.bronzeGiftArea.x,this.bronzeGiftArea.y));
            Tween.gridToBagBezierFuncDef(this.bronzeGiftArea.vo,-1,p.x,p.y);
         }
         else if(type == 2)
         {
            p = localToGlobal(new Point(this.goldGiftArea.x,this.goldGiftArea.y));
            Tween.gridToBagBezierFuncDef(this.goldGiftArea.vo,-1,p.x,p.y);
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.width) / 2;
         y = (Global.stage.stageHeight - this.height) / 2;
      }
   }
}

