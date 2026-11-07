package com.yiTian.net.handler
{
   import com.yiTian.data.model.Model_WeiLie;
   import com.yiTian.data.vo.Vo_WeiLie;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.weilie.View_WeiLie;
   
   public class WeiLieHandler
   {
      
      public function WeiLieHandler()
      {
         super();
      }
      
      public static function GC_WEILIE_OPEN(time:int, currentXF:int, arr:Vector.<Vo_WeiLie>, index:String) : void
      {
         var instance:View_WeiLie = null;
         var model:Model_WeiLie = Model_WeiLie.ins(Model_WeiLie.QZYG);
         model.time = time;
         model.data_log = arr;
         model.currentXF = currentXF;
         model.datalog = index;
         model.update();
         instance = model.view;
         instance.title = Model_WeiLie.QZYG;
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(instance,function():void
         {
            instance.visible = !instance.visible;
            instance.setdata();
         });
      }
      
      public static function GC_WEILIE_SHOT(sb:int, index:int, time:int) : void
      {
         var instance:View_WeiLie = null;
         var model:Model_WeiLie = Model_WeiLie.ins(Model_WeiLie.QZYG);
         instance = model.view;
         model.currentXF = sb;
         model.update();
         model.index = index;
         model.time = time;
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(instance,function():void
         {
            instance.biubiubiu();
         });
      }
      
      public static function GC_PPTREE_OPEN(time:int, currentXF:int, arr:Vector.<Vo_WeiLie>, index:String) : void
      {
         var instance:View_WeiLie = null;
         var model:Model_WeiLie = Model_WeiLie.ins(Model_WeiLie.QZGS);
         model.time = time;
         model.data_log = arr;
         model.currentXF = currentXF;
         model.datalog = index;
         model.update();
         instance = model.view;
         instance.title = Model_WeiLie.QZGS;
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(instance,function():void
         {
            instance.visible = !instance.visible;
            instance.setdata();
         });
      }
      
      public static function GC_PPTREE_SHOT(sb:int, index:int, time:int) : void
      {
         var instance:View_WeiLie = null;
         var model:Model_WeiLie = Model_WeiLie.ins(Model_WeiLie.QZGS);
         instance = model.view;
         model.currentXF = sb;
         model.update();
         model.index = index;
         model.time = time;
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(instance,function():void
         {
            instance.biubiubiu();
         });
      }
   }
}

