package com.yiTian.view.modules.chat
{
   import flash.display.GradientType;
   import flash.display.Shape;
   import flash.geom.Matrix;
   
   public class TweenRichTF extends RichTF
   {
      
      private static var _mat:Matrix;
      
      private var bg:Shape = new Shape();
      
      private var _lastTxt:String;
      
      public var content:String;
      
      public function TweenRichTF(_leading:int = 6)
      {
         addChild(this.bg);
         super(_leading);
         width = 160;
         if(!_mat)
         {
            _mat = new Matrix();
            _mat.createGradientBox(160,80,Math.PI * 0.75);
         }
      }
      
      public function set percent(value:Number) : void
      {
         var len:int = this.content.length * value;
         if(this.content.charAt(len - 1) == "/")
         {
            len += 2;
         }
         if(this.content.charAt(len - 2) == "/")
         {
            len += 1;
         }
         var curStr:String = this.content.slice(0,len);
         if(this._lastTxt != curStr)
         {
            htmlText = curStr;
            this.bgReset();
            this._lastTxt = curStr;
         }
      }
      
      override public function dispose() : void
      {
         clearFace();
         graphics.clear();
         htmlText = "";
         this._lastTxt = "";
      }
      
      private function bgReset() : void
      {
         var h:Number = tf.textHeight + 10;
         this.bg.graphics.clear();
         this.bg.graphics.beginGradientFill(GradientType.LINEAR,[11184640,7502418],[0.7,0.7],[0,127],_mat);
         this.bg.graphics.lineStyle(2,16382361);
         this.bg.graphics.drawRoundRect(-5,-5,160 + 10,h,5,5);
         this.bg.graphics.endFill();
      }
   }
}

