package com.yiTian.net.handler
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.actions.jiJin.FundMter;
   import com.yiTian.view.modules.actions.jiJin.chongzhi.View_chongzhi;
   import com.yiTian.view.modules.activity.View_ActivityMainPanel;
   import com.yiTian.view.modules.shouchong.ShouChongNew;
   import com.yiTian.view.modules.wuXing.WuXingMter;
   import flash.utils.setTimeout;
   
   public class ShouChongHandler
   {
      
      public function ShouChongHandler()
      {
         super();
      }
      
      public static function GC_SHOUCHONG(result:int, state:int) : void
      {
         UIManager.shouChongPanel.showShouChongBtn(state);
      }
      
      public static function GC_SHOUCHONG_AWARD(result:int) : void
      {
         if(Boolean(result))
         {
            UIManager.shouChongPanel.playEff();
            WuXingMter.getPan(ShouChongNew,function(pan:ShouChongNew):void
            {
               if(pan.visible)
               {
                  pan.visible = false;
               }
            });
         }
      }
      
      public static function GC_HAS_SHOUCHONG(result:int, result2:int) : void
      {
         var pan2:View_chongzhi = null;
         var handleOfR2:Function = function(r2:int):void
         {
            var m:int = 0;
            if(r2 == 1)
            {
               View_ActivityMainPanel.isGengXinPan = false;
               m = int(setTimeout(function():void
               {
                  UIManager.amPanel.visible = true;
               },100));
            }
         };
         if(result == 0)
         {
            WuXingMter.getPan(ShouChongNew,function(pan:ShouChongNew):void
            {
               pan.visible = true;
               handleOfR2(result2);
            });
         }
         else
         {
            handleOfR2(result2);
            UIManager.yuanBaoXiang.visible = true;
            if(Boolean(FundMter.chongZhiPan))
            {
               FundMter.chongZhiPan.visible = true;
               FundMter.chongZhiPan.isNeedAutoOpenCZ = true;
               FundMter.chongZhiPan.openCZ();
            }
            else
            {
               pan2 = Singleton.getInstance(View_chongzhi) as View_chongzhi;
               (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pan2,function():void
               {
                  FundMter.chongZhiPan = pan2;
                  FundMter.chongZhiPan.isNeedAutoOpenCZ = true;
                  FundMter.chongZhiPan.openCZ();
                  FundMter.chongZhiPan.visible = true;
               });
            }
         }
      }
   }
}

