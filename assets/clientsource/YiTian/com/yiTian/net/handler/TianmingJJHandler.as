package com.yiTian.net.handler
{
   import com.yiTian.data.model.Model_TianmingJJ;
   import com.yiTian.data.vo.Vo_TianMing;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.tianmingjj.View_TMLevelUpPanel;
   import com.yiTian.view.modules.tianmingjj.View_TianmingJJ;
   import com.yiTian.view.modules.tianmingjj.Vo_TianmingJJ;
   
   public class TianmingJJHandler
   {
      
      public function TianmingJJHandler()
      {
         super();
      }
      
      public static function GC_TMJJ_OPENWIN(tmd:int) : void
      {
         Model_TianmingJJ.currentTMD = tmd;
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(View_TianmingJJ.instance,function():void
         {
            View_TianmingJJ.instance.visible = true;
         });
      }
      
      public static function GC_TMJJ_TZ(vec:Vector.<Vo_TianmingJJ>, result:String, num:int) : void
      {
         Model_TianmingJJ.vec = vec;
         Model_TianmingJJ.result = result;
         Model_TianmingJJ.currentTimes = num;
         View_TianmingJJ.instance.setRoll();
      }
      
      public static function GC_TMJJ_GY(vec:Vector.<Vo_TianmingJJ>, result:String, num:int) : void
      {
         Model_TianmingJJ.vec = vec;
         Model_TianmingJJ.result = result;
         Model_TianmingJJ.currentTimes = num;
         View_TianmingJJ.instance.effectEnd();
         Utils.print("改运返回" + result);
      }
      
      public static function GC_TMJJ_LQ() : void
      {
         var arr:Array = Model_TianmingJJ.result.split("_");
         var str:String = "获得 ";
         if(arr[1] > 0)
         {
            str += arr[1] + "经验值 ";
         }
         if(arr[0] > 0)
         {
            str += arr[0] + "天命点 ";
         }
         if(arr[0] <= 0 && arr[1] <= 0)
         {
            str = "没有奖励！";
         }
         UIManager.centerBroadcast.addMsg(str,1);
         View_TianmingJJ.instance.update();
         View_TianmingJJ.instance.playEff();
      }
      
      public static function GC_TMJJ_JJ_START(reslut:int) : void
      {
         if(reslut == 1)
         {
            View_TMLevelUpPanel.instance.showEffect();
         }
         else
         {
            UIManager.centerBroadcast.addMsg("天命点不足！");
         }
      }
      
      public static function GC_TMJJ_JJ(voVec:Vector.<Array>, tmd:int) : void
      {
         var len:int;
         var i:int;
         var dataVec:Vector.<Vo_TianMing> = null;
         var vo:Vo_TianMing = null;
         var arr:Array = null;
         Model_TianmingJJ.currentTMD = tmd;
         dataVec = new Vector.<Vo_TianMing>();
         dataVec.length = 0;
         len = int(voVec.length);
         i = 0;
         while(i < len)
         {
            vo = new Vo_TianMing();
            vo.Init_sever_bag(voVec[i]);
            vo.gridId = i;
            dataVec.push(vo);
            i++;
         }
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(View_TMLevelUpPanel.instance,function():void
         {
            View_TMLevelUpPanel.instance.show(dataVec);
         });
      }
   }
}

