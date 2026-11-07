package com.yiTian.view.modules.kuafujingjichang
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.net.message.cg.KuaFuJingJiChangCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.view.Panel123;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   import flashx.textLayout.formats.TextAlign;
   
   public class SeachPanel extends Panel123
   {
      
      private static var _instance:SeachPanel;
      
      private var queDingBtn:Button;
      
      private var back:ScaleBitmap;
      
      private var num:MyTextField;
      
      public var input_num:int;
      
      public function SeachPanel()
      {
         super();
         regResource("lang/ch/DRKF_Imgs.swf","DRKF_Imgsdm");
      }
      
      public static function get instance() : SeachPanel
      {
         if(!_instance)
         {
            _instance = new SeachPanel();
         }
         return _instance;
      }
      
      public function focusIn() : void
      {
         if(Boolean(this.num))
         {
            this.num.setSelection(this.num.text.length,this.num.text.length);
            Global.focus = this.num;
         }
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
            "x":70,
            "y":100,
            "width":163,
            "height":23
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_SeachRoom",this,{
            "x":72,
            "y":5
         },Global.DRKF_Imgsdm);
         this.queDingBtn = ComponentUtil.getButton("确定","Button_Four",this,{
            "x":116,
            "y":154,
            "textColor":16184781
         },Global.Img_Cdm);
         this.queDingBtn.addEventListener(MouseEvent.CLICK,this.queDingClick);
         ComponentUtil.getTextField("请输入您需要查找的房间号码",this,{
            "x":71,
            "y":70,
            "color":11523767,
            "size":12,
            "leading":0
         });
         this.num = ComponentUtil.getTextField("点击输入",this,{
            "x":70,
            "y":102,
            "color":13424242,
            "size":12,
            "leading":0,
            "realWidth":160,
            "realHeight":19
         });
         this.num.align = TextAlign.CENTER;
         this.num.type = TextFieldType.INPUT;
         this.num.maxChars = 10;
         this.num.restrict = "0-9";
         this.num.addEventListener(MouseEvent.CLICK,this.numClick);
         move = new Rectangle(0,0,this.back.width,35);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":269,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.initDynamicView();
      }
      
      override protected function initStaticView() : void
      {
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
      }
      
      private function numClick(e:Event) : void
      {
         if(this.num.text == "点击输入")
         {
            this.num.text = "";
         }
         this.num = e.target as MyTextField;
         this.num.setSelection(this.num.text.length,this.num.text.length);
         this.input_num = int(this.num.text);
      }
      
      private function queDingClick(e:MouseEvent) : void
      {
         KuaFuJingJiChangCGMessage.CG_KUAFUTEAM_CHECK(int(this.num.text));
      }
      
      public function show() : void
      {
         this.visible = true;
         ModalUIManager.POPUP(this,"center",false);
      }
      
      public function hide() : void
      {
         ModalUIManager.UNPOP();
      }
      
      private function onAskSceneOk() : void
      {
         KuaFuJingJiChangCGMessage.CG_LEAVE_DRKFTEAM(2);
         Global.control.removeCallBack(Enum_MsgType.MSG_ASK_CHANGE_SCENE_OK,arguments.callee);
         this.hide();
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(!value)
         {
            this.num.text = "";
         }
         else
         {
            Global.stage.focus = this.num;
            Global.control.registerCallBack(Enum_MsgType.MSG_ASK_CHANGE_SCENE_OK,this.onAskSceneOk);
         }
      }
   }
}

