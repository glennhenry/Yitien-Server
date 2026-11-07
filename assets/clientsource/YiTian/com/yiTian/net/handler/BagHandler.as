package com.yiTian.net.handler
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_UpdateTime;
   import com.yiTian.data.model.Model_bag;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.ModelManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BagCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.actions.jiJin.FundMter;
   import com.yiTian.view.modules.chargeGuide.View_Fashions;
   import com.yiTian.view.modules.tip.tips.BagFullTips;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public class BagHandler
   {
      
      public static var _bmp:BagFullTips;
      
      public static var isValue:Boolean = false;
      
      private static var equipId:Number = 0;
      
      public function BagHandler()
      {
         super();
      }
      
      public static function GC_BAG_UPDATE(result:int, equips:Array, items:Array) : void
      {
         if(ModelManager.bag.canUse == 0)
         {
            ModelManager.bag.canUse = 50;
         }
         if(result == 1)
         {
            ModelManager.bag.init(equips,items);
            Global.updateTimeManager.add(Enum_UpdateTime.BAG_TIDY,CommandManager.get_serverTime().time / 1000,11);
            Utils.print("背包数据初始化");
         }
         else if(result == 2)
         {
            ModelManager.bag.update(equips,items,true);
            Utils.print("背包数据更新");
         }
         else if(result == 3)
         {
            ModelManager.bag.tidy(equips,items);
            Global.updateTimeManager.update(Enum_UpdateTime.BAG_TIDY);
         }
         else if(result == 4)
         {
            ModelManager.bag.update(equips,items);
            Utils.print("背包数据更新,角色装备");
         }
         else if(result == 5)
         {
            ModelManager.bag.update(equips,items);
            Utils.print("背包数据更新,铸造");
         }
         else if(result == 6)
         {
            ModelManager.bag.update(equips,items);
            Utils.print("背包数据更新,仓库");
         }
         else
         {
            if(result != 7)
            {
               throw new Error("背包数据出错");
            }
            ModelManager.bag.update(equips,items);
            Utils.print("背包数据更新,其他不用提示的情况");
         }
         CommandManager.update_bag(result,equips);
      }
      
      public static function GC_BAG_EMPTY(result:int, arr_gridId:Array) : void
      {
         if(result == 1)
         {
            ModelManager.bag.empty_some(arr_gridId);
            CommandManager.update_bag();
            if(UIManager.castPanel.visible)
            {
               UIManager.castPanel.update_bag_emp(arr_gridId);
            }
            Utils.print("清空背包格子  ",arr_gridId);
         }
         else
         {
            Utils.print("清空背包格子失败" + arr_gridId);
         }
         Global.control.sendNotification(Enum_MsgType.BAG_UPDATE,null);
      }
      
      public static function GC_BAG_EXTENSION(result:int, canUse:int) : void
      {
         if(result == 1)
         {
            ModelManager.bag.canUse = canUse;
            Utils.print("背包可用数  ",canUse);
         }
         else
         {
            Utils.print("背包扩充失败");
         }
      }
      
      public static function GC_BAG_FULL(rs:int) : void
      {
         if(Boolean(rs))
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ff0000\'>" + LangConfig.getWord("542",0) + "</font>");
         }
      }
      
      public static function GC_TIPS_ADD(res:int, cost:int) : void
      {
         if(res == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("549",0));
            UIManager.selfBroadcast.addMsg(LangConfig.getWord("550",0) + String(cost) + LangConfig.getWord("551",0));
         }
         else if(res == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("552",0));
         }
         else if(res == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("553",0));
         }
         else if(res == 4)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("554",0));
         }
         else if(res == 5)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("555",0));
         }
         else if(res == 6)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("556",0));
         }
      }
      
      public static function GC_TIPS_RIGHT_DOWN(color:int, res:int) : void
      {
         if(res == 1)
         {
            if(color == 1)
            {
               UIManager.selfBroadcast.addMsg("<font color=\'#000000\'>" + LangConfig.getWord("557",0) + "</font>");
            }
            else if(color == 2)
            {
               UIManager.selfBroadcast.addMsg("<font color=\'#ff0000\'>" + LangConfig.getWord("557",0) + "</font>");
            }
         }
      }
      
      public static function GC_BAG_FULL_TIPS(res:int) : void
      {
         if(Boolean(res))
         {
            getFullTis();
         }
      }
      
      public static function getFullTis() : void
      {
         var point:Point = UIManager.mainMenu.getbagPoint();
         if(!_bmp)
         {
            _bmp = new BagFullTips();
         }
         ComponentUtil.setPropertie(_bmp,{
            "x":point.x + 41,
            "y":point.y - 21
         });
         isValue = true;
         UIManager.selfBroadcast.addMsg("<font color=\'#ff0000\'>" + LangConfig.getWord("542",0) + "</font>");
         fullHandle();
      }
      
      public static function frameHandle(instan:int) : void
      {
         var temNum1:int = CommandManager.get_bag_canUse();
         var temNum2:int = CommandManager.get_bag_used();
         if(temNum1 - temNum2 > 0)
         {
            GameScene.instance.removeFrameCallBack(frameHandle);
            UIManager.mainMenu.removeEffect();
            if(Boolean(_bmp))
            {
               _bmp.remove();
            }
         }
      }
      
      public static function GC_NAIJIU_TISHI(result:int) : void
      {
         if(Boolean(result))
         {
            View_Alert.show(LangConfig.getWord("557",0),View_Alert.OK_CANCAL,mendHandle);
         }
         else
         {
            Utils.print("equip Durable errow");
         }
      }
      
      private static function mendHandle() : void
      {
         BagCGMessage.CG_BAG_FIX();
      }
      
      public static function GC_CZ_END(result:Number, _type:int, _pri:int = 0) : void
      {
         var pan:View_Fashions = null;
         Utils.print("times out faction");
         equipId = result;
         if(_type == 1)
         {
            View_Alert.show(LangConfig.getWord("982",0,_pri),View_Alert.OK_CANCAL,okFunc);
         }
         else if(_type == 2)
         {
            pan = Singleton.getInstance(View_Fashions) as View_Fashions;
            pan.visible = true;
         }
      }
      
      private static function okFunc() : void
      {
         BagCGMessage.CG_SZ_RENEW(equipId);
      }
      
      public static function GC_SZ_RENEW(result:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("987",0));
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("416",0));
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("9",0));
         }
      }
      
      public static function fullHandle() : void
      {
         if(Boolean(_bmp))
         {
            GameScene.instance.addFrameCallBack(frameHandle);
         }
      }
      
      public static function rePosTips() : void
      {
         var point:Point = null;
         if(Boolean(_bmp))
         {
            point = UIManager.mainMenu.getbagPoint();
            ComponentUtil.setPropertie(_bmp,{
               "x":point.x + 38,
               "y":point.y - 18
            });
         }
      }
      
      public static function GC_BAG_OPEN_GRID_TIPS(gridID:int, seconds:int) : void
      {
         Model_bag.curLeftCDs = seconds * 1000;
         Model_bag.curTime = getTimer();
         UIManager.bagPanel.dataTime = Data_lib.bagOpenGridCD[gridID][0];
         UIManager.bagPanel.curGrid = UIManager.bagPanel.getCloseGridById(gridID);
         if(UIManager.bagPanel.visible && UIManager.bagPanel.page_cur == UIManager.bagPanel.curCDGridPage)
         {
            if(!GameScene.instance.hasFrameCallBack(UIManager.bagPanel.onCDHandler))
            {
               GameScene.instance.addFrameCallBack(UIManager.bagPanel.onCDHandler);
            }
         }
      }
      
      public static function GC_BAG_OPEN_GRID_ON_CD(gridID:int, money:int) : void
      {
         if(Boolean(UIManager.bagPanel) && UIManager.bagPanel.visible)
         {
            UIManager.bagPanel.onOpenGridAlert(gridID,money);
         }
      }
      
      public static function GC_BAG_OPEN_GRID_OPEN(gridID:int, type:int, isSuccess:int = 2) : void
      {
         if(isSuccess == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("20004",11));
         }
         else
         {
            if(Boolean(UIManager.bagPanel.lastGrid) && Boolean(UIManager.bagPanel.lastGrid.vo))
            {
               if(UIManager.bagPanel.lastGrid.vo.gridId == gridID - 1)
               {
                  UIManager.bagPanel.lastGridHandler();
               }
            }
            if(Boolean(UIManager.bagPanel.curGrid) && Boolean(UIManager.bagPanel.curGrid.vo))
            {
               if(UIManager.bagPanel.curGrid.vo.gridId > 174 && type == 2)
               {
                  UIManager.bagPanel.lastGridHandler();
               }
               else if(UIManager.bagPanel.curGrid.vo.gridId == 180 && type == 1)
               {
                  UIManager.bagPanel.lastGridHandler();
               }
            }
         }
      }
      
      public static function GC_BAG_OPEN_GRID_NOT_ON_TIME(gridID:int, leftNum:int, money:int) : void
      {
         if(Boolean(UIManager.bagPanel) && UIManager.bagPanel.visible)
         {
            UIManager.bagPanel.onOpenGridAlert(gridID,money,leftNum);
         }
      }
      
      public static function GC_BAG_PWD_STATE(state:int, days:int) : void
      {
         Model_bag.pwdLockState = state;
         Model_bag.pwdResetLeftDays = days;
         if(days > 0)
         {
            UIManager.bagCancelApply.visible = true;
            UIManager.bagCancelApply.updateDaysInfo();
         }
         if(UIManager.bagPanel.visible)
         {
            UIManager.bagPanel.updateLockState();
         }
         if(FundMter.isShowChongzhiIng)
         {
            FundMter.chongZhiPan.updateMIMA();
         }
         if(UIManager.bagResetPwd.visible)
         {
            UIManager.bagCancelApply.visible = false;
            UIManager.bagResetPwd.visible = false;
         }
      }
      
      public static function GC_BAG_PWD_SET_SUCCESS_STATE_SETTER(isSuccess:int, state:int) : void
      {
         if(Boolean(isSuccess))
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("20005",11));
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("20006",11));
         }
         Model_bag.pwdLockState = state;
         if(UIManager.bagPanel.visible)
         {
            UIManager.bagPanel.updateLockState();
         }
         if(FundMter.isShowChongzhiIng)
         {
            FundMter.chongZhiPan.updateMIMA();
         }
      }
      
      public static function GC_BAG_PWD_SET_SUCCESS_STATE_SETTING(type:int, isSuccess:int, state:int) : void
      {
         if(Boolean(isSuccess))
         {
            if(type == Model_bag.PWD_TYPE_SETTING_0)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("20043",11));
            }
            else if(type == Model_bag.PWD_TYPE_SETTING_1)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("20009",11));
               UIManager.bagModifyPwd.visible = false;
            }
            else if(type == Model_bag.PWD_TYPE_SETTING_2)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("20011",11));
            }
            else if(type == Model_bag.PWD_TYPE_SETTING_3)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("20012",11));
               Model_bag.pwdResetLeftDays = Model_bag.PWD_MAX_RESET_DAYS;
            }
            else if(type == Model_bag.PWD_TYPE_SETTING_4)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("20013",11));
               UIManager.bagCancelApply.visible = false;
               Model_bag.pwdResetLeftDays = 0;
            }
         }
         else if(type == Model_bag.PWD_TYPE_SETTING_0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("20007",11));
         }
         else if(type == Model_bag.PWD_TYPE_SETTING_1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("20008",11));
         }
         else if(type == Model_bag.PWD_TYPE_SETTING_2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("20010",11));
         }
         else if(type != Model_bag.PWD_TYPE_SETTING_3)
         {
            if(type == Model_bag.PWD_TYPE_SETTING_4)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("20010",11));
            }
         }
         Model_bag.pwdLockState = state;
         if(UIManager.bagPanel.visible)
         {
            UIManager.bagPanel.updateLockState();
         }
         if(FundMter.isShowChongzhiIng)
         {
            FundMter.chongZhiPan.updateMIMA();
         }
      }
      
      public static function GC_BAG_PWD_SET_SUCCESS_STATE_LOCK_UP(isSuccess:int, state:int) : void
      {
         if(Boolean(isSuccess))
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("20016",11));
         }
         Model_bag.pwdLockState = state;
         if(UIManager.bagPanel.visible)
         {
            UIManager.bagPanel.updateLockState();
         }
         if(FundMter.isShowChongzhiIng)
         {
            FundMter.chongZhiPan.updateMIMA();
         }
      }
   }
}

