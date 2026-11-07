package com.yiTian.view.modules.chargeGuide
{
   import com.yiTian.manager.GameUnitManager;
   import flash.display.Sprite;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class SpeEff extends Sprite
   {
      
      public static var _instanc:SpeEff;
      
      private var s:Sprite = new Sprite();
      
      public var timeP:Array = [];
      
      private var isVis:Boolean = false;
      
      public function SpeEff()
      {
         super();
      }
      
      public static function getInstance() : SpeEff
      {
         if(!_instanc)
         {
            return new SpeEff();
         }
         return _instanc;
      }
      
      public function showEff(stx:int, sty:int, _obj:Object = null, _parent:Sprite = null) : void
      {
         this.s.graphics.lineStyle(2,16383488,1);
         this.s.graphics.moveTo(0,0);
         this.s.graphics.lineTo(_obj.width,0);
         this.s.graphics.lineTo(_obj.width,_obj.height);
         this.s.graphics.lineTo(0,_obj.height);
         this.s.graphics.lineTo(0,0);
         addChild(this.s);
         _parent.addChild(this);
         alpha = 0.5;
         x = stx;
         y = sty;
         this.isVis = true;
         this._play();
      }
      
      public function _play() : void
      {
         if(!this.isVis)
         {
            return;
         }
         if(GameUnitManager.hero.vip == 0)
         {
            this.removeItem();
            return;
         }
         this.timeP.push(setTimeout(this._go,500));
      }
      
      private function _go() : void
      {
         alpha = alpha == 1 ? 0.5 : 1;
         clearTimeout(this.timeP.shift());
         this._play();
      }
      
      public function removeItem() : void
      {
         this.isVis = false;
         if(Boolean(this.s))
         {
            if(contains(this.s))
            {
               removeChild(this.s);
            }
         }
         if(Boolean(this.timeP.length))
         {
            clearTimeout(this.timeP.shift());
         }
         if(Boolean(parent))
         {
            parent.removeChild(this);
         }
         _instanc = this;
      }
   }
}

