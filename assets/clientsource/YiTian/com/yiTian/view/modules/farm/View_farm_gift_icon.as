package com.yiTian.view.modules.farm
{
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.net.message.cg.FarmCGMessage;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_farm_gift_icon extends Sprite
   {
      
      private static var _instance:View_farm_gift_icon;
      
      public static var isCLick:Boolean = true;
      
      private var _bg:Bitmap;
      
      private var effect:Effect;
      
      public function View_farm_gift_icon()
      {
         super();
         if(Boolean(_instance))
         {
            throw new Error("singlton error");
         }
         this.init();
         _instance = this;
      }
      
      public static function get instance() : View_farm_gift_icon
      {
         if(!_instance)
         {
            _instance = new View_farm_gift_icon();
         }
         return _instance;
      }
      
      private function init() : void
      {
         this._bg = new Bitmap();
         this._bg = Utils.getLoadBitmap("resource/image/myPath/" + "farmGift" + ".png",this._bg);
         buttonMode = true;
         addChild(this._bg);
         this.addEffect();
         addEventListener(MouseEvent.CLICK,this.clickHandle);
      }
      
      private function clickHandle(evt:MouseEvent) : void
      {
         FarmCGMessage.cg_farm_get_everyday_gift();
      }
      
      public function addEffect() : void
      {
         if(!this.effect)
         {
            this.effect = EffectManager.addEffect("35343",this,1000,32,29,true);
         }
      }
   }
}

