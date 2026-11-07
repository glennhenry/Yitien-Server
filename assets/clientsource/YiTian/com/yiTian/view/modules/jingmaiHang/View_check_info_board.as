package com.yiTian.view.modules.jingmaiHang
{
   import com.ui.controls.Button;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.message.cg.ChatCGMessage;
   import com.yiTian.net.message.cg.FriendCGMessage;
   import com.yiTian.view.Panel;
   import flash.events.MouseEvent;
   
   public class View_check_info_board extends Panel
   {
      
      private var back2:ScaleBitmap;
      
      private var Button_pri_chat:Button;
      
      private var Button_send_mail:Button;
      
      private var Button_add_friend:Button;
      
      private var _role_id:Number = 0;
      
      private var _roleName:String;
      
      public function View_check_info_board()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         this.back2 = ComponentUtil.getScaleBitmap("Back_Floating",[8,9,4,2],this,{
            "x":-3,
            "y":0,
            "width":87,
            "height":95
         },Global.Img_Cdm);
         this.Button_add_friend = ComponentUtil.getButton(LangConfig.getWord("364",0),"ChannelButtonFour",this,{
            "x":2,
            "y":25.5
         },ComponentUtil.domain);
         this.Button_pri_chat = ComponentUtil.getButton(LangConfig.getWord("365",0),"ChannelButtonFour",this,{
            "x":2,
            "y":5.2
         },ComponentUtil.domain);
         this.Button_send_mail = ComponentUtil.getButton(LangConfig.getWord("366",0),"ChannelButtonFour",this,{
            "x":2,
            "y":45.8
         },ComponentUtil.domain);
         this.Button_add_friend.addEventListener(MouseEvent.MOUSE_DOWN,this.mDownHandle);
         this.Button_pri_chat.addEventListener(MouseEvent.MOUSE_DOWN,this.mDownHandle);
         this.Button_send_mail.addEventListener(MouseEvent.MOUSE_DOWN,this.mDownHandle);
         this.Button_add_friend.callBack = this.addFriend;
         this.Button_pri_chat.callBack = this.priChat;
         this.Button_send_mail.callBack = this.sendMail;
         this.back2.width = this.Button_add_friend.width + 10;
         this.back2.height = this.Button_add_friend.height + this.Button_pri_chat.height + this.Button_send_mail.height + 15;
      }
      
      private function mDownHandle(e:MouseEvent) : void
      {
         e.stopPropagation();
      }
      
      private function addFriend(e:MouseEvent = null) : void
      {
         FriendCGMessage.CG_ADD_FRIEND(this._roleName);
         this.visible = false;
      }
      
      private function priChat(e:MouseEvent = null) : void
      {
         ChatCGMessage.CG_SID_CHAT(this._role_id);
         this.visible = false;
      }
      
      public function update(role_id:Number, strName:String) : void
      {
         this._role_id = role_id;
         this._roleName = strName;
      }
      
      private function mHandle(e:MouseEvent) : void
      {
         this.visible = false;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            Global.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.mHandle);
         }
         else
         {
            Global.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.mHandle);
         }
      }
      
      private function sendMail(e:MouseEvent = null) : void
      {
         Global.control.sendNotification(Enum_MsgType.MSG_SENDMAIL,this._roleName);
         this.visible = false;
      }
   }
}

