package com.yiTian.view.modules.keJu
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_KeJu;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_XS_Introduce extends Panel
   {
      
      private static var _instance:View_XS_Introduce;
      
      private var titleBg:Bitmap;
      
      private var back:ScaleBitmap;
      
      private var back2:ScaleBitmap;
      
      private var joinButton:Button;
      
      private var clickHandler:Function;
      
      public function View_XS_Introduce()
      {
         super();
         init();
      }
      
      public static function get instance() : View_XS_Introduce
      {
         if(!_instance)
         {
            _instance = new View_XS_Introduce();
         }
         return _instance;
      }
      
      override protected function initStaticView() : void
      {
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":460,
            "height":330
         },Global.Img_Cdm);
         this.back2 = ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":412,
            "height":280
         },Global.Img_Cdm);
         move = new Rectangle(0,0,460,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":424,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         var content:MyTextField = ComponentUtil.getTextField("",this,{
            "x":39,
            "y":50,
            "color":16184781,
            "size":12,
            "leading":3
         });
         content.multiline = true;
         content.htmlText = LangConfig.getWord("1118",0);
         ComponentUtil.getTextField(LangConfig.getWord("80035",8),this,{
            "x":171,
            "y":50,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("80036",8),this,{
            "x":267,
            "y":50,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("14:15-15:15",this,{
            "x":195,
            "y":50,
            "color":2149919,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("15:15-15:45",this,{
            "x":291,
            "y":50,
            "color":2149919,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("80037",8),this,{
            "x":112,
            "y":101,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("80038",8),this,{
            "x":184,
            "y":169,
            "color":2149919,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("80039",8),this,{
            "x":339,
            "y":186,
            "color":2149919,
            "size":12,
            "leading":0
         });
         var tf:MyTextField = ComponentUtil.getTextField("",this,{
            "x":39,
            "y":254,
            "color":2149919,
            "size":12,
            "leading":3
         });
         tf.multiline = true;
         tf.htmlText = LangConfig.getWord("80045",8);
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
         this.joinButton = ComponentUtil.getButton(LangConfig.getWord("80054",8),"Button_Four",this,null,Global.Img_Cdm);
         this.joinButton.x = (width - this.joinButton.width) / 2;
         this.joinButton.y = 295;
         this.joinButton.addEventListener(MouseEvent.CLICK,this.onClick);
         this.joinButton.visible = false;
         this.titleBg = new Bitmap();
         addChild(this.titleBg);
         this.titleBg.x = 150;
         this.titleBg.y = 5;
      }
      
      private function onClick(event:MouseEvent) : void
      {
         if(this.clickHandler != null)
         {
            this.clickHandler();
            this.clickHandler = null;
            this.visible = false;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!Global.KeJu_Imgsdm)
            {
               this.load();
            }
            else
            {
               this.sourceComplete();
            }
         }
      }
      
      public function show(fun:Function = null) : void
      {
         if(fun != null)
         {
            this.back.height = 330 + 10;
            this.back2.height = 280 + 10;
            this.clickHandler = fun;
            this.joinButton.visible = true;
         }
         else
         {
            this.back.height = 330;
            this.back2.height = 280;
            this.joinButton.visible = false;
         }
         this.visible = true;
      }
      
      private function load() : void
      {
         var arr:Array = [];
         arr.push([Enum_KeJu.KEJUSOURCE,this.sourceComplete,LangConfig.getWord("20000",2),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
         View_loading.instance.load(arr,function():void
         {
            View_loading.instance.visible = false;
         });
      }
      
      private function sourceComplete(info:Object = null) : void
      {
         if(Boolean(info))
         {
            Global.KeJu_Imgsdm = info.applicationDomain;
         }
         var url:String = this.clickHandler != null ? "Title_XiangShi" : "KeJu_JianSao_txt";
         this.titleBg.bitmapData = ComponentUtil.getBitmapData(url,Global.KeJu_Imgsdm);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

