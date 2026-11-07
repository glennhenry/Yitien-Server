package com.yiTian.view.modules.KuaFuPaiDui
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel;
   import flash.display.Bitmap;
   
   public class View_KuaFuPaiDui_scoreEffect extends Panel
   {
      
      private static var _instance:View_KuaFuPaiDui_scoreEffect;
      
      private var numBmdtArray:Array;
      
      private var numBitmapArray:Array;
      
      public function View_KuaFuPaiDui_scoreEffect()
      {
         super();
         init();
      }
      
      public static function get instance() : View_KuaFuPaiDui_scoreEffect
      {
         if(!_instance)
         {
            _instance = new View_KuaFuPaiDui_scoreEffect();
         }
         return _instance;
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getBitmap("TX_Perfect",this,{},Global.KFPDdm);
         ComponentUtil.getBitmap("TX_SZD",this,{"x":140},Global.KFPDdm);
         this.numBmdtArray = [];
         var i:int = 0;
         while(i < 10)
         {
            this.numBmdtArray.push(ComponentUtil.getBitmapData("Num" + i,Global.KFPDdm));
            i++;
         }
         this.numBitmapArray = [];
         this.mouseEnabled = false;
         this.mouseChildren = false;
      }
      
      public function showScore(score:int) : void
      {
         var i:* = undefined;
         var j:* = undefined;
         visible = true;
         var str:Array = score.toString().split("");
         for(i in this.numBitmapArray)
         {
            if(Boolean(this.numBitmapArray[i]))
            {
               this.numBitmapArray[i].visible = false;
            }
         }
         for(j in str)
         {
            if(Boolean(this.numBitmapArray[j]))
            {
               this.numBitmapArray[j].visible = true;
            }
            else
            {
               this.numBitmapArray[j] = new Bitmap();
               addChild(this.numBitmapArray[j]);
               this.numBitmapArray[j].x = 161 + j * 19;
               this.numBitmapArray[j].y = 16;
            }
            this.numBitmapArray[j].bitmapData = this.numBmdtArray[str[j]];
         }
         Tween.to(this,3000,{"alpha":[1,0]});
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = Global.stage.stageHeight - 300;
      }
   }
}

