package com.yiTian.view.modules.friends
{
   import Layout.HGroup;
   import Layout.ILayout;
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.config.Enum_CrossType;
   import com.yiTian.data.model.Model_bag;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.data.vo.Vo_unit;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.ChatCGMessage;
   import com.yiTian.net.message.cg.FriendCGMessage;
   import com.yiTian.net.message.cg.RoleCGMessage;
   import com.yiTian.net.message.cg.TeamCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.KFHomeland.HomeLandCGMessage;
   import com.yiTian.view.modules.KFHomeland.HomeLandGCMessage;
   import com.yiTian.view.modules.KFHomeland.VoHome;
   import com.yiTian.view.modules.guangMingDing.View_guangMingDingTeamPanel;
   import com.yiTian.view.modules.qiJu.View_JoinQiJu;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.system.System;
   import flash.utils.Dictionary;
   
   public class View_FriendSelectedMenu extends Sprite
   {
      
      private static var instance:View_FriendSelectedMenu;
      
      private static const borderOffset:Number = 3;
      
      private static const itemHeight:Number = 18;
      
      private var selectedItemVec:Vector.<Button>;
      
      private var callBackVec:Vector.<Function>;
      
      private var bg:DisplayObject;
      
      private var l:ILayout;
      
      private var mode:uint = 0;
      
      public var data:Vo_unit;
      
      private var button_buffer:Dictionary;
      
      public function View_FriendSelectedMenu()
      {
         super();
         if(Boolean(instance))
         {
            throw new Error("Friend_Selected_Menu singlon error");
         }
         instance = this;
         this.selectedItemVec = new Vector.<Button>();
         this.bg = ComponentUtil.getScaleBitmap("Back_Floating",[8,9,4,2],this,{
            "x":0,
            "y":0,
            "width":87,
            "height":95
         },Global.Img_Cdm);
         GameScene.uiLayer.addChild(this);
         Global.stage.addEventListener(MouseEvent.CLICK,function(evt:MouseEvent):void
         {
            View_FriendSelectedMenu.getInstance().resetMode();
         });
         addEventListener(MouseEvent.CLICK,this.mouseClickHandle);
         this.l = new HGroup(3,3,0,0,0,itemHeight);
         this.button_buffer = new Dictionary();
      }
      
      public static function getInstance() : View_FriendSelectedMenu
      {
         if(instance)
         {
         }
         return instance;
      }
      
      public function setFrienSelectedItem() : void
      {
         this.show();
         if(this.mode != 1)
         {
            this.cleanItem();
            this.mode = 1;
            this.addItem(LangConfig.getWord("29076",2),this.chatTalkClickHandle);
            this.addItem(LangConfig.getWord("29077",2),this.applyTeamHandle);
            this.addItem(LangConfig.getWord("29078",2),this.sendMail);
            this.addItem(LangConfig.getWord("29079",2),this.transHandle);
            this.addItem("参观家园",this.visitFriendHome,16751052);
            this.addItem(LangConfig.getWord("29245",2),this.bestowFlowerHandle,16751052);
            this.addItem(LangConfig.getWord("29080",2),this.checkInfoClickHandle);
            this.addItem(LangConfig.getWord("29081",2),this.copyName);
            this.addItem(LangConfig.getWord("29082",2),this.delFriendClickHandle);
            this.addItem(LangConfig.getWord("29083",2),this.moveToHeatClickHandle);
         }
         this.align();
      }
      
      public function setHeatSelectedItem() : void
      {
         this.show();
         if(this.mode != 2)
         {
            this.cleanItem();
            this.mode = 2;
            this.addItem(LangConfig.getWord("29076",2),this.chatTalkClickHandle);
            this.addItem(LangConfig.getWord("29080",2),this.checkInfoClickHandle);
            this.addItem(LangConfig.getWord("29081",2),this.copyName);
            this.addItem(LangConfig.getWord("29085",2),this.delHeatClickHandle);
            this.addItem(LangConfig.getWord("29084",2),this.moToFriendClickHandle);
         }
         this.align();
      }
      
      public function setQQSelectedItem() : void
      {
         this.show();
         if(this.mode != 3)
         {
            this.cleanItem();
            this.mode = 3;
            this.addItem(LangConfig.getWord("29076",2),this.chatTalkClickHandle);
            this.addItem(LangConfig.getWord("29077",2),this.applyTeamHandle);
            this.addItem(LangConfig.getWord("29078",2),this.sendMail);
            this.addItem(LangConfig.getWord("29079",2),this.transHandle);
            this.addItem(LangConfig.getWord("29080",2),this.checkInfoClickHandle);
            this.addItem(LangConfig.getWord("29084",2),this.moToFriendClickHandle);
            this.addItem(LangConfig.getWord("29081",2),this.copyName);
         }
         this.align();
      }
      
      public function setCrossFriend() : void
      {
         this.show();
         if(this.mode != 4)
         {
            this.cleanItem();
            this.mode = 4;
            this.addItem(LangConfig.getWord("29076",2),this.crossChatHandle);
            this.addItem(LangConfig.getWord("29081",2),this.copyName);
            this.addItem("参观家园",this.visitFriendHome,16751052);
            this.addItem(LangConfig.getWord("29245",2),this.crossSendFlower,16751052);
            this.addItem(LangConfig.getWord("29083",2),this.crossFriendToHeat);
            this.addItem(LangConfig.getWord("29082",2),this.crossFriendDel);
         }
         this.align();
      }
      
      public function setCrossHeat() : void
      {
         this.show();
         if(this.mode != 5)
         {
            this.cleanItem();
            this.mode = 5;
            this.addItem(LangConfig.getWord("29076",2),this.crossChatHandle);
            this.addItem(LangConfig.getWord("29081",2),this.copyName);
            this.addItem(LangConfig.getWord("29084",2),this.crossHeatToFriend);
            this.addItem(LangConfig.getWord("29085",2),this.crossHeatDel);
         }
         this.align();
      }
      
      private function transHandle(evt:MouseEvent) : void
      {
         UIManager.trans_panel.show_trans_send(this.data.name);
      }
      
      private function align() : void
      {
         this.l.align();
         this.bg.height = this.selectedItemVec[this.selectedItemVec.length - 1].y + this.selectedItemVec[this.selectedItemVec.length - 1].height + 3;
      }
      
      private function visitFriendHome(evt:MouseEvent) : void
      {
         var j:int = 0;
         var spr:Sprite = null;
         if(!VoHome.isActivity)
         {
            UIManager.centerBroadcast.addMsg("亲，现在不是家园系统开放期间，还不能参观。");
            return;
         }
         if(Model_team.hasTeam())
         {
            UIManager.centerBroadcast.addMsg("组队状态下不能参观好友家园，只能带队进入自己家园");
            return;
         }
         if(GameUnitManager.hero.level < 38)
         {
            UIManager.centerBroadcast.addMsg("等级不够，不能参观他人家园。");
            return;
         }
         if(!VoHome.isCreatHome)
         {
            UIManager.centerBroadcast.addMsg("亲，你还没有家园，不能参观其他人的家园。");
            return;
         }
         var pnl:View_guangMingDingTeamPanel = View_guangMingDingTeamPanel.getInstance();
         if(pnl.visible)
         {
            UIManager.centerBroadcast.addMsg("亲，你已在光眀顶创建队伍，不能进入家园。");
            return;
         }
         if(View_JoinQiJu.instance.visible)
         {
            UIManager.centerBroadcast.addMsg("亲，请先关闭珍龙棋局再进入家园。");
            return;
         }
         var i:int = UIManager.visiblePanels.length - 1;
         while(i >= 0)
         {
            j = UIManager.visiblePanels[i].length - 1;
            while(j >= 0)
            {
               spr = UIManager.visiblePanels[i][j] as Sprite;
               spr.visible = false;
               j--;
            }
            i--;
         }
         Global.crossType = Enum_CrossType.CROSS_HOME;
         HomeLandGCMessage.roleId = this.data.id;
         HomeLandGCMessage.type = 1;
         var isKF:int = 1;
         var qh:int = Model_heFu.getQuHao(this.data.name);
         if(qh != -1)
         {
            HomeLandGCMessage.zone = qh;
            isKF = 2;
         }
         else
         {
            HomeLandGCMessage.zone = this.data.zone;
         }
         HomeLandCGMessage.CG_ENTER_HOME_SCENE(2,Global.crossType,GameUnitManager.hero.id + "_1" + "_" + this.data.id + "_" + isKF + "_" + HomeLandGCMessage.zone);
      }
      
      private function bestowFlowerHandle(evt:MouseEvent) : void
      {
         if(this.data.isOnline)
         {
            UIManager.bestowFlower.show(this.data.id);
            UIManager.bestowFlower.visible = true;
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("60122",6));
         }
      }
      
      private function checkInfoClickHandle(evt:MouseEvent) : void
      {
         RoleCGMessage.CG_CHECK_OTHERROLE(this.data.id);
      }
      
      private function copyName(evt:MouseEvent) : void
      {
         System.setClipboard(this.data.name);
      }
      
      private function applyTeamHandle(evt:MouseEvent) : void
      {
         TeamCGMessage.CG_DIRECT_TEAM_STATE(0,this.data.id.toString());
      }
      
      private function sendMail(evt:MouseEvent) : void
      {
         Global.control.sendNotification(Enum_MsgType.MSG_SENDMAIL,this.data.name);
      }
      
      private function chatTalkClickHandle(evt:MouseEvent) : void
      {
         if(this.data.isOnline == false)
         {
            UIManager.centerBroadcast.addMsg("该好友不在线，不能进行私聊");
            return;
         }
         if(GameUnitManager.hero.level < 30)
         {
            UIManager.centerBroadcast.addMsg("亲，您还未到30级不能私聊");
            return;
         }
         ChatCGMessage.CG_SID_CHAT(this.data.id);
      }
      
      private function crossChatHandle(evt:MouseEvent) : void
      {
         if(GameUnitManager.hero.level < 30)
         {
            UIManager.centerBroadcast.addMsg("亲，您还未到30级不能私聊");
            return;
         }
         if(this.data.isOnline == false)
         {
            UIManager.centerBroadcast.addMsg("该玩家不在线，无法进行私聊");
            return;
         }
         ChatCGMessage.CG_KUAFU_CHAT(this.data.id,this.data.name);
      }
      
      private function crossSendFlower(evt:MouseEvent) : void
      {
         UIManager.bestowFlower.show(this.data.id,this.data.name);
         UIManager.bestowFlower.visible = true;
      }
      
      private function crossFriendToHeat(evt:MouseEvent) : void
      {
         FriendCGMessage.CG_ADD_CROSSCONTACT(this.data.id,this.data.name);
      }
      
      private function crossFriendDel(evt:MouseEvent) : void
      {
         if(Model_bag.pwdLockState == Model_bag.PWD_STATE_LOCK_T)
         {
            UIManager.bagPwdPutIn.visible = true;
            return;
         }
         FriendCGMessage.CG_DEL_CROSSFRIEND(this.data.id,this.data.name);
      }
      
      private function crossHeatToFriend(evt:MouseEvent) : void
      {
         FriendCGMessage.CG_CROSS_HEATTOFRIEND(this.data.id,this.data.name);
      }
      
      private function crossHeatDel(evt:MouseEvent) : void
      {
         FriendCGMessage.CG_DEL_CROSSHEAT(this.data.id,this.data.name);
      }
      
      private function mouseClickHandle(evt:MouseEvent) : void
      {
         Child_FriendItem.doneSelectedTarget();
      }
      
      private function moToFriendClickHandle(evt:MouseEvent = null) : void
      {
         FriendCGMessage.CG_ADD_FRIEND(this.data.name);
      }
      
      private function delEnemyClickHandle(evt:MouseEvent = null) : void
      {
         FriendCGMessage.CG_DEL_FRIEND(3,this.data.id);
      }
      
      private function delHeatClickHandle(evt:MouseEvent = null) : void
      {
         FriendCGMessage.CG_DEL_FRIEND(2,this.data.id);
      }
      
      private function delFriendClickHandle(evt:MouseEvent = null) : void
      {
         if(Model_bag.pwdLockState == Model_bag.PWD_STATE_LOCK_T)
         {
            UIManager.bagPwdPutIn.visible = true;
            return;
         }
         if(this.data.id == GameUnitManager.hero.marriageID)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("1079",0));
         }
         else if(this.data.qinmidu >= 500)
         {
            View_Alert.show(LangConfig.getWord("29323",2,this.data.name,this.data.qinmidu),View_Alert.OK_CANCAL,function():void
            {
               FriendCGMessage.CG_DEL_FRIEND(data.relation,data.id);
            });
         }
         else
         {
            FriendCGMessage.CG_DEL_FRIEND(this.data.relation,this.data.id);
         }
      }
      
      private function moveToEnemyClickHandle(evt:MouseEvent) : void
      {
         FriendCGMessage.CG_ADD_CONTACT_BY_TYPE(3,this.data.name);
      }
      
      private function moveToHeatClickHandle(evt:MouseEvent) : void
      {
         FriendCGMessage.CG_ADD_CONTACT_BY_TYPE(2,this.data.name);
      }
      
      public function setData() : void
      {
      }
      
      public function addItem(itemName:String, callBack:Function, color:uint = 16184781) : void
      {
         var btn:Button = null;
         if(Boolean(this.button_buffer[itemName]))
         {
            btn = this.button_buffer[itemName];
         }
         else
         {
            btn = ComponentUtil.getButton(itemName,"ChannelButtonFour",null,{"textColor":color});
            this.button_buffer[itemName] = btn;
         }
         addChild(btn);
         this.selectedItemVec.push(btn);
         this.l.appendItem(btn);
         btn.callBack = callBack;
      }
      
      public function show() : void
      {
         visible = true;
      }
      
      public function cleanItem() : void
      {
         var btn:Button = null;
         for each(btn in this.selectedItemVec)
         {
            removeChild(btn);
         }
         this.l.clearItem();
         this.selectedItemVec.splice(0,this.selectedItemVec.length);
      }
      
      public function hide() : void
      {
         visible = false;
      }
      
      public function resetMode() : void
      {
         this.mode = 0;
         this.hide();
         this.cleanItem();
      }
   }
}

