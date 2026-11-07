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
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.message.cg.GuaJiCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   import flash.utils.getTimer;
   
   public class View_isAcceptShuangXiu extends Panel
   {
      
      private var titleBg:Bitmap;
      
      private var back:DisplayObject;
      
      private var btn_accept:Button;
      
      private var btn_unAccept:Button;
      
      private var tf_playerInfo:MyTextField;
      
      private var tf_timer:MyTextField;
      
      private var tf_warmTip:MyTextField;
      
      private var _startTime:int;
      
      private var _id:Number;
      
      private var _info:Object;
      
      public function View_isAcceptShuangXiu()
      {
         super();
         this.init1();
      }
      
      public function get id() : Number
      {
         return this._id;
      }
      
      public function get startTime() : int
      {
         return this._startTime;
      }
      
      private function init1() : void
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
         move = new Rectangle(0,0,270,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":364,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.tf_playerInfo = ComponentUtil.getTextField("",this,{
            "x":0,
            "y":52,
            "realWidth":398,
            "color":14662240
         });
         this.tf_playerInfo.autoSize = TextFieldAutoSize.CENTER;
         this.tf_timer = ComponentUtil.getTextField("",this,{
            "x":187,
            "y":73,
            "color":16776960,
            "size":24,
            "leading":0
         });
         this.tf_warmTip = ComponentUtil.getTextField("倒计时结束后默认为拒绝",this,{
            "x":136,
            "y":108,
            "color":13369344,
            "size":12,
            "leading":0
         });
         this.tf_playerInfo.selectable = false;
         this.tf_playerInfo.mouseEnabled = true;
         this.tf_playerInfo.addEventListener(TextEvent.LINK,this.linkHandle);
         this.btn_accept = ComponentUtil.getButton(LangConfig.getWord("29031",2),"Button_Four",this,{
            "x":100,
            "y":132,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn_accept.textColor = this.btn_accept.textOverColor = 10148472;
         this.btn_unAccept = ComponentUtil.getButton(LangConfig.getWord("29032",2),"Button_Four",this,{
            "x":227,
            "y":132,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn_unAccept.textColor = this.btn_unAccept.textOverColor = 10148472;
         CloseButton.callBack = this.unAcceptClickHandle;
         this.btn_accept.callBack = this.acceptClickHandle;
         this.btn_unAccept.callBack = this.unAcceptClickHandle;
      }
      
      private function linkHandle(evt:TextEvent) : void
      {
         Global.control.sendNotification(Enum_MsgType.MSG_CHECKOTHERROLE,this._id);
      }
      
      public function resetData(info:Object) : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
         var temp:String = info.name;
         var sex:int = int(info.sex);
         var nameStr:String = sex == 1 ? "<font color=\'#33CCFF\'>" + temp + "</font>" : "<font color=\'#DB7093\'>" + temp + "</font>";
         nameStr = HtmlUtil.createLink(nameStr);
         this.tf_playerInfo.htmlText = LangConfig.getWord("21174",2,nameStr);
         this._id = info.id;
         this._startTime = getTimer();
         this.visible = true;
      }
      
      public function setTimeRemain(remainNum:int) : void
      {
         this.tf_timer.htmlText = HtmlUtil.font(remainNum.toString(),ColorConstant.getColorStr(ColorConstant.ITEM_YELLOW),14);
      }
      
      private function acceptClickHandle(evt:MouseEvent) : void
      {
         GuaJiCGMessage.CG_SHUANGXIU_REQUEST_CHOOSE(1,this._id);
         Manager_acceptshuangXiu.getInstance().disposeItem(this);
      }
      
      private function unAcceptClickHandle(evt:MouseEvent) : void
      {
         GuaJiCGMessage.CG_SHUANGXIU_REQUEST_CHOOSE(2,this._id);
         Manager_acceptshuangXiu.getInstance().disposeItem(this);
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
         this.titleBg = ComponentUtil.getBitmap("Title_Prompt",this,{
            "x":119,
            "y":5
         },Global.GuaJi_Imgsdm);
      }
   }
}

