package com.yiTian.net.handler
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.activityGuide.ActivityGuideVo;
   import com.yiTian.view.modules.activityGuide.Enum_ActivityGuide;
   import com.yiTian.view.modules.activityGuide.Model_ActivityGuide;
   import com.yiTian.view.modules.activityGuide.View_ActivityGuidePanel;
   
   public class ActivityHandler
   {
      
      public function ActivityHandler()
      {
         super();
      }
      
      public static function GC_ACTIVITY_CWJX_GETWARD(result:int, index:int) : void
      {
         var vo:ActivityGuideVo = null;
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("领取成功");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("背包空间不足");
               return;
         }
         var btnID:int = index;
         vo = Model_ActivityGuide.activityVoDataById[Enum_ActivityGuide.JINGXIU] as ActivityGuideVo;
         if(Boolean(vo))
         {
            vo.allConditionStatus[btnID] = 2;
            View_ActivityGuidePanel.instance.updateData(vo);
            View_ActivityGuidePanel.instance.flyIcon(btnID);
         }
      }
      
      public static function GC_ACTIVITY_CWJX_OPEN(value:int, arr:Array) : void
      {
         var vo:ActivityGuideVo = null;
         var tempArr:Array = null;
         var l:int = 0;
         var str:String = "\n当前已提升<font color=\'#04ff00\'>" + value + "点</font>";
         vo = Model_ActivityGuide.activityVoDataById[Enum_ActivityGuide.JINGXIU] as ActivityGuideVo;
         if(!vo)
         {
            return;
         }
         vo.allConditionDes = [];
         var i:int = 0;
         while(i < arr.length)
         {
            vo.allConditionDes.push("提升精修值<font color=\"#f9ff00\">" + Model_ActivityGuide.chongwujingxiu[i] + "</font>点" + str);
            i++;
         }
         if(Boolean(vo))
         {
            tempArr = [];
            l = 0;
            while(l < arr.length)
            {
               tempArr.push(arr[l].value);
               l++;
            }
            vo.allConditionStatus = tempArr;
            View_ActivityGuidePanel.instance.updateData(vo);
         }
      }
      
      public static function GC_ACTIVITY_CWJX_HIGHLINE(result:int) : void
      {
         View_ActivityGuidePanel.instance.setBtnEff(Enum_ActivityGuide.JINGXIU,result);
      }
   }
}

