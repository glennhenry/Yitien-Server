package com.yiTian.view.modules.blueDiamondND
{
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BlueDiamondCGMessage;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ViewBuleDiamondTip extends Sprite
   {
      
      private static var _instance:ViewBuleDiamondTip;
      
      private var _bg:Bitmap;
      
      private var eff:Effect;
      
      public function ViewBuleDiamondTip()
      {
         super();
         if(Boolean(_instance))
         {
            throw new Error("singlton error");
         }
         this.init();
         _instance = this;
      }
      
      public static function get instance() : ViewBuleDiamondTip
      {
         if(_instance)
         {
         }
         return _instance;
      }
      
      private function init() : void
      {
         this._bg = new Bitmap();
         this._bg = Utils.getLoadBitmap("resource/image/myPath/" + "blue" + ".png",this._bg);
         buttonMode = true;
         addChild(this._bg);
         if(!this.eff)
         {
            this.eff = EffectManager.addEffect("35343",this,1000,32,29,true);
         }
         addEventListener(MouseEvent.CLICK,this.clickHandle);
      }
      
      private function clickHandle(evt:MouseEvent) : void
      {
         if(Boolean(this.eff))
         {
            EffectManager.removeEffect(this.eff);
            this.eff = null;
         }
         evt.stopPropagation();
         BlueDiamondCGMessage.CG_REQUEST_INITDATA();
         UIManager.blueDiamondND.visible = !UIManager.blueDiamondND.visible;
      }
   }
}

