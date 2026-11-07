package com.yiTian.view.modules.newRechargeFeedback
{
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.utils.Tween;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class View_NewFeedBackBar extends Sprite
   {
      
      private var bar:ScaleBitmap;
      
      private var bar_mask:Shape;
      
      private var tf:MyTextField;
      
      private var eff:Effect;
      
      public function View_NewFeedBackBar()
      {
         super();
         this.initUI();
      }
      
      private function initUI() : void
      {
         ComponentUtil.getScaleBitmap("HuiKuiProgress_Back",[32,15,61,4],this,{
            "x":0,
            "y":0,
            "width":620,
            "height":34
         },Global.NewHuiKui_Imgsdm);
         this.bar = ComponentUtil.getScaleBitmap("HuiKuiProgress",[6,7,42,2],this,{
            "x":25,
            "y":9,
            "width":570,
            "height":16
         },Global.NewHuiKui_Imgsdm);
         this.bar_mask = ComponentUtil.getShape(this.bar.width,this.bar.height);
         addChild(this.bar_mask);
         ComponentUtil.setPropertie(this.bar_mask,{
            "x":this.bar.x,
            "y":this.bar.y,
            "width":0
         });
         this.bar.mask = this.bar_mask;
         this.tf = ComponentUtil.getTextField("0/0",this,{
            "x":this.bar.x + this.bar.width / 2,
            "y":7
         },"center");
         this.eff = EffectManager.addEffect("35172",this,600,this.bar_mask.x + this.bar_mask.width,this.bar_mask.y + 6,true);
      }
      
      public function go(min:int, max:int) : void
      {
         var barWidth:Number = min / max * this.bar.width;
         this.tf.text = min + "/" + max;
         Tween.to(this.bar_mask,500,{"width":[this.bar_mask.width,barWidth]},function():void
         {
            trace("bar_mask.width" + bar_mask.width);
         },null,Tween.EASYINOUT);
         Tween.to(this.eff,500,{"px":[this.eff.px,this.bar_mask.x + barWidth]},null,null,Tween.EASYINOUT);
      }
   }
}

