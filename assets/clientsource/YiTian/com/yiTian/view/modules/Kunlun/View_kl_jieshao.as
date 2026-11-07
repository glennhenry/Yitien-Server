package com.yiTian.view.modules.Kunlun
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class View_kl_jieshao extends Panel
   {
      
      private var bg:DisplayObjectContainer;
      
      private var tf:MyTextField;
      
      private var isUIComplete:Boolean = false;
      
      public function View_kl_jieshao()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         this.bg = new Sprite();
         this.bg.mouseEnabled = false;
         addChild(this.bg);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.bg,{
            "x":0,
            "y":0,
            "width":458,
            "height":400
         },Global.Img_Cdm);
         move = new Rectangle(0,0,433,38);
         this.tf = ComponentUtil.getTextField("",this,{
            "x":38,
            "y":50,
            "realWidth":400,
            "color":14013809,
            "multiline":true,
            "wordWrap":true,
            "leading":5
         });
         this.tf.htmlText = LangConfig.getWord("20003",2);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":424,
            "y":6
         },Global.Img_Cdm);
      }
      
      override public function set visible(value:Boolean) : void
      {
         var arr:Array = null;
         if(value)
         {
            if(!this.isUIComplete)
            {
               if(!Global.KunLun_Imgsdm)
               {
                  arr = [];
                  arr.push(["lang/ch/KunLun_Imgs.swf",function(info:Object):void
                  {
                     Global.KunLun_Imgsdm = info.applicationDomain;
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
         }
         super.visible = value;
      }
      
      private function initT() : void
      {
         this.isUIComplete = true;
         var bm:Bitmap = new Bitmap();
         this.bg.addChild(bm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.bg,{
            "x":24,
            "y":40,
            "width":410,
            "height":350
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_KLJieShao",this.bg,{
            "x":119,
            "y":5
         },Global.KunLun_Imgsdm);
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

