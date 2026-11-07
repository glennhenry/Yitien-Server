package com.yiTian.net.handler
{
   import com.utils.ColorConstant;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.CardCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.modules.Card.CardEvent;
   import com.yiTian.view.modules.Card.Model_card;
   import com.yiTian.view.modules.Card.View_card_panel;
   
   public class CardHandle
   {
      
      private static var leftSeconds2:int;
      
      private static var t2:int;
      
      public function CardHandle()
      {
         super();
      }
      
      public static function GC_CARD_OPEN_PANEL(exp:int, pieces:int, leftTimes:int, haveUseTimes:int, haveUseMoneyZhanBuTimes:int, curXingZuo:int, arr:Array) : void
      {
         Model_card.exp = exp;
         Model_card.piece = pieces;
         Model_card.leftTimes = leftTimes;
         Model_card.haveUseTimes = haveUseTimes;
         Model_card.haveUseMoneyZhanBuTimes = haveUseMoneyZhanBuTimes;
         Model_card.curXingZuo = curXingZuo;
         Model_card.ZhanBuCardArray = arr;
         trace("刷新占卜面板：","exp=",exp,"piece=",pieces,"leftTimes=",leftTimes,"haveUseTimes=",haveUseTimes,"haveUseMoneyZhanBuTimes=",haveUseMoneyZhanBuTimes,"curXingZuo=",curXingZuo,"ZhanBuCardArray=",arr);
         Global.control.sendNotification(CardEvent.UPDATE_ZhanBu,null);
      }
      
      public static function GC_CARD_RETURN(flag:int) : void
      {
         switch(flag)
         {
            case 2:
               UIManager.centerBroadcast.addMsg("元宝不足");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("卡牌背包容量已满，请分解后在拾取");
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("卡牌残页不足");
               break;
            case 6:
               UIManager.centerBroadcast.addMsg("已装备相同属性的卡牌");
               break;
            case 7:
               UIManager.centerBroadcast.addMsg("升星所需要材料不足");
               break;
            case 8:
               Model_card.countDown = 0;
               Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,onCountDown2);
               break;
            case 9:
               Model_card.countDown = 360;
               setCountDown2();
         }
      }
      
      public static function GC_CARD_COUNT_DOWN_TIME(time:int) : void
      {
         Model_card.countDown = time;
         if(time > 0)
         {
            setCountDown2();
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,onCountDown2);
         }
      }
      
      public static function GC_CARD_JiangHuGuangBo(name:String, roleId:Number, card:int) : void
      {
         var name1:String = Model_heFu.repNameByHero(name);
         var str:String = HtmlUtil.link(HtmlUtil.font(HtmlUtil.underLine(name1),"#3888e9"),roleId.toString()) + "人品大爆发，使用" + HtmlUtil.fontNoSize(Data_lib.cardDivineCost[1][0] + "元宝","#ffff00") + "占卜卡牌获得" + HtmlUtil.fontNoSize(Data_lib.card[card][2],ColorConstant.getItemColorStr(Data_lib.card[card][4])) + "<u><a href=\'event:card\'><font color=\'#ffff00\'>【我也要占卜】</font></a></u>";
         UIManager.chatPanel.add(str,roleId,102,name1);
      }
      
      public static function GC_CARD_ZhanBu(result:int, prize:int, useType:int, item:int) : void
      {
         var times:int = 0;
         trace("占卜返回",result,prize,useType,item);
         switch(result)
         {
            case 1:
               if(prize == 1)
               {
                  Model_card.isZhanBuGetCard = true;
                  Model_card.ZhanBuCardID = item;
                  if(useType == 1)
                  {
                     UIManager.centerBroadcast.addMsg("恭喜你获得卡牌" + HtmlUtil.fontNoSize(Data_lib.card[item][2],ColorConstant.getItemColorStr(Data_lib.card[item][4])),1);
                     break;
                  }
                  times = Model_card.haveUseMoneyZhanBuTimes + 1 > Data_lib.cardDivineCost.getLength() ? int(Data_lib.cardDivineCost.getLength()) : int(Model_card.haveUseMoneyZhanBuTimes + 1);
                  UIManager.centerBroadcast.addMsg("花费" + HtmlUtil.fontNoSize(Data_lib.cardDivineCost[times][0] + "元宝",ColorConstant.getColorStr(ColorConstant.YELLOW)) + "占卜获得卡牌" + HtmlUtil.fontNoSize(Data_lib.card[item][2],ColorConstant.getItemColorStr(Data_lib.card[item][4])),1);
                  break;
               }
               if(prize == 2)
               {
                  UIManager.centerBroadcast.addMsg("恭喜您获得了" + item + "个卡牌残页",1);
                  Global.control.sendNotification(CardEvent.EXP_EFFECT,1);
               }
               else if(prize == -1)
               {
                  UIManager.centerBroadcast.addMsg("恭喜您获得了" + item + "点卡牌经验",1);
                  Global.control.sendNotification(CardEvent.EXP_EFFECT,2);
               }
               if(useType == 1)
               {
                  Model_card.curXingZuo = 0;
                  Global.control.sendNotification(CardEvent.RESET_CURRENT_XingZuo,null);
                  ++Model_card.haveUseTimes;
                  Global.control.sendNotification(CardEvent.UPDATE_HAVE_USE_TIME,null);
                  break;
               }
               if(useType == 2)
               {
                  ++Model_card.haveUseMoneyZhanBuTimes;
                  Global.control.sendNotification(CardEvent.UPDATE_HAVE_USE_MONEY_TIME,null);
               }
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("元宝不足",1);
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("最多占卜15张卡牌，请先收取卡牌到背包",1);
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("占卜签不足",1);
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("今日占卜已满25次",1);
               break;
            case 6:
               UIManager.centerBroadcast.addMsg("卡牌背包格子不够",1);
         }
      }
      
      public static function GC_CARD_UPDATE_CARD_PIECE(flag:int, num:int) : void
      {
         trace("更新卡牌碎片",flag,num);
         switch(flag)
         {
            case 1:
               if(num - Model_card.piece > 0)
               {
                  Global.control.sendNotification(CardEvent.EXP_EFFECT,1);
               }
               Model_card.piece = num;
               break;
            case 2:
               if(num - Model_card.exp > 0)
               {
                  Global.control.sendNotification(CardEvent.EXP_EFFECT,2);
               }
               Model_card.exp = num;
               break;
            case 3:
               Model_card.leftTimes = num;
               Global.control.sendNotification(CardEvent.LEFT_TIME,null);
         }
      }
      
      public static function GC_CARD_BUY(id:int) : void
      {
         if(id > 0)
         {
            UIManager.centerBroadcast.addMsg("恭喜您兑换获得" + HtmlUtil.fontNoSize(Data_lib.card[id][2] + "*1",ColorConstant.getItemColorStr(Data_lib.card[id][4])),1);
         }
         else
         {
            UIManager.centerBroadcast.addMsg("恭喜您兑换获得" + HtmlUtil.fontNoSize(Data_lib.cardShop[0][1] + "点",ColorConstant.getItemColorStr(ColorConstant.YELLOW)) + "卡牌经验",1);
         }
      }
      
      public static function GC_CARD_BAG(voArr:Array) : void
      {
         Model_card.bagCardVoArray = voArr;
         Global.control.sendNotification(CardEvent.UPDATE_BAG,null);
      }
      
      public static function GC_CARD_EQUIP_CARD(openedNum:int, voArr:Array) : void
      {
         Model_card.equipGridOpen = openedNum;
         Model_card.equipCardVoArray = voArr;
         Global.control.sendNotification(CardEvent.UPDATE_EQUIP_CARD,null);
      }
      
      public static function GC_CARD_TunShi(cardID:int, level:int, exp:int, BaoJiCount:int, totalExp:int) : void
      {
         var str:String = "";
         if(BaoJiCount > 0)
         {
            str = "，触发" + HtmlUtil.fontNoSize(String(BaoJiCount),ColorConstant.getColorStr(ColorConstant.GREEN)) + "次暴击";
         }
         UIManager.centerBroadcast.addMsg("吞噬成功" + str + "，共吞噬" + HtmlUtil.fontNoSize(String(totalExp),ColorConstant.getColorStr(ColorConstant.GREEN)) + "经验",1);
         Global.control.sendNotification(CardEvent.TunShi_CARD_SUCCESS,[cardID,level,exp]);
      }
      
      public static function GC_CARD_ShengXing(cardID:int, level:int) : void
      {
         UIManager.centerBroadcast.addMsg("升星成功",1);
         Global.control.sendNotification(CardEvent.ShengXing_CARD_SUCCESS,[cardID,level]);
      }
      
      public static function GC_CARD_FIRST_ICON(flag:int) : void
      {
         if(flag == 1)
         {
            Model_card.firstPlay = true;
         }
         View_card_panel.instance.showIcon2();
      }
      
      public static function GC_CARD_FenJie(exp:int, pieces:int) : void
      {
         UIManager.centerBroadcast.addMsg("您获得了" + exp + "卡牌经验",1);
         Global.control.sendNotification(CardEvent.EXP_EFFECT,2);
         if(pieces > 0)
         {
            UIManager.centerBroadcast.addMsg("您获得了" + pieces + "个卡牌残页",1);
            Global.control.sendNotification(CardEvent.EXP_EFFECT,1);
         }
      }
      
      public static function GC_CARD_TOTAL_ATTIBUTE(arr:Array) : void
      {
         Model_card.totalAttribute = arr;
         Global.control.sendNotification(CardEvent.TOTAL_ATTRIBUTE,null);
      }
      
      public static function GC_CARD_LOCK(bagID:int, lock:int, type:int) : void
      {
         if(type == 1)
         {
            Model_card.equipCardVoArray[bagID].lock = lock;
            Global.control.sendNotification(CardEvent.UPDATE_EQUIP_CARD,null);
         }
         else if(type == 2)
         {
            Model_card.bagCardVoArray[bagID].lock = lock;
            Global.control.sendNotification(CardEvent.UPDATE_BAG,null);
         }
      }
      
      private static function setCountDown2() : void
      {
         t2 = 0;
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,onCountDown2);
      }
      
      private static function onCountDown2(interval:int) : void
      {
         var pastSeconds:int = 0;
         var t:int = 0;
         t2 += interval;
         if(t2 > 1000)
         {
            pastSeconds = t2 / 1000;
            t2 %= 1000;
            t = Model_card.countDown - pastSeconds;
            Model_card.countDown = t < 0 ? 0 : t;
            if(Model_card.countDown == 0)
            {
               Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,onCountDown2);
               CardCGMessage.CG_CARD_COUNT_DOWN_TIMEOUT();
            }
         }
      }
   }
}

