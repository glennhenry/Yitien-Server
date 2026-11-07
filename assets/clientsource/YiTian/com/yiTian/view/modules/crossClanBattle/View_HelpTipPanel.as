package com.yiTian.view.modules.crossClanBattle
{
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Enum_explor;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class View_HelpTipPanel extends Panel
   {
      
      private var bg:DisplayObjectContainer;
      
      private var tf:MyTextField;
      
      private var back1:ScaleBitmap;
      
      private var back2:ScaleBitmap;
      
      private var isUIComplete:Boolean = false;
      
      private var titleBgOut:Bitmap;
      
      private var titleBgIn:Bitmap;
      
      private var isOut:Boolean;
      
      public function View_HelpTipPanel()
      {
         super();
         init();
      }
      
      public static function get instance() : View_HelpTipPanel
      {
         return Singleton.getInstance(View_HelpTipPanel);
      }
      
      override protected function initStaticView() : void
      {
         this.bg = new Sprite();
         this.bg.mouseEnabled = false;
         addChild(this.bg);
         this.back1 = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.bg,{
            "x":0,
            "y":0,
            "width":498,
            "height":415
         },Global.Img_Cdm);
         this.back2 = ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.bg,{
            "x":24,
            "y":40,
            "width":450,
            "height":365
         },Global.Img_Cdm);
         move = new Rectangle(0,0,433,38);
         this.tf = ComponentUtil.getTextField("",this,{
            "x":38,
            "y":50,
            "realWidth":435,
            "color":14013809,
            "multiline":true,
            "wordWrap":true,
            "leading":5
         });
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":464,
            "y":6
         },Global.Img_Cdm);
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
      }
      
      override public function set visible(value:Boolean) : void
      {
         var arr:Array = null;
         if(value)
         {
            if(!this.isUIComplete)
            {
               if(!Global.KFBang_CCdm)
               {
                  arr = [];
                  arr.push(["lang/ch/KFBang_CC.swf",function(info:Object):void
                  {
                     Global.KFBang_CCdm = info.applicationDomain;
                  },LangConfig.getWord("20000",2),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
                  View_loading.instance.load(arr,function():void
                  {
                     initT();
                     visible = true;
                     View_loading.instance.visible = false;
                  });
                  return;
               }
               this.initT();
            }
            bind_target = Enum_explor.bind(Enum_explor.BTN_CROSS_CLAN_HELP);
         }
         super.visible = value;
      }
      
      private function initT() : void
      {
         this.isUIComplete = true;
         this.titleBgOut = ComponentUtil.getBitmap("Title_GuiZe",this.bg,{
            "x":159,
            "y":5
         },Global.KFBang_CCdm);
         this.titleBgIn = ComponentUtil.getBitmap("Title_JieShao",this.bg,{
            "x":159,
            "y":5
         },Global.KFBang_CCdm);
         if(this.isOut == true)
         {
            this.checkTitleBgVisible(true);
         }
         else
         {
            this.checkTitleBgVisible(false);
         }
      }
      
      private function checkTitleBgVisible(value:Boolean) : void
      {
         if(!this.titleBgOut)
         {
            return;
         }
         this.titleBgOut.visible = value;
         this.titleBgIn.visible = !value;
      }
      
      public function showOut() : void
      {
         this.visible = true;
         this.isOut = true;
         this.checkTitleBgVisible(true);
         this.back1.height = 545;
         this.back2.height = 495;
         this.tf.htmlText = LangConfig.getWord("225",9);
         this.resetPosition();
      }
      
      public function showIn() : void
      {
         this.visible = true;
         this.isOut = false;
         this.checkTitleBgVisible(false);
         this.back1.height = 415;
         this.back2.height = 365;
         this.tf.htmlText = LangConfig.getWord("226",9);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

