package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.manager.BattleManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.battle.SiWangFuHuoPanel;
   import com.yiTian.view.modules.wanansi.WanAnSiVO;
   
   public class WanAnSiHandler
   {
      
      public function WanAnSiHandler()
      {
         super();
      }
      
      public static function GC_WANANSI_ICON(result:int) : void
      {
         WanAnSiVO.isPlay = false;
         WanAnSiVO.isHellPlay = false;
         switch(result)
         {
            case 0:
               UIManager.wanAnSiPanel.showIcon();
               break;
            case 1:
               WanAnSiVO.isPlay = true;
               break;
            case 2:
            case 4:
               UIManager.wanAnSiPanel.hideIcon();
               break;
            case 3:
               WanAnSiVO.isHellPlay = true;
         }
      }
      
      public static function GC_WANANSI_TIMES(times:int) : void
      {
         WanAnSiVO.times = times;
         UIManager.wanAnSiPanel.updateServerData();
      }
      
      public static function GC_WANANSI_FUHUOCISHU(times:int) : void
      {
         WanAnSiVO.fuHuoCiShu = times;
      }
      
      public static function GC_WANANSI_FUHUO(result:int) : void
      {
         if(Boolean(result))
         {
            if(Global.isInBattle)
            {
               BattleManager.jumpBattle();
            }
            UIManager.siWangFuHuoPanel.show(SiWangFuHuoPanel.HIDE);
         }
      }
      
      public static function GC_WANANSI_SKIP_BATTLE() : void
      {
         BattleManager.jumpBattle();
      }
      
      public static function GC_WANANSI_ENTER(layers:int, result:int, id:int, name:String) : void
      {
         var tips:String = null;
         WanAnSiVO.layers = layers;
         if(result == 1)
         {
            UIManager.wanAnSiPanel.visible = false;
         }
         else
         {
            switch(result)
            {
               case -1:
                  tips = LangConfig.getWord("10631",1);
                  break;
               case -2:
                  tips = LangConfig.getWord("10632",1);
                  break;
               case -3:
                  tips = "未开启地狱万安寺";
            }
            if(id == GameUnitManager.hero.id)
            {
               tips = LangConfig.getWord("10630",1) + tips;
            }
            else
            {
               tips = name + " " + tips;
            }
            UIManager.centerBroadcast.addMsg(tips);
         }
      }
   }
}

