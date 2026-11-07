package com.yiTian.net.message.gc
{
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.LingQiWuHunHandler;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.blueDiamondND.xiaofeiCJ.IconHide;
   import flash.utils.IDataInput;
   
   public class LingQiWuHunGCMessage
   {
      
      public function LingQiWuHunGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_LINGQIWUHUN] = GC_LINGQIWUHUN;
         index[MessageType.GC_JUANXIAN_LINGQI] = GC_JUANXIAN_LINGQI;
         index[MessageType.GC_LINGQIWUHUN_START_END] = GC_LINGQIWUHUN_START_END;
      }
      
      public static function GC_LINGQIWUHUN(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var curIntegral:int = patch.readInt();
         var maxIntegral:int = patch.readInt();
         var juanXianTimes:int = patch.readByte();
         LingQiWuHunHandler.GC_LINGQIWUHUN(result,curIntegral,maxIntegral,juanXianTimes);
      }
      
      public static function GC_JUANXIAN_LINGQI(patch:IDataInput) : void
      {
         var curIntegral:int = 0;
         var maxIntegral:int = 0;
         var juanXianTimes:int = 0;
         var jingYan:int = 0;
         var result:int = patch.readByte();
         if(result == 1)
         {
            curIntegral = patch.readInt();
            maxIntegral = patch.readInt();
            juanXianTimes = patch.readByte();
            jingYan = patch.readInt();
            LingQiWuHunHandler.GC_JUANXIAN_LINGQI(result,curIntegral,maxIntegral,juanXianTimes,jingYan);
            if(juanXianTimes == 3)
            {
               UIManager.lingQiWuHunPanel.visible = false;
               IconHide.instance.show();
            }
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10332",1) + "</font>");
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10329",1) + "</font>");
         }
         else if(result == 4)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10333",1) + "</font>");
         }
         else if(result == 5)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10334",1) + "</font>");
         }
      }
      
      public static function GC_LINGQIWUHUN_START_END(patch:IDataInput) : void
      {
         var status:int = patch.readByte();
         LingQiWuHunHandler.GC_LINGQIWUHUN_START_END(status);
      }
   }
}

