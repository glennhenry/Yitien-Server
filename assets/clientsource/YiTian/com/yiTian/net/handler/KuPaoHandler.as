package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.KuPaoCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.modules.paoku.model.Model_KuPao;
   import com.yiTian.view.modules.paoku.userCom.KuPaoMgr;
   import com.yiTian.view.modules.paoku.userCom.util.KuPaoUtil;
   import com.yiTian.view.modules.paoku.view.View_KuPaoShowoff;
   import flash.events.TextEvent;
   
   public class KuPaoHandler
   {
      
      public function KuPaoHandler()
      {
         super();
      }
      
      public static function GC_KP_REQUESTBASICINFO(hp:int, remainTime:int, itemInfo:String) : void
      {
         var itemInfoArr:Array = itemInfo.split("");
         Model_KuPao.updateHp(hp,remainTime);
         Model_KuPao.updateItems(itemInfoArr);
      }
      
      public static function GC_KP_FRIENDSRANK(friendRanks:Array) : void
      {
         friendRanks.sort(function(a:Array, b:Array):Number
         {
            return a[4] - b[4];
         });
         Model_KuPao.updateFriendRanks(friendRanks);
      }
      
      public static function GC_KP_REQUESTHP(hp:int, remainTime:int) : void
      {
         Model_KuPao.updateHp(hp,remainTime);
      }
      
      public static function GC_KP_USEITEM(rest:int, type:int) : void
      {
         var tipStr:String = null;
         if(rest == 1)
         {
            Model_KuPao.updatePerItem(type - 1,1);
            tipStr = LangConfig.reTxt("成功购买道具{0}",KuPaoUtil.getItemName(type));
            KuPaoCGMessage.CG_KP_GETITEMBUYTIMES();
         }
         else if(rest == 2)
         {
            tipStr = "元宝不足";
         }
         else if(rest == 3)
         {
            tipStr = LangConfig.reTxt("您已经购买过{0}",KuPaoUtil.getItemName(type));
         }
         if(tipStr != null)
         {
            UIManager.centerBroadcast.addMsg(tipStr,1);
         }
      }
      
      public static function GC_KP_RANK(ranks:Array, myRank:int, myScore:int) : void
      {
         Model_KuPao.updateRank(ranks,myRank,myScore);
      }
      
      public static function GC_KP_STARTGAME1(rest:int, itemsInfo:String, validateNum:int, hp:int) : void
      {
         var tipStr:String = null;
         if(rest == 1)
         {
            Model_KuPao.validateNum = validateNum;
            Model_KuPao.updateHp(hp);
            Model_KuPao.updateItems(itemsInfo.split(""));
            KuPaoMgr.instance.paokuGlobalSM.changeState(KuPaoMgr.GST_GAMESTART,null);
         }
         else
         {
            tipStr = "失败：CODE = " + rest;
         }
         if(tipStr != null)
         {
            UIManager.centerBroadcast.addMsg(tipStr);
         }
      }
      
      public static function GC_KP_SCOREREST(rest:int, hp:int, myScore:int, record:int) : void
      {
         var showoffPnl:View_KuPaoShowoff = null;
         Model_KuPao.score = myScore;
         Model_KuPao.recordScore = record;
         if(rest == 1)
         {
            showoffPnl = View_KuPaoShowoff.instance;
            Global.delegate.dosomething(showoffPnl,showoffPnl.show);
         }
      }
      
      public static function GC_KP_SHOWOFF(roleId:Number, roleName:String, score:int) : void
      {
         var roleNameHtml:String = HtmlUtil.createLink(roleName,true,"checkLink");
         var str:String = LangConfig.reTxt("<font color=\'#6666ff\'>{0}</font>在“<font color=\'#ffff33\'>敏敏酷跑</font>”活动中获得了<font color=\'#ffff33\'>{1}积分</font>，简直太厉害了！<font color=\'#44ff44\'><u><a href=\'event:me\'>【我也要跑】</a></u></font>",roleNameHtml,score);
         UIManager.chatPanel.addItem(str,tipLinkHander,{"roleID":roleId},[1]);
      }
      
      public static function GC_KP_GETITEMBUYTIMES(times:Array) : void
      {
         Model_KuPao.updateItemTimes(times);
      }
      
      private static function tipLinkHander(e:TextEvent, data:* = null) : void
      {
         GameScene.instance.onTextEventLink();
         if(e.text == "checkLink")
         {
            Global.control.sendNotification(Enum_MsgType.MSG_CHECKOTHERROLE,data.roleID);
         }
         else
         {
            KuPaoUtil.askOpenMainPanel();
         }
      }
   }
}

