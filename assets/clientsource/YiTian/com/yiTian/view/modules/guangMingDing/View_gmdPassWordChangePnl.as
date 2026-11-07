package com.yiTian.view.modules.guangMingDing
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.handler.GuangMingDingCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   
   public class View_gmdPassWordChangePnl extends Panel123
   {
      
      private var _tfInput:MyTextField;
      
      private var _btnCommit:Button;
      
      private var _btnCancel:Button;
      
      private var _staticStr:String;
      
      private var _openType:int;
      
      public function View_gmdPassWordChangePnl()
      {
         super();
         bindParent = GameScene.sysLayer;
         regResource("lang/ch/GuangMingDing_Img.swf","GuangMingDing_Imgdm");
      }
      
      public static function get instance() : View_gmdPassWordChangePnl
      {
         return Singleton.getInstance(View_gmdPassWordChangePnl);
      }
      
      override protected function initUI2() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":308,
            "height":220
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":260,
            "height":170
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_SZMiMa",this,{
            "x":74,
            "y":5
         },Global.GuangMingDing_Imgdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":34,
            "y":50,
            "width":240,
            "height":120
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Text_Back",[6,6,4,4],this,{
            "x":111,
            "y":82,
            "width":120,
            "height":28
         },Global.Img_Cdm);
         move = new Rectangle(0,0,width,35);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":width - 37,
            "y":6,
            "callBack":this.changeVis
         },Global.Img_Cdm);
         ComponentUtil.getTextField("设置密码：",this,{
            "x":50,
            "y":86,
            "color":11523767
         });
         ComponentUtil.getTextField("输入6位数以下密码，不输入则开放队伍",this,{
            "x":48,
            "y":129,
            "color":16764206
         });
         this._tfInput = ComponentUtil.getTextField("",this,{
            "x":117,
            "y":87,
            "color":13424242,
            "maxChars":6,
            "restrict":"0-9",
            "type":TextFieldType.INPUT,
            "realWidth":107
         },"center",TextFieldType.INPUT);
         this._btnCommit = ComponentUtil.getButton(LangConfig.getWord("29034",2),"Button_Four",this,{
            "x":67,
            "y":175,
            "textColor":16184781,
            "callBack":this.commitClickHd
         },Global.Img_Cdm);
         this._btnCancel = ComponentUtil.getButton(LangConfig.getWord("29035",2),"Button_Four",this,{
            "x":169,
            "y":175,
            "textColor":16184781,
            "callBack":this.hide
         },Global.Img_Cdm);
         this._staticStr = "点我输入";
         this._tfInput.addEventListener(FocusEvent.FOCUS_IN,this.focusInHd);
      }
      
      public function show(param:* = 1) : void
      {
         this._openType = param;
         this._tfInput.text = this._staticStr;
         this.visible = true;
         Global.control.registerCallBack(Msg_guangMingDing.TEAMPANEL_HIDE,this.onTeamPnlHide);
         Global.control.registerCallBack(Msg_guangMingDing.GMD_PASSWORD_CHANGE,this.onPassWordChange);
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(!value)
         {
            Global.control.removeCallBack(Msg_guangMingDing.TEAMPANEL_HIDE,this.onTeamPnlHide);
            Global.control.removeCallBack(Msg_guangMingDing.GMD_PASSWORD_CHANGE,this.onPassWordChange);
         }
         super.visible = value;
      }
      
      private function onTeamPnlHide() : void
      {
         this.hide();
      }
      
      private function onPassWordChange(pw:String) : void
      {
         this._tfInput.text = pw;
      }
      
      public function setTxt(v:String) : void
      {
         this._tfInput.text = v;
      }
      
      public function hide(param:* = null) : void
      {
         this.visible = false;
      }
      
      public function changeVis(param:* = null) : void
      {
         Global.delegate.dosomething(this,visible ? this.hide : this.show);
      }
      
      private function focusInHd(e:FocusEvent) : void
      {
         if(this._tfInput.text == this._staticStr)
         {
            this._tfInput.text = "";
         }
      }
      
      private function commitClickHd(e:MouseEvent) : void
      {
         switch(this._openType)
         {
            case 1:
               if(this._tfInput.text == this._staticStr || this._tfInput.text == "")
               {
                  GuangMingDingCGMessage.CG_GMD_CREATE_ROOM(0,"");
                  break;
               }
               GuangMingDingCGMessage.CG_GMD_CREATE_ROOM(1,this._tfInput.text);
               break;
            case 2:
               if(this._tfInput.text != this._staticStr)
               {
                  GuangMingDingCGMessage.CG_GMD_CHANGE_PASSWORD(this._tfInput.text);
               }
         }
         this.hide();
      }
   }
}

