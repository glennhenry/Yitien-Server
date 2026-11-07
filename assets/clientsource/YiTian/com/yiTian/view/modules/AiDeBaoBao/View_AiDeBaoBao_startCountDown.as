package com.yiTian.view.modules.AiDeBaoBao
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.view.Panel;
   import flash.display.Bitmap;
   
   public class View_AiDeBaoBao_startCountDown extends Panel
   {
      
      private static var _instance:View_AiDeBaoBao_startCountDown;
      
      private var bg:Bitmap;
      
      private var numArrBMDT:Array;
      
      public function View_AiDeBaoBao_startCountDown()
      {
         super();
         super.init();
      }
      
      public static function get instance() : View_AiDeBaoBao_startCountDown
      {
         if(!_instance)
         {
            _instance = new View_AiDeBaoBao_startCountDown();
         }
         return _instance;
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getBitmap("Back_DJS",this,{
            "x":0,
            "y":0
         },Global.ADBB_Imgsdm);
         this.bg = new Bitmap();
         addChild(this.bg);
         this.bg.x = 154;
         this.bg.y = 82;
         this.numArrBMDT = [];
         var i:int = 0;
         while(i < 10)
         {
            this.numArrBMDT.push(ComponentUtil.getBitmapData("SZ_" + i,Global.ADBB_Imgsdm));
            i++;
         }
         this.mouseEnabled = false;
         this.mouseChildren = false;
      }
      
      public function setNumber(num:int) : void
      {
         this.bg.bitmapData = this.numArrBMDT[num];
         this.bg.x = (this.width - this.bg.width) / 2;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2 - 100;
      }
   }
}

