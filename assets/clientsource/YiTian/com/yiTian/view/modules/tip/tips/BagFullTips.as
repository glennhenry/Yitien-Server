package com.yiTian.view.modules.tip.tips
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.chat.EffecObj;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BagFullTips extends Sprite
   {
      
      private var bmp:Bitmap = new Bitmap();
      
      public function BagFullTips()
      {
         super();
         buttonMode = true;
         mouseEnabled = true;
         addChild(Utils.getLoadBitmap("resource/image/bagFull/Full.png",this.bmp));
         EffecObj.getEffec(this.bmp);
         this.bmp.scaleX = 0.8;
         this.bmp.scaleY = 0.8;
         GameScene.popupLayer.addChild(this);
         addEventListener(MouseEvent.CLICK,this.cliHd);
      }
      
      private function cliHd(e:MouseEvent) : void
      {
         UIManager.bagPanel.visible = !UIManager.bagPanel.visible;
      }
      
      public function remove() : void
      {
         if(Boolean(parent))
         {
            parent.removeChild(this);
         }
         EffecObj.removeEffect(this.bmp);
      }
   }
}

