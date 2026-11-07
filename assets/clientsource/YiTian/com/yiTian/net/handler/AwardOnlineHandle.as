package com.yiTian.net.handler
{
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.activity.CJInfo;
   import com.yiTian.view.modules.activity.Child_GetJRCJItem;
   import com.yiTian.view.modules.activity.Child_GetRCCJItem;
   import com.yiTian.view.modules.activity.Child_cjBoard;
   import com.yiTian.view.modules.awardOnline.AwardItemData;
   import com.yiTian.view.modules.awardOnline.View_AwardWaitTip;
   import com.yiTian.view.modules.awardOnline.View_GetAwardPanel;
   import com.yiTian.view.modules.awardOnline.View_PreviewAwardPanel;
   
   public class AwardOnlineHandle
   {
      
      private static var flag:Boolean = false;
      
      public function AwardOnlineHandle()
      {
         super();
      }
      
      public static function GC_AWARD_TIP(result:int, id:int, remainTime:int, nextTimeCount:int, arr:Array) : void
      {
         var waitTip:View_AwardWaitTip = null;
         if(result == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("542",0));
            return;
         }
         waitTip = View_AwardWaitTip.getInstance();
         var model:AwardItemData = AwardItemData.getInstance();
         model.id = id;
         model.nextTimeCount = nextTimeCount;
         switch(result)
         {
            case 1:
               AwardItemData.getInstance().dataArr = arr;
               UIManager.mainUiBtnContainer.addBTN(waitTip);
               if(id == 5)
               {
               }
               if(flag == false)
               {
                  AwardItemData.getInstance().dataArr = arr;
                  View_GetAwardPanel.getInstance().update();
                  View_PreviewAwardPanel.getInstance().update();
                  flag = true;
               }
               else
               {
                  View_GetAwardPanel.getInstance().showBenz();
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("543",0));
                  AwardItemData.getInstance().dataArr = arr;
                  View_GetAwardPanel.getInstance().update();
                  View_PreviewAwardPanel.getInstance().update();
               }
               if(remainTime > 0)
               {
                  waitTip.resetTime(remainTime);
                  View_GetAwardPanel.getInstance().visible = false;
                  waitTip.state = 1;
                  break;
               }
               waitTip.state = 2;
               break;
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("544",0));
               break;
            case 3:
               View_GetAwardPanel.getInstance().showBenz();
               View_GetAwardPanel.getInstance().visible = false;
               UIManager.mainUiBtnContainer.removeBTN(waitTip);
         }
      }
      
      public static function GC_RCCJ_INFO(comboDay:int, state:int, itemArr1:Array, state2:int, nextFre:int, nxtFreName:String, itemArr2:Array) : void
      {
         var info:CJInfo = CJInfo.getInstance();
         info.comboDay = comboDay;
         info.state1 = state;
         info.arr1 = itemArr1;
         info.nxtFreName = nxtFreName;
         var ins:Child_cjBoard = UIManager.cjPanel.cjBroad;
         if(ins.isRun1 || ins.isRun2)
         {
            return;
         }
         switch(state)
         {
            case 0:
               ins.status1 = itemArr1.length > 0 ? 1 : 0;
               break;
            case 1:
               ins.status1 = 2;
               break;
            case 2:
               ins.status1 = 3;
               break;
            default:
               ins.status1 = state;
         }
         info.nextFreDay = nextFre;
         info.arr2 = itemArr2;
         if(nextFre != 0)
         {
            ins.status2 = 4;
            return;
         }
         switch(state2)
         {
            case 0:
               ins.status2 = itemArr2.length > 0 ? 1 : 0;
               break;
            case 1:
               ins.status2 = 2;
               break;
            case 2:
               ins.status2 = 3;
               break;
            default:
               ins.status2 = state2;
         }
      }
      
      public static function GC_CJ_START_RE(result:int, isDouble:int, zjArr:Array) : void
      {
         var index:int = 0;
         while(index < zjArr.length)
         {
            zjArr[index] -= 1;
            index++;
         }
         var info:CJInfo = CJInfo.getInstance();
         switch(result)
         {
            case 1:
               info.arr1 = zjArr;
               UIManager.cjPanel.cjBroad.start1(zjArr);
               break;
            case 2:
               info.arr2 = zjArr;
               UIManager.cjPanel.cjBroad.start2(zjArr);
         }
      }
      
      public static function GC_JRCJ_START_RE(result:int, isDouble:int, zjArr:Array) : void
      {
         var index:int = 0;
         while(index < zjArr.length)
         {
            zjArr[index] -= 1;
            index++;
         }
         var info:CJInfo = CJInfo.getInstance();
         info.arr2 = zjArr;
         UIManager.cjPanel.cjBroad.start2(zjArr);
      }
      
      public static function GC_GET_CJ_AWARD_RE(result:int, type:int) : void
      {
         var ins:Child_cjBoard = UIManager.cjPanel.cjBroad;
         if(type == 1)
         {
            switch(result)
            {
               case 1:
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("545",0));
                  Child_GetRCCJItem.getInstance().showBez();
                  if(ins.status1 == 1)
                  {
                     ins.status1 = 0;
                     break;
                  }
                  ins.status1 = 3;
                  break;
               case 2:
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("546",0));
            }
         }
         else if(type == 2)
         {
            switch(result)
            {
               case 1:
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("547",0));
                  Child_GetJRCJItem.getInstance().showBez();
                  if(ins.status2 == 1)
                  {
                     ins.status2 = 0;
                     break;
                  }
                  ins.status2 = 3;
                  break;
               case 2:
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("548",0));
            }
         }
      }
   }
}

