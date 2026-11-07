package com.yiTian.view.modules.cast.baishiZengyi
{
   import com.utils.Util;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.utils.call.Delegate123;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BaoSZYTip extends Sprite
   {
      
      private var stoneLvl:int;
      
      private var tipShow:TipMan;
      
      public function BaoSZYTip()
      {
         super();
         filters = Util.disabled;
         addChild(Utils.getLoadBitmap("resource/image/baoshiZY/bsZY30.png",new Bitmap()));
      }
      
      public function show(lvl:int) : void
      {
         this.stoneLvl = lvl;
         this.tipShow = TipMan.instance;
         if(GameUnitManager.hero.level < 40)
         {
            this.tipShow.bind(this,"40级开启",false);
            filters = Util.disabled;
            if(hasEventListener(MouseEvent.CLICK))
            {
               removeEventListener(MouseEvent.CLICK,this.cliHd);
            }
            if(hasEventListener(MouseEvent.MOUSE_DOWN))
            {
               removeEventListener(MouseEvent.MOUSE_DOWN,this.downHd);
            }
            buttonMode = false;
         }
         else
         {
            this.tipShow.bind(this,lvl,true);
            filters = [];
            addEventListener(MouseEvent.CLICK,this.cliHd);
            addEventListener(MouseEvent.MOUSE_DOWN,this.downHd);
            buttonMode = true;
         }
      }
      
      private function downHd(e:MouseEvent) : void
      {
         var pan:View_baoshiZY = Singleton.getInstance(View_baoshiZY) as View_baoshiZY;
         if(pan.visible)
         {
            pan.visible = false;
         }
      }
      
      private function cliHd(e:MouseEvent) : void
      {
         var pan:View_baoshiZY = null;
         pan = Singleton.getInstance(View_baoshiZY) as View_baoshiZY;
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pan,function():void
         {
            pan.updata(stoneLvl);
         });
      }
   }
}

