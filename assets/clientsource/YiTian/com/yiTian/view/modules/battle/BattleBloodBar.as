package com.yiTian.view.modules.battle
{
   import com.yiTian.utils.Tween;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class BattleBloodBar extends Sprite
   {
      
      public static const UPDATE_MSG:String = "bbbPercentUpdate";
      
      private var _e:Event;
      
      public var bars:Array = [];
      
      private var _len:uint;
      
      private var _disPercent:Number;
      
      protected var _percent:Number = 1;
      
      public var curPercent:Number = 1;
      
      public var playIndex:int = 0;
      
      public function BattleBloodBar()
      {
         super();
      }
      
      public function insertBarAt(d:DisplayObject, index:int) : void
      {
         if(index < 0)
         {
            this.bars.push(d);
            addChild(d);
         }
         else
         {
            d = this.bars.splice(index,0,d);
            addChildAt(d,index);
         }
         this._len = this.bars.length;
      }
      
      public function appendBar(d:DisplayObject) : void
      {
         this.insertBarAt(d,-1);
      }
      
      public function tween(curPercent:Number) : void
      {
         this._disPercent = curPercent;
         Tween.to(this,1000,{"percent":[this._percent,curPercent]},this.onComplete,null,Tween.SIN);
      }
      
      public function get percent() : Number
      {
         return this._percent;
      }
      
      public function set percent(v:Number) : void
      {
         this._percent = v;
         this.playIndex = this._len * this._percent;
         if(this.playIndex < 0)
         {
            this.playIndex = 0;
            this.curPercent = 0;
         }
         if(this.playIndex < this._len)
         {
            this.curPercent = this._percent * this._len - this.playIndex;
         }
         else
         {
            this.playIndex = this._len - 1;
            this.curPercent = 1;
         }
         this.invalidate();
      }
      
      protected function _render(e:Event) : void
      {
         var i:int = 0;
         while(i < this.playIndex)
         {
            this.bars[i].visible = true;
            i += 1;
         }
         var j:int = this._len - 1;
         while(j > this.playIndex)
         {
            if(Boolean(this.bars[j].visible))
            {
               this.bars[j].visible = false;
            }
            j -= 1;
         }
         this.bars[j].visible = this.bars[j].visible || true;
         removeEventListener(Event.EXIT_FRAME,this._render);
      }
      
      public function invalidate() : void
      {
         addEventListener(Event.EXIT_FRAME,this._render);
      }
      
      private function onComplete() : void
      {
         this.percent = this._disPercent;
      }
   }
}

