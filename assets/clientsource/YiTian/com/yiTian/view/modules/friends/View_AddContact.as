package com.yiTian.view.modules.friends
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.message.cg.FriendCGMessage;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.view.Panel;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   
   public class View_AddContact extends Panel
   {
      
      private var Button_OK:Button;
      
      private var Button_Friend:TabButton;
      
      private var Button_CrossFriend:TabButton;
      
      private var Button_Heat:TabButton;
      
      private var z_text:MyTextField;
      
      private var field_Name:MyTextField;
      
      private const FRIEND:int = 1;
      
      private const HEAT:int = 2;
      
      private const CROSSFRIEND:int = 3;
      
      private var mode:uint = 1;
      
      private var _tf:MyTextField;
      
      private var targetTabBtn:TabButton;
      
      private var backSP:Sprite;
      
      private var isLoad:Boolean = false;
      
      public function View_AddContact()
      {
         super();
         init();
      }
      
      override protected function initStaticView() : void
      {
         this.backSP = new Sprite();
         addChild(this.backSP);
         this.backSP.mouseEnabled = false;
         var back:DisplayObject = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.backSP,{
            "x":0,
            "y":0,
            "width":300,
            "height":160
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.backSP,{
            "x":24,
            "y":70,
            "width":252,
            "height":80
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this.backSP,{
            "x":34,
            "y":111,
            "width":150,
            "height":24
         },Global.Img_Cdm);
         this.Button_OK = ComponentUtil.getButton(LangConfig.getWord("29034",2),"Button_Two64",this,{
            "x":200,
            "y":110,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_Friend = ComponentUtil.getTabButton(LangConfig.getWord("29037",2),"TabButton_Four",this,{
            "x":30,
            "y":49,
            "textColor":16773818,
            "chooseColor":16773818
         },Global.Img_Cdm);
         this.Button_CrossFriend = ComponentUtil.getTabButton("跨服好友","TabButton_Four",this,{
            "x":105,
            "y":49
         },Global.Img_Cdm);
         this.Button_Heat = ComponentUtil.getTabButton(LangConfig.getWord("23132",2),"TabButton_Four",this,{
            "x":180,
            "y":49,
            "textColor":16773818,
            "chooseColor":16773818
         },Global.Img_Cdm);
         this._tf = ComponentUtil.getTextField(LangConfig.getWord("60120",6),this,{
            "x":35,
            "y":85,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.field_Name = ComponentUtil.getTextField("",this,{
            "x":39,
            "y":114,
            "color":12877056,
            "size":12,
            "leading":0,
            "realWidth":130
         });
         this.field_Name.maxChars = 20;
         this.Button_Friend.choose = true;
         this.targetTabBtn = this.Button_Friend;
         this.field_Name.type = TextFieldType.INPUT;
         move = new Rectangle(0,0,208,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":266,
            "y":5,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_OK.addEventListener(MouseEvent.CLICK,this.btn_okClickHandle);
         this.Button_Friend.addEventListener(MouseEvent.CLICK,this.tabButtonClick);
         this.Button_Heat.addEventListener(MouseEvent.CLICK,this.tabButtonClick);
         this.Button_CrossFriend.addEventListener(MouseEvent.CLICK,this.tabButtonClick);
      }
      
      private function initTl() : void
      {
         ComponentUtil.getBitmap("Title_Join",this.backSP,{
            "x":70,
            "y":5
         },Global.FriendShip_Imgsdm);
      }
      
      private function tabButtonClick(evt:MouseEvent) : void
      {
         this.changeFocus(evt.target as TabButton);
      }
      
      private function changeFocus(target:TabButton) : void
      {
         if(target == this.Button_Friend)
         {
            this.mode = this.FRIEND;
            this._tf.htmlText = LangConfig.getWord("60120",6);
         }
         else if(target == this.Button_Heat)
         {
            this._tf.htmlText = LangConfig.getWord("60120",6);
            this.mode = this.HEAT;
         }
         else if(target == this.Button_CrossFriend)
         {
            this.mode = this.CROSSFRIEND;
            this._tf.htmlText = "请输入玩家名称+服务器区号 例：倚天.S1";
         }
         this.Button_Friend.choose = false;
         this.Button_Heat.choose = false;
         this.Button_CrossFriend.choose = false;
         target.choose = true;
         this.targetTabBtn = target;
      }
      
      private function btn_okClickHandle(evt:MouseEvent) : void
      {
         switch(this.mode)
         {
            case this.FRIEND:
               FriendCGMessage.CG_ADD_FRIEND(this.field_Name.text);
               break;
            case this.HEAT:
               FriendCGMessage.CG_ADD_CONTACT_BY_TYPE(2,this.field_Name.text);
               break;
            case this.CROSSFRIEND:
               FriendCGMessage.CG_ADD_FRIEND_SERV(this.field_Name.text);
         }
         this.visible = false;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      public function show(name:String = "") : void
      {
         this.field_Name.text = name;
         this.visible = true;
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            if(!this.isLoad)
            {
               SingleLoader.add("lang/ch/FriendShip_Imgs.swf",function(info:Object):void
               {
                  Global.FriendShip_Imgsdm = info.applicationDomain;
                  isLoad = true;
                  initTl();
                  visible = true;
               });
               return;
            }
            super.visible = true;
         }
         else
         {
            this.field_Name.text = "";
            this.changeFocus(this.Button_Friend);
            super.visible = false;
         }
      }
   }
}

