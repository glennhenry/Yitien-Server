package com.yiTian.view.modules.vipBGift
{
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.utils.call.Delegate123;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MainIcon_VBG extends Sprite
   {
      
      private static var instance:MainIcon_VBG;
      
      private var _bm:Bitmap;
      
      private var effect:Effect;
      
      public function MainIcon_VBG()
      {
         super();
      }
      
      public static function getInstance() : MainIcon_VBG
      {
         if(!instance)
         {
            instance = new MainIcon_VBG();
         }
         return instance;
      }
      
      public function init() : void
      {
         this._bm = new Bitmap();
         this._bm = Utils.getLoadBitmap("resource/image/vipBGift/Icon_WHLB.png",this._bm);
         addChild(this._bm);
         this.effect = EffectManager.addEffect("35343",this,1000,32,29,true);
         buttonMode = true;
         addEventListener(MouseEvent.CLICK,this.clickHandle);
         UIManager.mainUiBtnContainer.addBTN(this);
      }
      
      public function clickHandle(evt:MouseEvent = null) : void
      {
         if(Boolean(this.effect))
         {
            EffectManager.removeEffect(this.effect);
            this.effect = null;
         }
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(View_vipBGift.getInstance(),function():void
         {
            View_vipBGift.getInstance().visible = !View_vipBGift.getInstance().visible;
         });
      }
      
      public function dispose() : void
      {
         if(!this.effect)
         {
            return;
         }
         UIManager.mainUiBtnContainer.removeBTN(this);
         removeEventListener(MouseEvent.CLICK,this.clickHandle);
         EffectManager.removeEffect(this.effect);
         this.effect = null;
         this._bm.bitmapData = null;
         this._bm = null;
      }
   }
}

