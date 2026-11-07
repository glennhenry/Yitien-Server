package com.yiTian.view.modules.Kunlun
{
   import com.yiTian.Global;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.mainUIBtnContainer.Enum_mainUIBtn_hide;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_klTipBtn extends Sprite
   {
      
      private static var _instance:View_klTipBtn;
      
      private var _bm:Bitmap;
      
      private var effect:Effect;
      
      public function View_klTipBtn()
      {
         super();
         if(Boolean(_instance))
         {
            throw new Error("singlon error");
         }
         this.init();
         _instance = this;
      }
      
      public static function isInstance() : Boolean
      {
         return _instance != null;
      }
      
      public static function get instance() : View_klTipBtn
      {
         if(_instance)
         {
         }
         return _instance;
      }
      
      private function init() : void
      {
         this._bm = new Bitmap();
         this._bm = Utils.getLoadBitmap("resource/image/extralPng/kls.png",this._bm);
         addChild(this._bm);
         this.effect = EffectManager.addEffect("35343",this,1000,32,29,true);
         buttonMode = true;
         addEventListener(MouseEvent.CLICK,this.clickHandle);
         Global.control.registerCallBack(Enum_mainUIBtn_hide.MOVE_TO_HIDE,this.onHide);
      }
      
      private function onHide() : void
      {
         UIManager.mainUiBtnContainer.partPauseRemove(this,1);
      }
      
      public function clickHandle(evt:MouseEvent = null) : void
      {
         UIManager.kunlun_prompt.visible = !UIManager.kunlun_prompt.visible;
      }
      
      public function dispose() : void
      {
         UIManager.mainUiBtnContainer.removeBTN(this);
         EffectManager.removeEffect(this.effect);
         this.effect = null;
         removeChild(this._bm);
         removeEventListener(MouseEvent.CLICK,this.clickHandle);
         this._bm.bitmapData = null;
         this._bm = null;
         _instance = null;
      }
   }
}

