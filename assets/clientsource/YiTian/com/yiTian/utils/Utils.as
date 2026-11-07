package com.yiTian.utils
{
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.scene.GameScene;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class Utils
   {
      
      public static var print:Function;
      
      public static var matrix:Matrix = new Matrix();
      
      public static var point:Point = new Point();
      
      public static var rect:Rectangle = new Rectangle();
      
      private static var count:int = 0;
      
      public static var swfPool:Dictionary = new Dictionary();
      
      private static var isPlayingUpDown:Boolean = false;
      
      private static var upDMArr:Array = [];
      
      private static var poolDic:Dictionary = new Dictionary();
      
      public function Utils()
      {
         super();
      }
      
      public static function getLoadBitmap(url:String, bitmap:Bitmap = null, propertie:Object = null, complete:Function = null, loadLevel:int = 1) : Bitmap
      {
         var key:String = null;
         if(!bitmap)
         {
            bitmap = new Bitmap();
         }
         if(Boolean(Util.bmdPool[url]))
         {
            bitmap.bitmapData = Util.bmdPool[url] as BitmapData;
            for(key in propertie)
            {
               bitmap[key] = propertie[key];
            }
            if(complete != null)
            {
               complete();
            }
         }
         else
         {
            MassLoader.add(url,function(info:Object):void
            {
               var key:String = null;
               if(Boolean(info.content))
               {
                  info.obj.bm.bitmapData = (info.content as Bitmap).bitmapData;
                  Util.bmdPool[info.url] = (info.content as Bitmap).bitmapData;
               }
               for(key in info.obj.propertie)
               {
                  info.obj.bm[key] = info.obj.propertie[key];
               }
               if(info.obj.complete != null)
               {
                  info.obj.complete();
               }
            },null,loadLevel,{
               "bm":bitmap,
               "propertie":propertie,
               "complete":complete
            });
         }
         return bitmap;
      }
      
      public static function getScaleBitmap(url:String, bitmap:ScaleBitmap, rectData:Array, propertie:Object = null, complete:Function = null, loadLevel:int = 1) : ScaleBitmap
      {
         var key:String = null;
         if(!bitmap)
         {
            bitmap = new ScaleBitmap();
         }
         if(Boolean(Util.bmdPool[url]))
         {
            bitmap.bitmapData = Util.bmdPool[url] as BitmapData;
            for(key in propertie)
            {
               bitmap[key] = propertie[key];
            }
            Util.rect.x = rectData[0];
            Util.rect.y = rectData[1];
            Util.rect.width = rectData[2];
            Util.rect.height = rectData[3];
            bitmap.scale9Grid = Util.rect;
            if(complete != null)
            {
               complete();
            }
         }
         else
         {
            MassLoader.add(url,function(info:Object):void
            {
               var key:String = null;
               info.obj.bm.bitmapData = (info.content as Bitmap).bitmapData;
               Util.bmdPool[info.url] = (info.content as Bitmap).bitmapData;
               for(key in info.obj.propertie)
               {
                  info.obj.bm[key] = info.obj.propertie[key];
               }
               Util.rect.x = info.obj.rectData[0];
               Util.rect.y = info.obj.rectData[1];
               Util.rect.width = info.obj.rectData[2];
               Util.rect.height = info.obj.rectData[3];
               info.obj.bm.scale9Grid = Util.rect;
               if(info.obj.complete != null)
               {
                  info.obj.complete();
               }
            },null,loadLevel,{
               "bm":bitmap,
               "propertie":propertie,
               "complete":complete,
               "rectData":rectData
            });
         }
         return bitmap;
      }
      
      public static function getSwfBitmap(url:String, bitmap:Bitmap = null, propertie:Object = null, complete:Function = null, loadLevel:int = 1) : Bitmap
      {
         var key:String = null;
         if(!bitmap)
         {
            bitmap = new Bitmap();
         }
         if(Boolean(Util.bmdPool[url]))
         {
            bitmap.bitmapData = Util.bmdPool[url] as BitmapData;
            for(key in propertie)
            {
               bitmap[key] = propertie[key];
            }
            if(complete != null)
            {
               complete();
            }
         }
         else
         {
            MassLoader.add(url,function(info:Object):void
            {
               var key:String = null;
               var bmd:BitmapData = ComponentUtil.getBitmapData("s",info.applicationDomain);
               info.obj.bm.bitmapData = bmd;
               Util.bmdPool[info.url] = bmd;
               for(key in info.obj.propertie)
               {
                  info.obj.bm[key] = info.obj.propertie[key];
               }
               if(info.obj.complete != null)
               {
                  info.obj.complete();
               }
            },null,loadLevel,{
               "bm":bitmap,
               "propertie":propertie,
               "complete":complete
            });
         }
         return bitmap;
      }
      
      public static function rnd(min:Number, max:Number) : Number
      {
         return Math.floor(Math.random() * (max - min + 1)) + min;
      }
      
      public static function dist(x1:int, y1:int, x2:int, y2:int) : int
      {
         return (y2 - y1) * (y2 - y1) + (x2 - x1) * (x2 - x1);
      }
      
      public static function getWay(x0:int, y0:int, x:int, y:int) : int
      {
         var a:Number = Math.atan2(y - y0,x - x0);
         return int((a + Math.PI * 3.625) % (Math.PI * 2) / (Math.PI / 4));
      }
      
      public static function getShipWay(x0:int, y0:int, x:int, y:int) : int
      {
         var a:Number = Math.atan2(y - y0,x - x0);
         return int((a + Math.PI * 3.625) % (Math.PI * 2) / (Math.PI / 6));
      }
      
      public static function checkAlpha(overObj:Bitmap, w:int = 10, minAlpha:int = 200) : Boolean
      {
         var j:int = 0;
         point.x = Global.stage.mouseX;
         point.y = Global.stage.mouseY;
         var p:Point = overObj.globalToLocal(point);
         var i:int = -w;
         loop0:
         while(i < w)
         {
            j = -w;
            while(true)
            {
               if(j >= 10)
               {
                  i++;
                  continue loop0;
               }
               if((overObj.bitmapData.getPixel32(p.x + i,p.y + j) >> 24 & 0xFF) > minAlpha)
               {
                  break;
               }
               j++;
            }
            return true;
         }
         return false;
      }
      
      public static function getGapNum(value:String) : String
      {
         var result:String = "";
         count = 0;
         var i:int = value.length - 1;
         while(i >= 0)
         {
            ++count;
            result = value.charAt(i) + result;
            if(count == 3)
            {
               if(Boolean(i))
               {
                  result = "," + result;
               }
               count = 0;
            }
            i--;
         }
         return result;
      }
      
      public static function formatIntToLong(high:int, low:int) : Number
      {
         return low + Number(high << Math.pow(2,32));
      }
      
      public static function drawDashed(graphics:Graphics, path:Array, sx:Number, sy:Number) : void
      {
         var begin:Array = null;
         var beginX:Number = NaN;
         var beginY:Number = NaN;
         var to:Array = null;
         var toX:Number = NaN;
         var toY:Number = NaN;
         var radian:Number = NaN;
         var totalLen:Number = NaN;
         var currLen:Number = NaN;
         var x:Number = NaN;
         var y:Number = NaN;
         if(!graphics || !path.length)
         {
            return;
         }
         graphics.clear();
         graphics.lineStyle(1.5,16383744);
         while(Boolean(path.length))
         {
            begin = path.shift();
            beginX = begin[0] / sx;
            beginY = begin[1] / sy;
            to = path[0];
            if(Boolean(to))
            {
               toX = to[0] / sx;
               toY = to[1] / sy;
            }
            else
            {
               toX = beginX;
               toY = beginY;
            }
            radian = Math.atan2(toY - beginY,toX - beginX);
            totalLen = Math.sqrt(Utils.dist(beginX,beginY,toX,toY));
            currLen = 0;
            while(currLen <= totalLen)
            {
               x = beginX + Math.cos(radian) * currLen;
               y = beginY + Math.sin(radian) * currLen;
               graphics.moveTo(x,y);
               currLen += 3;
               if(currLen > totalLen)
               {
                  currLen = totalLen;
               }
               x = beginX + Math.cos(radian) * currLen;
               y = beginY + Math.sin(radian) * currLen;
               graphics.lineTo(x,y);
               currLen += 3;
            }
         }
      }
      
      public static function loadTitle(_path:String, _url:String, _bm:Bitmap, _propertie:Object = null, _parent:DisplayObjectContainer = null, _onCom:Function = null) : void
      {
         var imges:Class = null;
         var key:String = null;
         if(Boolean(swfPool[_path]))
         {
            imges = swfPool[_path].getDefinition(_url) as Class;
            _bm.bitmapData = new imges(0,0);
            for(key in _propertie)
            {
               _bm[key] = _propertie[key];
            }
            if(Boolean(_parent))
            {
               _parent.addChild(_bm);
            }
            if(_onCom != null)
            {
               if(!_onCom.length)
               {
                  _onCom();
               }
               else
               {
                  _onCom(swfPool[_path]);
               }
            }
         }
         else
         {
            MassLoader.add(_path,function(info:Object):void
            {
               var key:String = null;
               var imges:Class = null;
               if(Boolean(info.content))
               {
                  imges = info.applicationDomain.getDefinition(info.obj.url) as Class;
                  info.obj.bm.bitmapData = new imges(0,0);
                  swfPool[info.url] = info.applicationDomain;
               }
               for(key in info.obj.propertie)
               {
                  info.obj.bm[key] = info.obj.propertie[key];
               }
               if(Boolean(info.obj.parent))
               {
                  (info.obj.parent as DisplayObjectContainer).addChild(info.obj.bm);
               }
               if(info.obj.onCom != null)
               {
                  if(!info.obj.onCom.length)
                  {
                     info.obj.onCom();
                  }
                  else
                  {
                     info.obj.onCom(info);
                  }
               }
            },null,MassLoader.LEVEL2,{
               "bm":_bm,
               "propertie":_propertie,
               "url":_url,
               "parent":_parent,
               "onCom":_onCom
            });
         }
      }
      
      public static function bmSetBMDFromBM(targetBM:Bitmap, srcBM:Bitmap, property:Object, parent:DisplayObjectContainer) : Bitmap
      {
         if(!targetBM)
         {
            targetBM = new Bitmap();
         }
         targetBM.bitmapData = srcBM.bitmapData;
         if(Boolean(property))
         {
            ComponentUtil.setPropertie(targetBM,property);
         }
         if(Boolean(parent))
         {
            parent.addChild(targetBM);
         }
         return targetBM;
      }
      
      public static function FFHomes(value:Number) : int
      {
         var _n:int = value * 10 % 10;
         var _value:int = Math.floor(value);
         return _value + (_n >= 5);
      }
      
      public static function changeNumStr(_num:int) : String
      {
         if(_num >= 0 && _num <= 9)
         {
            return "0" + _num;
         }
         return _num.toString();
      }
      
      public static function up_down_move(target:Sprite, range:Number, centerY:Number) : void
      {
         var frame:Function = null;
         var tt:Sprite = null;
         frame = function():void
         {
            var _arr:Array = null;
            var _tar:Sprite = null;
            if(upDMArr.length == 0)
            {
               GameScene.instance.removeFrameCallBack(frame);
               isPlayingUpDown = false;
               return;
            }
            for each(_arr in upDMArr)
            {
               _tar = _arr[0];
               _tar.y = centerY + Math.sin(_arr[2]) * range;
               _arr[2] += Math.PI / 30;
            }
         };
         var i:int = 0;
         while(i < upDMArr.length)
         {
            tt = upDMArr[i][0];
            if(tt == target)
            {
               return;
            }
            i++;
         }
         if(!poolDic[target])
         {
            upDMArr.push([target,centerY,0]);
         }
         else
         {
            upDMArr.push(poolDic[target]);
         }
         if(Boolean(upDMArr.length) && !isPlayingUpDown)
         {
            isPlayingUpDown = true;
            GameScene.instance.addFrameCallBack(frame);
         }
      }
      
      public static function remove_up_down_move(target:Sprite, remainY:Number) : void
      {
         var _arr:Array = null;
         for each(_arr in upDMArr)
         {
            if(target == _arr[0])
            {
               upDMArr.splice(upDMArr.indexOf(_arr),1);
               target.y = remainY;
               if(!poolDic[target])
               {
                  poolDic[target] = _arr;
               }
            }
         }
      }
      
      public static function numToCN(num:int) : String
      {
         return "";
      }
   }
}

