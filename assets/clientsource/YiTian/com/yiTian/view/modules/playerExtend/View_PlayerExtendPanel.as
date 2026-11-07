package com.yiTian.view.modules.playerExtend
{
   import com.ui.controls.Button;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.manager.BattleManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.ChatCGMessage;
   import com.yiTian.net.message.cg.FriendCGMessage;
   import com.yiTian.net.message.cg.RoleCGMessage;
   import com.yiTian.net.message.cg.TeamCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.friends.Model_Friends;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.system.System;
   import flash.text.TextField;
   
   public class View_PlayerExtendPanel extends Panel
   {
      
      public static var _chatContant:String;
      
      private static var _instance:View_PlayerExtendPanel;
      
      public static var _priChatOtherRoleId:Number = 0;
      
      public static var _OtherRoleName:String = "name";
      
      private var Button_CheckInformat:Button;
      
      private var Button_InviteTeam:Button;
      
      private var Button_Chat:Button;
      
      private var Button_JiaoYi:Button;
      
      private var Button_FriendShip:Button;
      
      private var Button_blackHim:Button;
      
      private var Button_Watch:Button;
      
      private var Button_CopyName:Button;
      
      private var btnPro:Array;
      
      private var back:DisplayObject;
      
      private var back2:ScaleBitmap;
      
      private var btnArr:Array = [];
      
      public var numItemShow:int = 0;
      
      public function View_PlayerExtendPanel()
      {
         super();
         this.btnPro = [{
            "label":LangConfig.getWord("899",0),
            "style":"ChannelButtonFour",
            "property":{
               "textColor":14013822,
               "callBack":this.teamHandle
            }
         },{
            "label":LangConfig.getWord("900",0),
            "style":"ChannelButtonFour",
            "property":{
               "textColor":14013822,
               "callBack":this.checkInformat
            }
         },{
            "label":LangConfig.getWord("901",0),
            "style":"ChannelButtonFour",
            "property":{
               "textColor":14013822,
               "callBack":this.downHandle
            }
         },{
            "label":LangConfig.getWord("70",0),
            "style":"ChannelButtonFour",
            "property":{
               "textColor":14013822,
               "callBack":this.jiaoyiHandle
            }
         },{
            "label":LangConfig.getWord("364",0),
            "style":"ChannelButtonFour",
            "property":{
               "textColor":14013822,
               "callBack":this.friInformat
            }
         },{
            "label":LangConfig.getWord("902",0),
            "style":"ChannelButtonFour",
            "property":{
               "textColor":14013822,
               "callBack":this.copyHandle
            }
         },{
            "label":LangConfig.getWord("1130",0),
            "style":"ChannelButtonFour",
            "property":{
               "textColor":14013822,
               "callBack":this.pingBi
            }
         },{
            "label":"私聊",
            "style":"ChannelButtonFour",
            "property":{
               "textColor":14013822,
               "callBack":this.crossServChat
            }
         },{
            "label":"添加好友",
            "style":"ChannelButtonFour",
            "property":{
               "textColor":14013822,
               "callBack":this.addFriendServ
            }
         }];
         bindParent = GameScene.sysLayer;
         this.initB();
      }
      
      public static function get instance() : View_PlayerExtendPanel
      {
         if(!_instance)
         {
            _instance = new View_PlayerExtendPanel();
         }
         return _instance;
      }
      
      public function initB() : void
      {
         var obj:Object = null;
         var btn:Button = null;
         this.back2 = ComponentUtil.getScaleBitmap("Back_Floating",[8,9,4,2],this,{
            "width":85,
            "height":18
         },Global.Img_Cdm);
         Global.control.registerCallBack(Enum_MsgType.MSG_PRIVATE_CHAT,this.sendPriChat);
         var i:int = 0;
         while(i < this.btnPro.length)
         {
            obj = this.btnPro[i];
            btn = ComponentUtil.getButton(obj.label,obj.style,this,{
               "x":2.5,
               "y":2.5 + 20 * i,
               "textColor":obj.property.textColor,
               "callBack":obj.property.callBack
            },ComponentUtil.domain);
            this.btnArr.push(btn);
            i++;
         }
         this.back2.width = 85;
         this.back2.height = 20 * this.btnArr.length + 6;
      }
      
      private function copyHandle(e:MouseEvent) : void
      {
         System.setClipboard(_OtherRoleName);
         this.visible = false;
      }
      
      private function reset() : void
      {
         var btn:Button = null;
         for each(btn in this.btnArr)
         {
            btn.visible = false;
            this.back2.width = 0;
            this.back2.height = 0;
         }
      }
      
      public function getItem(bool:Boolean, ... parem) : void
      {
         var _arr:Array = null;
         var i:int = 0;
         var _ind:int = 0;
         var btn:Button = null;
         var j:int = 0;
         var _btn:Button = null;
         this.reset();
         this.numItemShow = 7;
         if(!bool)
         {
            _arr = [];
            this.numItemShow = parem.length;
            i = 0;
            while(i < this.numItemShow)
            {
               _ind = int(parem[i]);
               btn = this.btnArr[_ind - 1] as Button;
               ComponentUtil.setPropertie(btn,{
                  "x":2.5,
                  "y":2.5 + 20 * i
               });
               btn.visible = true;
               this.back2.width = 85;
               i++;
            }
         }
         else
         {
            this.numItemShow = 0;
            j = 0;
            while(j < 7)
            {
               this.numItemShow += 1;
               _btn = this.btnArr[j] as Button;
               ComponentUtil.setPropertie(_btn,{
                  "x":2.5,
                  "y":2.5 + 20 * j
               });
               _btn.visible = true;
               this.back2.width = 85;
               j++;
            }
         }
         this.back2.height = 20 * this.numItemShow + 6;
      }
      
      public function get perfectHeight() : Number
      {
         return this.numItemShow * 20 + 6;
      }
      
      private function pingBi(e:MouseEvent) : void
      {
         this.visible = false;
         if(Model_Friends.getHeatVoById(_priChatOtherRoleId) != null)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("1131",0));
            return;
         }
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("1132",0));
         if(Boolean(_chatContant))
         {
            trace(_chatContant);
         }
         FriendCGMessage.CG_ADD_CONTACT_BY_TYPE(2,_OtherRoleName);
      }
      
      private function friInformat(e:MouseEvent) : void
      {
         if(BattleManager.isPlaying)
         {
            return;
         }
         FriendCGMessage.CG_ADD_FRIEND(_OtherRoleName);
         this.visible = false;
      }
      
      private function checkInformat(e:MouseEvent) : void
      {
         this.visible = false;
         RoleCGMessage.CG_CHECK_OTHERROLE(_priChatOtherRoleId);
      }
      
      private function dHandle(e:MouseEvent) : void
      {
         if(e.target is Button || e.target is TextField)
         {
            return;
         }
         this.visible = false;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(!value)
         {
            if(Boolean(parent))
            {
               parent.setChildIndex(this,numChildren - 1);
            }
            Global.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.dHandle);
         }
         else
         {
            Global.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.dHandle);
         }
      }
      
      private function teamHandle(e:MouseEvent) : void
      {
         if(BattleManager.isPlaying)
         {
            return;
         }
         this.visible = false;
         TeamCGMessage.CG_DIRECT_TEAM_STATE(0,_priChatOtherRoleId.toString());
      }
      
      private function jiaoyiHandle(e:MouseEvent) : void
      {
         if(BattleManager.isPlaying)
         {
            return;
         }
         this.visible = false;
         UIManager.trans_send_panel.visible = true;
         UIManager.trans_send_panel.setName(_OtherRoleName);
         if(!UIManager.bagPanel.visible)
         {
            UIManager.bagPanel.visible = true;
         }
      }
      
      private function functionOK() : void
      {
         Model_team.isCaptain[GameUnitManager.hero.id] = true;
         TeamCGMessage.CG_CREATE_TEAM();
      }
      
      private function downHandle(e:MouseEvent = null) : void
      {
         Global.control.sendNotification(Enum_MsgType.MSG_PRIVATE_CHAT,_priChatOtherRoleId);
         this.visible = false;
      }
      
      private function addFriendServ(e:MouseEvent = null) : void
      {
         if(GameUnitManager.hero.level < 40)
         {
            UIManager.centerBroadcast.addMsg("您的等级不足40，不能添加跨服好友");
            return;
         }
         FriendCGMessage.CG_ADD_FRIEND_SERV(_OtherRoleName);
         this.visible = false;
      }
      
      private function heatCrossServ(e:MouseEvent = null) : void
      {
         FriendCGMessage.CG_ADD_CROSSCONTACT(_priChatOtherRoleId,_OtherRoleName);
         this.visible = false;
      }
      
      private function crossServChat(e:MouseEvent = null) : void
      {
         if(GameUnitManager.hero.level < 30)
         {
            UIManager.centerBroadcast.addMsg("亲，您还未到30级不能私聊");
            return;
         }
         ChatCGMessage.CG_KUAFU_CHAT(_priChatOtherRoleId,_OtherRoleName);
         this.visible = false;
      }
      
      private function sendPriChat(roleId:Object) : void
      {
         if(GameUnitManager.hero.level < 30)
         {
            UIManager.centerBroadcast.addMsg("亲，您还未到30级不能私聊");
            return;
         }
         ChatCGMessage.CG_SID_CHAT(Number(roleId));
      }
   }
}

