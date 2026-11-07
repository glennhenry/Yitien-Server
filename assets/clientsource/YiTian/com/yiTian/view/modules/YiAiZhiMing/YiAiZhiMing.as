package com.yiTian.view.modules.YiAiZhiMing
{
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class YiAiZhiMing
   {
      
      private static var icon:Icon;
      
      public function YiAiZhiMing()
      {
         super();
         throw new Error("YiAiZhiMing not to be creat!");
      }
      
      public static function ShowIcon() : void
      {
         if(GameUnitManager.hero.level < 35)
         {
            return;
         }
         icon = new Icon();
         UIManager.mainUiBtnContainer.addBTN(icon);
         icon.addEventListener(MouseEvent.CLICK,onClick);
      }
      
      private static function onClick(e:MouseEvent) : void
      {
         UIManager.mainUiBtnContainer.removeBTN(icon);
         var request:URLRequest = new URLRequest("http://yi.qq.com/webplat/info/news_version3/4814/5561/5564/m4016/201308/219946.shtml");
         navigateToURL(request);
      }
   }
}

import com.yiTian.gameUnit.magic.Effect;
import com.yiTian.utils.Utils;
import flash.display.Bitmap;
import flash.display.Sprite;

class Icon extends Sprite
{
   
   private var bg:Bitmap;
   
   private var ef:Effect;
   
   public function Icon()
   {
      super();
      this.Init();
   }
   
   private function Init() : void
   {
      this.bg = Utils.getLoadBitmap("resource/image/YiAiZhiMing/YiAiZhiMing.png");
      this.bg.x = -11;
      this.bg.y = -9;
      this.buttonMode = true;
      this.addChild(this.bg);
   }
}
