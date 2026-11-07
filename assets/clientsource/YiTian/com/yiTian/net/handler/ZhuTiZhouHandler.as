package com.yiTian.net.handler
{
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.modules.zhutizhou.ActivityTopicPanel;
   import com.yiTian.view.modules.zhutizhou.View_XianShiLiBaoPanel;
   
   public class ZhuTiZhouHandler
   {
      
      public static var tempId:int;
      
      public static var panelArr:Array = [];
      
      public static var libaoPanelArr:Array = [];
      
      public function ZhuTiZhouHandler()
      {
         super();
      }
      
      public static function showIcon(arr:Array) : void
      {
         var actPanel:ActivityTopicPanel = null;
         var actTopicPanel:ActivityTopicPanel = null;
         var i:int = panelArr.length - 1;
         while(i >= 0)
         {
            actPanel = panelArr[i];
            if(Boolean(actPanel.scBtn))
            {
               UIManager.mainUiBtnContainer.removeBTN(actPanel.scBtn);
            }
            panelArr.pop();
            if(Boolean(actPanel.parent))
            {
               actPanel.parent.removeChild(actPanel);
            }
            actPanel = null;
            i--;
         }
         var len:int = int(arr.length);
         i = 0;
         while(i < len)
         {
            actTopicPanel = new ActivityTopicPanel();
            actTopicPanel.dataArr = arr[i];
            panelArr.push(actTopicPanel);
            actTopicPanel.updateData(actTopicPanel.dataArr);
            i++;
         }
      }
      
      public static function chongZhi(id:int, flag:int, isSecuess:int, roleName:String) : void
      {
         var i:int = 0;
         var str:String = null;
         var str1:String = null;
         tempId = id;
         if(flag == 1)
         {
            i = 0;
            while(i < panelArr.length)
            {
               if((panelArr[i] as ActivityTopicPanel).id == id)
               {
                  panelArr[i].changeIcon();
                  break;
               }
               i++;
            }
            if(isSecuess == 1)
            {
               str = HtmlUtil.font(" 系统  ","#ff0000") + "<font color=\'#FFF4A5\'>恭喜玩家<font color=\'#32CCFE\'>" + roleName + "</font>进行了<font color=\'#00ff00\'>" + Data_lib.zhutizhou[id][0] + "</font>活动获得了巨多的奖励！<font color=\'#ffff00\'>" + HtmlUtil.createLink("我也要奖励",true,"zhutizhou") + "</font></font>";
               UIManager.chatPanel.add(str,0,1);
            }
         }
         else if(flag == 0)
         {
            if(isSecuess == 0)
            {
               str1 = HtmlUtil.font(" 系统  ","#ff0000") + "<font color=\'#FFF4A5\'>恭喜玩家<font color=\'#32CCFE\'>" + roleName + "</font>进行了<font color=\'#00ff00\'>" + Data_lib.zhutizhou[id][0] + "</font>活动获得了巨多的奖励！<font color=\'#ffff00\'>" + HtmlUtil.createLink("我也要奖励",true,"zhutizhou") + "</font></font>";
               UIManager.chatPanel.add(str1,0,1);
            }
         }
      }
      
      public static function getAward(arr:Array) : void
      {
         var i:int = 0;
         var result:int = int(arr[0]);
         if(result == 1)
         {
            i = 0;
            while(i < panelArr.length)
            {
               if(panelArr[i].id == ActivityTopicPanel.index)
               {
                  panelArr[i].getAward(arr[1],arr[2]);
                  UIManager.centerBroadcast.addMsg("领取成功");
                  break;
               }
               i++;
            }
         }
         else if(result == 0)
         {
            UIManager.centerBroadcast.addMsg("领取失败");
         }
      }
      
      public static function libaoGetAward(result:int) : void
      {
         var i:int = 0;
         if(result == 1)
         {
            i = 0;
            while(i < libaoPanelArr.length)
            {
               if(libaoPanelArr[i].id == View_XianShiLiBaoPanel.index)
               {
                  libaoPanelArr[i].getAward();
                  UIManager.centerBroadcast.addMsg("领取成功");
                  break;
               }
               i++;
            }
         }
         else if(result == 0)
         {
            UIManager.centerBroadcast.addMsg("元宝不足，请充值再领取礼包");
         }
      }
      
      public static function libaoShowIcon(arr:Array) : void
      {
         var libaoPanel:View_XianShiLiBaoPanel = null;
         var view_libaoPanel:View_XianShiLiBaoPanel = null;
         var i:int = libaoPanelArr.length - 1;
         while(i >= 0)
         {
            libaoPanel = libaoPanelArr[i];
            if(Boolean(libaoPanel.libaoBtn))
            {
               UIManager.mainUiBtnContainer.removeBTN(libaoPanel.libaoBtn);
            }
            libaoPanelArr.pop();
            if(Boolean(libaoPanel.parent))
            {
               libaoPanel.parent.removeChild(libaoPanel);
            }
            libaoPanel = null;
            i--;
         }
         var len:int = int(arr.length);
         i = 0;
         while(i < len)
         {
            view_libaoPanel = new View_XianShiLiBaoPanel();
            ZhuTiZhouHandler.libaoPanelArr.push(view_libaoPanel);
            view_libaoPanel.updateIconData(arr[i][0],arr[i][1]);
            i++;
         }
      }
      
      public static function shouGongGao(flag:int) : void
      {
         var i:int = 0;
         if(flag == 2)
         {
            UIManager.centerBroadcast.addMsg("您已经领取了所有奖励");
            return;
         }
         if(flag == 1)
         {
            UIManager.centerBroadcast.addMsg("您已经首充过了");
            return;
         }
         var len:int = int(ZhuTiZhouHandler.panelArr.length);
         if(len > 0)
         {
            i = 0;
            while(i < len)
            {
               if(ZhuTiZhouHandler.panelArr[i].id == ActivityTopicPanel.index)
               {
                  ZhuTiZhouHandler.panelArr[i].visible = !ZhuTiZhouHandler.panelArr[i].visible;
                  break;
               }
               i++;
            }
         }
      }
   }
}

