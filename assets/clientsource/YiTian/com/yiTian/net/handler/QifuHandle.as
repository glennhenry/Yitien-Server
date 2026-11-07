package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.modules.actions.qifu.Child_grid;
   import com.yiTian.view.modules.actions.qifu.QifuPan;
   import com.yiTian.view.modules.actions.qifu.QifuXinxi;
   
   public class QifuHandle
   {
      
      private static var saveCurQIfuTimes:int;
      
      private static var saveStartNum:int;
      
      private static var saveArrM:Array = [];
      
      private static var savearrG:Array = [];
      
      private static var _arrL:Array = [];
      
      public static var isBagFull:Boolean = false;
      
      public function QifuHandle()
      {
         super();
      }
      
      public static function GC_OPEN_QIFU_PAN(arrM:Array, arrG:Array, curQIfuTimes:int, startNum:int) : void
      {
         var pan:QifuPan = null;
         if(Child_grid.isRunning)
         {
            saveArrM = arrM;
            savearrG = arrG;
            saveCurQIfuTimes = curQIfuTimes;
            saveStartNum = startNum;
            return;
         }
         pan = Singleton.getInstance(QifuPan) as QifuPan;
         Global.delegate.dosomething(pan,function():void
         {
            if(pan.visible)
            {
               pan.update(arrM,arrG,curQIfuTimes,startNum);
            }
            else
            {
               pan.setData(arrM,arrG,curQIfuTimes,startNum);
            }
         });
      }
      
      public static function GC_QIFU_TYPE(arrM:Array, arrG:Array, arrL:Array, arrK:Array) : void
      {
         var pan:QifuPan = null;
         _arrL = arrL;
         pan = Singleton.getInstance(QifuPan) as QifuPan;
         Global.delegate.dosomething(pan,function():void
         {
            pan.run(arrK,handle);
         });
      }
      
      private static function handle() : void
      {
         var _pan:QifuXinxi = null;
         _pan = Singleton.getInstance(QifuXinxi) as QifuXinxi;
         Global.delegate.dosomething(_pan,function():void
         {
            _pan.update(_arrL);
         });
         GC_OPEN_QIFU_PAN(saveArrM,savearrG,saveCurQIfuTimes,saveStartNum);
      }
   }
}

