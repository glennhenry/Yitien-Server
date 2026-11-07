package com.yiTian.view.modules.bianxinggaiming
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BianXingGaiMingCGMessage;
   import com.yiTian.scene.CreateScene;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.StrFilter;
   import com.yiTian.view.Panel;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFieldType;
   
   public class View_BangHuiGaiMingPanel extends Panel
   {
      
      private var tf_input:MyTextField;
      
      private var btn_submit:Button;
      
      private var btn_cancel:Button;
      
      private var _oldName:String;
      
      public function View_BangHuiGaiMingPanel()
      {
         super();
         bindParent = GameScene.modalLayer;
         this.initUI();
      }
      
      private function initUI() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":328,
            "height":180
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":280,
            "height":130
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_WXPrompt",this,{
            "x":90,
            "y":5
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":64,
            "y":95,
            "width":200,
            "height":24
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":294,
            "y":6
         },Global.Img_Cdm);
         CloseButton.callBack = this.hide;
         ComponentUtil.getTextField("请输入新的帮会名称",this,{
            "x":96,
            "y":60,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.tf_input = ComponentUtil.getTextField("",this,{
            "x":64,
            "y":97,
            "color":16777215,
            "realWidth":192
         });
         this.tf_input.restrict = "^_|,";
         this.tf_input.maxChars = 6;
         this.tf_input.autoSize = TextFieldAutoSize.CENTER;
         this.tf_input.type = TextFieldType.INPUT;
         this.tf_input.addEventListener(FocusEvent.FOCUS_IN,this.inputFocusInHd);
         this.btn_submit = ComponentUtil.getButton(LangConfig.getWord("60036",6),"Button_Four",this,{
            "x":64,
            "y":132,
            "callBack":this.submitClickHd
         },Global.Img_Cdm);
         this.btn_cancel = ComponentUtil.getButton(LangConfig.getWord("60037",6),"Button_Four",this,{
            "x":192,
            "y":132,
            "callBack":this.hide
         },Global.Img_Cdm);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
      }
      
      private function inputFocusInHd(event:Event) : void
      {
      }
      
      private function submitClickHd(event:MouseEvent) : void
      {
         if(this._oldName == this.tf_input.text)
         {
            UIManager.centerBroadcast.addMsg("请输入新的名称");
            return;
         }
         StrFilter.load(this.tf_input.text,function(text:String):void
         {
            var reg2:RegExp = /</gi;
            var temp:String = text.match(reg2).toString();
            if(temp.length > 0)
            {
               UIManager.centerBroadcast.addMsg("不能包含&lt; 、,&gt;等符号");
               return;
            }
            if(StrFilter.hasUnRegisterString(text))
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("60041",6));
            }
            else if(CreateScene.strHd(text))
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("60042",6));
            }
            else
            {
               BianXingGaiMingCGMessage.CG_CHANGE_BANGNAME(text);
               ModalUIManager.UNPOP();
            }
         });
      }
      
      public function show(vo:Vo_valuable = null) : void
      {
         if(!GameUnitManager.hero.partyId)
         {
            UIManager.centerBroadcast.addMsg("您还没有帮会");
            return;
         }
         ModalUIManager.POPUP(this);
         this._oldName = GameUnitManager.hero.party;
         this.tf_input.text = this._oldName;
         Global.focus = this.tf_input;
         this.tf_input.setSelection(this.tf_input.text.length,this.tf_input.text.length);
      }
      
      private function hide(event:MouseEvent) : void
      {
         ModalUIManager.UNPOP();
      }
   }
}

