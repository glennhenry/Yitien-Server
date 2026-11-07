package com.yiTian.view.modules.guangMingDing
{
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel;
   
   public class View_gmdUseMiJiPromt extends Panel
   {
      
      private var btn_ok:Button;
      
      private var btn_cancel:Button;
      
      public var _cb:CheckBox;
      
      private var tf_info:MyTextField;
      
      private var _tfTip:MyTextField;
      
      public var _fun:Function;
      
      public var _param:*;
      
      public function View_gmdUseMiJiPromt()
      {
         super();
         this.init2();
      }
      
      public static function get instance() : View_gmdUseMiJiPromt
      {
         return Singleton.getInstance(View_gmdUseMiJiPromt);
      }
      
      private function init2() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":308,
            "height":185
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":260,
            "height":110
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_Prompt",this,{
            "x":74,
            "y":5
         },Global.Img_Cdm);
         this.tf_info = ComponentUtil.getTextField("",this,{
            "x":50,
            "y":60,
            "color":16184781,
            "realWidth":200,
            "leading":5
         });
         this.tf_info.align = "center";
         this.tf_info.wordWrap = true;
         this.tf_info.multiline = true;
         this.btn_ok = ComponentUtil.getButton(LangConfig.getWord("29034",2),"Button_Four",this,{
            "x":55,
            "y":152,
            "textColor":16184781,
            "callBack":this.okClick
         },Global.Img_Cdm);
         this.btn_cancel = ComponentUtil.getButton(LangConfig.getWord("29035",2),"Button_Four",this,{
            "x":175,
            "y":152,
            "textColor":16184781,
            "callBack":this.cancelClickHd
         },Global.Img_Cdm);
         this._cb = ComponentUtil.getCheckBox(LangConfig.getWord("29115",2),"CheckBox01",this,{
            "x":120,
            "y":120
         },Global.Img_Cdm);
         Global.control.registerCallBack(Msg_guangMingDing.CHANPANEL_HIDE,this.hide);
      }
      
      private function okClick(p:* = null) : void
      {
         if(Boolean(this._fun.length))
         {
            this._fun(this._param);
         }
         else
         {
            this._fun();
         }
         this._fun = null;
         this._param = null;
         this.hide();
      }
      
      private function cancelClickHd(p:* = null) : void
      {
         this._cb.selected = false;
         this.hide();
      }
      
      private function hide(p:* = null) : void
      {
         this.visible = false;
         stopDrag();
      }
      
      public function applyFun(label:String, fun:Function, ... param) : void
      {
         if(this._cb.selected)
         {
            if(Boolean(fun.length))
            {
               fun();
            }
            else
            {
               fun(param);
            }
         }
         else
         {
            this._fun = fun;
            this._param = param;
            this.tf_info.htmlText = label;
            this.visible = true;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_PRE_START,this.hide);
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_PRE_START,this.hide);
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

