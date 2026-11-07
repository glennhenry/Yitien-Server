package com.yiTian.view.modules.chat
{
   import com.utils.Util;
   import com.yiTian.scene.GameScene;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   
   public class EffecObj extends Sprite
   {
      
      public static var objArr:Array = [];
      
      public static var isRunning:Boolean = false;
      
      private static var timeCount:Dictionary = new Dictionary();
      
      private static var b:Dictionary = new Dictionary();
      
      public function EffecObj()
      {
         super();
      }
      
      public static function getEffec(obj:Object) : void
      {
         var _obj:Object = null;
         for each(_obj in objArr)
         {
            if(_obj == obj)
            {
               return;
            }
         }
         timeCount[obj] = 0;
         b[obj] = false;
         objArr.push(obj);
         if(!isRunning)
         {
            GameScene.instance.addFrameCallBack(run);
         }
      }
      
      private static function run(interenal:int) : void
      {
         var obj:Object = null;
         if(!objArr.length)
         {
            isRunning = false;
            GameScene.instance.removeFrameCallBack(run);
            return;
         }
         isRunning = true;
         var i:int = 0;
         while(i < objArr.length)
         {
            obj = objArr[i];
            ++timeCount[obj];
            if(timeCount[obj] % 15 == 0)
            {
               obj.transform.colorTransform = Boolean(b[obj]) ? Util.colorNomal : Util.colorGlow;
               b[obj] = !b[obj];
            }
            i++;
         }
      }
      
      public static function removeEffect(obj:Object) : void
      {
         var _obj:Object = null;
         for each(_obj in objArr)
         {
            if(_obj == obj)
            {
               _obj.transform.colorTransform = Util.colorNomal;
               objArr.splice(objArr.indexOf(_obj),1);
            }
         }
      }
   }
}

