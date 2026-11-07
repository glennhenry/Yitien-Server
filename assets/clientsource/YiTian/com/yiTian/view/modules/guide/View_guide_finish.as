package com.yiTian.view.modules.guide
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.MainUIBase;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.system.ApplicationDomain;
   
   public class View_guide_finish extends MainUIBase
   {
      
      private var tip1:String;
      
      private var tip2:String;
      
      private var tip3:String;
      
      private var bg:Bitmap;
      
      private var Button_Huo:Button;
      
      private var guajiBtn:Button;
      
      private var CloseButton:Button;
      
      private var btnDm:ApplicationDomain;
      
      public function View_guide_finish()
      {
         var arr:Array;
         super();
         this.tip1 = LangConfig.getWord("50019",5);
         this.tip2 = LangConfig.getWord("50020",5);
         this.tip3 = LangConfig.getWord("50021",5);
         arr = [];
         arr.push(["lang/ch/guajiaBtn.swf",function(info:Object):void
         {
            btnDm = info.applicationDomain;
         },LangConfig.getWord("10626",1),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
         View_loading.instance.load(arr,init);
      }
      
      override protected function initStaticView() : void
      {
         var tf1:MyTextField;
         var tf2:MyTextField;
         var tf3:MyTextField;
         this.bg = ComponentUtil.getBitmap("guideBg",this,null,Global.guideMM);
         this.CloseButton = ComponentUtil.getButton("","Red_Close",this,{
            "x":540,
            "y":133
         },Global.Img_Cdm);
         this.CloseButton.callBack = this.closeClick;
         tf1 = ComponentUtil.getTextField(this.tip1,this,{
            "color":14013822,
            "x":260,
            "y":150,
            "realWidth":255,
            "wordWrap":true
         });
         tf2 = ComponentUtil.getTextField(this.tip2,this,{
            "color":6938422,
            "x":260,
            "y":237
         });
         tf3 = ComponentUtil.getTextField(this.tip3,this,{
            "color":6938422,
            "x":390,
            "y":237
         });
         this.Button_Huo = ComponentUtil.getButton("","Button_HuoDong",this,{
            "x":290,
            "y":195
         },ComponentUtil.domain);
         this.Button_Huo.callBack = this.huoClick;
         this.guajiBtn = ComponentUtil.getButton("","Button_GJTS",this,{
            "x":420,
            "y":195
         },this.btnDm);
         this.guajiBtn.callBack = function(evt:MouseEvent):void
         {
            Global.control.sendNotification(Enum_MsgType.MSG_GUAJIA,null);
            closeClick();
         };
         this.resetPosition();
      }
      
      private function closeClick(e:MouseEvent = null) : void
      {
         if(Boolean(this.bg) && Boolean(this.bg.bitmapData))
         {
            this.bg = null;
         }
         this.btnDm = null;
         parent.removeChild(this);
      }
      
      private function huoClick(e:MouseEvent) : void
      {
         UIManager.amPanel.visible = true;
         this.closeClick();
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 560) / 2;
         y = (Global.stage.stageHeight - 288) / 2;
      }
   }
}

