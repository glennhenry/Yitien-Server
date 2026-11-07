package com.yiTian.view.modules.bag
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_bag;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BagCGMessage;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_bagResetPwdApply extends Panel123
   {
      
      private var titleBg:Bitmap;
      
      private var backBitmap:ScaleBitmap;
      
      private var backLayer:Sprite;
      
      private var txtLayer:Sprite;
      
      private var dymLayer:Sprite;
      
      private var yesBtn:Button;
      
      private var noBtn:Button;
      
      public function View_bagResetPwdApply()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var txt:MyTextField;
         this.backLayer = new Sprite();
         addChild(this.backLayer);
         this.txtLayer = new Sprite();
         addChild(this.txtLayer);
         this.dymLayer = new Sprite();
         addChild(this.dymLayer);
         this.backBitmap = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.backLayer,{
            "x":0,
            "y":0,
            "width":328,
            "height":200
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this.backLayer,{
            "x":24,
            "y":40,
            "width":280,
            "height":150
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this.backLayer,{
            "x":34,
            "y":50,
            "width":260,
            "height":86
         },Global.Img_Cdm);
         move = new Rectangle(0,0,808,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":292,
            "y":6,
            "textColor":16184781,
            "callBack":function():void
            {
               visible = false;
            }
         },Global.Img_Cdm);
         txt = ComponentUtil.getTextField("    " + LangConfig.getWord("20032",11),this.txtLayer,{
            "x":55,
            "y":71,
            "realWidth":224,
            "color":13424242,
            "size":12,
            "wordWrap":true
         });
      }
      
      override protected function initDynamicView() : void
      {
         this.yesBtn = ComponentUtil.getButton(LangConfig.getWord("29034",2),"Button_Four",this.dymLayer,{
            "x":65,
            "y":151,
            "textColor":16184781,
            "callBack":this.onClickHandler
         },Global.Img_Cdm);
         this.noBtn = ComponentUtil.getButton(LangConfig.getWord("29035",2),"Button_Four",this.dymLayer,{
            "x":189,
            "y":151,
            "textColor":16184781,
            "callBack":this.onClickHandler
         },Global.Img_Cdm);
      }
      
      override protected function initUI2() : void
      {
         this.titleBg = ComponentUtil.getBitmap("Title_ChongZhi",this,{
            "x":84,
            "y":5
         },Global.EJiMiMa_Imgsdm);
      }
      
      private function onClickHandler(e:MouseEvent) : void
      {
         var btn:Button = e.target as Button;
         switch(btn)
         {
            case this.yesBtn:
               BagCGMessage.CG_BAG_PWD_TYPE_SETTING(Model_bag.PWD_TYPE_SETTING_3,"","","");
               break;
            case this.noBtn:
               UIManager.bagPwdAdSetting.visible = true;
         }
         this.visible = false;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!Global.EJiMiMa_Imgsdm)
            {
               regResource(Model_bag.EJiMiMaSOURCE_URL,"EJiMiMa_Imgsdm");
               preFun();
            }
            else if(!this.titleBg)
            {
               this.initUI2();
            }
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.width) / 2;
         y = (Global.stage.stageHeight - this.height) / 2;
      }
      
      override public function get width() : Number
      {
         return 328;
      }
      
      override public function get height() : Number
      {
         return 200;
      }
   }
}

