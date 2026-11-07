package com.yiTian.view.modules.midAutumn
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.FishingCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.panel.Enum_panel_cast;
   import com.yiTian.view.modules.treasureBowl.View_treasureBowl;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_midAutumn extends Panel
   {
      
      public var btn0:Button;
      
      public var btn1:Button;
      
      public var btn2:Button;
      
      public var btn3:Button;
      
      public var btn4:Button;
      
      private var isLoadCom:Boolean;
      
      public function View_midAutumn()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":718,
            "height":490
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":670,
            "height":440
         },Global.Img_Cdm);
         move = new Rectangle(0,0,710,36);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":684,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!this.isLoadCom)
            {
               Utils.loadTitle("lang/ch/ZhongQiu_Imgs.swf","ZhongQiuBG",new Bitmap(),{
                  "x":34,
                  "y":50
               },this,this.onLoadCom);
               Utils.loadTitle("lang/ch/ZhongQiu_Imgs.swf","Title_ZhongQiu",new Bitmap(),{
                  "x":284,
                  "y":5
               },this);
            }
         }
      }
      
      private function onLoadCom() : void
      {
         this.isLoadCom = true;
         this.btn0 = ComponentUtil.getButton("","HuoDong01",this,{
            "x":342,
            "y":127,
            "textColor":16184781
         },Utils.swfPool["lang/ch/ZhongQiu_Imgs.swf"]);
         this.btn1 = ComponentUtil.getButton("","HuoDong02",this,{
            "x":317,
            "y":194,
            "textColor":16184781
         },Utils.swfPool["lang/ch/ZhongQiu_Imgs.swf"]);
         this.btn2 = ComponentUtil.getButton("","HuoDong03",this,{
            "x":300,
            "y":261,
            "textColor":16184781
         },Utils.swfPool["lang/ch/ZhongQiu_Imgs.swf"]);
         this.btn3 = ComponentUtil.getButton("","HuoDong04",this,{
            "x":317,
            "y":328,
            "textColor":16184781
         },Utils.swfPool["lang/ch/ZhongQiu_Imgs.swf"]);
         this.btn4 = ComponentUtil.getButton("","HuoDong05",this,{
            "x":342,
            "y":395,
            "textColor":16184781
         },Utils.swfPool["lang/ch/ZhongQiu_Imgs.swf"]);
         this.btn0.addEventListener(MouseEvent.CLICK,this.onClickBtn0);
         this.btn1.addEventListener(MouseEvent.CLICK,this.onClickBtn1);
         this.btn2.addEventListener(MouseEvent.CLICK,this.onClickBtn2);
         this.btn3.addEventListener(MouseEvent.CLICK,this.onClickBtn3);
         this.btn4.addEventListener(MouseEvent.CLICK,this.onClickBtn4);
         TipManager.bind(this.btn0,LangConfig.getWord("70007",7));
         TipManager.bind(this.btn1,LangConfig.getWord("70008",7));
         TipManager.bind(this.btn2,LangConfig.getWord("70009",7));
         TipManager.bind(this.btn3,LangConfig.getWord("70010",7));
         TipManager.bind(this.btn4,LangConfig.getWord("70011",7));
      }
      
      private function onClickBtn0(evt:MouseEvent) : void
      {
         if(GameUnitManager.hero.level < Global.tuanGouOpenLevel)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("70012",7,Global.tuanGouOpenLevel));
            return;
         }
         UIManager.tuanGou.visible = true;
         this.visible = false;
      }
      
      private function onClickBtn1(evt:MouseEvent) : void
      {
         FishingCGMessage.CG_ENTER_RIVER(-1);
         this.visible = false;
      }
      
      private function onClickBtn2(evt:MouseEvent) : void
      {
         UIManager.castPanel.visible = true;
         UIManager.castPanel.openView(Enum_panel_cast.GEM_COMPOSE);
         this.visible = false;
      }
      
      private function onClickBtn3(evt:MouseEvent) : void
      {
         if(!UIManager.treasureBowlPanel)
         {
            UIManager.treasureBowlPanel = new View_treasureBowl();
            UIManager.treasureBowlPanel.init();
         }
         UIManager.treasureBowlPanel.visible = true;
         this.visible = false;
      }
      
      private function onClickBtn4(evt:MouseEvent) : void
      {
         UIManager.jjc_panel.visible = true;
         this.visible = false;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.width) / 2;
         y = (Global.stage.stageHeight - this.height) / 2;
      }
   }
}

