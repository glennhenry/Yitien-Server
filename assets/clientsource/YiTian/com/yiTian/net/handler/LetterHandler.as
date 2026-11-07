package com.yiTian.net.handler
{
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.LetterCGMessage;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.modules.letter.LetterViewPanel;
   
   public class LetterHandler
   {
      
      public function LetterHandler()
      {
         super();
      }
      
      public static function GC_MAIL(letterVOArr:Array) : void
      {
         UIManager.letterManagerViewPanel.letterVOArr = letterVOArr;
         UIManager.letterManagerViewPanel.refreshData();
      }
      
      public static function GC_GET_ATTACHMENT(result:int) : void
      {
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10243",1) + "</font>");
               if(LetterViewPanel.isCan)
               {
                  Tween.gridToBagBezierFuncDef(LetterViewPanel.curVO,-1,LetterViewPanel.curPoint.x,LetterViewPanel.curPoint.y);
               }
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10244",1) + "</font>");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10245",1) + "</font>");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10246",1) + "</font>");
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10247",1) + "</font>");
               break;
            case 6:
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10248",1) + "</font>");
         }
      }
      
      public static function GC_SEND_MAIL(result:int) : void
      {
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10249",1) + "</font>");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10250",1) + "</font>");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10251",1) + "</font>");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10252",1) + "</font>");
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10253",1) + "</font>");
               break;
            case 6:
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10254",1) + "</font>");
               break;
            case 7:
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10255",1) + "</font>");
               break;
            case 8:
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10256",1) + "</font>");
               break;
            case 9:
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10257",1) + "</font>");
               break;
            case 10:
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>您在对方黑名单中，不能发送邮件</font>");
         }
      }
      
      public static function GC_DELETE_MAIL(result:int, size:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10258",1) + "</font>");
         }
         else if(result == 2)
         {
         }
      }
      
      public static function GC_CLEAR_MAIL(result:int, size:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10259",1) + "</font>");
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10260",1) + "</font>");
         }
      }
      
      public static function GC_NEW_MAIL_NOTI() : void
      {
         UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10261",1) + "</font>");
         if(UIManager.letterManagerViewPanel.visible)
         {
            LetterCGMessage.CG_MAIL(1,1);
         }
         UIManager.smallMap.addTip(1);
      }
   }
}

