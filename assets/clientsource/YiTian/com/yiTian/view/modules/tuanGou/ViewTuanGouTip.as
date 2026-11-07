package com.yiTian.view.modules.tuanGou
{
   import com.yiTian.Global;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.TuanGouCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.mainUIBtnContainer.Enum_mainUIBtn_hide;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ViewTuanGouTip extends Sprite
   {
      
      private static var _instance:ViewTuanGouTip;
      
      public static var isCLick:Boolean = true;
      
      private var _bg:Bitmap;
      
      private var ef:Effect;
      
      public function ViewTuanGouTip()
      {
         super();
         if(Boolean(_instance))
         {
            throw new Error("singlton error");
         }
         this.init();
         _instance = this;
      }
      
      public static function get instance() : ViewTuanGouTip
      {
         if(_instance)
         {
         }
         return _instance;
      }
      
      private function init() : void
      {
         this._bg = new Bitmap();
         this._bg = Utils.getLoadBitmap("resource/image/myPath/" + "tuanGou" + ".png",this._bg);
         buttonMode = true;
         addChild(this._bg);
         addEventListener(MouseEvent.CLICK,this.clickHandle);
         Global.control.registerCallBack(Enum_mainUIBtn_hide.MOVE_TO_HIDE,this.onHide);
      }
      
      private function onHide() : void
      {
         UIManager.mainUiBtnContainer.partPauseRemove(this,1);
      }
      
      private function clickHandle(evt:MouseEvent) : void
      {
         if(isCLick)
         {
            evt.stopPropagation();
            if(!UIManager.tuanGou.visible)
            {
               TuanGouCGMessage.CG_TUANGOU_REQUEST_LIST();
               UIManager.tuanGou.visible = true;
            }
            isCLick = false;
         }
      }
      
      public function effectBegin() : void
      {
         if(!this.ef)
         {
            this.ef = EffectManager.addEffect("35343",this,1000,32,29,true);
         }
      }
      
      public function effectEnd() : void
      {
         if(Boolean(this.ef))
         {
            EffectManager.removeEffect(this.ef);
            this.ef = null;
         }
      }
   }
}

