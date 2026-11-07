package com.yiTian.effects
{
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class Effect_flower
   {
      
      private static var leftCount:int;
      
      private static var timeOut:Array = [];
      
      private static var _isPlaying:Boolean = false;
      
      public function Effect_flower()
      {
         super();
      }
      
      public static function addFlower() : void
      {
         ++leftCount;
         if(Boolean(leftCount))
         {
            play();
         }
      }
      
      private static function play() : void
      {
         if(!leftCount)
         {
            return;
         }
         if(_isPlaying)
         {
            return;
         }
         --leftCount;
         _isPlaying = true;
         var i:int = 0;
         while(i < 10)
         {
            timeOut.push(setTimeout(_play,i * 1000));
            i++;
         }
      }
      
      private static function _play() : void
      {
         var j:int;
         var eff:Bitmap = null;
         var angle:Number = NaN;
         var dist:Number = NaN;
         var sin:Number = NaN;
         var cos:Number = NaN;
         var heartX:Number = NaN;
         var heartY:Number = NaN;
         var i:uint = 0;
         var e1:Effect = null;
         heartX = Util.rnd(200,Global.stage.stageWidth - 200);
         heartY = Util.rnd(50,Global.stage.stageHeight - 300);
         var heartSize:Number = 150;
         i = 1;
         while(i < 360)
         {
            angle = Math.PI * i / 180;
            sin = Math.sin(angle);
            cos = Math.cos(angle);
            dist = heartSize * (1 - sin);
            eff = Utils.getLoadBitmap("resource/image/flower/50_Flower_05.png");
            eff.x = heartX;
            eff.y = heartY + 80;
            GameScene.upUILayer.addChild(eff);
            Tween.to(eff,3000,{
               "x":[eff.x,heartX - dist * cos],
               "y":[eff.y,heartY - dist * sin],
               "alpha":[1,0.8]
            },function(eff:Bitmap):void
            {
               Tween.to(eff,300,{"alpha":[0.8,0.3]},function(eff:Bitmap):void
               {
                  eff.bitmapData = null;
                  eff.parent.removeChild(eff);
                  eff = null;
               });
            },null,Tween.SIN);
            i += 25;
         }
         j = 0;
         while(j < 25)
         {
            e1 = EffectManager.addEffect("35091",GameScene.upUILayer,Util.rnd(1500,2000),Util.rnd(0,Global.stage.stageWidth),Util.rnd(-50,300),true);
            e1.scaleX = Util.rnd(0.5,0.8);
            e1.scaleY = e1.scaleX;
            Tween.to(e1,Util.rnd(6000,8000),{"py":[e1.py,Global.stage.stageHeight]},function(eff:Effect):void
            {
               EffectManager.removeEffect(eff);
               eff = null;
            },null,Tween.EASYINOUT);
            j++;
         }
         clearTimeout(timeOut.shift());
         if(!timeOut.length)
         {
            _isPlaying = false;
            play();
         }
      }
   }
}

