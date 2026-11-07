package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.xiaofeituangou.View_XiaoFeiTuanGouPanel;
   import flash.text.TextFormatAlign;
   
   public class XiaoFeiTuanGouHandle
   {
      
      public function XiaoFeiTuanGouHandle()
      {
         super();
      }
      
      public static function GC_XFTG_OPEN(arr:Array) : void
      {
         var ins:View_XiaoFeiTuanGouPanel = null;
         ins = View_XiaoFeiTuanGouPanel.instance;
         Global.delegate.dosomething(ins,function():void
         {
            var str:String = null;
            ins.visible = !ins.visible;
            ins.update(arr);
            if(ins.visible)
            {
               str = "<font color=\'#ffffff\' size=\'16\'><font color=\'#00ff00\'>00:00-00:15</font>购买或者消费都不会计入跨服团购人数，<font color=\'#ff0000\'>请不要在此时间段参与活动<font></font>";
               View_Alert.show(str,View_Alert.OK,null,null,null,null,420,"","",TextFormatAlign.CENTER);
            }
         });
      }
      
      public static function GC_XFTG_OPEN2() : void
      {
         var ins:View_XiaoFeiTuanGouPanel = null;
         ins = View_XiaoFeiTuanGouPanel.instance;
         Global.delegate.dosomething(ins,function():void
         {
            ins.updateTuanGou();
         });
      }
      
      public static function GC_XFTG_GETAWARD(result:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("领取成功",1);
            View_XiaoFeiTuanGouPanel.instance.getAward();
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg("领取失败",1);
         }
      }
      
      public static function GC_XFTG_BUY(result:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("购买成功",1);
            View_XiaoFeiTuanGouPanel.instance.getAward();
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg("购买失败",1);
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg("购买次数已达上限",1);
         }
         else if(result == 4)
         {
            UIManager.centerBroadcast.addMsg("元宝不足",1);
         }
      }
      
      public static function GC_XFTG_BROCAST() : void
      {
         var str:String = HtmlUtil.font(" 系统  ","#ff0000") + "<font color=\'#FFF4A5\'>跨服团购正在火热进行，参与人数疯狂增加中！赶紧出手，冲击终极奖励，<font color=\'#ffff00\'>" + HtmlUtil.createLink("【我要参加】",true,"xiaofeituangou") + "</font></font>";
         UIManager.chatPanel.add(str,0,1);
      }
   }
}

