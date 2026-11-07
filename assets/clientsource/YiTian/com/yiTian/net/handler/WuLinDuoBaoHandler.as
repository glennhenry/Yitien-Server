package com.yiTian.net.handler
{
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.activity.Model_actDaily;
   import com.yiTian.view.modules.wulinduobao.BaoXiang;
   import com.yiTian.view.modules.wulinduobao.BaoXiangVO;
   import flash.utils.getTimer;
   
   public class WuLinDuoBaoHandler
   {
      
      private static var _levelTxt:Array;
      
      private static const baoXiangXY:Array = [[3850,2400],[1500,820],[4439,1070]];
      
      public function WuLinDuoBaoHandler()
      {
         super();
      }
      
      private static function get levelTxt() : Array
      {
         if(!_levelTxt)
         {
            _levelTxt = [LangConfig.getWord("702",0),LangConfig.getWord("703",0),LangConfig.getWord("704",0)];
         }
         return _levelTxt;
      }
      
      public static function GC_SHOW_BAOXIANG(result:int, arr:Array) : void
      {
      }
      
      public static function GC_HIDE_BAOXIANG(result:int) : void
      {
      }
      
      public static function GC_DUOBAO(result:int) : void
      {
         if(result == 1)
         {
            BaoXiang.showCollectBar(true);
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("705",0) + "</font>");
         }
         else if(result == 3)
         {
            BaoXiang.showCollectBar(false);
            BaoXiangVO.lastTime = getTimer();
         }
         else if(result == 4)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("706",0) + "</font>");
         }
      }
      
      public static function GC_GET_BAOXIANG(result:int) : void
      {
         if(result == 1)
         {
            BaoXiang.showCollectBar(false);
         }
      }
      
      public static function GC_CANCEL_GET_BAOXIANG(result:int) : void
      {
         if(result == 1)
         {
            BaoXiang.showCollectBar(false);
         }
      }
      
      public static function GC_SNATCH_BX_TIP() : void
      {
         UIManager.smallMap.addTip(0);
         Model_actDaily.getInstance().updateAct(0,true);
      }
   }
}

