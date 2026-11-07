package com.yiTian.view
{
   import com.ui.controls.TextInput;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.scene.GameScene;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   
   public class UIBase extends Sprite
   {
      
      protected var bindParent:Sprite;
      
      protected var bind_target:Object;
      
      public var isInit_base:Boolean = false;
      
      protected var _tmpParent:Sprite;
      
      public function UIBase()
      {
         super();
      }
      
      final public function init() : void
      {
         this.initStaticView();
         this.initDynamicView();
         this.isInit_base = true;
      }
      
      protected function initStaticView() : void
      {
      }
      
      protected function initDynamicView() : void
      {
      }
      
      public function resetPosition() : void
      {
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(Boolean(this._tmpParent))
            {
               this._tmpParent.addChild(this);
            }
            else if(Boolean(this.bindParent))
            {
               this.bindParent.addChild(this);
            }
         }
         else
         {
            if(Boolean(parent) && (Boolean(this.bindParent) || Boolean(this._tmpParent)))
            {
               parent.removeChild(this);
            }
            if(!(Global.focus is TextField && (Global.focus as TextField).type == TextFieldType.INPUT) && !(Global.focus is TextInput))
            {
               Global.focus = GameScene.instance;
            }
         }
      }
      
      public function set tmpParent(v:Sprite) : void
      {
         this._tmpParent = v;
         if(Boolean(v))
         {
            Global.control.registerCallBack(Enum_MsgType.MODAL_SHOW,this.onModalShow);
            Global.control.registerCallBack(Enum_MsgType.MODAL_HIDE,this.onModalHide);
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.MODAL_SHOW,this.onModalShow);
            Global.control.removeCallBack(Enum_MsgType.MODAL_HIDE,this.onModalHide);
         }
      }
      
      private function onModalShow() : void
      {
         if(visible && Boolean(this._tmpParent))
         {
            this._tmpParent.addChild(this);
         }
      }
      
      private function onModalHide() : void
      {
         if(visible && Boolean(this.bindParent))
         {
            this.bindParent.addChild(this);
         }
      }
   }
}

