package com.yiTian.view.modules.newerGuide.thirdNewerGuide
{
   import com.utils.Util;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BtnSpr extends Sprite
   {
      
      public var status:int;
      
      public function BtnSpr()
      {
         super();
         buttonMode = true;
         addEventListener(MouseEvent.MOUSE_OVER,this.overHd);
         addEventListener(MouseEvent.MOUSE_OUT,this.outHd);
      }
      
      private function overHd(e:MouseEvent) : void
      {
         transform.colorTransform = Util.colorGlow;
      }
      
      private function outHd(e:MouseEvent) : void
      {
         transform.colorTransform = Util.colorNomal;
      }
   }
}

