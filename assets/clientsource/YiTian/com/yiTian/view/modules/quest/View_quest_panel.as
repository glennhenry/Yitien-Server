package com.yiTian.view.modules.quest
{
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_quest;
   import com.yiTian.data.vo.quest.Vo_quest;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_quest_panel extends Panel
   {
      
      private var TabButton_Present:TabButton;
      
      private var TabButton_Take:TabButton;
      
      private var acceptedView:View_quest_accepted;
      
      private var canAcceptView:View_quest_canAccept;
      
      private var titleBm:Bitmap;
      
      private var isInited:Boolean = false;
      
      private var now:TabButton;
      
      public function View_quest_panel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         this.titleBm = new Bitmap();
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":558,
            "height":420
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":70,
            "width":510,
            "height":315
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":194,
            "y":265,
            "width":335,
            "height":115
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":194,
            "y":160,
            "width":335,
            "height":100
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":194,
            "y":75,
            "width":335,
            "height":80
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":29,
            "y":75,
            "width":160,
            "height":305
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":195,
            "y":76,
            "width":333,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":195,
            "y":161,
            "width":333,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":195,
            "y":266,
            "width":333,
            "height":20
         },Global.Img_Cdm);
         move = new Rectangle(0,0,558,36);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":524,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.TabButton_Present = ComponentUtil.getTabButton(LangConfig.getWord("10479",1),"TabButton_Four",this,{
            "x":34,
            "y":48,
            "textColor":11770414,
            "chooseColor":16773818
         },Global.Img_Cdm);
         this.TabButton_Take = ComponentUtil.getTabButton(LangConfig.getWord("10480",1),"TabButton_Four",this,{
            "x":110,
            "y":48,
            "textColor":11770414,
            "chooseColor":16773818
         },Global.Img_Cdm);
         this.canAcceptView = new View_quest_canAccept();
         addChild(this.canAcceptView);
         this.TabButton_Take.binding = this.canAcceptView;
         this.acceptedView = new View_quest_accepted();
         this.TabButton_Present.binding = this.acceptedView;
         addChild(this.acceptedView);
         this.TabButton_Present.addEventListener(MouseEvent.CLICK,this.clickEvent);
         this.TabButton_Take.addEventListener(MouseEvent.CLICK,this.clickEvent);
         this.TabButton_Present.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
      }
      
      public function clickEvent(e:MouseEvent) : void
      {
         var btn:TabButton = e.target as TabButton;
         if(this.now == btn)
         {
            return;
         }
         if(Boolean(this.now))
         {
            this.now.choose = false;
         }
         btn.choose = true;
         this.now = btn;
      }
      
      public function update() : void
      {
         this.acceptedView.update();
         this.canAcceptView.update();
      }
      
      override public function set visible(value:Boolean) : void
      {
         var quest:Vo_quest = null;
         super.visible = value;
         if(value)
         {
            if(!this.isInited)
            {
               Utils.loadTitle("lang/ch/Mission_Imgs.swf","Title_Mission",this.titleBm,{
                  "x":199,
                  "y":5
               },this);
               this.isInited = true;
            }
            for each(quest in Model_quest.accepted)
            {
               if(Boolean(quest))
               {
                  this.TabButton_Present.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                  return;
               }
            }
            this.TabButton_Take.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

