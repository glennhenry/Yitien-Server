package com.yiTian.net.handler
{
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.zhuanZhi.Model_zhuanZhi;
   import com.yiTian.view.modules.zhuanZhi.View_zhuanZhiFangXiang;
   import com.yiTian.view.modules.zhuanZhi.View_zhuanZhiPanel;
   import com.yiTian.view.modules.zhuanZhi.View_zhuanZhiTask;
   import com.yiTian.view.modules.zhuanZhi.ZhuanZhiUtil;
   
   public class ZhuanZhiHandle
   {
      
      public function ZhuanZhiHandle()
      {
         super();
      }
      
      public static function GC_ZZ_ZHUANZHIINFO(info:Array) : void
      {
         var pnl:View_zhuanZhiTask = null;
         var wayPnl:View_zhuanZhiFangXiang = null;
         Model_zhuanZhi.myState = info[0];
         Model_zhuanZhi.myTaskInfos = info[1];
         var idx:int = ZhuanZhiUtil.getCanSumitTaskIndex(info[1]);
         ZhuanZhiUtil.updateTipBtn(info[0] == 2 && idx >= 0);
         if(Singleton.hasInstance(View_zhuanZhiTask))
         {
            pnl = Singleton.getInstance(View_zhuanZhiTask);
            if(pnl.visible)
            {
               if(info[0] == 3)
               {
                  pnl.visible = false;
                  wayPnl = Singleton.getInstance(View_zhuanZhiFangXiang);
                  (Singleton.getInstance(Delegate123) as Delegate123).dosomething(wayPnl,wayPnl.show);
               }
               else
               {
                  pnl.update();
                  pnl.setChooseIndex(ZhuanZhiUtil.getBestChooseIndex(info[1]));
               }
            }
         }
      }
      
      public static function GC_ZZ_WOYAOZHUANZHI(r:int) : void
      {
         var zhuanZhiPnl:View_zhuanZhiPanel = null;
         var zhuanZhiTaskPnl:View_zhuanZhiTask = null;
         if(r == 1)
         {
            Model_zhuanZhi.myState = 2;
            zhuanZhiPnl = Singleton.getInstance(View_zhuanZhiPanel);
            zhuanZhiPnl.visible = false;
            zhuanZhiTaskPnl = Singleton.getInstance(View_zhuanZhiTask);
            (Singleton.getInstance(Delegate123) as Delegate123).dosomething(zhuanZhiTaskPnl,function():void
            {
               zhuanZhiTaskPnl.visible = true;
               zhuanZhiTaskPnl.setChooseIndex(0);
            });
         }
      }
      
      public static function GC_APPLY_TASK(r:int) : void
      {
         if(r == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("29442",2));
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("29443",2));
         }
      }
      
      public static function GC_ZZ_CHOICE_WAY(r:int) : void
      {
         switch(r)
         {
            case 1:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("29444",2));
               break;
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("20241",2));
         }
      }
   }
}

