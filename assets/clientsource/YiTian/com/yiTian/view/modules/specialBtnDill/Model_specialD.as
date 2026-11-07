package com.yiTian.view.modules.specialBtnDill
{
   import com.utils.ComponentUtil;
   import com.yiTian.manager.NewPushManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.modules.horse.HorseUtil;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class Model_specialD
   {
      
      private static var isNotFin:Boolean = false;
      
      private static var dicCopyObj:Dictionary = new Dictionary();
      
      public function Model_specialD()
      {
         super();
      }
      
      public static function showExtAllbtn() : void
      {
         UIManager.mainMenu.showExBtn();
         UIManager.special_btn.showExB();
         HorseUtil.init();
         var arr:Array = [25,26,28,200];
         var i:int = 0;
         while(i < arr.length)
         {
            NewPushManager.isShow = true;
            NewPushManager.showNew(arr[i]);
            i++;
         }
      }
      
      public static function visFalseComp(pan:DisplayObject, btn:DisplayObject, endCall:Function, type:int = 0, scaleX_ep:int = 2, scaleY_ep:int = 2) : void
      {
         var _parent:DisplayObjectContainer;
         var point:Point;
         var staScaleX:int = 0;
         var staScaleY:int = 0;
         if(!btn || !btn.parent)
         {
            return;
         }
         _parent = btn.parent as DisplayObjectContainer;
         point = _parent.localToGlobal(new Point(btn.x,btn.y));
         staScaleX = pan.scaleX;
         staScaleY = pan.scaleY;
         if(isNotFin)
         {
            return;
         }
         isNotFin = true;
         Tween.to(pan,300,{
            "scaleX":[1,0],
            "scaleY":[1,0],
            "x":[pan.x,point.x],
            "y":[pan.y,point.y]
         },function():void
         {
            if(type == 0)
            {
               getEff(btn);
            }
            else
            {
               upStep(btn,scaleX_ep,scaleY_ep);
            }
            if(Boolean(endCall.length))
            {
               endCall(pan);
            }
            else
            {
               endCall();
            }
            pan.scaleX = staScaleX;
            pan.scaleY = staScaleY;
            isNotFin = false;
         });
      }
      
      private static function getEff(btn:DisplayObject) : void
      {
         var sty:int = 0;
         sty = btn.y;
         btn.y = -btn.height;
         Tween.to(btn,200,{"scaleY":[1,1.1]},function():void
         {
            btn.y = sty;
            btn.scaleX = 1;
            btn.scaleY = 1;
         });
      }
      
      public static function upStep(disObj:DisplayObject, scaleXNum:int, scaleYNum:int) : void
      {
         var dltaNumX:int;
         var dltaNumY:int;
         var copyObj:DisplayObject = null;
         if(!dicCopyObj[disObj])
         {
            dicCopyObj[disObj] = clone(disObj);
         }
         copyObj = dicCopyObj[disObj] as DisplayObject;
         dltaNumX = scaleXNum - 1;
         dltaNumY = scaleYNum - 1;
         if(Boolean(disObj.parent))
         {
            disObj.parent.addChild(copyObj);
         }
         ComponentUtil.setPropertie(copyObj,{
            "x":disObj.x,
            "y":disObj.y
         });
         Tween.to(copyObj,300,{
            "alpha":[1,0],
            "scaleX":[1,scaleXNum],
            "scaleY":[1,scaleYNum],
            "x":[copyObj.x,disObj.x - copyObj.width * (dltaNumX / 2)],
            "y":[copyObj.y,disObj.y - copyObj.height * (dltaNumY / 2)]
         },function():void
         {
            if(Boolean(copyObj.parent))
            {
               copyObj.parent.removeChild(copyObj);
            }
            copyObj.scaleX = 1;
            copyObj.scaleY = 1;
         });
      }
      
      private static function clone(source:Object) : *
      {
         if(!(source is DisplayObject))
         {
            return null;
         }
         var disObj:DisplayObject = source as DisplayObject;
         var bmd:BitmapData = new BitmapData(disObj.width,disObj.height,true,0);
         bmd.draw(disObj);
         return new Bitmap(bmd);
      }
   }
}

