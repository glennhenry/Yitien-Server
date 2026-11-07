package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.View_CaiDengMi_Menu;
   
   public class CaiDengMiHandle
   {
      
      public function CaiDengMiHandle()
      {
         super();
      }
      
      public static function GC_CaiDengMi_OPEN(result:int, titleId:int, haveAnsweredCount:int, rightCount:int) : void
      {
         if(result == 0)
         {
            UIManager.centerBroadcast.addMsg("本次猜灯谜您已经猜完10个灯谜，请下次活动再来参与！");
            if(View_CaiDengMi_Menu.instance.visible)
            {
               View_CaiDengMi_Menu.instance.end();
            }
         }
         else if(result == 1)
         {
            Global.delegate.dosomething(View_CaiDengMi_Menu.instance,function():void
            {
               View_CaiDengMi_Menu.instance.setData(titleId,haveAnsweredCount,rightCount);
               View_CaiDengMi_Menu.instance.visible = true;
            });
         }
         else if(result == 2)
         {
            if(View_CaiDengMi_Menu.instance.visible)
            {
               View_CaiDengMi_Menu.instance.end();
               UIManager.centerBroadcast.addMsg("本次活动结束，请下次活动再来参与！");
            }
         }
      }
      
      public static function GC_CaiDengMi_CHOISE(result:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("回答正确",1,0,-60);
         }
         else
         {
            UIManager.centerBroadcast.addMsg("回答错误",1,0,-60);
         }
      }
   }
}

