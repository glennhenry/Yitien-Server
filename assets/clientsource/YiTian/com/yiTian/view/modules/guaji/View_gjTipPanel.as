package com.yiTian.view.modules.guaji
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_GuaJi;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   
   public class View_gjTipPanel extends Panel
   {
      
      private var bg:ScaleBitmap;
      
      private var tf_info:MyTextField;
      
      private var titleBg:Bitmap;
      
      private var btn_ok:Button;
      
      public function View_gjTipPanel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         this.bg = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":398,
            "height":180
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":350,
            "height":130
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":364,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.tf_info = ComponentUtil.getTextField("",this,{
            "x":38,
            "realWidth":this.bg.width - 60,
            "y":65,
            "wordWrap":true,
            "size":14,
            "color":14662240
         });
         this.tf_info.autoSize = TextFieldAutoSize.CENTER;
         this.tf_info.htmlText = LangConfig.getWord("21175",2);
         this.btn_ok = ComponentUtil.getButton(LangConfig.getWord("29034",2),"Button_Four",this,{
            "x":168,
            "y":122,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn_ok.x = (this.bg.width - this.btn_ok.width) / 2;
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
         this.btn_ok.callBack = this.okClickHd;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.bg.width) / 2;
         y = (Global.stage.stageHeight - this.bg.height) / 2;
      }
      
      private function okClickHd(evt:MouseEvent) : void
      {
         this.hide();
      }
      
      public function hide() : void
      {
         this.visible = false;
      }
      
      public function show() : void
      {
         this.visible = true;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!Global.GuaJi_Imgsdm)
            {
               this.load();
            }
            else if(!this.titleBg)
            {
               this.sourceComplete();
            }
         }
      }
      
      private function load() : void
      {
         var arr:Array = [];
         arr.push([Enum_GuaJi.GUAJISOURCE,this.sourceComplete,LangConfig.getWord("20000",2),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
         View_loading.instance.load(arr,function():void
         {
            View_loading.instance.visible = false;
         });
      }
      
      private function sourceComplete(info:Object = null) : void
      {
         if(Boolean(info))
         {
            Global.GuaJi_Imgsdm = info.applicationDomain;
         }
         this.titleBg = ComponentUtil.getBitmap("Title_HLGuaJi",this,{
            "x":119,
            "y":5
         },Global.GuaJi_Imgsdm);
      }
   }
}

