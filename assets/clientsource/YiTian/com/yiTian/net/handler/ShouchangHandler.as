package com.yiTian.net.handler
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.shouchangyouli.View_shouchang_Btn;
   
   public class ShouchangHandler
   {
      
      public function ShouchangHandler()
      {
         super();
      }
      
      public static function GC_SHOW_SHOUCHANG_ICON() : void
      {
         if(!UIManager.mainUiBtnContainer.hasBTN(View_shouchang_Btn.instance))
         {
            UIManager.mainUiBtnContainer.addBTN(View_shouchang_Btn.instance);
         }
      }
      
      public static function GC_SHOUCHANG(result:int) : void
      {
         if(result == 1 || result == 2)
         {
            if(result == 1)
            {
               UIManager.shouchang_panel.flyToBag();
            }
            else
            {
               UIManager.centerBroadcast.addMsg("收藏成功，奖励已发到邮箱，请查收");
            }
            if(UIManager.mainUiBtnContainer.hasBTN(View_shouchang_Btn.instance))
            {
               UIManager.mainUiBtnContainer.removeBTN(View_shouchang_Btn.instance);
            }
            if(Boolean(UIManager.shouchang_panel))
            {
               UIManager.shouchang_panel.visible = false;
            }
         }
      }
   }
}

