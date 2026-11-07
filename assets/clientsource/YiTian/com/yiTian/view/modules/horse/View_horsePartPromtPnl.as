package com.yiTian.view.modules.horse
{
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.UIBase;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   
   public class View_horsePartPromtPnl extends UIBase
   {
      
      private var btn_ok:Button;
      
      private var btn_cancel:Button;
      
      public var _cb:CheckBox;
      
      private var tf_info:MyTextField;
      
      public var _fun:Function;
      
      public var _param:*;
      
      public function View_horsePartPromtPnl()
      {
         super();
         bindParent = GameScene.modalLayer;
         this.init2();
      }
      
      public static function get instance() : View_horsePartPromtPnl
      {
         return Singleton.getInstance(View_horsePartPromtPnl);
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
            "x":157,
            "y":60,
            "color":16184781,
            "realWidth":0,
            "leading":5
         });
         this.tf_info.align = "center";
         this.tf_info.autoSize = TextFieldAutoSize.CENTER;
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
            "callBack":this.hide
         },Global.Img_Cdm);
         this._cb = ComponentUtil.getCheckBox(LangConfig.getWord("29115",2),"CheckBox01",this,{
            "x":120,
            "y":120
         },Global.Img_Cdm);
      }
      
      private function okClick(e:MouseEvent) : void
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
      
      private function hide(e:MouseEvent = null) : void
      {
         ModalUIManager.UNPOP();
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
            ModalUIManager.POPUP(this);
         }
      }
   }
}

