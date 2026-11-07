package com.yiTian.view.modules.huaShanLunJian.viewer
{
   import com.ui.constants.ScrollAutoType;
   import com.ui.containers.Canvas;
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.scene.GameScene;
   import com.yiTian.view.Panel123;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_HuaShanRulePanel2 extends Panel123
   {
      
      private var closeBtn:Button;
      
      private var tf_main:MyTextField;
      
      private var canvas:Canvas;
      
      public function View_HuaShanRulePanel2()
      {
         super();
         regResource("lang/ch/kuafuzhan_Imgs.swf","kuafuzhan_Imgsdm");
      }
      
      override protected function initUI2() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":526,
            "height":278
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":478,
            "height":228
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Cross_huashan",this,{
            "x":183,
            "y":5
         },Global.kuafuzhan_Imgsdm);
         move = new Rectangle(0,0,width,38);
         this.canvas = new Canvas(463,219);
         this.canvas.scrollAutoType = ScrollAutoType.TO_TOP;
         ComponentUtil.setPropertie(this.canvas,{
            "x":30,
            "y":45
         });
         addChild(this.canvas);
         this.closeBtn = ComponentUtil.getButton("","Button_Close",this,{
            "callBack":this.closeBtnClickHd,
            "x":width - 30,
            "y":5
         },Global.Img_Cdm);
         bindParent = GameScene.uiLayer;
         this.tf_main = ComponentUtil.getTextField("",this.canvas,{
            "realWidth":430,
            "multiline":true,
            "leading":5,
            "color":14662240
         });
         this.tf_main.wordWrap = true;
         this.tf_main.htmlText = LangConfig.getWord("29328",2);
         this.canvas.align();
      }
      
      private function closeBtnClickHd(event:MouseEvent) : void
      {
         visible = false;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 520) / 2;
         y = (Global.stage.stageHeight - 275) / 2;
      }
   }
}

