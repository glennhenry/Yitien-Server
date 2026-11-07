package com.yiTian.view.modules.tianmingjj
{
   import com.yiTian.utils.Tween;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   
   public class Child_imgsRoll extends Sprite
   {
      
      public static const UP:int = 1;
      
      public static const DOWN:int = 2;
      
      private var _numberIcons:Vector.<Bitmap>;
      
      public var time:Number = 0.1;
      
      public var gapV:int = 5;
      
      private var _value:int;
      
      private var _num:int = 0;
      
      private var numImage:Sprite;
      
      private var maskSp:Sprite;
      
      private var datas:Array;
      
      private var icon:Bitmap;
      
      private var desArr:Array;
      
      private var curDir:int;
      
      private var overFun:Function;
      
      private var overParam:Array;
      
      public var extendParam:Array;
      
      public function Child_imgsRoll(numberIcons:Vector.<BitmapData>)
      {
         var b:Bitmap = null;
         super();
         this._numberIcons = new Vector.<Bitmap>();
         while(Boolean(numberIcons.length))
         {
            b = new Bitmap();
            b.bitmapData = numberIcons.shift();
            this._numberIcons.push(b);
         }
         this.mouseEnabled = false;
         this.mouseChildren = false;
         this.initData();
      }
      
      public function get value() : int
      {
         return this._value;
      }
      
      public function set value($value:int) : void
      {
         this.callBack = null;
         Tween.stop(this.numImage);
         this._value = $value;
         if($value < 0)
         {
            this.clear();
         }
         else
         {
            this._num = $value % this._numberIcons.length;
            this.clearSp();
            this.icon = this._numberIcons[this._num];
            this.icon.x = 0;
            this.icon.y = 0;
            this.numImage.addChild(this.icon);
            this.width = this.icon.width;
            this.height = this.icon.height;
         }
      }
      
      public function customIcon($value:Bitmap) : void
      {
         this.icon = $value;
      }
      
      public function get numberIcons() : Vector.<Bitmap>
      {
         return this._numberIcons;
      }
      
      public function set numberIcons(value:Vector.<Bitmap>) : void
      {
         this._numberIcons = value;
         this.initMask();
      }
      
      public function set num(value:int) : void
      {
         this.numFromTo(this._num,value);
      }
      
      public function get num() : int
      {
         return this._num;
      }
      
      public function set callBack(fun:Function) : void
      {
         this.overFun = fun;
      }
      
      public function set callBackParam(value:Array) : void
      {
         this.overParam = value;
      }
      
      public function setNum(value:int, dir:int) : void
      {
         this.numFromTo(this._num,value,dir);
      }
      
      private function initData() : void
      {
         this.datas = new Array();
         this.numImage = new Sprite();
         this.maskSp = new Sprite();
         addChild(this.maskSp);
         this.numImage.mask = this.maskSp;
         this.addChild(this.numImage);
         this.initMask();
      }
      
      private function initMask() : void
      {
         this.desArr = new Array();
         this.maskSp.graphics.beginFill(0);
         if(Boolean(this._numberIcons[0]))
         {
            this.maskSp.graphics.drawRect(0,0,this._numberIcons[0].width,this._numberIcons[0].height);
         }
         this.maskSp.graphics.endFill();
      }
      
      public function numFromTo($start:int, $end:int, dir:int = 1) : void
      {
         var count:int = 0;
         var bm:Bitmap = null;
         var i:int = 0;
         var j:int = 0;
         if($start == $end)
         {
            if(this.overFun != null)
            {
               this.overFun.apply(null,this.overParam);
            }
            this.value = $end;
            return;
         }
         this._num = $end;
         this.datas.length = 0;
         $start %= this._numberIcons.length;
         $end %= this._numberIcons.length;
         $end += this._numberIcons.length;
         this.curDir = dir;
         if(dir == UP)
         {
            count = $end - $start >= 0 ? int($end - $start) : int(this._numberIcons.length + ($end - $start));
            i = $start;
            while(i <= $start + count)
            {
               bm = new Bitmap();
               bm.bitmapData = this._numberIcons[i % this._numberIcons.length].bitmapData.clone();
               this.datas.push(bm);
               i++;
            }
         }
         else
         {
            count = $start - $end >= 0 ? int($start - $end) : int(this._numberIcons.length + ($start - $end));
            j = $end + count;
            while(j >= $end)
            {
               this.datas.push(this._numberIcons[j % this._numberIcons.length]);
               j--;
            }
         }
         this.effect();
      }
      
      private function effect() : void
      {
         var i:int;
         var des:int;
         var index:int = 0;
         var coms:Function = null;
         var desY:Number = NaN;
         var bm:Bitmap = null;
         coms = function():void
         {
            clearSp();
            numImage.y = 0;
            numImage.addChild(icon);
            icon.x = 0;
            icon.y = 0;
            width = icon.width;
            height = icon.height;
            Tween.stop(numImage);
            if(overFun != null)
            {
               overFun.apply(null,overParam);
            }
         };
         Tween.stop(this.numImage);
         this.clearSp();
         this.desArr = new Array();
         this.icon = this.datas[this.datas.length - 1];
         i = 0;
         while(i < this.datas.length)
         {
            index = i % this._numberIcons.length;
            desY = (this.curDir == UP ? 1 : -1) * i * (this._numberIcons[index].height + this.gapV);
            this.desArr.push(desY);
            bm = this.datas[i];
            bm.y = desY;
            this.numImage.addChild(bm);
            i++;
         }
         this.numImage.y = 0;
         des = int(this.desArr[this.datas.length - 1]);
         Tween.to(this.numImage,1000,{"y":[0,0 - des]},coms);
      }
      
      public function persistRollTo($start:int, $end:int, $times:int = 3, dir:int = 1) : void
      {
         var count:int;
         var i:int;
         var index:int;
         var a:int;
         var des:int;
         var bm:Bitmap = null;
         var coms:Function = null;
         var indexs:int = 0;
         var desY:Number = NaN;
         coms = function():void
         {
            numFromTo($start,$end,dir);
         };
         this._num = $end;
         this.datas.length = 0;
         $start %= this._numberIcons.length;
         $end %= this._numberIcons.length;
         $end += this._numberIcons.length;
         this.curDir = dir;
         count = this._numberIcons.length + 1;
         i = 0;
         index = $start;
         if(dir == UP)
         {
            while(i < count)
            {
               indexs = index % this._numberIcons.length;
               if(i == count - 1)
               {
                  bm = new Bitmap();
                  bm.bitmapData = this._numberIcons[indexs].bitmapData.clone();
                  this.datas.push(bm);
               }
               else
               {
                  this.datas.push(this._numberIcons[indexs]);
               }
               index++;
               i++;
            }
         }
         else
         {
            while(i < count)
            {
               index %= this._numberIcons.length;
               bm = new Bitmap();
               bm.bitmapData = this._numberIcons[index].bitmapData.clone();
               this.datas.push(bm);
               index--;
               if(index < 0)
               {
                  index = this._numberIcons.length - 1;
               }
               i++;
            }
         }
         Tween.stop(this.numImage);
         this.clearSp();
         this.desArr = new Array();
         this.icon = this.datas[this.datas.length - 1];
         i = 0;
         while(i < this.datas.length)
         {
            desY = (this.curDir == UP ? 1 : -1) * i * (this.datas[i].height + this.gapV);
            this.desArr.push(desY);
            bm = this.datas[i];
            bm.y = desY;
            this.numImage.addChild(bm);
            i++;
         }
         a = 0;
         this.numImage.y = 0;
         des = int(this.desArr[this.datas.length - 1]);
         Tween.to(this.numImage,this.time * this.datas.length / 2,{"y":[this.numImage.y,0 - des]},coms);
      }
      
      private function clearSp() : void
      {
         var i:int = this.numImage.numChildren;
         while(i > 0)
         {
            this.numImage.removeChildAt(0);
            i--;
         }
         this.numImage.y = 0;
      }
      
      public function clear() : void
      {
         this._num = 0;
         this.clearSp();
      }
      
      public function destroy() : void
      {
         var len:int = 0;
         this.clearSp();
         this.datas.length = 0;
         if(Boolean(this._numberIcons))
         {
            len = int(this._numberIcons.length);
            while(len > 0)
            {
               this._numberIcons.pop().bitmapData = null;
               len--;
            }
         }
      }
   }
}

