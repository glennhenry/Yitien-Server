package com.yiTian.view.modules.huangzuanchongwu
{
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.DictionaryTabel;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class Child_grid extends Sprite
   {
      
      public static var isUseYunSu:Boolean = true;
      
      public static var usingNewSpeed:int = 10;
      
      private static var isFastMove:Boolean = false;
      
      public static var isRunning:Boolean = false;
      
      private var gridVec:Vector.<View_Grid>;
      
      private var bm:Bitmap;
      
      private var movieClipConVec:Vector.<MovieClip>;
      
      private var addSpeed:int = 0;
      
      private var count:int = 0;
      
      public var _zhongIndex:int = 1;
      
      private var __index:int;
      
      private var _startIndex:int;
      
      private var anotherCount:int;
      
      private var callBack:Function;
      
      private var fIndex:int = 0;
      
      private var fsMove_arr:Array;
      
      private var fly_inx:int;
      
      private var _arrbmp:Array;
      
      public function Child_grid()
      {
         var i:int;
         var dic:Dictionary;
         var len:int;
         var dicArr:Array;
         var key:String = null;
         var g:View_Grid = null;
         var proper:Object = null;
         var gg:View_Grid = null;
         var arr:Array = null;
         var _str:String = null;
         var _ar:Array = null;
         var _ty:int = 0;
         var _id:int = 0;
         var _cn:int = 0;
         var isXianLiang:int = 0;
         var voI:Vo_item = null;
         var voE:Vo_equip = null;
         this.gridVec = new Vector.<View_Grid>(12);
         this.movieClipConVec = new Vector.<MovieClip>(12);
         this.fsMove_arr = [];
         this._arrbmp = [];
         super();
         i = 0;
         while(i < this.gridVec.length)
         {
            g = new View_Grid(true);
            g.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
            g.set_bmp_over(true,null);
            g.set_tf_count(true,false,true);
            this.gridVec[i] = g;
            proper = Model_hzcw.posArr[i];
            ComponentUtil.setPropertie(g,{
               "x":proper.x - 60,
               "y":proper.y - 83
            });
            addChild(g);
            i++;
         }
         dic = Data_lib.hzcw;
         len = int((dic as DictionaryTabel).getLength());
         dicArr = [];
         for(key in dic)
         {
            dicArr.push(dic[key]);
         }
         dicArr.sort(function(arr1:Array, arr2:Array):int
         {
            if(arr1[2] > arr2[2])
            {
               return 1;
            }
            if(arr1[2] < arr2[2])
            {
               return -1;
            }
            return 0;
         });
         i = 0;
         while(i < dicArr.length)
         {
            gg = this.gridVec[i];
            arr = dicArr[i];
            _str = arr[1];
            _ar = _str.split("_");
            _ty = int(_ar[0]);
            _id = int(_ar[1]);
            _cn = int(_ar[2]);
            isXianLiang = int(arr[3]);
            if(_ty == 1)
            {
               voI = new Vo_item();
               voI.id = _id;
               voI.count = _cn;
               voI.Init_lib();
               gg.vo = voI;
            }
            else if(_ty == 2)
            {
               voE = new Vo_equip();
               voE.id = _id;
               voE.count = _cn;
               voE.Init_lib();
               gg.vo = voE;
            }
            ComponentUtil.getBitmap("coin_" + arr[3],this,{
               "x":gg.x,
               "y":gg.y
            },Global.HZCWdm);
            i++;
         }
         this.bm = ComponentUtil.getBitmap("Light_FGQ",this,{
            "x":-3,
            "y":109,
            "visible":false
         },Global.HZCWdm);
      }
      
      public function moveTo() : void
      {
         var g:View_Grid = null;
         var moveSpeed:int = 0;
         g = this.gridVec[this._startIndex];
         if(isUseYunSu)
         {
            moveSpeed = usingNewSpeed;
         }
         else
         {
            if(this.addSpeed <= 190 && this.count == 0)
            {
               this.addSpeed += 9;
            }
            else
            {
               ++this.count;
               if(this.count > 50)
               {
                  this.addSpeed -= 10 + 1 * this.count;
               }
            }
            if(isFastMove)
            {
               moveSpeed = 10;
            }
            else
            {
               moveSpeed = 200 - this.addSpeed;
            }
         }
         Tween.to(this.bm,moveSpeed,{
            "x":[this.bm.x,g.x - 6],
            "y":[this.bm.y,g.y - 6],
            "alpha":[0,1]
         },function():void
         {
            var tm:int = 0;
            if(isUseYunSu)
            {
               if(count >= 12)
               {
                  usingNewSpeed = 80 + anotherCount * 5;
                  ++anotherCount;
                  if(anotherCount >= 6)
                  {
                     if(_startIndex == _zhongIndex)
                     {
                        isRunning = false;
                        callBack();
                        return;
                     }
                  }
               }
               _startIndex += 1;
               if(_startIndex > 11)
               {
                  _startIndex = 0;
               }
               ++count;
               moveTo();
            }
            else
            {
               if(moveSpeed >= 230)
               {
                  if(_startIndex == _zhongIndex)
                  {
                     ComboTweenStep.toBag(g);
                     isRunning = false;
                     callBack();
                     return;
                  }
               }
               _startIndex += 1;
               if(_startIndex > 11)
               {
                  _startIndex = 0;
               }
               if(moveSpeed > 30)
               {
                  tm = int(setTimeout(function():void
                  {
                     moveTo();
                     clearTimeout(tm);
                  },28));
               }
               else
               {
                  moveTo();
               }
            }
         });
      }
      
      public function beginMove(zIndex:int, func:Function) : void
      {
         this._zhongIndex = zIndex - 1;
         this.addSpeed = 0;
         this.count = 0;
         this.anotherCount = 0;
         usingNewSpeed = 10;
         isFastMove = false;
         this.callBack = func;
         this.bm.visible = true;
         this.moveTo();
      }
      
      public function fastMove(arr:Array, func:Function) : void
      {
         this.fsMove_arr = arr;
         this.addSpeed = 0;
         this.count = 0;
         isFastMove = true;
         this.bm.visible = false;
         this.callBack = func;
      }
      
      private function fMoveHd() : void
      {
         var _bm:Bitmap = null;
         var _index:int = 0;
         var _count:int = 0;
         var g:View_Grid = null;
         this.fly_inx = 0;
         this._arrbmp = [];
         var i:int = 0;
         while(i < this.fsMove_arr.length)
         {
            _bm = new Bitmap();
            addChild(_bm);
            _bm.bitmapData = ComponentUtil.getBitmapData("Good_FaGuang",Global.QiFudm);
            ComponentUtil.setPropertie(_bm,{
               "x":135 + _bm.width / 2,
               "y":115 + _bm.height / 2
            });
            _bm.scaleX = 0;
            _bm.scaleY = 0;
            _index = int(this.fsMove_arr[i][0]);
            _count = int(this.fsMove_arr[i][1]);
            g = this.gridVec[_index - 1];
            this._arrbmp.push([_bm,{
               "x":g.x - 5,
               "y":g.y - 5,
               "gd":g,
               "count":_count,
               "index":_index - 1
            }]);
            i++;
         }
      }
      
      private function comboToBagHd(gg:View_Grid, count:int, _index:int) : void
      {
         var num:int = 0;
         if(_index > count)
         {
            return;
         }
         num = int(setTimeout(function():void
         {
            ComboTweenStep.toBag(gg);
            ++_index;
            comboToBagHd(gg,count,_index);
            clearTimeout(num);
         },200));
      }
      
      public function set faGuang(value:int) : void
      {
         var g:View_Grid = this.gridVec[value];
         this._startIndex = 0;
         ComponentUtil.setPropertie(this.bm,{
            "x":g.x - 6,
            "y":g.y - 6
         });
      }
      
      public function showVisEf() : void
      {
         this.updateGridData();
      }
      
      private function updateGridData() : void
      {
         var key:String = null;
         var indx:int = 0;
         var gg:View_Grid = null;
         var arr:Array = null;
         var _str:String = null;
         var _ar:Array = null;
         var _ty:int = 0;
         var _id:int = 0;
         var _cn:int = 0;
         var voI:Vo_item = null;
         var voE:Vo_equip = null;
         var dic:Dictionary = Data_lib.qifuAward;
         for(key in dic)
         {
            indx = int(key);
            gg = this.gridVec[indx - 1];
            arr = dic[key];
            _str = arr[1];
            _ar = _str.split("_");
            _ty = int(_ar[0]);
            _id = int(_ar[1]);
            _cn = int(_ar[2]);
            if(_ty == 1)
            {
               voI = new Vo_item();
               voI.id = _id;
               voI.count = _cn;
               voI.Init_lib();
               gg.vo = voI;
            }
            else if(_ty == 2)
            {
               voE = new Vo_equip();
               voE.id = _id;
               voE.count = _cn;
               voE.Init_lib();
               gg.vo = voE;
            }
         }
      }
      
      public function getAward(_index:int) : void
      {
         var g:View_Grid = this.gridVec[_index];
         g.filters = Util.disabled;
         this.gridToIcon(g);
      }
      
      public function set gridStatus(_index:int) : void
      {
         var g:View_Grid = this.gridVec[_index];
         g.filters = Util.disabled;
      }
      
      public function gridToIcon(obj:Object, totalTime:int = -1, sx:Number = 0, sy:Number = 0) : void
      {
         var aimPoint:Point;
         var param:Number;
         var py:Number;
         var point1:Point;
         var vo:Object = null;
         var p:Point = null;
         var dir:String = null;
         var bm:Bitmap = null;
         if(obj is View_Grid)
         {
            if(!obj.vo)
            {
               return;
            }
            vo = obj.vo;
            p = obj.localToGlobal(new Point(0,0));
            dir = "resource/image/icon60/" + vo.str_icon + ".png";
         }
         bm = new Bitmap();
         bm = Utils.getLoadBitmap(dir,bm);
         bm.x = p.x;
         bm.y = p.y;
         GameScene.popupLayer.addChild(bm);
         aimPoint = UIManager.mainMenu.getbagPoint();
         if(totalTime <= 0)
         {
            totalTime = Math.pow(Math.pow(aimPoint.y - p.y,2) + Math.pow(aimPoint.x - p.x,2),0.5) * 3.5;
         }
         param = 0.1;
         py = p.y + Math.abs(p.y - aimPoint.y) / 5;
         point1 = new Point(aimPoint.x,py);
         Tween.to(bm,totalTime,{
            "x":[bm.x,aimPoint.x],
            "y":[bm.y,aimPoint.y]
         },function():void
         {
            Tween.stop(bm);
            if(Boolean(bm.parent))
            {
               bm.parent.removeChild(bm);
            }
            if(Boolean(bm))
            {
               bm.bitmapData = null;
            }
         },null,Tween.EASYINOUT);
      }
   }
}

