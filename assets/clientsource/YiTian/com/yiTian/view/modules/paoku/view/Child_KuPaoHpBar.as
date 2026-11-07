package com.yiTian.view.modules.paoku.view
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class Child_KuPaoHpBar extends Sprite
   {
      
      public var hpHeats:Array = [];
      
      public function Child_KuPaoHpBar()
      {
         super();
      }
      
      public function setHp(value:int) : void
      {
         var i:int = 0;
         var bm:Bitmap = null;
         if(value >= 0)
         {
            i = 0;
            while(i < 5)
            {
               bm = this.hpHeats[i];
               if(bm == null)
               {
                  bm = new Bitmap();
                  this.hpHeats.push(bm);
                  bm.x = i * 35;
                  addChild(bm);
               }
               bm.bitmapData = ComponentUtil.getBitmapData(value > i ? "mx" : "kx",Global.MMKPdm);
               i++;
            }
         }
      }
   }
}

