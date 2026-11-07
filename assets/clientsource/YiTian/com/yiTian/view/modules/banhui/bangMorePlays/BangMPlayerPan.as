package com.yiTian.view.modules.banhui.bangMorePlays
{
   import flash.display.Sprite;
   
   public class BangMPlayerPan extends Sprite
   {
      
      public function BangMPlayerPan()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         var instance:Child_P = new Child_P();
         instance.x = 29;
         instance.y = 69;
         addChild(instance);
      }
   }
}

