package com.yiTian.view.modules.guangMingDing
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.GuangMingDingCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.text.TextFieldType;
   
   public class View_gmdPassWordJoinPnl extends Panel123
   {
      
      private var _tfInput:MyTextField;
      
      private var _staticStr:String;
      
      private var _targetID:int;
      
      public function View_gmdPassWordJoinPnl()
      {
         super();
         bindParent = GameScene.sysLayer;
         this.initUI2();
      }
      
      public static function get instance() : View_gmdPassWordJoinPnl
      {
         return Singleton.getInstance(View_gmdPassWordJoinPnl);
      }
      
      override protected function initUI2() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":308,
            "height":210
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":260,
            "height":160
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":34,
            "y":50,
            "width":240,
            "height":100
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_Prompt",this,{
            "x":74,
            "y":5
         },Global.Img_Cdm);
         ComponentUtil.getTextField("输入密码",this,{
            "x":58,
            "y":90,
            "color":11523767
         });
         ComponentUtil.getScaleBitmap("Text_Back",[6,6,4,4],this,{
            "x":111,
            "y":86,
            "width":120,
            "height":28
         },Global.Img_Cdm);
         this._tfInput = ComponentUtil.getTextField("",this,{
            "x":117,
            "y":91,
            "maxChars":6,
            "color":13424242,
            "restrict":"0-9",
            "realWidth":110
         });
         this._tfInput.type = TextFieldType.INPUT;
         ComponentUtil.getButton("确定","Button_Four",this,{
            "x":67,
            "y":161,
            "textColor":16184781,
            "callBack":this.commitClickHd
         },Global.Img_Cdm);
         ComponentUtil.getButton("取消","Button_Four",this,{
            "x":169,
            "y":161,
            "textColor":16184781,
            "callBack":this.hide
         },Global.Img_Cdm);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":274,
            "y":6,
            "callBack":this.hide
         },Global.Img_Cdm);
         this._staticStr = "点我输入";
         this._tfInput.addEventListener(FocusEvent.FOCUS_IN,this.focusInHd);
         this._tfInput.addEventListener(FocusEvent.FOCUS_OUT,this.focusOutHd);
      }
      
      private function focusInHd(e:FocusEvent) : void
      {
         if(this._tfInput.text == this._staticStr)
         {
            this._tfInput.text = "";
         }
      }
      
      private function focusOutHd(e:FocusEvent) : void
      {
         if(this._tfInput.text == "")
         {
            this._tfInput.text = this._staticStr;
         }
      }
      
      public function show(targetRoom:int) : void
      {
         this._targetID = targetRoom;
         this._tfInput.text = this._staticStr;
         this.visible = true;
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            Global.control.registerCallBack(Msg_guangMingDing.HALLPANEL_HIDE,this.hide);
         }
         else
         {
            Global.control.removeCallBack(Msg_guangMingDing.HALLPANEL_HIDE,this.hide);
         }
         super.visible = value;
      }
      
      public function hide(prm:* = null) : void
      {
         this.visible = false;
      }
      
      private function commitClickHd(e:MouseEvent) : void
      {
         if(this._tfInput.text != this._staticStr)
         {
            GuangMingDingCGMessage.CG_GMD_INVITE_RESPON(this._targetID,this._tfInput.text);
         }
         else
         {
            UIManager.centerBroadcast.addMsg("请输入密码");
         }
      }
   }
}

