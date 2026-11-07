package com.yiTian.view.modules.FeiXingQi
{
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_job;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class Enum_FeiXingQi
   {
      
      public static const TILEW:int = 76;
      
      public static const TILEH:int = 42;
      
      public static const NUMTILE:int = 100;
      
      public static const TILEMAPOFFSETX:Number = 244;
      
      public static const TILEMAPOFFSETY:Number = 65;
      
      public static const FXQWIDTH:int = 560;
      
      public static const FXQHEIGHT:int = 400;
      
      public static const FXQMASKW:int = 560;
      
      public static const FXQMASKH:int = 380;
      
      public static const FXQMASKMENDX:int = 31;
      
      public static const FXQMASKMENDY:int = 13;
      
      public static const PLAYERANITIME:int = 250;
      
      public static const FLAYANITIME:int = 50;
      
      public static const STATUSDIR:Array = ["stand","run"];
      
      public static const ROLESCALE:Number = 0.5;
      
      public static const ROLEOFFSETX:Number = 35;
      
      public static const ROLEOFFSETY:Number = 21;
      
      public static const TOUZIDIR:String = "lang/ch/ChuangGuan_Imgs.swf";
      
      public static const MAPBGDIR:String = "resource/image/fxq/fxqMapBG.jpg";
      
      public static const GUESSBGDIR:String = "resource/image/fxq/CaiQuan_BG.jpg";
      
      public static const NPCHEADDIR:String = "resource/image/icon/23591.png";
      
      public static const ICONDIR:String = "resource/image/fxq/chuangguan.png";
      
      public static const FXQOPENLVNEED:int = 26;
      
      public function Enum_FeiXingQi()
      {
         super();
      }
      
      public static function getHeadDir(job:int, sex:int) : String
      {
         return "resource/image/icon/" + (23030 + Enum_job.getBaseJob(job) * 100 + sex).toString() + ".jpg";
      }
      
      public static function getTileYOffset(i:int) : Number
      {
         return Data_lib.fxqMap[i][6] - 13;
      }
      
      public static function getTileXOffset(i:int) : Number
      {
         return Data_lib.fxqMap[i][5] - 31;
      }
      
      public static function getTile(index:int) : Child_FeiXingQiTile
      {
         var result:Child_FeiXingQiTile = null;
         if(Boolean(Data_lib.fxqMap[index]))
         {
            result = Model_FeiXingQi.tileArr[index];
         }
         return result;
      }
      
      public static function depthSort(... param) : Array
      {
         var obj:Object = null;
         var result:Array = [];
         for each(obj in param)
         {
            result = result.concat(obj);
         }
         result.sortOn("y",Array.NUMERIC);
         return result;
      }
      
      public static function caculateModelId(job:int, sex:int) : int
      {
         return 20000 + Enum_job.getBaseJob(job) * 100 + sex;
      }
      
      public static function getPoint(y:int, x:int) : Point
      {
         var py:Number = y * TILEH / 2 + x * TILEH / 2;
         var px:Number = x * TILEW / 2 - y * TILEW / 2;
         return new Point(px,py);
      }
      
      public static function getLengthFromTo(s:int, e:int) : Number
      {
         var arr1:Array = Data_lib.fxqMap[s];
         var arr2:Array = Data_lib.fxqMap[e];
         return Math.sqrt(Math.pow((arr1[0] - arr2[0]) * TILEH,2) + Math.pow((arr1[1] - arr2[1]) * TILEW,2));
      }
      
      public static function getWinPoint(ta:int) : int
      {
         return ta >= 3 ? 1 : int(ta + 1);
      }
      
      public static function getLostPoint(ta:int) : int
      {
         return ta <= 1 ? 3 : int(ta - 1);
      }
      
      public static function getUnitWayFromTo(index1:int, index2:int) : int
      {
         return 1;
      }
      
      public static function getUnitWay(tileIndex:int) : int
      {
         var way:int = 0;
         var tileDic:Dictionary = Data_lib.fxqMap;
         var nxtArr:Array = tileDic[tileIndex + 1];
         if(Boolean(nxtArr))
         {
            way = getUnitWayB(tileDic[tileIndex],nxtArr);
         }
         else
         {
            way = getUnitWayB(tileDic[tileIndex - 1],tileDic[tileIndex]);
         }
         return way;
      }
      
      private static function getUnitWayB(a1:Array, a2:Array) : int
      {
         var y1:int = int(a1[0]);
         var y2:int = int(a2[0]);
         var x1:int = int(a1[1]);
         var x2:int = int(a2[1]);
         var dy:int = y2 - y1;
         var dx:int = x2 - x1;
         var way:int = 0;
         if(dx - dy > 0)
         {
            way = dx + dy + 1;
         }
         else if(dx - dy < 0)
         {
            way = 5 - dx - dy;
         }
         else
         {
            way = 0;
         }
         return way + 1;
      }
      
      public static function getTouZiBmd(definedName:String) : BitmapData
      {
         if(!Global.ChuangGuan_Imgsdm)
         {
            return null;
         }
         return new (Global.ChuangGuan_Imgsdm.getDefinition(definedName) as Class)();
      }
   }
}

