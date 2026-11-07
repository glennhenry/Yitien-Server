package com.yiTian.view.modules.collect
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.MainUIBase;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.text.TextFieldAutoSize;
   
   public class View_collect extends MainUIBase
   {
      
      private var rateTF:MyTextField;
      
      private var back:Bitmap;
      
      private var progress:Bitmap;
      
      private var proMask:Shape;
      
      private var tf:MyTextField;
      
      public function View_collect()
      {
         super();
         this.back = Utils.getLoadBitmap("resource/image/collect/CaiJi_ProgressBG.png");
         this.back.x = -125;
         addChild(this.back);
         this.progress = Utils.getLoadBitmap("resource/image/collect/CaiJi_Progress.png");
         this.progress.x = -110;
         this.progress.y = 7;
         addChild(this.progress);
         this.proMask = ComponentUtil.getShape(220,8,16711680,0);
         this.proMask.x = -110;
         this.proMask.y = 7;
         addChild(this.proMask);
         this.progress.mask = this.proMask;
         this.tf = ComponentUtil.getTextField("",this,{
            "color":16776960,
            "x":0,
            "y":-16
         },TextFieldAutoSize.CENTER);
         this.rateTF = ComponentUtil.getTextField("",this,{
            "x":65,
            "y":-16
         },TextFieldAutoSize.CENTER);
      }
      
      public function reset() : void
      {
         this.proMask.width = 1;
         this.rateTF.text = "0%";
      }
      
      public function set label(str:String) : void
      {
         this.tf.htmlText = str;
      }
      
      public function update(rate:Number) : void
      {
         this.proMask.width = rate * 220;
         this.rateTF.text = int(rate * 100) + "%";
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2 + 110;
         y = (Global.stage.stageHeight - height) / 2 + 150;
      }
   }
}

