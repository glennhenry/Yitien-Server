package com.yiTian.net.handler
{
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.activity.Model_actDaily;
   import com.yiTian.view.modules.retrieExp.View_retrieExp;
   
   public class RetrieExpHandle
   {
      
      public function RetrieExpHandle()
      {
         super();
      }
      
      public static function GC_RETRIEEXP_INFO(array:Array, obj2:Object) : void
      {
         var ins:View_retrieExp = null;
         if(obj2.overflow > 0)
         {
            array.push(obj2);
         }
         Model_actDaily.getInstance().retExpArr = array;
         ins = Singleton.getInstance(View_retrieExp);
         if(array.length <= 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("660",0));
            ins.visible = false;
         }
         else
         {
            (Singleton.getInstance(Delegate123) as Delegate123).dosomething(ins,function():void
            {
               ins.update();
               if(!ins.visible)
               {
                  ins.visible = true;
               }
            });
         }
      }
      
      public static function GC_RETRIEEXP1(result:int) : void
      {
         switch(result)
         {
            case 1:
               Utils.print("成功");
               break;
            case 2:
               Utils.print("失败");
               break;
            case 3:
               Utils.print("元宝不足");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("661",0));
               Utils.print("不是VIP");
               break;
            case 5:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("724",0));
               Utils.print("英雄令不存在");
         }
      }
      
      public static function GC_RETRIEEXP2(result:int) : void
      {
         switch(result)
         {
            case 1:
               Utils.print("成功");
               break;
            case 2:
               Utils.print("失败");
         }
      }
   }
}

