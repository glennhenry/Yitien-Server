package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.modules.newYear.View_nianShouPnl;
   
   public class NewYearHandle
   {
      
      public function NewYearHandle()
      {
         super();
      }
      
      public static function GC_NIANGAOMAIL_BUY_ITEM(r:int) : void
      {
         switch(r)
         {
            case 0:
               BagHandler.getFullTis();
               break;
            case 1:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("12",0));
               break;
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("115",0,1));
         }
      }
      
      public static function GC_NIANSHOUDATA(remainTimes:int, jifen:int) : void
      {
         var targetPnl:View_nianShouPnl = null;
         targetPnl = Singleton.getInstance(View_nianShouPnl);
         Global.delegate.dosomething(targetPnl,function():void
         {
            targetPnl.updateJiFen(jifen);
            targetPnl.updateRemain(remainTimes);
            if(!targetPnl.visible)
            {
               targetPnl.show();
            }
         });
      }
      
      public static function CG_USENIANSHOUTOKEN(result:int, remainTimes:int, jifen:int, add:int) : void
      {
         var targetPnl:View_nianShouPnl = null;
         targetPnl = Singleton.getInstance(View_nianShouPnl);
         if(result == 1)
         {
            Global.delegate.dosomething(targetPnl,function():void
            {
               if(targetPnl.visible)
               {
                  targetPnl.updateJiFen(jifen);
                  targetPnl.updateRemain(remainTimes);
                  targetPnl.showAdd(add);
               }
            });
         }
         else
         {
            if(result == 4)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("706",0));
            }
            if(result == 5)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("70031",7));
            }
            Global.delegate.dosomething(targetPnl,function():void
            {
               if(targetPnl.visible)
               {
                  targetPnl.maimeng(3000);
               }
            });
         }
      }
   }
}

