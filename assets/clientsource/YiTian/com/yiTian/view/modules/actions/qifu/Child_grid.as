package com.yiTian.view.modules.actions.qifu
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.net.handler.QifuHandle;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class Child_grid extends Sprite
   {
      
      public static var isUseYunSu:Boolean = true;
      
      public static var usingNewSpeed:int = 10;
      
      private static var isFastMove:Boolean = false;
      
      public static var isRunning:Boolean = false;
      
      private var gridVec:Vector.<View_Grid> = new Vector.<View_Grid>(16);
      
      private var bm:Bitmap;
      
      private var bmXianLiangVec:Vector.<Bitmap> = new Vector.<Bitmap>(16);
      
      private var bmFaGuangBm:Vector.<Bitmap> = new Vector.<Bitmap>(16);
      
      private var bgBmp:Bitmap;
      
      private var bgBmpCopy:Bitmap;
      
      private var movieClipConVec:Vector.<MovieClip> = new Vector.<MovieClip>(16);
      
      private var addSpeed:int = 0;
      
      private var count:int = 0;
      
      public var _zhongIndex:int = 1;
      
      private var __index:int;
      
      private var _startIndex:int;
      
      private var anotherCount:int;
      
      private var callBack:Function;
      
      private var fIndex:int = 0;
      
      private var fsMove_arr:Array = [];
      
      private var fly_inx:int;
      
      private var _arrbmp:Array = [];
      
      public function Child_grid()
      {
         var g:View_Grid = null;
         var proper:Object = null;
         var movieClipCon:Sprite = null;
         var cl:Class = null;
         var mc:MovieClip = null;
         var b:Bitmap = null;
         super();
         this.bgBmp = ComponentUtil.getBitmap("BG_MM",this,{
            "x":14.5 - 36,
            "y":82 - 43
         },Global.QiFudm);
         this.bgBmpCopy = ComponentUtil.getBitmap("BG_MM",this,{
            "x":14.5 - 36,
            "y":82 - 43,
            "alpha":0
         },Global.QiFudm);
         var i:int = 0;
         while(i < this.gridVec.length)
         {
            g = new View_Grid();
            g.set_bmp_bg();
            g.set_bmp_over(true,null);
            g.set_tf_count(true,false,true);
            this.gridVec[i] = g;
            proper = Model_qifu.posArr[i];
            ComponentUtil.setPropertie(g,{
               "x":proper.x - 60,
               "y":proper.y - 83
            });
            movieClipCon = new Sprite();
            addChild(movieClipCon);
            addChild(g);
            cl = Global.QiFudm.getDefinition("effFaGuang") as Class;
            mc = new cl() as MovieClip;
            movieClipCon.addChild(mc);
            ComponentUtil.setPropertie(movieClipCon,{
               "x":g.x - 5,
               "y":g.y - 5
            });
            this.movieClipConVec[i] = mc;
            b = ComponentUtil.getBitmap("Text_XianLiang",this,{
               "x":proper.x - 80,
               "y":proper.y - 102
            },Global.QiFudm);
            this.bmXianLiangVec[i] = b;
            i++;
         }
         this.bm = ComponentUtil.getBitmap("Good_FaGuang",this,{
            "x":-3,
            "y":109,
            "visible":false
         },Global.QiFudm);
      }
      
      private function handlLvl(str:String) : String
      {
         return str;
      }
      
      public function reset() : void
      {
         var b:Bitmap = null;
         for each(b in this.bmXianLiangVec)
         {
            b.visible = false;
         }
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
            "x":[this.bm.x,g.x - 5],
            "y":[this.bm.y,g.y - 5],
            "alpha":[0,1]
         },function():void
         {
            var tm:int = 0;
            if(isUseYunSu)
            {
               if(count >= 16)
               {
                  usingNewSpeed = 80 + anotherCount * 5;
                  ++anotherCount;
                  if(anotherCount >= 6)
                  {
                     if(_startIndex == _zhongIndex)
                     {
                        if(QifuPan.isVis && !QifuHandle.isBagFull)
                        {
                           ComboTweenStep.toBag(g);
                        }
                        isRunning = false;
                        callBack();
                        return;
                     }
                  }
               }
               _startIndex += 1;
               if(_startIndex > 15)
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
               if(_startIndex > 15)
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
      
      public function beginMove(zIndex:int, __count:int, func:Function) : void
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
         ComponentUtil.setPropertie(this.bgBmpCopy,{
            "x":14.5 - 36,
            "y":82 - 43
         });
         Tween.to(this.bgBmpCopy,600,{
            "x":[this.bgBmpCopy.x,this.bgBmpCopy.x - this.bgBmpCopy.width / 9],
            "y":[this.bgBmpCopy.y,this.bgBmpCopy.y - this.bgBmpCopy.height / 9],
            "alpha":[1,0],
            "scaleX":[1,1.2],
            "scaleY":[1,1.2]
         },function():void
         {
            fMoveHd();
         });
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
         this.flyTo();
      }
      
      private function flyTo() : void
      {
         var __b:Bitmap = null;
         var proper:Object = null;
         var mc:MovieClip = null;
         var _arr:Array = null;
         var __bmp:Bitmap = null;
         if(!this._arrbmp || !this._arrbmp.length)
         {
            return;
         }
         if(this.fly_inx == this._arrbmp.length)
         {
            isRunning = false;
            this.callBack();
            for each(_arr in this._arrbmp)
            {
               __bmp = _arr[0];
               Tween.to(__bmp,800,{"alpha":[1,0]},function(b_m:Bitmap):void
               {
                  if(Boolean(b_m))
                  {
                     removeChild(b_m);
                     b_m = null;
                  }
               });
            }
            return;
         }
         __b = this._arrbmp[this.fly_inx][0];
         proper = this._arrbmp[this.fly_inx][1];
         mc = this.movieClipConVec[proper.index];
         Tween.to(__b,600,{
            "x":[__b.x,__b.x - 47],
            "y":[__b.y,__b.y - 47],
            "scaleX":[0,2],
            "scaleY":[0,2],
            "alpha":[0.3,1]
         },function():void
         {
            Tween.to(__b,300,{
               "x":[__b.x,proper.x],
               "y":[__b.y,proper.y],
               "scaleX":[2,1],
               "scaleY":[2,1]
            },function():void
            {
               mc.play();
               if(QifuPan.isVis && !QifuHandle.isBagFull)
               {
                  comboToBagHd(proper.gd,proper.count,1);
               }
               ++fly_inx;
               flyTo();
            });
         });
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
            "x":g.x - 5,
            "y":g.y - 5
         });
      }
      
      public function showVisEf() : void
      {
         Tween.to(this.bgBmp,800,{"alpha":[0,1]});
         this.updateGridData();
      }
      
      private function updateGridData() : void
      {
         var key:String = null;
         var indx:int = 0;
         var gg:View_Grid = null;
         var __bXL:Bitmap = null;
         var arr:Array = null;
         var str:String = null;
         var _str:String = null;
         var _ar:Array = null;
         var _ty:int = 0;
         var _id:int = 0;
         var _cn:int = 0;
         var isXianLiang:int = 0;
         var voI:Vo_item = null;
         var voE:Vo_equip = null;
         var dic:Dictionary = Data_lib.qifuAward;
         var sex:int = GameUnitManager.hero.sex - 1;
         for(key in dic)
         {
            indx = int(key);
            gg = this.gridVec[indx - 1];
            __bXL = this.bmXianLiangVec[indx - 1];
            arr = dic[key];
            str = arr[sex];
            _str = this.handlLvl(str);
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
            if(isXianLiang == 1)
            {
               __bXL.visible = true;
            }
            else
            {
               __bXL.visible = false;
            }
         }
      }
      
      public function getAward(_index:int) : void
      {
         var g:View_Grid = this.gridVec[_index];
         ComboTweenStep.toBag(g);
      }
   }
}

