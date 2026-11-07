package com.yiTian.view.modules.pet
{
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.view.Panel;
   import flash.events.MouseEvent;
   
   public class TiShiPanel extends Panel
   {
      
      private static var _instance:TiShiPanel;
      
      private var tf:MyTextField;
      
      private var tf2:MyTextField;
      
      private var checkBox:CheckBox;
      
      private var queDingBtn:Button;
      
      private var quXiaoBtn:Button;
      
      private var closeBtn:Button;
      
      private var back:ScaleBitmap;
      
      public function TiShiPanel()
      {
         super();
         this.init2();
         bindParent = GameScene.modalLayer;
      }
      
      public static function get instance() : TiShiPanel
      {
         if(!_instance)
         {
            _instance = new TiShiPanel();
         }
         return _instance;
      }
      
      private function init2() : void
      {
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":358,
            "height":220 - 25
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":24,
            "y":40,
            "width":310,
            "height":170 - 25
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this,{
            "x":34,
            "y":50,
            "width":290,
            "height":110 - 20
         },Global.Img_Cdm);
         this.tf = ComponentUtil.getTextField("",this,{
            "x":67,
            "y":70,
            "color":13424242,
            "size":12,
            "leading":5
         });
         this.tf2 = ComponentUtil.getTextField("",this,{
            "x":67 + 70,
            "y":70 + 20,
            "color":13424242,
            "size":12,
            "leading":5
         });
         this.tf.htmlText = "是否自动花费元宝购买" + "<font color =\'#00ff00\'>" + "宠物强化石" + "</font>？";
         this.tf2.htmlText = "(80元宝/个)";
         this.queDingBtn = ComponentUtil.getButton("确定","Button_Four",this,{
            "x":73,
            "y":170 - 20,
            "textColor":16184781
         },Global.Img_Cdm);
         this.quXiaoBtn = ComponentUtil.getButton("取消","Button_Four",this,{
            "x":213,
            "y":170 - 20,
            "textColor":16184781
         },Global.Img_Cdm);
         this.closeBtn = ComponentUtil.getButton("","Button_Close",this,{
            "x":324,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_Prompt",this,{
            "x":99,
            "y":5
         },Global.Img_Cdm);
         this.closeBtn.callBack = this.close;
         this.quXiaoBtn.callBack = this.close;
         this.queDingBtn.addEventListener(MouseEvent.CLICK,this.queDingClick);
      }
      
      private function close(e:MouseEvent) : void
      {
         ZhuangBeiPanel.instance.zdgmBox.selected = false;
         visible = false;
         this.hide();
      }
      
      private function queDingClick(e:MouseEvent) : void
      {
         ZhuangBeiPanel.instance.zdgmBox.selected = true;
         visible = false;
         this.hide();
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.back.width) / 2;
         y = (Global.stage.stageHeight - this.back.height) / 2;
      }
      
      public function hide() : void
      {
         ModalUIManager.UNPOP();
      }
      
      public function show() : void
      {
         visible = true;
         ModalUIManager.POPUP(this);
      }
   }
}

