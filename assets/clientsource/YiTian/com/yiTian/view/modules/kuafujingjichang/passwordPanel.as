package com.yiTian.view.modules.kuafujingjichang
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.net.handler.DRKFHandler;
   import com.yiTian.scene.GameScene;
   import com.yiTian.view.Panel123;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   import flashx.textLayout.formats.TextAlign;
   
   public class passwordPanel extends Panel123
   {
      
      private static var _instance:passwordPanel;
      
      private var queDingBtn:Button;
      
      private var back:ScaleBitmap;
      
      private var num:MyTextField;
      
      public var input_num:String;
      
      public function passwordPanel()
      {
         super();
         regResource("lang/ch/DRKF_Imgs.swf","DRKF_Imgsdm");
      }
      
      public static function get instance() : passwordPanel
      {
         if(!_instance)
         {
            _instance = new passwordPanel();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         bindParent = GameScene.modalLayer;
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":303,
            "height":200
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_PassWord",this,{
            "x":72,
            "y":5
         },Global.DRKF_Imgsdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":24,
            "y":40,
            "width":255,
            "height":150
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this,{
            "x":34,
            "y":50,
            "width":235,
            "height":90
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":119,
            "y":81,
            "width":120,
            "height":23
         },Global.Img_Cdm);
         this.queDingBtn = ComponentUtil.getButton("确定","Button_Four",this,{
            "x":116,
            "y":150,
            "textColor":16184781
         },Global.Img_Cdm);
         this.queDingBtn.addEventListener(MouseEvent.CLICK,this.queDingClick);
         ComponentUtil.getTextField("输入密码：",this,{
            "x":55,
            "y":83,
            "color":11523767,
            "size":12,
            "leading":0
         });
         this.num = ComponentUtil.getTextField("点击输入房间密码",this,{
            "x":130,
            "y":83,
            "color":13424242,
            "size":12,
            "leading":0,
            "realHeight":20,
            "realWidth":100
         });
         this.num.align = TextAlign.CENTER;
         this.num.type = TextFieldType.INPUT;
         this.num.maxChars = 6;
         this.num.restrict = "0-9";
         this.num.addEventListener(MouseEvent.CLICK,this.numremove);
         this.num.addEventListener(Event.CHANGE,this.numClick);
         this.num.addEventListener(TextEvent.TEXT_INPUT,this.onTextInput);
         move = new Rectangle(0,0,this.back.width,35);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":269,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         CloseButton.callBack = this.hide;
         this.initDynamicView();
      }
      
      protected function onTextInput(event:TextEvent) : void
      {
         if(!visible)
         {
            return;
         }
         if(this.num.text == "点击输入房间密码")
         {
            this.num.text = "";
            if(Global.focus != this.num)
            {
               Global.focus = this.num;
            }
            return;
         }
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
      }
      
      public function show() : void
      {
         ModalUIManager.POPUP(this,"center",false);
         this.visible = true;
      }
      
      public function hide() : void
      {
         ModalUIManager.UNPOP();
      }
      
      private function queDingClick(e:MouseEvent) : void
      {
         DRKFHandler.joinDRKFTeam(DRKFItem.teamid,DRKFItem.teamtype,this.input_num);
      }
      
      private function numremove(e:MouseEvent) : void
      {
         if(this.num.text == "点击输入房间密码")
         {
            this.num.text = "";
         }
      }
      
      private function numClick(e:Event) : void
      {
         this.num = e.target as MyTextField;
         this.num.setSelection(this.num.text.length,this.num.text.length);
         this.input_num = this.num.text;
      }
      
      private function onAskSceneOk() : void
      {
         this.hide();
         Global.control.removeCallBack(Enum_MsgType.MSG_ASK_CHANGE_SCENE_OK,arguments.callee);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            Global.focus = this.num;
            Global.control.registerCallBack(Enum_MsgType.MSG_ASK_CHANGE_SCENE_OK,this.onAskSceneOk);
         }
      }
   }
}

