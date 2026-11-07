package com.yiTian.view.modules.hapStone
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Pool;
   import com.yiTian.utils.Tween;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class Model_hapStone
   {
      
      public static var nowHapItem:Child_hapStone;
      
      public static var nowDHCount:int = 0;
      
      public static var data_of_voStone:Array = new Array();
      
      public static var _data_of_duihuan:Array = [];
      
      public static var data_of_jifen:Array = [];
      
      public static var nowScore:int = -1;
      
      public static var totalScore:int = -1;
      
      private static var numsDic:Dictionary = new Dictionary();
      
      private static var isPlaying:Boolean = false;
      
      public function Model_hapStone()
      {
         super();
      }
      
      public static function set data_of_duihuan(value:Array) : void
      {
         var vo_hap:Vo_hapStone = null;
         var i:int = 0;
         while(i < value.length)
         {
            vo_hap = data_of_voStone[i];
            if(!vo_hap)
            {
               break;
            }
            vo_hap.itemSellCount = value[i];
            i++;
         }
      }
      
      public static function getAward(bmPool:Array, disObj:DisplayObject) : void
      {
         var disPoint:Point = null;
         var _parent:DisplayObjectContainer = null;
         var step2:Function = null;
         var step1:Function = function():void
         {
            var bb:Bitmap;
            var _p:Point;
            var nn:int = 0;
            if(bmPool.length == 0)
            {
               return;
            }
            bb = bmPool.shift();
            _p = _parent.localToGlobal(new Point(disObj.x + 2,disObj.y + 2));
            ComponentUtil.setPropertie(bb,{
               "x":_p.x,
               "y":_p.y
            });
            if(!Global.stage.contains(bb))
            {
               Global.stage.addChild(bb);
            }
            Tween.to(bb,500,{
               "x":[bb.x,bb.x + 50],
               "y":[bb.y,bb.y - 100]
            },step2,null,Tween.SIN);
            nn = int(setTimeout(function():void
            {
               clearTimeout(nn);
               step1();
            },90));
         };
         step2 = function(bmp:Bitmap):void
         {
            var ss:Sprite = Pool.getObject(Sprite);
            Global.stage.addChild(ss);
            ComponentUtil.setPropertie(ss,{
               "x":bmp.x + bmp.width / 2,
               "y":bmp.y + bmp.height / 2
            });
            ss.addChild(bmp);
            ComponentUtil.setPropertie(bmp,{
               "x":-bmp.width / 2,
               "y":-bmp.height / 2
            });
            Tween.to(ss,1300,{
               "x":[ss.x,disPoint.x],
               "y":[ss.y,disPoint.y],
               "rotation":[0,360]
            },function(sss:Sprite):void
            {
               var b_b:DisplayObject = null;
               Pool.saveObject(sss);
               if(Boolean(sss.parent))
               {
                  sss.parent.removeChild(sss);
               }
               while(Boolean(sss.numChildren))
               {
                  b_b = sss.getChildAt(0);
                  if(b_b is Bitmap)
                  {
                     (b_b as Bitmap).bitmapData = null;
                     sss.removeChild(b_b);
                     Pool.saveObject(b_b as Bitmap);
                  }
               }
            },null,Tween.SIN);
         };
         var rolePoint:Point = UIManager.mainMenu.getbagPoint();
         disPoint = new Point(rolePoint.x + 16,rolePoint.y + 16);
         _parent = disObj.parent;
         step1();
      }
      
      public static function showNumsEff(tf:MyTextField, nowVal:int) : void
      {
         if(!numsDic[tf])
         {
            numsDic[tf] = {
               "tf":tf,
               "nowVal":nowVal
            };
         }
         var lastVal:int = int(numsDic[tf].text);
         var n:int = nowVal - lastVal;
      }
      
      private static function play() : void
      {
         var key:String = null;
         var obj:Object = null;
         isPlaying = true;
         for(key in numsDic)
         {
            obj = numsDic[key];
            if(int(obj.tf.text) >= obj.nowVal)
            {
               delete numsDic[obj.tf.text];
            }
         }
      }
      
      public static function remove(tf:MyTextField) : void
      {
         delete numsDic[tf];
      }
   }
}

