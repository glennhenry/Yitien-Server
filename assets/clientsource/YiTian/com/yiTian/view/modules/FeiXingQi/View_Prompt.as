package com.yiTian.view.modules.FeiXingQi
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Alert;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   
   public class View_Prompt extends Panel
   {
      
      private var bg:DisplayObject;
      
      private var tf_info:MyTextField;
      
      private var btn_ok:Button;
      
      private var btn_cancel:Button;
      
      private var _okFun:Function;
      
      public function View_Prompt()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
      }
      
      override protected function initDynamicView() : void
      {
      }
      
      private function okClickHd(evt:MouseEvent) : void
      {
         ModalUIManager.UNPOP();
         this._okFun(evt);
         this.clear();
      }
      
      private function cancelClickHd(evt:MouseEvent) : void
      {
         ModalUIManager.UNPOP();
         this.clear();
      }
      
      public function clear() : void
      {
         this.tf_info.text = "";
         this._okFun = null;
      }
      
      public function show(info:String, type:int, okFun:Function) : void
      {
         View_Alert.show(info,type,okFun);
      }
      
      private function align() : void
      {
         this.btn_ok.x = 40;
         this.btn_cancel.x = this.bg.width - this.btn_cancel.width - 40;
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            this.align();
         }
         super.visible = value;
      }
   }
}

