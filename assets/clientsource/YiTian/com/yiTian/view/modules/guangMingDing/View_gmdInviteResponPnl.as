package com.yiTian.view.modules.guangMingDing
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.handler.GuangMingDingCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class View_gmdInviteResponPnl extends Panel123
   {
      
      private var _tfInfo:MyTextField;
      
      private var _tfTimer:MyTextField;
      
      private var _timer:Timer;
      
      private var count:int = 0;
      
      private var _hostID:Number;
      
      private var _targetRoom:int;
      
      private var _pw:String;
      
      public function View_gmdInviteResponPnl()
      {
         super();
         this.initUI2();
      }
      
      public static function get instance() : View_gmdInviteResponPnl
      {
         return Singleton.getInstance(View_gmdInviteResponPnl);
      }
      
      override protected function initUI2() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":338,
            "height":235
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":23,
            "y":39,
            "width":290,
            "height":185
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":34,
            "y":50,
            "width":270,
            "height":130
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_Prompt",this,{
            "x":77,
            "y":5
         },Global.Img_Cdm);
         this._tfInfo = ComponentUtil.getTextField("",this,{
            "x":width / 2,
            "y":73,
            "color":13424242,
            "realWidth":0,
            "leading":4
         });
         var _temp_1:* = this._tfInfo;
         this._tfInfo.autoSize = "center";
         _temp_1.align = "center";
         this._tfTimer = ComponentUtil.getTextField("",this,{
            "x":152,
            "y":123,
            "color":16383744,
            "size":28
         });
         ComponentUtil.getButton("接受","Button_Four",this,{
            "x":77,
            "y":188,
            "textColor":16184781,
            "callBack":this.acceptClickHd
         },Global.Img_Cdm);
         ComponentUtil.getButton("拒绝","Button_Four",this,{
            "x":190,
            "y":188,
            "textColor":16184781,
            "callBack":this.unAcceptClickHd
         },Global.Img_Cdm);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":304,
            "y":6
         },Global.Img_Cdm);
         this._tfInfo.mouseEnabled = true;
         this._tfInfo.addEventListener(TextEvent.LINK,this.infoLinkHd);
         this._timer = new Timer(1000);
         this._timer.addEventListener(TimerEvent.TIMER,this.onTimer);
      }
      
      private function onTimer(e:TimerEvent) : void
      {
         this.count += 1;
         this._tfTimer.text = Enum_BroadCastTool.instance.getBitStr(10 - this.count);
         if(this.count >= 11)
         {
            this.visible = false;
         }
      }
      
      private function infoLinkHd(e:TextEvent) : void
      {
         Global.control.sendNotification(Enum_MsgType.MSG_CHECKOTHERROLE,this._hostID);
      }
      
      public function show(hostID:Number, hostName:String, targetRoom:Number) : void
      {
         this._targetRoom = targetRoom;
         this._hostID = hostID;
         var nameTxt:String = "<font color=\'#ffff33\'>" + HtmlUtil.createLink(hostName) + "</font>";
         var roomTxt:String = targetRoom.toString();
         this._tfInfo.htmlText = LangConfig.reTxt("{0}邀请您加入到\n光眀顶NO.{1}房间",nameTxt,roomTxt);
         this._tfTimer.text = "10";
         this.visible = true;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.count = 0;
            this._timer.reset();
            this._timer.start();
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_FUBEN,this.onSceneChange);
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_SCENE,this.onSceneChange);
         }
         else
         {
            this._timer.stop();
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTER_FUBEN,this.onSceneChange);
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTER_SCENE,this.onSceneChange);
         }
      }
      
      private function onSceneChange() : void
      {
         this.visible = false;
      }
      
      private function acceptClickHd(e:MouseEvent) : void
      {
         if(!GuangMingDingConfig.isCanJoin())
         {
            return;
         }
         GuangMingDingCGMessage.CG_GMD_INVITE_RESPON(this._targetRoom,"-1");
         this.visible = false;
      }
      
      private function unAcceptClickHd(e:MouseEvent) : void
      {
         this._targetRoom = 0;
         this._pw = null;
         this.visible = false;
      }
   }
}

