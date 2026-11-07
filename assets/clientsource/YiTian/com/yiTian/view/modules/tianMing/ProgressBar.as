package com.yiTian.view.modules.tianMing
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_TianMing;
   import com.yiTian.data.model.Model_Tianming;
   import com.yiTian.utils.Tween;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ProgressBar extends Sprite
   {
      
      private var bar_mask:Shape;
      
      private var bar:Bitmap;
      
      private var tf:MyTextField;
      
      private var min:int;
      
      private var max:int;
      
      private var _barWidth:Number;
      
      private var btn:Button;
      
      private var valueVec:Vector.<MyTextField>;
      
      private var valueTF:MyTextField;
      
      public function ProgressBar()
      {
         super();
      }
      
      private function init() : void
      {
      }
      
      public function upData(min:int, max:int) : void
      {
         if(min == this.min && max == this.max)
         {
            return;
         }
         this.min = min;
         this.max = max;
         if(!this.bar)
         {
            return;
         }
         if(Model_Tianming.zhuFuExp >= Data_lib.tmzf[Enum_TianMing.ZHUFU_MAXLEVEL][0])
         {
            this.btn.enabled = false;
         }
         this.go();
      }
      
      public function get barWidth() : Number
      {
         return this._barWidth;
      }
      
      private function go() : void
      {
         this._barWidth = this.min / this.max * this.bar.width;
         this.tf.text = this.min + "/" + this.max;
         Tween.to(this.bar_mask,500,{"width":[this.bar_mask.width,this._barWidth]},null,null,Tween.EASYINOUT);
      }
      
      public function initUI() : void
      {
         ComponentUtil.getBitmap("ZFProgress_Back",this,{
            "x":0,
            "y":0
         },Global.TianMing_Imgsdm);
         this.bar = ComponentUtil.getBitmap("ZFProgress",this,{
            "x":17,
            "y":6
         },Global.TianMing_Imgsdm);
         this.bar_mask = ComponentUtil.getShape(this.bar.width,this.bar.height);
         addChild(this.bar_mask);
         ComponentUtil.setPropertie(this.bar_mask,{
            "x":this.bar.x,
            "y":this.bar.y,
            "width":0
         });
         this.bar.mask = this.bar_mask;
         this.tf = ComponentUtil.getTextField("100/100",this,{
            "x":this.bar.x + this.bar.width / 2,
            "y":4
         },"center");
         this.btn = ComponentUtil.getButton("","Button_ZFJia",this,{
            "x":473,
            "y":3,
            "textColor":16184781
         },Global.TianMing_Imgsdm);
         this.btn.callBack = function(e:MouseEvent):void
         {
            View_BlessingFruit.instance.visible = true;
         };
         this.creatTF();
         if(this.min == 0 && this.max == 0)
         {
            return;
         }
         this.go();
         if(Model_Tianming.zhuFuExp >= Data_lib.tmzf[Enum_TianMing.ZHUFU_MAXLEVEL][0])
         {
            this.btn.enabled = false;
         }
      }
      
      private function creatTF() : void
      {
         var valueTF:MyTextField = null;
         this.valueVec = new Vector.<MyTextField>(2);
         var i:int = 0;
         while(i < 2)
         {
            valueTF = ComponentUtil.getTextField("",this,{
               "color":52224,
               "size":22
            });
            valueTF.bold = true;
            valueTF.align = "center";
            this.valueVec[i] = valueTF;
            i++;
         }
      }
      
      public function valueEff(value:int) : void
      {
         this.check();
         this.valueTF = this.valueVec.shift();
         this.valueTF.x = this._barWidth;
         this.valueTF.y = this.bar.y;
         this.valueTF.text = "+" + value;
         Tween.to(this.valueTF,1000,{
            "y":[this.bar.y,this.bar.y - 100],
            "alpha":[1,0]
         },this.dispose,null,Tween.EASYINOUT);
      }
      
      private function check() : void
      {
         if(Boolean(this.valueTF))
         {
            Tween.stop(this.valueTF);
            Tween.to(this.valueTF,300,{
               "y":[this.valueTF.y,this.bar.y - 100],
               "alpha":[this.valueTF.alpha,0]
            },this.dispose,null,Tween.EASYINOUT);
            this.valueVec.push(this.valueTF);
         }
      }
      
      private function dispose(tf:MyTextField) : void
      {
         Tween.stop(tf);
         tf.text = "";
         tf.alpha = 1;
      }
   }
}

