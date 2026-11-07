package com.yiTian.view.modules.huaShanLunJian.viewer
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.message.cg.HuaShanCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.huaShanLunJian.model.Model_HuaShan;
   import com.yiTian.view.modules.huaShanLunJian.util.HuaShanUtil;
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class View_HuaShanBaoMing extends Panel123
   {
      
      private var bg:DisplayObjectContainer;
      
      private var bm_main:Bitmap;
      
      private var tf_descript:MyTextField;
      
      private var tf_tipTf:MyTextField;
      
      private var tf_extraTip:MyTextField;
      
      private var btn_commit:Button;
      
      public function View_HuaShanBaoMing()
      {
         regResource("lang/ch/kuafuzhan_Imgs.swf","kuafuzhan_Imgsdm");
         bindParent = GameScene.uiLayer;
         super();
         this.initB();
      }
      
      override protected function initUI2() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.bg,{
            "x":0,
            "y":0,
            "width":508,
            "height":320
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.bg,{
            "x":24,
            "y":40,
            "width":460,
            "height":270
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Cross_baoming",this,{
            "x":174,
            "y":5
         },Global.kuafuzhan_Imgsdm);
         this.bm_main = ComponentUtil.getBitmap("Dargent",this,{
            "x":30,
            "y":50
         },Global.kuafuzhan_Imgsdm);
      }
      
      private function initB() : void
      {
         this.bg = new Sprite();
         this.bg.mouseEnabled = false;
         addChild(this.bg);
         move = new Rectangle(0,0,this.bg.width,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":474,
            "y":6
         },Global.Img_Cdm);
         this.bm_main = new Bitmap();
         this.bm_main.x = 30;
         this.bm_main.y = 46;
         addChild(this.bm_main);
         this.tf_descript = ComponentUtil.getTextField("",this,{
            "x":230,
            "y":45,
            "color":14013809,
            "leading":4
         });
         this.tf_descript.multiline = true;
         this.tf_descript.htmlText = LangConfig.getWord("29324",2);
         this.tf_extraTip = ComponentUtil.getTextField(LangConfig.getWord("29325",2),this,{
            "x":230,
            "y":259,
            "color":11162965
         });
         this.btn_commit = ComponentUtil.getButton("","Button_Orange",this,{
            "x":299,
            "y":281,
            "callBack":this.commitClickHd
         },Global.Img_Cdm);
         initDynamicView();
      }
      
      private function handleTxtChange(txt:String) : void
      {
         this.tf_descript.htmlText = txt;
      }
      
      public function update() : void
      {
         var model:Model_HuaShan = Singleton.getInstance(Model_HuaShan) as Model_HuaShan;
         switch(model.matchState)
         {
            case 1:
               this.btn_commit.label = LangConfig.getWord("29326",2);
               break;
            case 2:
               this.btn_commit.label = LangConfig.getWord("29327",2);
         }
      }
      
      private function commitClickHd(event:MouseEvent) : void
      {
         var model:Model_HuaShan = Singleton.getInstance(Model_HuaShan) as Model_HuaShan;
         model.btnBaoMingClickTime = getTimer();
         switch(model.matchState)
         {
            case 1:
               HuaShanCGMessage.CG_HS_COMMIT();
               break;
            case 2:
               HuaShanUtil.REQTEAMINFO();
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.bg.width) / 2;
         y = (Global.stage.stageHeight - this.bg.height) / 2;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
      }
   }
}

