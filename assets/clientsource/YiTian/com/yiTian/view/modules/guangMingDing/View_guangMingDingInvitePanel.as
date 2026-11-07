package com.yiTian.view.modules.guangMingDing
{
   import com.ui.controls.Tapper;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.GuangMingDingCGMessage;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.activity.DefaultTappBtnFac;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class View_guangMingDingInvitePanel extends Panel123
   {
      
      public var _tapper:Tapper;
      
      public var _friendList:Child_InviteList;
      
      public var _bangList:Child_InviteList;
      
      private var _bg:DisplayObject;
      
      private var lastFastInviteTime:int = -60000;
      
      private var lastRefreshTime:int = 0;
      
      public function View_guangMingDingInvitePanel()
      {
         super();
         regResource("lang/ch/GuangMingDing_Img.swf","GuangMingDing_Imgdm");
      }
      
      override protected function initUI2() : void
      {
         this._bg = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":468,
            "height":443
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":420,
            "height":393
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":34,
            "y":70,
            "width":400,
            "height":323
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this,{
            "x":44,
            "y":80,
            "width":380,
            "height":303
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_YaoQing",this,{
            "x":154,
            "y":5
         },Global.GuangMingDing_Imgdm);
         move = new Rectangle(0,0,this._bg.width,35);
         this._tapper = new Tapper(new DefaultTappBtnFac(),Global.stage);
         addChild(this._tapper);
         this._tapper.x = 43;
         this._tapper.y = 49;
         this._friendList = new Child_InviteList();
         this._bangList = new Child_InviteList();
         this._friendList.type = 1;
         this._bangList.type = 2;
         this._tapper.appendTapper({
            "label":"好友",
            "style":"TabButton_Four",
            "dm":Global.Img_Cdm,
            "type":1
         },this._friendList);
         this._tapper.appendTapper({
            "label":"帮会",
            "style":"TabButton_Four",
            "dm":Global.Img_Cdm,
            "type":2
         },this._bangList);
         ComponentUtil.getButton("快速邀请","Button_Four",this,{
            "x":133,
            "y":400,
            "textColor":16184781,
            "callBack":this.fastInviteClickHd
         },Global.Img_Cdm);
         ComponentUtil.getButton("刷新","Button_Four",this,{
            "x":255,
            "y":400,
            "textColor":16184781,
            "callBack":this.refreshClickHd
         },Global.Img_Cdm);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":434,
            "y":6,
            "callBack":this.hide
         },Global.Img_Cdm);
      }
      
      public function show(param:* = null) : void
      {
         this._tapper.setSelectedIndex(0);
         this.visible = true;
      }
      
      public function hide(param:* = null) : void
      {
         this.visible = false;
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_FUBEN,this.hide);
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_SCENE,this.hide);
            Global.control.registerCallBack(Msg_guangMingDing.TEAMPANEL_HIDE,this.hide);
            Global.control.registerCallBack(Msg_guangMingDing.MYTEAM_UPDATE,this.onTeamUpdate);
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTER_FUBEN,this.hide);
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTER_SCENE,this.hide);
            Global.control.removeCallBack(Msg_guangMingDing.TEAMPANEL_HIDE,this.hide);
            Global.control.removeCallBack(Msg_guangMingDing.MYTEAM_UPDATE,this.onTeamUpdate);
         }
         super.visible = value;
      }
      
      override public function get width() : Number
      {
         return this._bg.width;
      }
      
      override public function get height() : Number
      {
         return this._bg.height;
      }
      
      private function onTeamUpdate() : void
      {
         if(Model_guangMingDing.isLeader(GameUnitManager.hero.id) == false)
         {
            this.hide();
         }
      }
      
      private function fastInviteClickHd(e:MouseEvent) : void
      {
         if(Model_guangMingDing.teamInfo.length >= 3)
         {
            UIManager.centerBroadcast.addMsg("房间人数已满");
            return;
         }
         var now:int = getTimer();
         if(now - this.lastFastInviteTime > 60000)
         {
            GuangMingDingCGMessage.CG_GMD_INVITE_QUICKLY();
            this.lastFastInviteTime = now;
         }
         else
         {
            UIManager.centerBroadcast.addMsg("一分钟之内只能发送一次快速邀请");
         }
      }
      
      private function refreshClickHd(e:MouseEvent) : void
      {
         var now:int = getTimer();
         if(now - this.lastRefreshTime < 5000)
         {
            return;
         }
         this.lastRefreshTime = now;
         Global.control.sendNotification(Msg_guangMingDing.INVITE_REFRESH,null);
      }
   }
}

