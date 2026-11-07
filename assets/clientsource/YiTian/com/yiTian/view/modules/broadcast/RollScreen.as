package com.yiTian.view.modules.broadcast
{
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class RollScreen extends Sprite
   {
      
      private var vecRoll:Vector.<RollItem>;
      
      private var _test:Shape;
      
      public function RollScreen()
      {
         super();
         this._test = new Shape();
         this._test.graphics.beginFill(16777215,1);
         this._test.graphics.drawRect(0,0,1,140);
         this._test.graphics.endFill();
         this.vecRoll = new Vector.<RollItem>();
      }
      
      public function addItem(value:String) : int
      {
         var rollItem:RollItem = RollItem.getItem();
         rollItem.htmlText = value;
         addChild(rollItem);
         if(Boolean(this.vecRoll.length))
         {
            rollItem.y = this.vecRoll[this.vecRoll.length - 1].y + this.vecRoll[this.vecRoll.length - 1].height + View_SelfBroadcast.SPACING;
         }
         this.vecRoll.push(rollItem);
         return rollItem.height + View_SelfBroadcast.SPACING;
      }
      
      public function dispose(hei:Number, clear:Boolean = false) : void
      {
         var i:int = 0;
         var len:uint = 0;
         this._test.height = hei;
         if(clear || this.vecRoll.length == 0)
         {
            this._test.y = 0;
         }
         else if(this.vecRoll[this.vecRoll.length - 1].y + this.vecRoll[this.vecRoll.length - 1].height > hei)
         {
            this._test.y = this.vecRoll[this.vecRoll.length - 1].y + this.vecRoll[this.vecRoll.length - 1].height - hei;
         }
         else
         {
            this._test.y = 0;
         }
         len = this.vecRoll.length;
         i = 0;
         while(i < len)
         {
            if(i < this.vecRoll.length)
            {
               if(clear)
               {
                  this.vecRoll[i].dispose();
                  this.removeChild(this.vecRoll[i]);
                  this.vecRoll.shift();
                  i--;
               }
               else if(this.vecRoll[i].y + this.vecRoll[i].height < this._test.y)
               {
                  this.vecRoll[i].dispose();
                  this.removeChild(this.vecRoll[i]);
                  this.vecRoll.shift();
                  i--;
               }
            }
            i++;
         }
      }
   }
}

