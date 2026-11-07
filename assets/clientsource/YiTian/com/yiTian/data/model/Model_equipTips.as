package com.yiTian.data.model
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.geom.Point;
   
   public class Model_equipTips
   {
      
      private static var urlList:Array = ["SZ_Ling","SZ_Yi","SZ_Er","SZ_San","SZ_Si","SZ_Wu","SZ_Liu","SZ_Qi","SZ_Ba","SZ_Jiu"];
      
      private static const ZHANLISTR:String = "resource/image/equipTips/Icon_ZhanLi.png";
      
      private static const EQUIPED:String = "resource/image/equipTips/Icon_YZB.png";
      
      private static const HORIZOTAL_GAP:int = 10;
      
      private static var modelDic:Array = new Array();
      
      private var list:Array = [];
      
      private var backBm:Bitmap = new Bitmap();
      
      private var _startPoint:Point;
      
      private var zhanliToStr:String;
      
      private var _pool:Array = [];
      
      public var width:int;
      
      private var dressBm:Bitmap;
      
      public function Model_equipTips()
      {
         super();
      }
      
      public static function getModel(key:int) : Model_equipTips
      {
         if(!modelDic[key] || !(modelDic[key] is Model_equipTips))
         {
            modelDic[key] = new Model_equipTips();
         }
         return modelDic[key];
      }
      
      public function show(zhanli:int, _parent:DisplayObjectContainer, startPoint:Point, isShowZhanliBack:Boolean = true) : void
      {
         var b:Bitmap = null;
         var url:String = null;
         this.remove();
         if(zhanli == 0)
         {
            return;
         }
         this._startPoint = startPoint;
         if(isShowZhanliBack)
         {
            this.init_b_value(this.backBm,ZHANLISTR,_parent);
         }
         this.zhanliToStr = zhanli.toString();
         var i:int = 0;
         while(i < this.zhanliToStr.length)
         {
            b = this.getBM();
            url = urlList[uint(this.zhanliToStr.charAt(i))];
            this.init_b_value(b,url,_parent);
            this.list.push(b);
            i++;
         }
         this.resize();
      }
      
      private function getBM() : Bitmap
      {
         return this._pool.pop() || new Bitmap();
      }
      
      private function saveBM(bm:Bitmap) : void
      {
         this._pool.push(bm);
      }
      
      private function init_b_value(tem_bitmap:Bitmap, url:String, __parent:DisplayObjectContainer) : void
      {
         if(url.indexOf("/") == -1)
         {
            tem_bitmap.bitmapData = ComponentUtil.getBitmapData(url,Global.Img_Cdm);
         }
         else
         {
            Utils.getLoadBitmap(url,tem_bitmap);
         }
         if(Boolean(__parent) && !__parent.contains(tem_bitmap))
         {
            __parent.addChild(tem_bitmap);
         }
      }
      
      public function remove() : void
      {
         var bm:Bitmap = null;
         for each(bm in this.list)
         {
            if(bm)
            {
               if(Boolean(bm.parent))
               {
                  bm.parent.removeChild(bm);
               }
               bm.bitmapData = null;
               this.saveBM(bm);
            }
         }
         this.list.splice(0);
         this._startPoint = null;
         if(Boolean(this.backBm) && Boolean(this.backBm.bitmapData))
         {
            this.backBm.bitmapData = null;
         }
      }
      
      private function resize() : void
      {
         var nowX:int = 0;
         var listBM:Bitmap = null;
         ComponentUtil.setPropertie(this.backBm,{
            "x":this._startPoint.x,
            "y":this._startPoint.y
         });
         nowX = this._startPoint.x + 40;
         var i:int = 0;
         while(i < this.list.length)
         {
            listBM = this.list[i];
            listBM.x = nowX;
            listBM.y = this._startPoint.y + 3;
            nowX += HORIZOTAL_GAP;
            i++;
         }
         this.width = nowX + HORIZOTAL_GAP - this._startPoint.x;
      }
      
      public function showBdress(isDress:Boolean, point:Point, _parent:DisplayObjectContainer) : void
      {
         if(!this.dressBm)
         {
            this.dressBm = this.getBM();
         }
         this.dressBm.bitmapData = null;
         this.dressBm.name = "dressBm";
         if(!_parent.contains(this.dressBm))
         {
            _parent.addChild(this.dressBm);
         }
         if(isDress)
         {
            Utils.getLoadBitmap(EQUIPED,this.dressBm,{
               "x":point.x,
               "y":point.y
            });
         }
      }
      
      public function resizeAlign(borderWid:int) : void
      {
         if(!this._startPoint)
         {
            return;
         }
         this._startPoint.x = borderWid - this.width - 3;
         this.resize();
      }
   }
}

