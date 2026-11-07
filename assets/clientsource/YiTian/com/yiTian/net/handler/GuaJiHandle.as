package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_GuaJi;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.CountStandTimeManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.view.modules.activity.Model_actDaily;
   import com.yiTian.view.modules.guaji.BitmapBtn;
   import com.yiTian.view.modules.guaji.Manager_acceptshuangXiu;
   import com.yiTian.view.modules.guaji.Model_guajiInfo;
   import com.yiTian.view.modules.guaji.View_gjReplayPanel;
   import com.yiTian.view.modules.guaji.View_gjTipPanel;
   import com.yiTian.view.modules.guaji.View_guajiPanel;
   import com.yiTian.view.modules.guaji.View_wwsxMoveButton;
   import com.yiTian.view.modules.guaji.Vo_GuaJiReplay;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class GuaJiHandle
   {
      
      public static var cancelCallBack:Function;
      
      private static const bitmapDir:String = "resource/image/extralPng/replay.png";
      
      public function GuaJiHandle()
      {
         super();
      }
      
      public static function GC_GUAJI_INFO_CHANGE(isRequestGJ:int, gainExp:int, countTime:int, sxType:int, lqType:int, starTime:int, isVip:int, wawaTime:int, isUseWaWa:int, targetName:String) : void
      {
         var info:Model_guajiInfo = null;
         var gjp2:View_guajiPanel = null;
         info = Model_guajiInfo.getInstance();
         if(Model_guajiInfo.getInstance().sxType != 0 && sxType == 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("21151",2));
         }
         if(isVip == 2 || isVip == 3)
         {
            info.isBaiYinVip = true;
         }
         else
         {
            info.isBaiYinVip = false;
         }
         var gjp:View_guajiPanel = UIManager.guajiPanel;
         gjp.starTime = starTime;
         if(Global.sceneMap == 14401)
         {
            return;
         }
         switch(isRequestGJ)
         {
            case 1:
               gjp.gainExp = 0;
               gjp.timeCount = countTime;
               gjp.expPercent = Enum_GuaJi.SHUANGXIUADDPERCENT[sxType];
               gjp.lingqiPercent = Enum_GuaJi.LINGQIADDPERCENT[lqType];
               GameUnitManager.hero.status = Status.SIT;
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("21152",2));
               UIManager.guajiPanel.visible = true;
               GameScene.uiLayer.setChildIndex(UIManager.guajiPanel,0);
               break;
            case 2:
               gjp2 = UIManager.guajiPanel;
               if(gainExp > 0)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("21153",2,gainExp.toString()));
               }
               gjp.gainExp = gjp2.gainExp + gainExp;
               gjp.timeCount = countTime;
               gjp.expPercent = Enum_GuaJi.SHUANGXIUADDPERCENT[sxType];
               gjp.lingqiPercent = Enum_GuaJi.LINGQIADDPERCENT[lqType];
         }
         info.sxType = sxType;
         if(sxType == 2)
         {
         }
         if(isUseWaWa == 1)
         {
            UIManager.qysxPanel.cb_useWaWa.selected = true;
         }
         else
         {
            UIManager.qysxPanel.cb_useWaWa.selected = false;
         }
         GameUnitManager.hero.lqColor = lqType;
         UIManager.qysxExpInfoPanel.updateView(wawaTime,isRequestGJ);
         info.isClickedWaWaShuangXiu = false;
         info.wawaTime = wawaTime;
         info.lastUpdateWawaTime = getTimer();
         View_wwsxMoveButton.getInstance().update();
         info.currentSXName = targetName;
      }
      
      public static function GC_GET_XINGXINGEXP(xingxingTime:int, gainExp:int) : void
      {
         UIManager.guajiPanel.starTime = xingxingTime;
         if(gainExp > 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("21154",2,gainExp.toString()));
         }
      }
      
      public static function GC_GUAJI_CANCEL(result:int) : void
      {
         var info:Model_guajiInfo = null;
         info = Model_guajiInfo.getInstance();
         CountStandTimeManager.reset();
         GameUnitManager.hero.status = Status.NOMAL;
         UIManager.guajiPanel.visible = false;
         UIManager.qysxExpInfoPanel.visible = false;
         UIManager.qysxPanel.visible = false;
         UIManager.lqqdPlayerInfoPanel.visible = false;
         GameUnitManager.hero.lqColor = 0;
         info.sxType = 0;
         View_wwsxMoveButton.getInstance().update();
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("21155",2));
         if(cancelCallBack != null)
         {
            cancelCallBack();
         }
         cancelCallBack = null;
      }
      
      public static function GC_LQQD_INFO(lqType1:int, array1:Array, lqType2:int, array2:Array, lqType3:int, array3:Array, refreshViewFlag:int) : void
      {
         var templqTypeArr:Array = [lqType1,lqType2,lqType3];
         var templqArr:Array = [array1,array2,array3];
         Model_guajiInfo.getInstance().resetlqData();
         var index:int = 0;
         while(index < templqTypeArr.length)
         {
            switch(templqTypeArr[index])
            {
               case 1:
                  Model_guajiInfo.getInstance().ziChenRoomInfo = templqArr[index];
                  break;
               case 2:
                  Model_guajiInfo.getInstance().lanChenRoomInfo = templqArr[index];
                  break;
               case 3:
                  Model_guajiInfo.getInstance().lvChenRoomInfo = templqArr[index];
            }
            index++;
         }
         UIManager.guajiPanel.btnEnabled = true;
         UIManager.lqqdPlayerInfoPanel.updateView(UIManager.lqqdPlayerInfoPanel.currentIndex,UIManager.lqqdPlayerInfoPanel.currentType);
         if(refreshViewFlag == 2)
         {
            UIManager.lqqdPlayerInfoPanel.refreshTipShow();
         }
         else if(!UIManager.lqqdPlayerInfoPanel.visible)
         {
            UIManager.lqqdPlayerInfoPanel.visible = true;
         }
      }
      
      public static function GC_SNATCH_LQROOM(battleId:int, roleId:int, name:String, lqType:int, type:int, selfZF:int, targetZF:int, units:Array, steps:Array, isWin:int, roundStartMap:Object) : void
      {
         var vo:Vo_GuaJiReplay = new Vo_GuaJiReplay();
         vo.battleId = battleId;
         vo.unitId = roleId;
         vo.opponentName = name;
         vo.lqType = lqType;
         vo.type = type;
         vo.selfZF = selfZF;
         vo.targetZF = targetZF;
         vo.units = units;
         vo.steps = steps;
         vo.isWin = isWin;
         vo.isReplay = true;
         vo.roundStartMap = roundStartMap;
         var tip:BitmapBtn = new BitmapBtn();
         tip.init();
         tip.extraObject = vo;
         tip.setBgDir(bitmapDir);
         tip.clickCallBack = replayClickCB;
         UIManager.tipBtnContainer.addItem(tip);
      }
      
      private static function replayClickCB(evt:MouseEvent) : void
      {
         var target:BitmapBtn = null;
         target = evt.target as BitmapBtn;
         var viewIns:View_gjReplayPanel = UIManager.gjReplay;
         viewIns.vo = target.extraObject as Vo_GuaJiReplay;
         viewIns.visible = true;
         UIManager.tipBtnContainer.removeItem(target);
         target.dispose();
      }
      
      public static function GC_SNATCH_COLLDOWN(type:int, coolTime:int) : void
      {
         var remain:int = 60 - coolTime;
         switch(type)
         {
            case 1:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("21156",2,remain.toString()));
               break;
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("21157",2,remain.toString()));
         }
      }
      
      public static function GC_SHUANGXIU_INFO(array:Array) : void
      {
         Model_guajiInfo.getInstance().qysxData = array;
         UIManager.qysxPanel.show(1);
      }
      
      public static function GC_SHUANGXIU_REQUEST_RE(obj:Object) : void
      {
         Manager_acceptshuangXiu.getInstance().addInfo(obj);
      }
      
      public static function GC_QYSX_REQUEST_RESYLT(result:int) : void
      {
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("21158",2));
               UIManager.qysxPanel.lastTime = getTimer();
         }
      }
      
      public static function GC_SHUANGXIU_REQUEST_CHOOSE_RE(choose:int, name:String) : void
      {
         var id:int = 21158 + choose;
         var str:String = LangConfig.getWord(id.toString(),2,name);
         switch(choose)
         {
            case 1:
               Model_guajiInfo.getInstance().currentSXName = name;
               break;
            case 2:
               Model_guajiInfo.getInstance().currentSXName = "";
               break;
            case 3:
               Model_guajiInfo.getInstance().currentSXName = "";
               break;
            default:
               str = "";
               Model_guajiInfo.getInstance().currentSXName = "";
         }
         UIManager.centerBroadcast.addMsg(str);
      }
      
      public static function GC_GUAJIEXPADDTIP(exp:int) : void
      {
         var str:String = null;
         if(exp > 0)
         {
            str = LangConfig.getWord("21164",2,exp.toString());
            UIManager.centerBroadcast.addMsg(str);
            UIManager.selfBroadcast.addMsg(str);
         }
      }
      
      public static function GC_WAWATIME(countTime:int) : void
      {
         if(Boolean(countTime))
         {
            View_wwsxMoveButton.getInstance().visible = true;
            UIManager.heroHead.addBuff(View_wwsxMoveButton.getInstance());
         }
         Model_guajiInfo.getInstance().wawaTime = countTime;
         Model_guajiInfo.getInstance().lastUpdateWawaTime = getTimer();
         View_wwsxMoveButton.getInstance().update();
         View_wwsxMoveButton.getInstance().isUseFilters = View_wwsxMoveButton.getInstance().isUseFilters;
      }
      
      private static function ADD_GJ_TIP() : void
      {
         Model_actDaily.getInstance().updateAct(6,true);
         UIManager.smallMap.addTip(0);
      }
      
      public static function GC_5XGUAJITIMEON(isStart:Boolean = false) : void
      {
         var bmBtn:BitmapBtn = Model_guajiInfo.getInstance().tipBtn;
         if(!bmBtn)
         {
            bmBtn = new BitmapBtn();
            bmBtn.init(4,4,46,46);
            bmBtn.setBgDir("resource/image/myPath/gjTip.png");
            bmBtn.buttonMode = true;
            UIManager.mainUiBtnContainer.addBTN(bmBtn);
            bmBtn.clickCallBack = function(evt:MouseEvent):void
            {
               var pnl:View_gjTipPanel = UIManager.gjTipPanel;
               if(!pnl.visible)
               {
                  pnl.show();
               }
               else
               {
                  pnl.hide();
               }
            };
            Model_guajiInfo.getInstance().tipBtn = bmBtn;
         }
         if(isStart)
         {
            if(!bmBtn.extraObject)
            {
               bmBtn.extraObject = EffectManager.addEffect("35343",bmBtn,1000,32,29,true);
            }
            ADD_GJ_TIP();
         }
         else
         {
            if(Boolean(bmBtn.extraObject))
            {
               EffectManager.removeEffect(bmBtn.extraObject as Effect);
            }
            bmBtn.extraObject = null;
         }
      }
      
      public static function GC_5XGUAJITIMEOFF() : void
      {
         var bmBtn:BitmapBtn = Model_guajiInfo.getInstance().tipBtn;
         if(Boolean(bmBtn))
         {
            if(Boolean(bmBtn.extraObject))
            {
               EffectManager.removeEffect(bmBtn.extraObject as Effect);
            }
            bmBtn.extraObject = null;
            UIManager.mainUiBtnContainer.removeBTN(bmBtn);
            bmBtn.buttonMode = false;
            bmBtn.dispose();
            Model_guajiInfo.getInstance().tipBtn = null;
         }
         Model_actDaily.getInstance().updateAct(6,false);
      }
      
      public static function GC_GJDINFO(type:int, remainTime:int) : void
      {
         Model_guajiInfo.getInstance().updateGJDBuff(type,remainTime);
         Model_guajiInfo.getInstance().gjdLastupdateTime = getTimer();
         Model_guajiInfo.getInstance().upGJDBuffFilters();
      }
   }
}

