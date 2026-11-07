package com.yiTian.view.modules.WulinDaHui
{
   import com.yiTian.Global;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class View_WulinEff extends Sprite
   {
      
      public static var stX:int;
      
      public static var stY:int;
      
      public static var stWidth:int;
      
      private static const SIZE:int = 8;
      
      public static var pool:Array = [];
      
      private var bmpVec:Vector.<Bitmap> = new Vector.<Bitmap>();
      
      private var arrCount:Array;
      
      private var isLoad1:Boolean = false;
      
      private var isLoad2:Boolean = false;
      
      private var isLoad3:Boolean = false;
      
      private var isLoad4:Boolean = false;
      
      private var isLoad5:Boolean = false;
      
      private var arr:Array = ["ling","yi","er","san","si","wu","liu","qi","ba","jiu"];
      
      private var CompArr:Array = ["ling","shi","bai","qian","wan"];
      
      public function View_WulinEff()
      {
         super();
         var i:int = 0;
         while(i < SIZE)
         {
            this.bmpVec[i] = new Bitmap();
            addChild(this.bmpVec[i]);
            stWidth = SIZE * 68;
            i++;
         }
         stX = Global.stage.stageWidth / 2 + 50;
         stY = Global.stage.stageHeight / 2 - 50;
         GameScene.upUILayer.addChild(this);
      }
      
      public static function getInstance() : View_WulinEff
      {
         if(Boolean(pool.length))
         {
            return pool.pop();
         }
         return new View_WulinEff();
      }
      
      private function reset() : void
      {
         var i:int = 0;
         while(i < SIZE)
         {
            if(Boolean(this.bmpVec[i]))
            {
               this.bmpVec[i].bitmapData = null;
            }
            i++;
         }
      }
      
      public function change(_numbers:int) : void
      {
         var Ten:int = 0;
         var Abit:int = 0;
         var h:int = 0;
         var t:int = 0;
         var a:int = 0;
         var temHun:int = _numbers / 100;
         var temTen:int = _numbers / 10;
         this.reset();
         if(temHun == 0)
         {
            if(temTen == 0)
            {
               this.getBmp(0,0,_numbers);
            }
            else
            {
               Ten = _numbers / 10;
               Abit = _numbers % 10;
               this.getBmp(0,Ten,Abit);
            }
         }
         else
         {
            h = _numbers / 100;
            t = int(_numbers / 10) % 10;
            a = _numbers % 10;
            this.getBmp(h,t,a);
         }
      }
      
      private function effectHandle2() : void
      {
         Tween.to(this,300,{
            "scaleX":[1.5,1],
            "scaleY":[1.5,1],
            "x":[this.x,this.x + this.width / 8],
            "y":[this.y,this.y + this.height / 8]
         },function():void
         {
            Tween.to(GameScene.mapLayer,3,{"y":[GameScene.mapLayer.y,GameScene.mapLayer.y - 3]},shakeBack);
            comp2();
         });
      }
      
      private function comp2() : void
      {
         var i:int = 0;
         var bmp:Bitmap = null;
         this.arrCount = [];
         i = 0;
         while(i < this.bmpVec.length)
         {
            bmp = new Bitmap();
            bmp.bitmapData = this.bmpVec[i].bitmapData;
            bmp.x = this.bmpVec[i].x;
            bmp.y = this.bmpVec[i].y;
            addChild(bmp);
            Tween.to(bmp,500,{
               "alpha":[1,0],
               "scaleX":[1,2],
               "scaleY":[1,2],
               "x":[bmp.x,bmp.x - bmp.width / 4],
               "y":[bmp.y,bmp.y - bmp.height / 4]
            },function():void
            {
               if(Boolean(bmp))
               {
                  removeChild(bmp);
                  bmp.bitmapData = null;
                  bmp = null;
               }
               arrCount.push(i);
               if(arrCount.length == bmpVec.length)
               {
                  move();
               }
            });
            i++;
         }
      }
      
      private function effectHandle() : void
      {
         Tween.to(this,300,{
            "scaleX":[1,1.5],
            "scaleY":[1,1.5],
            "x":[this.x,this.x - this.width / 8],
            "y":[this.y,this.y - this.height / 8]
         },function():void
         {
            comp();
         });
      }
      
      private function comp() : void
      {
         Tween.to(this,200,{
            "scaleX":[1.5,1],
            "scaleY":[1.5,1],
            "x":[this.x,this.x + this.width / 8],
            "y":[this.y,this.y + this.height / 8]
         },function():void
         {
            move();
            Tween.to(GameScene.mapLayer,3,{"y":[GameScene.mapLayer.y,GameScene.mapLayer.y - 3]},shakeBack);
         });
      }
      
      private function shakeBack() : void
      {
         Tween.to(GameScene.mapLayer,3,{"y":[GameScene.mapLayer.y,GameScene.mapLayer.y + 3]});
      }
      
      public function move() : void
      {
         Tween.to(this,500,{"y":[stY,stY - 300]},this.dispose);
      }
      
      public function set vecData(vec:Vector.<Bitmap>) : void
      {
         var i:int = 0;
         while(i < vec.length)
         {
            this.bmpVec[i].bitmapData = vec[i].bitmapData;
            i++;
         }
      }
      
      public function get vecData() : Vector.<Bitmap>
      {
         return this.bmpVec;
      }
      
      public function getBmp(huns:int, tens:int, Abit:int) : void
      {
         var maxIndex:int = 0;
         this.isLoad1 = false;
         this.isLoad2 = false;
         this.isLoad3 = false;
         this.isLoad4 = false;
         this.isLoad5 = false;
         if(huns == 0)
         {
            if(tens == 0)
            {
               if(Abit == 1)
               {
                  maxIndex = -1;
                  this.bmpVec[2] = Utils.getLoadBitmap(this.getUrl(Abit),this.bmpVec[2],null,function():void
                  {
                     getExPNG(maxIndex);
                  });
               }
               else
               {
                  maxIndex = 2;
                  this.bmpVec[1] = Utils.getLoadBitmap(this.getUrl(Abit),this.bmpVec[1],null,function():void
                  {
                     getExPNG(maxIndex);
                  });
               }
            }
            else if(tens != 1)
            {
               if(Abit == 0)
               {
                  maxIndex = 2;
                  this.bmpVec[0] = Utils.getLoadBitmap(this.getUrl(tens),this.bmpVec[0],null,function():void
                  {
                     isLoad1 = true;
                     if(isLoad2)
                     {
                        getExPNG(maxIndex);
                     }
                  });
                  this.bmpVec[1] = Utils.getLoadBitmap(this.getCompUrl(1),this.bmpVec[1],null,function():void
                  {
                     isLoad2 = true;
                     if(isLoad1)
                     {
                        getExPNG(maxIndex);
                     }
                  });
               }
               else
               {
                  maxIndex = 3;
                  this.bmpVec[0] = Utils.getLoadBitmap(this.getUrl(tens),this.bmpVec[0],null,function():void
                  {
                     isLoad1 = true;
                     if(isLoad2 && isLoad3)
                     {
                        getExPNG(maxIndex);
                     }
                  });
                  this.bmpVec[1] = Utils.getLoadBitmap(this.getCompUrl(1),this.bmpVec[1],null,function():void
                  {
                     isLoad2 = true;
                     if(isLoad1 && isLoad3)
                     {
                        getExPNG(maxIndex);
                     }
                  });
                  this.bmpVec[2] = Utils.getLoadBitmap(this.getUrl(Abit),this.bmpVec[2],null,function():void
                  {
                     isLoad3 = true;
                     if(isLoad1 && isLoad2)
                     {
                        getExPNG(maxIndex);
                     }
                  });
               }
            }
            else if(Abit == 0)
            {
               maxIndex = 2;
               this.bmpVec[1] = Utils.getLoadBitmap(this.getCompUrl(1),this.bmpVec[1],null,function():void
               {
                  getExPNG(maxIndex);
               });
            }
            else
            {
               maxIndex = 2;
               this.bmpVec[0] = Utils.getLoadBitmap(this.getCompUrl(1),this.bmpVec[0],null,function():void
               {
                  isLoad1 = true;
                  if(isLoad2)
                  {
                     getExPNG(maxIndex);
                  }
               });
               this.bmpVec[1] = Utils.getLoadBitmap(this.getUrl(Abit),this.bmpVec[1],null,function():void
               {
                  isLoad2 = true;
                  if(isLoad1)
                  {
                     getExPNG(maxIndex);
                  }
               });
            }
         }
         else if(tens == 0)
         {
            if(Abit == 0)
            {
               maxIndex = 3;
               this.bmpVec[1] = Utils.getLoadBitmap(this.getUrl(huns),this.bmpVec[1],null,function():void
               {
                  isLoad1 = true;
                  if(isLoad2)
                  {
                     getExPNG(maxIndex);
                  }
               });
               this.bmpVec[2] = Utils.getLoadBitmap(this.getCompUrl(2),this.bmpVec[2],null,function():void
               {
                  isLoad2 = true;
                  if(isLoad1)
                  {
                     getExPNG(maxIndex);
                  }
               });
            }
            else
            {
               maxIndex = 5;
               this.bmpVec[1] = Utils.getLoadBitmap(this.getUrl(huns),this.bmpVec[1],null,function():void
               {
                  isLoad1 = true;
                  if(isLoad2 && isLoad3 && isLoad4)
                  {
                     getExPNG(maxIndex);
                  }
               });
               this.bmpVec[2] = Utils.getLoadBitmap(this.getCompUrl(2),this.bmpVec[2],null,function():void
               {
                  isLoad2 = true;
                  if(isLoad1 && isLoad3 && isLoad4)
                  {
                     getExPNG(maxIndex);
                  }
               });
               this.bmpVec[3] = Utils.getLoadBitmap(this.getCompUrl(0),this.bmpVec[3],null,function():void
               {
                  isLoad3 = true;
                  if(isLoad2 && isLoad1 && isLoad4)
                  {
                     getExPNG(maxIndex);
                  }
               });
               this.bmpVec[4] = Utils.getLoadBitmap(this.getUrl(Abit),this.bmpVec[4],null,function():void
               {
                  isLoad4 = true;
                  if(isLoad2 && isLoad3 && isLoad1)
                  {
                     getExPNG(maxIndex);
                  }
               });
            }
         }
         else if(Abit == 0)
         {
            maxIndex = 5;
            this.bmpVec[1] = Utils.getLoadBitmap(this.getUrl(huns),this.bmpVec[1],null,function():void
            {
               isLoad1 = true;
               if(isLoad2 && isLoad3 && isLoad4)
               {
                  getExPNG(maxIndex);
               }
            });
            this.bmpVec[2] = Utils.getLoadBitmap(this.getCompUrl(2),this.bmpVec[2],null,function():void
            {
               isLoad2 = true;
               if(isLoad1 && isLoad3 && isLoad4)
               {
                  getExPNG(maxIndex);
               }
            });
            this.bmpVec[3] = Utils.getLoadBitmap(this.getUrl(tens),this.bmpVec[3],null,function():void
            {
               isLoad3 = true;
               if(isLoad2 && isLoad1 && isLoad4)
               {
                  getExPNG(maxIndex);
               }
            });
            this.bmpVec[4] = Utils.getLoadBitmap(this.getCompUrl(1),this.bmpVec[4],null,function():void
            {
               isLoad4 = true;
               if(isLoad2 && isLoad3 && isLoad1)
               {
                  getExPNG(maxIndex);
               }
            });
         }
         else
         {
            maxIndex = 6;
            this.bmpVec[1] = Utils.getLoadBitmap(this.getUrl(huns),this.bmpVec[1],null,function():void
            {
               isLoad1 = true;
               if(isLoad2 && isLoad3 && isLoad4 && isLoad5)
               {
                  getExPNG(maxIndex);
               }
            });
            this.bmpVec[2] = Utils.getLoadBitmap(this.getCompUrl(2),this.bmpVec[2],null,function():void
            {
               isLoad2 = true;
               if(isLoad1 && isLoad3 && isLoad4 && isLoad5)
               {
                  getExPNG(maxIndex);
               }
            });
            this.bmpVec[3] = Utils.getLoadBitmap(this.getUrl(tens),this.bmpVec[3],null,function():void
            {
               isLoad3 = true;
               if(isLoad2 && isLoad1 && isLoad4 && isLoad5)
               {
                  getExPNG(maxIndex);
               }
            });
            this.bmpVec[4] = Utils.getLoadBitmap(this.getCompUrl(1),this.bmpVec[4],null,function():void
            {
               isLoad4 = true;
               if(isLoad2 && isLoad3 && isLoad1 && isLoad5)
               {
                  getExPNG(maxIndex);
               }
            });
            this.bmpVec[5] = Utils.getLoadBitmap(this.getUrl(Abit),this.bmpVec[5],null,function():void
            {
               isLoad5 = true;
               if(isLoad2 && isLoad3 && isLoad4 && isLoad1)
               {
                  getExPNG(maxIndex);
               }
            });
         }
      }
      
      public function getExPNG(maxIndex:int) : void
      {
         if(maxIndex != -1)
         {
            this.bmpVec[maxIndex] = Utils.getLoadBitmap(this.getBasicUrl("lian"),this.bmpVec[maxIndex]);
            this.bmpVec[maxIndex + 1] = Utils.getLoadBitmap(this.getBasicUrl("zhan"),this.bmpVec[maxIndex + 1]);
         }
         else
         {
            this.bmpVec[1] = Utils.getLoadBitmap(this.getBasicUrl("di"),this.bmpVec[1]);
            this.bmpVec[3] = Utils.getLoadBitmap(this.getBasicUrl("zhan"),this.bmpVec[3]);
         }
         this.resetPosition();
         this.effectHandle2();
      }
      
      public function getUrl(_n:int) : String
      {
         return "resource/image/wulinParty/eff/" + this.arr[_n] + ".png";
      }
      
      public function getCompUrl(_n:int) : String
      {
         return "resource/image/wulinParty/eff/" + this.CompArr[_n] + ".png";
      }
      
      public function getBasicUrl(url:String) : String
      {
         return "resource/image/wulinParty/eff/" + url + ".png";
      }
      
      public function resetPosition() : void
      {
         var count:int = 0;
         var i:int = 0;
         count = 0;
         i = 0;
         while(i < SIZE)
         {
            this.bmpVec[i].x = i * 68;
            count += this.bmpVec[i].width;
            i++;
         }
         x = stX;
         y = stY;
         this.effectHandle();
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         while(i < this.bmpVec.length)
         {
            if(Boolean(this.bmpVec[i].bitmapData))
            {
               this.bmpVec[i].bitmapData = null;
            }
            i++;
         }
         pool.push(this);
      }
      
      public function removItem() : void
      {
         if(Boolean(parent))
         {
            parent.removeChild(this);
         }
         delete global[this];
         if(Boolean(pool.length))
         {
            pool.pop();
         }
      }
   }
}

