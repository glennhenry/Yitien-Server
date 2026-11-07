package com.yiTian.effects
{
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class CoolDown extends Sprite
   {
      
      private var _width:int;
      
      private var r:Number;
      
      private var _percent:Number = 0;
      
      private var _color:uint = 0;
      
      public function CoolDown(width:int = 40, color:uint = 0, alpha:Number = 0.5)
      {
         super();
         this._width = width;
         this.r = width / 2 * 1.5;
         this._color = color;
         var shape:Shape = new Shape();
         shape.graphics.beginFill(0);
         shape.graphics.drawRect(0,0,width,width);
         shape.graphics.endFill();
         addChild(shape);
         var _temp_1:* = this;
         this.mouseChildren = false;
         _temp_1.mouseEnabled = false;
         this.mask = shape;
         this.alpha = alpha;
      }
      
      public function set percent(per:Number) : void
      {
         if(per > 0)
         {
            this._percent = per >= 1 ? 1 : per;
         }
         else
         {
            this._percent = 0;
         }
         var radian:Number = Math.PI * 2 * this._percent - Math.PI / 2;
         this.graphics.clear();
         switch(this._percent)
         {
            case 0:
               this.graphics.beginFill(this._color);
               this.graphics.drawRect(0,0,this._width,this._width);
               this.graphics.endFill();
               break;
            default:
               this.graphics.beginFill(this._color);
               this.graphics.drawRect(0,0,this._width,this._width);
               this.graphics.moveTo(this._width / 2,this._width / 2);
               this.graphics.lineTo(this._width / 2,this._width / 2 - this.r);
               if(radian >= Math.PI * 0.25 - Math.PI / 2)
               {
                  this.graphics.lineTo(this._width,0);
                  if(radian >= Math.PI * 0.25)
                  {
                     this.graphics.lineTo(this._width,this._width);
                     if(radian >= Math.PI * 0.75)
                     {
                        this.graphics.lineTo(0,this._width);
                        if(radian >= Math.PI * 1.25)
                        {
                           this.graphics.lineTo(0,0);
                        }
                     }
                  }
               }
               this.graphics.lineTo(this._width / 2 + Math.cos(radian) * this.r,this._width / 2 + Math.sin(radian) * this.r);
               this.graphics.lineTo(this._width / 2,this._width / 2);
               this.graphics.endFill();
         }
      }
      
      public function get percent() : Number
      {
         return this._percent;
      }
      
      public function set color(value:uint) : void
      {
         this._color = value;
         this.percent = this._percent;
      }
   }
}

