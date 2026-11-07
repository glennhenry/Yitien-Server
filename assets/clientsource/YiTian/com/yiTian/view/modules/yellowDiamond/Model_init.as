package com.yiTian.view.modules.yellowDiamond
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.BagHandler;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.modules.Card.View_card_panel;
   import com.yiTian.view.modules.DAU.Model_DAU;
   import com.yiTian.view.modules.QT.View_qtPanel;
   import com.yiTian.view.modules.YiAiZhiMing.YiAiZhiMing;
   import com.yiTian.view.modules.actions.DLxiaxin.TipbtnXiaxin;
   import com.yiTian.view.modules.actions.beCahua.TipBtnBeCahua;
   import com.yiTian.view.modules.actions.beauty_draft.Icon_beautyDraft;
   import com.yiTian.view.modules.actions.fimMovies.FilMoviewTip;
   import com.yiTian.view.modules.actions.frids.NewFriendTip;
   import com.yiTian.view.modules.actions.guoqingkuanghuan.GuoqingkuanghuanTip;
   import com.yiTian.view.modules.actions.jiJin.fundShop.FundShoConfig;
   import com.yiTian.view.modules.actions.jianghumiling.JhmlTip;
   import com.yiTian.view.modules.actions.newAct_0508.IconTip;
   import com.yiTian.view.modules.actions.qtAction_0620.QtIcon;
   import com.yiTian.view.modules.actions.quweizhongqiu.QuweizhongqiuTip;
   import com.yiTian.view.modules.actions.sheNianLibao.SheNianGiftTip;
   import com.yiTian.view.modules.actions.shizhuangtoupiao.ShiZhuangTouPiaoTip;
   import com.yiTian.view.modules.actions.teachersDay.TeachersDayTip;
   import com.yiTian.view.modules.actions.the_champion.Icon_theChampion;
   import com.yiTian.view.modules.actions.weiXin.weiXTip;
   import com.yiTian.view.modules.actions.xsHaoli.XSHaoLiTip;
   import com.yiTian.view.modules.activityGuide.WuYueTip;
   import com.yiTian.view.modules.aixin.AiXinBtn;
   import com.yiTian.view.modules.blueDiamondFuLi.View_BlueDiamondFuLi_icon;
   import com.yiTian.view.modules.boatChall.BoatManager;
   import com.yiTian.view.modules.changxiang.ChangXiangBtn;
   import com.yiTian.view.modules.chatM.ChatPanM;
   import com.yiTian.view.modules.gongcehuodong.View_GongCeHuoDongIcon;
   import com.yiTian.view.modules.horse.HorseUtil;
   import com.yiTian.view.modules.newYear.Config_NewYear;
   import com.yiTian.view.modules.olympic.View_OlympicPanel;
   import com.yiTian.view.modules.qingMing.QingMIconTip;
   import com.yiTian.view.modules.qingrenjie.Icon_QRJ;
   import com.yiTian.view.modules.qplus.ViewQplusShare;
   import com.yiTian.view.modules.shenBing.ShenBingUtil;
   import com.yiTian.view.modules.wuXing.WuxingIconTip;
   import com.yiTian.view.modules.yellowDiamond.newAct.XinPianSDTip;
   import com.yiTian.view.modules.yellowDiamond.yellowDiaShengYan.YellowDiaShengYanBtn;
   import com.yiTian.view.modules.zhuanZhi.ZhuanZhiUtil;
   import flash.external.ExternalInterface;
   import flash.utils.clearTimeout;
   import flash.utils.setInterval;
   import flash.utils.setTimeout;
   
   public class Model_init
   {
      
      public static var isChangeEff:Boolean = true;
      
      public static var isUseNewChat:Boolean = false;
      
      public function Model_init()
      {
         super();
      }
      
      public static function init() : void
      {
         var fes:Boolean;
         var curTime:int = 0;
         var date:Date = null;
         var clearId:int = 0;
         var removeIcon:Function = null;
         var onLevelUp:Function = null;
         if(Global.pf == Enum_SPStr.GUANWANG)
         {
            if(Global.huiYuanLibao)
            {
               HuiYuanLibao.instance.showTip();
            }
         }
         if(Global.pf == Enum_SPStr.QQGAME)
         {
            if(Global.QQGameIcon)
            {
               QQgameLibao.instance.showTip();
            }
            if(Global.sheNianGfTipCtr)
            {
               SheNianGiftTip.instance.show();
            }
         }
         if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isIwan(Global.pf))
         {
            if(Global.merriIcon)
            {
            }
            if(Global.huangZAct)
            {
               View_OlympicPanel.instance.showOlym();
            }
         }
         if(Global.twoEggs)
         {
            TwoEggsTip.instance.show();
         }
         if(Global.pf == Enum_SPStr.QQGAME || Global.pf == Enum_SPStr.QQ3366 || Global.pf == Enum_SPStr.QZONE || Global.pf == Enum_SPStr.PENGYOU)
         {
            if(Global.baoshiQingYuan)
            {
               BaoshiQingYuanTip.instance.show();
            }
         }
         if(Global.pf == Enum_SPStr.GUANWANG || Global.pf == Enum_SPStr.QQ3366)
         {
            IconHide.instance.show();
         }
         if(Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isUnion(Global.pf))
         {
            if(Global.huiYuanIconCtrl)
            {
               if(!HuiyuanGiftTip.huiYuanSign)
               {
                  if(Global.pf == Enum_SPStr.GUANWANG)
                  {
                     return;
                  }
               }
               HuiyuanGiftTip.instance.show();
            }
         }
         XinPianSDTip.instance.show();
         ZhuanZhiUtil.init();
         Config_NewYear.init();
         if(Model_init.isUseNewChat)
         {
            ChatPanM.instance.addMes(1,HtmlUtil.font(LangConfig.getWord("847",0) + "\n" + LangConfig.getWord("848",0) + "\n" + LangConfig.getWord("849",0) + "\n" + LangConfig.getWord("850",0) + "\n","#fe0000"),null,true);
         }
         else
         {
            UIManager.chatPanel.jlmAddMsg(HtmlUtil.font(LangConfig.getWord("847",0) + "\n" + LangConfig.getWord("848",0) + "\n" + LangConfig.getWord("849",0) + "\n" + LangConfig.getWord("850",0) + "\n","#fe0000"));
         }
         FundShoConfig.init();
         HorseUtil.init();
         WuxingIconTip.show();
         QingMIconTip.showTip();
         FilMoviewTip.showTip();
         if(Global.activityGuide == true)
         {
            WuYueTip.showTip();
         }
         if(Global.WabIconCtrl)
         {
            IconTip.showTip();
         }
         if(Global.JiangHuMiLing)
         {
            JhmlTip.showTip();
         }
         if(Global.JiaoShiJieZhuFu)
         {
            TeachersDayTip.showTip();
         }
         if(Global.QuWeiZhongQiu)
         {
            QuweizhongqiuTip.showTip();
         }
         if(Global.GuoQingKuangHuan)
         {
            GuoqingkuanghuanTip.showTip();
         }
         if(Global.ShiZhuangTouPiao)
         {
            ShiZhuangTouPiaoTip.showTip();
         }
         if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QQ3366 || Global.pf == Enum_SPStr.QQGAME || Enum_SPStr.isIwan(Global.pf) || Global.pf == Enum_SPStr.QQJIA || Global.pf == Enum_SPStr.QZONE || Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isUnion(Global.pf))
         {
            Model_txAction.instance.showYellowBtn();
         }
         UIManager.qplusShare = new ViewQplusShare();
         UIManager.qplusShare.init();
         if(Global.AiXin)
         {
            AiXinBtn.show();
         }
         if(Global.changxiang)
         {
            ChangXiangBtn.show();
         }
         if(Global.xianShiGiftCtrl)
         {
            XSHaoLiTip.showTip();
         }
         if(Global.WXIconCtrl)
         {
            weiXTip.showTip();
         }
         if(Global.QTIconCtrl)
         {
            QtIcon.showTip();
         }
         if(Global.DLXiaXin)
         {
            TipbtnXiaxin.show();
         }
         if(Global.BeCaHua)
         {
            TipBtnBeCahua.show();
         }
         if(Global.QT && GameUnitManager.hero.level > 54)
         {
            View_qtPanel.instance.showBtn();
         }
         if(Global.LZFuLi)
         {
            if(Global.pf == "qqgame")
            {
               removeIcon = function():void
               {
                  clearTimeout(clearId);
                  UIManager.mainUiBtnContainer.removeBTN(View_BlueDiamondFuLi_icon.instance);
               };
               date = new Date();
               clearId = 0;
               if(GameUnitManager.hero.level >= 25)
               {
                  curTime = date.getTime();
                  UIManager.mainUiBtnContainer.addBTN(View_BlueDiamondFuLi_icon.instance);
                  clearId = int(setTimeout(removeIcon,1000 * 60 * 60));
               }
               else
               {
                  onLevelUp = function():void
                  {
                     if(GameUnitManager.hero.level >= 25)
                     {
                        curTime = date.getTime();
                        clearId = setTimeout(removeIcon,1000 * 60 * 60);
                        Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP_2,onLevelUp);
                        UIManager.mainUiBtnContainer.addBTN(View_BlueDiamondFuLi_icon.instance);
                     }
                  };
                  Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP_2,onLevelUp);
               }
            }
         }
         NewFriendTip.showTip();
         ShenBingUtil.init();
         if(Global.pf == Enum_SPStr.QQGAME && Global.DAUCtrl)
         {
            Model_DAU.init();
         }
         if(Global.fcmBoolean == true)
         {
            ExternalInterface.call("fcm","");
         }
         if(Global.YiAiZhiMing)
         {
            com.yiTian.view.modules.YiAiZhiMing.YiAiZhiMing.ShowIcon();
         }
         if(Global.HZShengYan && (Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE))
         {
            YellowDiaShengYanBtn.show();
         }
         if(Global.theBeautyIcon)
         {
            Icon_beautyDraft.show();
         }
         if(Global.theChampionIcon)
         {
            Icon_theChampion.show();
         }
         fes = Global.festivalActs;
         if(Global.festivalActs)
         {
            View_GongCeHuoDongIcon.instance.addIcon();
         }
         if(Global.qingrenjieActs)
         {
            Icon_QRJ.instance.init();
         }
         View_card_panel.instance.showIcon();
         ActionsCtrl.init();
         ExternalInterface.addCallback("openShoppingMall",UIManager.mainMenu.shoppingMallHandle);
         BoatManager.init();
      }
      
      public static function reposition() : void
      {
         BagHandler.rePosTips();
      }
      
      public static function fcmChecking() : void
      {
         var t:uint = 15 * 60 * 1000;
         var setTimes:uint = setInterval(function():void
         {
            ExternalInterface.call("fcm","");
         },t);
      }
   }
}

