package com.yiTian.view.modules.qiJu
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class QijuBoss_Blood extends Sprite
   {
      
      private var bloodBG:Bitmap;
      
      private var blood:Bitmap;
      
      private var bloodMark:Shape;
      
      private var tf:MyTextField;
      
      private var nowBlood:Number;
      
      private var countBlood:Number;
      
      public function QijuBoss_Blood()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         this.bloodBG = new Bitmap();
         this.blood = new Bitmap();
         addChild(this.bloodBG);
         addChild(this.blood);
         this.tf = ComponentUtil.getTextField("",this,{"y":3});
         this.tf.align = "center";
         ComponentUtil.setPropertie(this.blood,{
            "x":20,
            "y":4
         });
         Utils.getLoadBitmap("resource/image/bang/b_1.png",this.bloodBG);
         Utils.getLoadBitmap("resource/image/bang/p_1_0.png",this.blood,null,this.drawMark);
      }
      
      private function drawMark() : void
      {
         this.bloodMark = ComponentUtil.getShape(this.blood.width,this.blood.height);
         ComponentUtil.setPropertie(this.bloodMark,{
            "x":this.blood.x,
            "y":this.blood.y
         });
         this.tf.x = this.blood.x;
         this.tf.realWidth = this.blood.width;
         addChild(this.bloodMark);
         this.blood.mask = this.bloodMark;
         if(!isNaN(this.nowBlood))
         {
            this.go();
         }
      }
      
      public function upData(nowBlood:Number, countBlood:Number) : void
      {
         this.nowBlood = nowBlood;
         this.countBlood = countBlood;
         this.tf.text = nowBlood + "/" + countBlood;
         if(!this.blood.bitmapData || !this.bloodMark || !this.bloodBG.bitmapData)
         {
            return;
         }
         this.go();
      }
      
      private function go() : void
      {
         var bloodWidth:Number = this.nowBlood / this.countBlood * this.blood.width;
         Tween.to(this.bloodMark,500,{"width":[this.bloodMark.width,bloodWidth]});
      }
   }
}

