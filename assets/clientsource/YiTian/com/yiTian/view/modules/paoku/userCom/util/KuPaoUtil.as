package com.yiTian.view.modules.paoku.userCom.util
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.KuPaoCGMessage;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import com.yiTian.view.modules.paoku.model.Model_KuPao;
   import com.yiTian.view.modules.paoku.view.View_KuPaoFriendRank;
   import com.yiTian.view.modules.paoku.view.View_KuPaoGuide;
   import com.yiTian.view.modules.paoku.view.View_kuPaoPnl;
   import com.yiTian.view.modules.paoku.view.View_kuPaoRankPnl;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class KuPaoUtil
   {
      
      public static const mainDmName:String = "MMKPdm";
      
      private static var rewards:Array = [[[1,46255,3],[1,43003,2],[1,43013,2],[1,46589,10]],[[1,46255,1],[1,43003,2],[1,43013,2],[1,46589,8]],[[1,46254,3],[1,43003,1],[1,43013,1],[1,46589,5]],[[1,46254,1],[1,43003,1],[1,43013,1],[1,46589,3]]];
      
      public static var pkHelStr:String = "<font color=\'#ffff55\'>每日积分奖励：</font>\n" + "<font color=\'#ffff55\'>0-500可获得：       </font><font color=\'#88ff00\'>低级阅历丹*5、四级气血药*15、赤金银锭*10</font>\n" + "<font color=\'#ffff55\'>501-1000可获得：  </font><font color=\'#88ff00\'>低级阅历丹*5、四级气血药*16、赤金银锭*11</font>\n" + "<font color=\'#ffff55\'>1001-1500可获得：</font><font color=\'#88ff00\'>低级阅历丹*5、四级气血药*17、赤金银锭*12</font>\n" + "<font color=\'#ffff55\'>1501-2000可获得：</font><font color=\'#88ff00\'>低级阅历丹*5、四级气血药*18、赤金银锭*13</font>\n" + "<font color=\'#ffff55\'>2001-2500可获得：</font><font color=\'#88ff00\'>低级阅历丹*6、四级气血药*19、赤金银锭*14</font>\n" + "<font color=\'#ffff55\'>2501-3000可获得：</font><font color=\'#88ff00\'>低级阅历丹*6、四级气血药*20、赤金银锭*15</font>\n" + "<font color=\'#ffff55\'>3001-3500可获得：</font><font color=\'#88ff00\'>低级阅历丹*7、四级气血药*21、赤金银锭*16</font>\n" + "<font color=\'#ffff55\'>3501-4000可获得：</font><font color=\'#88ff00\'>低级阅历丹*7、四级气血药*24、赤金银锭*16</font>\n" + "<font color=\'#ffff55\'>4001-4500可获得：</font><font color=\'#88ff00\'>低级阅历丹*8、四级气血药*25、赤金银锭*16</font>\n" + "<font color=\'#ffff55\'>4501-5000可获得：</font><font color=\'#88ff00\'>低级阅历丹*8、四级气血药*26、赤金银锭*16</font>\n" + "<font color=\'#ffff55\'>5001-5500可获得：</font><font color=\'#88ff00\'>低级阅历丹*9、四级气血药*27、赤金银锭*17</font>\n" + "<font color=\'#ffff55\'>5501-6000可获得：</font><font color=\'#88ff00\'>低级阅历丹*9、四级气血药*28、赤金银锭*18</font>\n" + "<font color=\'#ffff55\'>6001-6500可获得：</font><font color=\'#88ff00\'>低级阅历丹*10、四级气血药*29、赤金银锭*19</font>\n" + "<font color=\'#ffff55\'>6501-最高可获得： </font><font color=\'#88ff00\'>低级阅历丹*10、四级气血药*30、赤金银锭*20</font></font>";
      
      public function KuPaoUtil()
      {
         super();
      }
      
      public static function convertViewX(x:Number) : Number
      {
         return x;
      }
      
      public static function convertViewY(y:Number) : Number
      {
         return 480 - y;
      }
      
      public static function restrictXInBlock(curxpos:Number, nextxpos:Number) : Number
      {
         var rest:int = 0;
         var index:int = curxpos / 40;
         var curLeft:int = index * 40;
         var curRight:int = index * 40 + 39;
         if(nextxpos > curRight)
         {
            rest = curRight;
         }
         else if(nextxpos < curLeft)
         {
            rest = curLeft;
         }
         else
         {
            rest = nextxpos;
         }
         return rest;
      }
      
      public static function restrictYInBlock(curypos:Number, nextypos:Number) : Number
      {
         var rest:int = 0;
         var index:int = curypos / 40;
         var curBottom:int = index * 40;
         var curTop:int = index * 40 + 39;
         if(nextypos > curTop)
         {
            rest = curTop;
         }
         else if(nextypos < curBottom)
         {
            rest = curBottom;
         }
         else
         {
            rest = curypos;
         }
         return rest;
      }
      
      public static function restrictPos() : Point
      {
         return null;
      }
      
      public static function askOpenMainPanel() : void
      {
         if(GameUnitManager.hero.level < 40)
         {
            UIManager.centerBroadcast.addMsg("等级未达40，请加油练级。",1);
            return;
         }
         if(SceneConfig.getSceneType() != SceneConfig.COMMON)
         {
            UIManager.centerBroadcast.addMsg("副本地图不能参与酷跑。",1);
            return;
         }
         if(GameUnitManager.hero.action != Action.SIT)
         {
            UIManager.centerBroadcast.addMsg("挂机状态才能够参与酷跑哦~",1);
            return;
         }
         var pkPnl:View_kuPaoPnl = View_kuPaoPnl.instance;
         var delegate:Delegate123 = Global.delegate;
         KuPaoCGMessage.CG_KP_REQUESTBASICINFO();
         KuPaoCGMessage.CG_KP_GETITEMBUYTIMES();
         if(pkPnl.visible == false)
         {
            delegate.dosomething(pkPnl,pkPnl.show);
         }
         else
         {
            delegate.dosomething(pkPnl,pkPnl.hide);
         }
      }
      
      public static function askOpenRankPanel() : void
      {
         var rankPnl:View_kuPaoRankPnl = View_kuPaoRankPnl.instance;
         var delegate:Delegate123 = Global.delegate;
         if(rankPnl.visible == false)
         {
            delegate.dosomething(rankPnl,rankPnl.show);
         }
         else
         {
            delegate.dosomething(rankPnl,rankPnl.hide);
         }
      }
      
      public static function askOpenFriendRank() : void
      {
         var rankPnl:View_KuPaoFriendRank = View_KuPaoFriendRank.instance;
         var delegate:Delegate123 = Global.delegate;
         if(rankPnl.visible == false)
         {
            delegate.dosomething(rankPnl,rankPnl.show);
         }
         else
         {
            delegate.dosomething(rankPnl,rankPnl.hide);
         }
      }
      
      public static function askOpenGuidePnl() : void
      {
         var guidePnl:View_KuPaoGuide = View_KuPaoGuide.instance;
         Global.delegate.dosomething(guidePnl,guidePnl.visible == false ? guidePnl.show : guidePnl.hide);
      }
      
      public static function computeValidateScore(coin:int, meter:int) : int
      {
         var validateNum:int = Model_KuPao.validateNum;
         return int((coin + validateNum + 1) * 18 + meter);
      }
      
      public static function getItemName(type:int) : String
      {
         var rest:String = null;
         if(type == 1)
         {
            rest = "开局冲冲冲";
         }
         else if(type == 2)
         {
            rest = "积分翻翻翻";
         }
         else if(type == 3)
         {
            rest = "死亡继续冲";
         }
         else if(type == 4)
         {
            rest = "炸弹也不怕";
         }
         else
         {
            rest = "";
         }
         return rest;
      }
      
      public static function yellowBmdFunc(char:String) : BitmapData
      {
         return ComponentUtil.getBitmapData("SZ_H" + char,Global.MMKPdm);
      }
      
      public static function blueBmdFunc(char:String) : BitmapData
      {
         return ComponentUtil.getBitmapData("SZ_L" + char,Global.MMKPdm);
      }
      
      public static function getAwardStr(index:int) : String
      {
         var ar:Array = null;
         var rest:String = null;
         var s:String = null;
         var term:Array = [];
         for each(ar in rewards[index])
         {
            s = Enum_BroadCastTool.instance.getItemText(ar[1]) + "*" + ar[2];
            term.push(s);
         }
         return "<font color=\'#ffff55\'>此名次可领奖励为：</font>\n" + term.join("\n");
      }
      
      public static function tryToBuyTool(type:int) : void
      {
         var rep:String = null;
         var has:int = Model_KuPao.getNumTool(type - 1);
         var times:int = int(Model_KuPao.itemTimes[type - 1]);
         var price:int = KuPaoUtil.getItemPrice(type,times);
         if(has <= 0)
         {
            rep = "";
            if(price == 0)
            {
               rep = "您将购买{1}(第一次免费)";
            }
            else
            {
               rep = "您将花费{0}元宝来购买{1}";
            }
            View_Alert.show(LangConfig.reTxt(rep,price,getItemName(type)),View_Alert.OK_CANCAL,function():void
            {
               KuPaoCGMessage.CG_KP_USEITEM(type);
            });
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.reTxt("不能重复购买{0}",getItemName(type)),1);
         }
      }
      
      public static function getRewardArr(score:int) : Array
      {
         var itemArr:Array = null;
         var tabel:Array = Data_lib.mmkpAward.toArray();
         var rest:Array = tabel[0];
         for each(itemArr in tabel)
         {
            if(score >= itemArr[1] && score <= itemArr[2])
            {
               rest = itemArr;
               break;
            }
         }
         return rest;
      }
      
      public static function getItemPrice(id:int, times:int) : int
      {
         var rt:int = Math.max(0,Math.min(times - 1,5));
         var lib:* = Data_lib.mmkpItemPrice;
         return int(Data_lib.mmkpItemPrice[id][rt + 1]);
      }
   }
}

