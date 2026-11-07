package com.yiTian.view.modules.shenBing
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
   import com.yiTian.view.Panel;
   import flash.events.MouseEvent;
   
   public class View_CuiLianPrompt extends Panel
   {
      
      private var tf_info:MyTextField;
      
      private var btn_ok:Button;
      
      private var btn_cancel:Button;
      
      private var _cb:CheckBox;
      
      private var _times:int;
      
      public function View_CuiLianPrompt()
      {
         super();
         bindParent = GameScene.modalLayer;
         this.initStaticView();
      }
      
      public static function get instance() : View_CuiLianPrompt
      {
         return Singleton.getInstance(View_CuiLianPrompt);
      }
      
      override protected function initStaticView() : void
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
            "callBack":this.cancelClick
         },Global.Img_Cdm);
         this._cb = ComponentUtil.getCheckBox(LangConfig.getWord("29115",2),"CheckBox01",this,{
            "x":120,
            "y":120
         },Global.Img_Cdm);
         this._cb.clickFun = this.cbClickHd;
      }
      
      public function show(prm:* = null) : void
      {
         this._cb.selected = false;
         ModalUIManager.POPUP(this);
         this._times = prm;
         var money:int = this._times * 10;
         this.tf_info.htmlText = LangConfig.reTxt("您的玉牌不足,是否花费<font color=\'#33ff33\'>{0}</font>元宝\n进行{1}次淬炼",money,this._times);
      }
      
      public function hide(prm:* = null) : void
      {
         ModalUIManager.UNPOP();
      }
      
      private function okClick(e:MouseEvent) : void
      {
         if(!ShenBingUtil.askSendCuiLian(2,this._times))
         {
            Model_ShenBing._cuiLianNotPrompt = false;
         }
         this.hide();
      }
      
      private function cancelClick(e:MouseEvent) : void
      {
         Model_ShenBing._cuiLianNotPrompt = false;
         this.hide();
      }
      
      private function cbClickHd(target:CheckBox) : void
      {
         Model_ShenBing._cuiLianNotPrompt = this._cb.selected;
      }
   }
}

