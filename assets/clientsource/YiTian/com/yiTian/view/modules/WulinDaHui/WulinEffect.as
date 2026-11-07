package com.yiTian.view.modules.WulinDaHui
{
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class WulinEffect extends Sprite
   {
      
      private static var _instance:WulinEffect;
      
      private static const NUMBERS:int = 3;
      
      private var loadH:Boolean = false;
      
      private var loadT:Boolean = false;
      
      private var loadA:Boolean = false;
      
      private var bmpVec:Vector.<Bitmap>;
      
      private var isInit:Boolean = false;
      
      private var arr:Array;
      
      public function WulinEffect()
      {
         var i:int;
         this.bmpVec = new Vector.<Bitmap>();
         this.arr = ["zero","one","two","three","four","five","six","seven","eight","nine"];
         super();
         GameScene.upUILayer.addChild(this);
         mouseChildren = false;
         mouseEnabled = false;
         if(!this.isInit)
         {
            addChild(Utils.getLoadBitmap("resource/image/wulinParty/eff/lianZhan.png",null,null,function():void
            {
               isInit = true;
            }));
         }
         i = 0;
         while(i < NUMBERS)
         {
            this.bmpVec.push(new Bitmap());
            addChild(this.bmpVec[i]);
            this.bmpVec[i].y = 36;
            i++;
         }
         GameScene.instance.addFrameCallBack(this.listen);
         this.pos();
      }
      
      public static function getInstance() : WulinEffect
      {
         if(Boolean(_instance))
         {
            return _instance;
         }
         _instance = new WulinEffect();
         return _instance;
      }
      
      private function listen(interenal:int) : void
      {
         if(SceneConfig.getSceneType() != SceneConfig.WULIN)
         {
            GameScene.instance.removeFrameCallBack(this.listen);
            this.removeItem();
         }
      }
      
      public function getNums(_numbers:int) : void
      {
         var h:int = 0;
         var t:int = 0;
         var a:int = 0;
         var Ten:int = 0;
         var Abit:int = 0;
         this.loadH = false;
         this.loadT = false;
         this.loadA = false;
         if(_numbers == 0)
         {
            this.removeItem();
            return;
         }
         if(_numbers >= 100)
         {
            h = _numbers / 100;
            t = int(_numbers / 10) % 10;
            a = _numbers % 10;
            Utils.getLoadBitmap(this.getUrl(h),this.bmpVec[0],null,function():void
            {
               loadH = true;
               if(loadT && loadA)
               {
                  finishHd();
               }
            });
            Utils.getLoadBitmap(this.getUrl(t),this.bmpVec[1],null,function():void
            {
               loadT = true;
               if(loadH && loadA)
               {
                  finishHd();
               }
            });
            Utils.getLoadBitmap(this.getUrl(a),this.bmpVec[2],null,function():void
            {
               loadA = true;
               if(loadH && loadT)
               {
                  finishHd();
               }
            });
         }
         else if(_numbers >= 10 && _numbers <= 99)
         {
            Ten = _numbers / 10;
            Abit = _numbers % 10;
            Utils.getLoadBitmap(this.getUrl(Ten),this.bmpVec[0],null,function():void
            {
               loadT = true;
               if(loadA)
               {
                  finishHd();
               }
            });
            Utils.getLoadBitmap(this.getUrl(Abit),this.bmpVec[1],null,function():void
            {
               loadA = true;
               if(loadT)
               {
                  finishHd();
               }
            });
         }
         else
         {
            this.loadH = true;
            this.loadT = true;
            Utils.getLoadBitmap(this.getUrl(_numbers),this.bmpVec[0],null,function():void
            {
               finishHd();
            });
         }
      }
      
      private function finishHd() : void
      {
         var _count:int = 0;
         var i:int = 0;
         var bmp:Bitmap = null;
         _count = 0;
         i = 0;
         while(i < this.bmpVec.length)
         {
            this.bmpVec[i].x = _count + 136;
            _count += this.bmpVec[i].width;
            bmp = new Bitmap();
            bmp.bitmapData = this.bmpVec[i].bitmapData;
            bmp.x = this.bmpVec[i].x;
            bmp.y = this.bmpVec[i].y;
            addChild(bmp);
            Tween.to(bmp,200,{
               "alpha":[1,0],
               "scaleX":[1,2],
               "scaleY":[1,2],
               "x":[bmp.x,bmp.x - bmp.width / 2],
               "y":[bmp.y,bmp.y - bmp.height / 2]
            },function():void
            {
               if(Boolean(bmp))
               {
                  removeChild(bmp);
               }
               bmp = null;
            });
            i++;
         }
      }
      
      public function pos() : void
      {
         x = 2;
         y = 90;
      }
      
      private function getUrl(_n:int) : String
      {
         return "resource/image/wulinParty/eff/" + this.arr[_n] + ".png";
      }
      
      public function removeItem() : void
      {
         if(Boolean(parent))
         {
            parent.removeChild(this);
         }
         delete global[this];
         _instance = null;
         this.isInit = false;
      }
   }
}

