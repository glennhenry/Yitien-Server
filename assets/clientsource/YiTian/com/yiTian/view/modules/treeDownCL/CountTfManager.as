package com.yiTian.view.modules.treeDownCL
{
   import com.ui.controls.MyTextField;
   import com.yiTian.scene.GameScene;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class CountTfManager
   {
      
      private static var dataArr:Array = [];
      
      private static var isPlaying:Boolean = false;
      
      private static var dataDic:Dictionary = new Dictionary();
      
      private static var pool:Array = [];
      
      public function CountTfManager()
      {
         super();
      }
      
      public static function add(tf:MyTextField, count:int, addOrDown:Boolean = false, callBack:Function = null) : void
      {
         var t:MyTextField = null;
         var dIm:DItem = null;
         for each(t in dataArr)
         {
            if(t == tf)
            {
               return;
            }
         }
         dataArr.push(tf);
         dIm = Boolean(pool.length) ? pool.pop() : new DItem();
         dIm.b = addOrDown;
         dIm.countNum = count;
         dIm.func = callBack;
         dataDic[tf] = dIm;
         if(!isPlaying)
         {
            addFrame();
         }
      }
      
      private static function addFrame() : void
      {
         isPlaying = true;
         GameScene.instance.addFrameCallBack(play);
      }
      
      private static function removeFrame() : void
      {
         GameScene.instance.removeFrameCallBack(play);
         isPlaying = false;
      }
      
      public static function remove(tf:MyTextField) : void
      {
         var t:MyTextField = null;
         var dIm:DItem = null;
         for each(t in dataArr)
         {
            if(t == tf)
            {
               dataArr.splice(dataArr.indexOf(tf),1);
               dIm = dataDic[tf];
               dIm.dispose();
               pool.push(dIm);
               delete dataDic[tf];
            }
         }
      }
      
      private static function play() : void
      {
         var tf:MyTextField = null;
         var dIm:DItem = null;
         var func:Function = null;
         var b:Boolean = false;
         if(!dataArr.length)
         {
            removeFrame();
            return;
         }
         var now:int = getTimer();
         var i:int = 0;
         while(i < dataArr.length)
         {
            tf = dataArr[i];
            dIm = dataDic[tf];
            func = dIm.func;
            b = dIm.b;
            if(now - dIm.lastTime >= 1000)
            {
               if(b)
               {
                  ++dIm.countNum;
                  tf.text = dIm.countNum.toString();
                  if(func != null)
                  {
                     if(Boolean(func.length))
                     {
                        func(dIm.countNum);
                     }
                     else
                     {
                        func();
                     }
                  }
               }
               else
               {
                  --dIm.countNum;
                  tf.text = dIm.countNum >= 0 ? dIm.countNum.toString() : "0";
                  if(func != null)
                  {
                     if(Boolean(func.length))
                     {
                        func(dIm.countNum);
                     }
                     else
                     {
                        func();
                     }
                  }
               }
               dIm.lastTime = now;
            }
            i++;
         }
      }
   }
}

class DItem
{
   
   public var func:Function;
   
   public var b:Boolean;
   
   public var countNum:int;
   
   public var lastTime:int;
   
   public function DItem()
   {
      super();
   }
   
   public function dispose() : void
   {
      this.func = null;
      this.b = false;
      this.countNum = 0;
      this.lastTime = 0;
   }
}
