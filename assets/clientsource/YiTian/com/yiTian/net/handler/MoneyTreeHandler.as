package com.yiTian.net.handler
{
   import com.yiTian.data.model.Model_MoneyTree;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.moneyTree.Icon_MoneyTree;
   import com.yiTian.view.modules.moneyTree.View_MoneyTree;
   
   public class MoneyTreeHandler
   {
      
      public function MoneyTreeHandler()
      {
         super();
      }
      
      public static function CG_MONEYTREE_ICON(resulte:int, flag:int, time:int, isShowTime:Boolean) : void
      {
         Icon_MoneyTree.instance.init(resulte,flag,time,isShowTime);
      }
      
      public static function GC_MONEYTREE_OPENWIN(currentTree:int, growPer:Number, status:Array) : void
      {
         Model_MoneyTree.currentTree = currentTree;
         Model_MoneyTree.growPer = growPer;
         Model_MoneyTree.status = status;
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(View_MoneyTree.instance,function():void
         {
            View_MoneyTree.instance.update();
         });
      }
      
      public static function GC_MONEYTREE_PLANT(reslut:int, index:int) : void
      {
         var str:String = null;
         switch(reslut)
         {
            case 1:
               str = "种植成功";
               (Singleton.getInstance(Delegate123) as Delegate123).dosomething(View_MoneyTree.instance,function():void
               {
                  View_MoneyTree.instance.plant_eff(index);
                  Icon_MoneyTree.instance.setStatus();
               });
               break;
            case 2:
               str = "元宝不足";
               break;
            case 3:
               str = "不在活动时间内";
         }
         UIManager.centerBroadcast.addMsg(str,1);
      }
      
      public static function GC_MONEYTREE_WATER(reslut:int) : void
      {
         var str:String = null;
         switch(reslut)
         {
            case 1:
               str = "灌溉成功，获得20%成长值";
               (Singleton.getInstance(Delegate123) as Delegate123).dosomething(View_MoneyTree.instance,function():void
               {
                  View_MoneyTree.instance.update();
                  View_MoneyTree.instance.eff_yb();
               });
               break;
            case 2:
               str = "元宝不足，请及时充值";
               break;
            case 3:
               str = "摇钱树的成长值已经满了";
         }
         UIManager.centerBroadcast.addMsg(str,1);
      }
      
      public static function GC_MONEYTREE_GETWARD(reslut:int, index:int = 0) : void
      {
         var str:String = null;
         switch(reslut)
         {
            case 1:
               str = "您尚未种植摇钱树";
               break;
            case 2:
               str = "条件未满足";
               break;
            case 3:
               str = "已领取";
               break;
            case 4:
               str = "背包空间不足";
               break;
            case 5:
               str = "领取成功";
               (Singleton.getInstance(Delegate123) as Delegate123).dosomething(View_MoneyTree.instance,function():void
               {
                  View_MoneyTree.instance.flyIcon(index);
               });
         }
         UIManager.centerBroadcast.addMsg(str,1);
      }
      
      public static function GC_MONEYTREE_BROCAST(roleId:Number, roleName:String, level:int, money:int) : void
      {
         var arr:Array = ["","青铜","白银","黄金"];
         var msg:String = "<font color=\'#FF0000\'> " + "摇钱树" + "   </font>" + HtmlUtil.underLine(HtmlUtil.font(roleName,"#04ff00")) + "购买了" + arr[level] + "摇钱树，返还了" + money + "元宝，大家赶紧" + "<font color=\'#FFFF00\'>【</font><a href=\'event:moneytree\'>" + HtmlUtil.underLine(HtmlUtil.font("点击种植","#FFFF00")) + "</a><font color=\'#FFFF00\'>】</font>";
         UIManager.chatPanel.add(msg,roleId,890,roleName);
      }
   }
}

