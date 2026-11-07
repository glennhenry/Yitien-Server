package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_LFower;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.LFlowerCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.lFlower.View_LFlower;
   
   public class LFlowerHandler
   {
      
      public function LFlowerHandler()
      {
         super();
      }
      
      public static function GC_IFLOWER_WY(relute:int) : void
      {
         switch(relute)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("赶紧去结婚吧，才能种植爱情之花，可获得情人节属性丹哦",1);
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("伴侣不在线，无法发送种植邀请",1);
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("没有这朵爱情花",1);
               break;
            case 4:
               View_LFlower.instance.killCD();
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("元宝不足，请及时充值",1);
               break;
            case 6:
               UIManager.centerBroadcast.addMsg("成功发送种花邀请",1);
               break;
            case 7:
               UIManager.centerBroadcast.addMsg("种植成功",1);
               break;
            case 8:
               UIManager.centerBroadcast.addMsg("爱情之花成长值已满，不能喂养",1);
         }
      }
      
      public static function GC_IFLOWER_OPEN(c:int, n:int, cd:int) : void
      {
         Model_LFower.currentCZ = c;
         Model_LFower.nextCZ = n;
         Model_LFower.cdTime = cd;
         Global.delegate.dosomething(View_LFlower.instance,function():void
         {
            View_LFlower.instance.update();
         });
      }
      
      public static function GC_IFLOWER_BROCAST(id_1:Number, rn_1:String, id_2:Number, rn_2:String) : void
      {
         var id1:String = "qrj" + id_1;
         var id2:String = "qrj" + id_2;
         var msg:String = "<font color=\'#FF0000\'> " + "情人节" + "   </font>" + HtmlUtil.underLine(HtmlUtil.font(rn_1,"#04ff00")) + "和</font>" + HtmlUtil.underLine(HtmlUtil.font(rn_2,"#04ff00")) + "的爱情之花成长又提高了，情人节属性奖励马上到手咯!" + "<font color=\'#FFFF00\'>【</font><a href=\'event:qingrenjie\'>" + HtmlUtil.underLine(HtmlUtil.font("我也要种花","#FFFF00")) + "</a><font color=\'#FFFF00\'>】</font>";
         UIManager.chatPanel.add(msg,id_1,889,rn_1);
      }
      
      public static function GC_IFLOWER_INVITE() : void
      {
         var okFun:Function = null;
         var cancelFun:Function = null;
         okFun = function():void
         {
            LFlowerCGMessage.CG_IFLOWER_INVITED();
         };
         cancelFun = function():void
         {
            LFlowerCGMessage.CG_IFLOWER_INVITE_N();
         };
         Global.delegate.dosomething(View_LFlower.instance,function():void
         {
            View_LFlower.instance.stopTimer();
         });
         View_Alert.show("是否和自己伴侣一起种植爱情之花？",View_Alert.OK_CANCAL,okFun,cancelFun);
      }
      
      public static function GC_IFLOWER_INVITE_N() : void
      {
         UIManager.centerBroadcast.addMsg("您的伴侣正在闹脾气 (┬＿┬)",1);
      }
   }
}

