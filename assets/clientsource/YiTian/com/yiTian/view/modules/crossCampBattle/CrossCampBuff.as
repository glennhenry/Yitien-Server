package com.yiTian.view.modules.crossCampBattle
{
   import com.yiTian.manager.TipManager;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class CrossCampBuff extends Sprite
   {
      
      private static var pool:Array = [];
      
      public static var buffTip:Object = new Object();
      
      buffTip[39474] = "可直接杀死敌人，绝对秒杀，大师的剑，你懂的！";
      buffTip[39475] = "点击敌方战车可直接摧毁！";
      buffTip[53533] = "交给总管，可以大量回复皇旗的生命值！";
      buffTip[53534] = "交给总管，可以回复皇旗一定的生命值！";
      
      private var bm_bg:Bitmap = new Bitmap();
      
      public var id:int;
      
      public function CrossCampBuff()
      {
         super();
         addChild(this.bm_bg);
      }
      
      public static function get instance() : CrossCampBuff
      {
         return Boolean(pool.length) ? pool.pop() : new CrossCampBuff();
      }
      
      public function update(sprIndex:int) : void
      {
         this.id = sprIndex;
         this.bm_bg = Utils.getLoadBitmap("resource/image/buff/" + sprIndex + ".png",this.bm_bg);
         TipManager.bind(this,buffTip[sprIndex]);
      }
      
      public function dispose() : void
      {
         if(Boolean(this.bm_bg))
         {
            removeChild(this.bm_bg);
         }
         this.bm_bg = null;
         this.id = 0;
         pool.push(this);
      }
   }
}

