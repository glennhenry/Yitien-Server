package com.yiTian.net.handler
{
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.VIPCGMessage;
   import com.yiTian.view.modules.vip.VipPanel;
   import com.yiTian.view.modules.vip.VipVO;
   import com.yiTian.view.modules.vipServer.VipServerIcon;
   import com.yiTian.view.modules.vipServer.VipServerPanel;
   import flash.utils.setTimeout;
   
   public class VIPHandle
   {
      
      public function VIPHandle()
      {
         super();
      }
      
      public static function GC_VIP_OPEN(result:int, leftDays:int, data:Vector.<int>) : void
      {
         VipVO.days = leftDays;
         VipVO.level = result;
         VipVO.data = data;
         if(!VipPanel.firstApp)
         {
            if(GameUnitManager.hero.vip != 0)
            {
               vHd();
            }
            if(UIManager.vipPanel.visible)
            {
               UIManager.vipPanel.updata();
            }
         }
         else
         {
            vHd();
         }
         VipPanel.firstApp = false;
      }
      
      public static function vHd() : void
      {
         if(!VipPanel.firstApp)
         {
            return;
         }
         if(GameUnitManager.hero.vip == 0)
         {
            return;
         }
         var i:int = 0;
         while(i < VipVO.data.length)
         {
            if(VipVO.data[i] == 0)
            {
               UIManager.heroHead.getVipEff();
               return;
            }
            if(i == VipVO.data.length - 1)
            {
               UIManager.heroHead.removeVipEff();
            }
            i++;
         }
      }
      
      public static function GC_BUY_VIP(result:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10424",1));
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10425",1));
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10426",1));
         }
         vHd();
         UIManager.openVipPanel.visible = false;
      }
      
      public static function GC_GET_VIP_YIQUAN(result:int) : void
      {
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("10427",1));
               UIManager.vipPanel.setGray(Data_lib.attribute[18][0]);
               UIManager.vipPanel.removeI(2);
               break;
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("10428",1));
               UIManager.vipPanel.setGray(Data_lib.attribute[18][0]);
               break;
            case 3:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("10429",1));
               UIManager.vipPanel.setGray(LangConfig.getWord("10399",1));
               UIManager.vipPanel.removeI(3);
               break;
            case 4:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("10430",1));
               UIManager.vipPanel.setGray(LangConfig.getWord("10399",1));
               break;
            case 5:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("10431",1));
               UIManager.vipPanel.setGray(Data_lib.attribute[14][0]);
               UIManager.vipPanel.removeI(1);
               break;
            case 6:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("10432",1));
               UIManager.vipPanel.setGray(Data_lib.attribute[14][0]);
               break;
            case 9:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("10433",1));
         }
         VIPCGMessage.CG_VIP_OPEN();
      }
      
      public static function GC_SHOW_VIP_SERVER_ICON(result:int) : void
      {
         switch(result)
         {
            case 0:
               VipServerIcon.realShowTip();
               break;
            case 1:
               VipServerIcon.hide();
         }
      }
      
      public static function GC_SAVE_VIP_SERVER_INFO(result:int) : void
      {
         switch(result)
         {
            case 0:
               UIManager.centerBroadcast.addMsg("保存成功");
               VipServerPanel.instance.flyIcon();
               setTimeout(function():void
               {
                  VipServerPanel.instance.visible = false;
               },1500);
               break;
            case 1:
               UIManager.centerBroadcast.addMsg("输入有误，保存失败");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("已经填过信息不能重复填写");
         }
      }
   }
}

