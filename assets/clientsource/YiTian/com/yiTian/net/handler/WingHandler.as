package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_wing;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.modules.guaji.BitmapBtn;
   import com.yiTian.view.modules.wing.View_wing_blessTipsMenu;
   import com.yiTian.view.modules.wing.View_wing_buff;
   import com.yiTian.view.modules.wing.View_wing_buyGuide;
   import com.yiTian.view.modules.wing.View_wing_menu;
   
   public class WingHandler
   {
      
      public function WingHandler()
      {
         super();
      }
      
      public static function CG_HAVE_WING(flag:int) : void
      {
         if(flag == 0)
         {
            UIManager.special_btn.setMoveEff(3,true);
         }
      }
      
      public static function GC_WING_OPEN(flag:int, wingId:int = 0, bless:int = 0, blessTime:int = 0) : void
      {
         if(flag == 1)
         {
            Model_wing.wingId = wingId;
            Model_wing.bless = bless;
            Model_wing.blessTime = blessTime;
            View_wing_menu.instance.update();
            View_wing_menu.instance.visible = true;
            UIManager.special_btn.setMoveEff(3,false);
         }
         else if(flag == 2)
         {
            View_wing_buyGuide.instance.visible = true;
         }
      }
      
      public static function GC_WING_TIPS() : void
      {
         var tip:BitmapBtn = null;
         tip = new BitmapBtn();
         tip.init();
         tip.setBgDir("resource/image/wing/tipsIcon.png");
         UIManager.tipBtnContainer.addItem(tip);
         tip.clickCallBack = function():void
         {
            Global.delegate.dosomething(View_wing_blessTipsMenu.instance,function():void
            {
               UIManager.tipBtnContainer.removeItem(tip);
               View_wing_blessTipsMenu.instance.visible = true;
            });
         };
      }
      
      public static function GC_WING_BLESS_MENU(wingId:int, bless:int, blessTime:int) : void
      {
         Model_wing.wingId = wingId;
         Model_wing.bless = bless;
         Model_wing.blessTime = blessTime;
         View_wing_blessTipsMenu.instance.update();
      }
      
      public static function GC_WING_BUY(result:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("购买成功");
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg("元宝不足");
         }
      }
      
      public static function GC_WING_UP_LEVEL(result:int) : void
      {
         switch(result)
         {
            case 1:
               View_wing_menu.instance.showUpLevelBitmap(1);
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("无法进阶，已达到最高级");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("材料不足");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("元宝不足");
               break;
            case 5:
               View_wing_menu.instance.showUpLevelBitmap(2);
         }
      }
      
      public static function GC_WING_UP_COST(count:int) : void
      {
         UIManager.centerBroadcast.addMsg("自动购买" + HtmlUtil.fontNoSize(String(count) + "个翅膀羽毛，","#00ff00") + "花费" + HtmlUtil.fontNoSize(String(count * 48) + "元宝","#00ff00"));
      }
      
      public static function GC_WING_CHANGE_MODEL(result:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("模型更换成功");
            View_wing_menu.instance.updateShowBtn();
         }
         else
         {
            UIManager.centerBroadcast.addMsg("模型更换失败");
         }
      }
      
      public static function GC_WING_SHOW_AND_HIDE(result:int) : void
      {
         switch(result)
         {
            case 0:
               UIManager.centerBroadcast.addMsg("显示失败");
               break;
            case 1:
               UIManager.centerBroadcast.addMsg("隐藏失败");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("显示成功");
               View_wing_menu.instance.updateShowBtn();
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("隐藏成功");
               View_wing_menu.instance.updateShowBtn();
         }
      }
      
      public static function GC_WING_USE_RESULT(result:int, itemId:int) : void
      {
         if(result == 0)
         {
            UIManager.centerBroadcast.addMsg("恭喜您成功使用" + Data_lib.item[itemId][1] + "，翅膀功能将在67级开放，敬请期待！",1);
         }
         else if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("恭喜您成功使用" + Data_lib.item[itemId][1] + "，可在翅膀界面进行隐藏外观操作！",1);
         }
      }
      
      public static function GC_WING_BUFF_TIME(result:int, count:int, modelId:int, itemId:int) : void
      {
         if(result == 0)
         {
            View_wing_buff.instance.updateTime(0);
            if(Model_wing.HuanHuaID > 0)
            {
               Model_wing.HuanHuaID = 0;
               Model_wing.HuanHuaDanID = 0;
               UIManager.heroHead.removeBuff(View_wing_buff.instance);
            }
            if(Boolean(Global.ChiBangdm))
            {
               View_wing_menu.instance.HuanHuaBtn.visible = false;
            }
         }
         else
         {
            UIManager.heroHead.addBuff(View_wing_buff.instance);
            Model_wing.HuanHuaID = modelId;
            Model_wing.HuanHuaDanID = itemId;
            View_wing_buff.instance.updateTime(count);
            if(Boolean(Global.ChiBangdm))
            {
               View_wing_menu.instance.HuanHuaBtn.visible = true;
            }
         }
      }
   }
}

