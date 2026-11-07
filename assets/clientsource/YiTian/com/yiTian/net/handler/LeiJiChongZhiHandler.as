package com.yiTian.net.handler
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.actions.leijichongzhi.LeiJiChongZhiBtn;
   import com.yiTian.view.modules.actions.leijichongzhi.LeiJiChongZhiPan;
   
   public class LeiJiChongZhiHandler
   {
      
      public function LeiJiChongZhiHandler()
      {
         super();
      }
      
      public static function showIcon(isShow:int, isLight:int) : void
      {
         if(isShow == 1)
         {
            LeiJiChongZhiBtn.showIcon();
            if(isLight == 1)
            {
               LeiJiChongZhiBtn.addEff();
            }
            else if(isLight == 0)
            {
               LeiJiChongZhiBtn.removeEff();
            }
         }
         else if(isShow == 0)
         {
            if(isLight == 0)
            {
               LeiJiChongZhiBtn.removeEff();
            }
            LeiJiChongZhiBtn.remove();
         }
      }
      
      public static function showPanel(arr:Array, money:int) : void
      {
         if(Boolean(LeiJiChongZhiPan.instance))
         {
            LeiJiChongZhiPan.instance.update(arr,money);
         }
      }
      
      public static function getAward(dangshu:int, btnIndex:int, result:int) : void
      {
         if(result == 0)
         {
            UIManager.centerBroadcast.addMsg("领取成功");
            if(Boolean(LeiJiChongZhiPan.instance))
            {
               LeiJiChongZhiPan.instance.getAward(dangshu,btnIndex);
            }
         }
         else if(result == -1)
         {
            UIManager.centerBroadcast.addMsg("未达到领取要求无法领取");
         }
         else if(result == -2)
         {
            UIManager.centerBroadcast.addMsg("已领取过奖励，无法重复领取");
         }
      }
   }
}

