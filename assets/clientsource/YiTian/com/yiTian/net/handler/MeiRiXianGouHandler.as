package com.yiTian.net.handler
{
   import com.yiTian.data.model.Model_MeiRiXianGou;
   import com.yiTian.data.vo.Vo_MeiRiXianGou;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.meirixg.View_MeiRiXianGou;
   
   public class MeiRiXianGouHandler
   {
      
      public function MeiRiXianGouHandler()
      {
         super();
      }
      
      public static function GC_MRXG_OPEN(type:int, vec:Vector.<Vo_MeiRiXianGou>) : void
      {
         var len:int;
         var k:int;
         var j:int = 0;
         if(type == 2)
         {
            View_MeiRiXianGou.instance.visible = true;
         }
         len = int(vec.length);
         k = 0;
         while(k < len)
         {
            j = 0;
            while(j < len)
            {
               if(vec[k].index == Model_MeiRiXianGou.data_MRXG[j].index)
               {
                  Model_MeiRiXianGou.data_MRXG[j].count = vec[k].count;
               }
               j++;
            }
            k++;
         }
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(View_MeiRiXianGou.instance,function():void
         {
            View_MeiRiXianGou.instance.setdata();
         });
      }
      
      public static function GC_MRXG_BUY(result:int) : void
      {
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("购买成功",1);
               (Singleton.getInstance(Delegate123) as Delegate123).dosomething(View_MeiRiXianGou.instance,function():void
               {
                  View_MeiRiXianGou.instance.iconFly();
               });
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("元宝不足！");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("活动已结束！");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("已达今日抢购上限，请明天再来！");
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("银两不足！");
               break;
            case 6:
               UIManager.centerBroadcast.addMsg("基金不足！");
               break;
            case 7:
               UIManager.centerBroadcast.addMsg("礼券不足！");
         }
      }
   }
}

