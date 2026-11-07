package com.yiTian.view.modules.guangMingDing
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.text.TextFieldAutoSize;
   
   public class View_gmdLeaderApplyPnl extends Panel
   {
      
      private var btn_ok:Button;
      
      private var btn_cancel:Button;
      
      private var tf_info:MyTextField;
      
      public var memberId:Number = 0;
      
      public var _fun:Function;
      
      public var _param:*;
      
      public function View_gmdLeaderApplyPnl()
      {
         super();
         bindParent = GameScene.sysLayer;
         this.init2();
      }
      
      public static function get instance() : View_gmdLeaderApplyPnl
      {
         return Singleton.getInstance(View_gmdLeaderApplyPnl);
      }
      
      private function init2() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":308,
            "height":185
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":260,
            "height":110
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_Prompt",this,{
            "x":74,
            "y":5
         },Global.Img_Cdm);
         this.tf_info = ComponentUtil.getTextField("",this,{
            "x":157,
            "y":75,
            "color":16184781,
            "realWidth":0,
            "leading":5
         });
         this.tf_info.align = "center";
         this.tf_info.autoSize = TextFieldAutoSize.CENTER;
         this.tf_info.multiline = true;
         this.tf_info.mouseEnabled = true;
         this.tf_info.addEventListener(TextEvent.LINK,this.onLinkEvent);
         this.btn_ok = ComponentUtil.getButton(LangConfig.getWord("29034",2),"Button_Four",this,{
            "x":55,
            "y":152,
            "textColor":16184781,
            "callBack":this.okClick
         },Global.Img_Cdm);
         this.btn_cancel = ComponentUtil.getButton(LangConfig.getWord("10598",1),"Button_Four",this,{
            "x":180,
            "y":152,
            "textColor":16184781,
            "callBack":this.hide
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":278,
            "y":6,
            "callBack":this.hide
         },Global.Img_Cdm);
         Global.control.registerCallBack(Msg_guangMingDing.TEAMPANEL_HIDE,this.hide);
      }
      
      private function okClick(e:MouseEvent) : void
      {
         if(Boolean(this._fun.length))
         {
            this._fun(this._param);
         }
         else
         {
            this._fun();
         }
         this._fun = null;
         this._param = null;
         this.hide();
      }
      
      private function hide(e:* = null) : void
      {
         visible = false;
      }
      
      public function applyFun(label:String, fun:Function, ... param) : void
      {
         this._fun = fun;
         this._param = param;
         this.tf_info.htmlText = label;
         visible = true;
      }
      
      private function onLinkEvent(e:Event) : void
      {
         Global.control.sendNotification(Enum_MsgType.MSG_CHECKOTHERROLE,this.memberId);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

