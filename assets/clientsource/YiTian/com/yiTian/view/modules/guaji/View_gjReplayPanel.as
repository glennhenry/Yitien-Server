package com.yiTian.view.modules.guaji
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.config.Enum_GuaJi;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.manager.BattleManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   
   public class View_gjReplayPanel extends Panel
   {
      
      private var titleBg:Bitmap;
      
      private var _tf_info:MyTextField;
      
      private var _tf_rePlay:MyTextField;
      
      private var _btn_ok:Button;
      
      private var _vo:Vo_GuaJiReplay;
      
      public function View_gjReplayPanel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
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
         move = new Rectangle(0,0,398,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":364,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this._tf_info = ComponentUtil.getTextField("",this,{
            "x":103,
            "y":60,
            "color":14662240,
            "size":12,
            "leading":0,
            "realWidth":212.8
         });
         this._tf_info.autoSize = TextFieldAutoSize.CENTER;
         this._tf_rePlay = ComponentUtil.getTextField("",this,{
            "x":173,
            "y":89,
            "color":13369344,
            "size":12,
            "leading":0
         });
         this._btn_ok = ComponentUtil.getButton(LangConfig.getWord("29034",2),"Button_Four",this,{
            "x":166,
            "y":123,
            "textColor":16184781
         },Global.Img_Cdm);
      }
      
      override protected function initDynamicView() : void
      {
         this._tf_info.mouseEnabled = true;
         this._tf_rePlay.mouseEnabled = true;
         CloseButton.addEventListener(MouseEvent.CLICK,this.okClickHandle);
         var str_temp:String = HtmlUtil.createLink(LangConfig.getWord("29140",2));
         str_temp = HtmlUtil.font(str_temp,ColorConstant.getColorStr(ColorConstant.RED));
         this._tf_rePlay.htmlText = str_temp;
         this._tf_info.addEventListener(TextEvent.LINK,this.linkHandle);
         this._tf_rePlay.addEventListener(TextEvent.LINK,this.checkHandle);
         this._btn_ok.callBack = this.okClickHandle;
      }
      
      protected function checkHandle(evt:TextEvent) : void
      {
         evt.stopPropagation();
         BattleManager.init(this._vo);
         this.hide();
      }
      
      protected function linkHandle(evt:TextEvent) : void
      {
         Global.control.sendNotification(Enum_MsgType.MSG_CHECKOTHERROLE,this._vo.unitId);
         evt.stopPropagation();
      }
      
      protected function okClickHandle(evt:MouseEvent) : void
      {
         evt.stopPropagation();
         this.hide();
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      public function set vo(value:Vo_GuaJiReplay) : void
      {
         if(value == null)
         {
            this._tf_info.text = "";
         }
         this._vo = value;
         var linkStr:String = HtmlUtil.createLink(value.opponentName);
         this._tf_info.htmlText = HtmlUtil.font(linkStr,ColorConstant.getColorStr(ColorConstant.GREEN)) + HtmlUtil.font(LangConfig.getWord("21176",2),ColorConstant.getColorStr(ColorConstant.WHITE)) + Enum_GuaJi.LINGQIHTMLNAME12[value.lqType];
      }
      
      public function hide() : void
      {
         this.visible = false;
         this._vo = null;
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
         this.titleBg = ComponentUtil.getBitmap("Title_ZhanBao",this,{
            "x":119,
            "y":5
         },Global.GuaJi_Imgsdm);
      }
   }
}

