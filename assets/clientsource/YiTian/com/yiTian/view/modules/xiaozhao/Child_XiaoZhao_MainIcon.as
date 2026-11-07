package com.yiTian.view.modules.xiaozhao
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
   
   public class Child_XiaoZhao_MainIcon extends Sprite
   {
      
      private static var instance:Child_XiaoZhao_MainIcon;
      
      private var _bm:Bitmap;
      
      private var effect:Effect;
      
      private var isInit:Boolean;
      
      public function Child_XiaoZhao_MainIcon()
      {
         super();
      }
      
      public static function getInstance() : Child_XiaoZhao_MainIcon
      {
         if(!instance)
         {
            instance = new Child_XiaoZhao_MainIcon();
         }
         return instance;
      }
      
      public function addIcon() : void
      {
         this.init();
      }
      
      public function init() : void
      {
         if(this.isInit)
         {
            return;
         }
         this.isInit = true;
         this._bm = new Bitmap();
         this._bm = Utils.getLoadBitmap("resource/image/xiaozhao/Icon_XZJZ.png",this._bm);
         addChild(this._bm);
         this.effect = EffectManager.addEffect("35343",this,1000,32,29,true);
         buttonMode = true;
         UIManager.mainUiBtnContainer.addBTN(this);
         addEventListener(MouseEvent.CLICK,this.clickHandle);
      }
      
      public function clickHandle(evt:MouseEvent = null) : void
      {
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(View_XiaoZhao.getInstance(),function():void
         {
            View_XiaoZhao.getInstance().visible = !View_XiaoZhao.getInstance().visible;
         });
         if(Boolean(this.effect))
         {
            EffectManager.removeEffect(this.effect);
            this.effect = null;
         }
      }
      
      public function dispose() : void
      {
         if(!this.isInit)
         {
            return;
         }
         UIManager.mainUiBtnContainer.removeBTN(this);
         removeEventListener(MouseEvent.CLICK,this.clickHandle);
         EffectManager.removeEffect(this.effect);
         this.effect = null;
         this._bm.bitmapData = null;
         this._bm = null;
         this.isInit = false;
      }
   }
}

