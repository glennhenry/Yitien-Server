package com.yiTian.view.modules.guaji
{
   import com.utils.ColorConstant;
   import com.yiTian.utils.HtmlUtil;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class Child_starContainer extends Sprite
   {
      
      public static const maxSimpleStar:uint = 4;
      
      private var _data:Number;
      
      private var starVec:Vector.<Child_processStar>;
      
      private var specilStar:Child_processStar;
      
      private var tf_specilStarCount:TextField;
      
      private var _value:Number;
      
      public function Child_starContainer()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         var star:Child_processStar = null;
         this.starVec = new Vector.<Child_processStar>();
         var index:uint = 0;
         while(index < maxSimpleStar)
         {
            star = new Child_processStar();
            star.x = index * 35;
            star.percent = 0;
            this.starVec.push(star);
            addChild(star);
            index++;
         }
         this.specilStar = new Child_processStar();
         this.specilStar.x = 35;
         this.specilStar.percent = 0;
         this.specilStar.visible = false;
         addChild(this.specilStar);
         this.tf_specilStarCount = new TextField();
         this.tf_specilStarCount.x = 57;
         this.tf_specilStarCount.y = -2;
         this.tf_specilStarCount.mouseEnabled = false;
         this.tf_specilStarCount.height = 30;
         this.tf_specilStarCount.visible = false;
         addChild(this.tf_specilStarCount);
      }
      
      private function set simpleVisible(value:Boolean) : void
      {
         var star:Child_processStar = null;
         for each(star in this.starVec)
         {
            star.visible = value;
         }
      }
      
      public function set value(valuen:Number) : void
      {
         if(valuen < 0)
         {
            valuen = 0;
         }
         this._value = valuen;
         this.updateView();
      }
      
      private function updateView() : void
      {
         var i1:int = 0;
         var index:int = 0;
         var e:int = 0;
         var percent:Number = NaN;
         var i2:int = 0;
         var count:int = 0;
         if(this._value <= 4)
         {
            this.simpleVisible = true;
            this.specilStar.visible = false;
            this.tf_specilStarCount.visible = false;
            i1 = 0;
            while(i1 < this.starVec.length)
            {
               this.starVec[i1].visible = true;
               i1++;
            }
            index = 0;
            e = this._value;
            index = 0;
            while(index < this.starVec.length)
            {
               percent = e - index > 0 ? e - index : 0;
               this.starVec[index].percent = percent * 100;
               index++;
            }
         }
         else if(this._value < 32)
         {
            this.simpleVisible = false;
            this.specilStar.visible = true;
            this.tf_specilStarCount.visible = true;
            i2 = 0;
            while(i2 < this.starVec.length)
            {
               this.starVec[i2].visible = false;
               i2++;
            }
            count = this._value;
            this.specilStar.percent = 100;
            this.tf_specilStarCount.htmlText = HtmlUtil.font("× " + count.toString(),ColorConstant.getColorStr(ColorConstant.BLUE),20);
         }
         else
         {
            this.simpleVisible = false;
            this.specilStar.visible = true;
            this.tf_specilStarCount.visible = true;
            this.specilStar.percent = 100;
            this.tf_specilStarCount.htmlText = HtmlUtil.font("× 32",ColorConstant.getColorStr(ColorConstant.BLUE),20);
         }
      }
   }
}

