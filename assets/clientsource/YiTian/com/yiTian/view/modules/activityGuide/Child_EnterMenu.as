package com.yiTian.view.modules.activityGuide
{
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BlueDiamondCGMessage;
   import com.yiTian.net.message.cg.DailyActCGMessage;
   import com.yiTian.net.message.cg.JingJiChangCGMessage;
   import com.yiTian.net.message.cg.LeiJiChongZhiCGMessage;
   import com.yiTian.net.message.cg.NewYearCGMessage;
   import com.yiTian.net.message.cg.QifuCGMessage;
   import com.yiTian.net.message.cg.WeiLieCGMessage;
   import com.yiTian.net.message.cg.XiaoFeiTuanGouCGMessage;
   import com.yiTian.net.message.cg.XuYuanShuCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.ChongZhiPaiHang.View_ChongZhiPaiHang_icon;
   import com.yiTian.view.modules.HaiDiXunBao.View_HaiDiXunBao_panel;
   import com.yiTian.view.modules.ShenMaoTanBao.View_ShenMaoTanBao_menu;
   import com.yiTian.view.modules.WuLinMiXin.View_WuLinMiXin_MainButton;
   import com.yiTian.view.modules.XianGou.View_XianGou_icon;
   import com.yiTian.view.modules.XiaoFeiPaiHang.View_XiaoFeiPaiHang_icon;
   import com.yiTian.view.modules.YueBingShangCheng.View_YueBingShangCheng;
   import com.yiTian.view.modules.actions.leijichongzhi.LeiJiChongZhiPan;
   import com.yiTian.view.modules.actions.qifu.QifuPan;
   import com.yiTian.view.modules.baby.babyManager.Model_baby;
   import com.yiTian.view.modules.blueDiamondND.xiaofeiCJ.Model_xiaoFeiCJ;
   import com.yiTian.view.modules.canggao.CangGaoPanel;
   import com.yiTian.view.modules.fishing.View_FishTipBtn;
   import com.yiTian.view.modules.hapStone.View_hapStone;
   import com.yiTian.view.modules.juhuasuan.View_JvHuaSuanPanel;
   import com.yiTian.view.modules.meirixg.View_MeiRiXianGou;
   import com.yiTian.view.modules.nationalTreasure.NationalTreasureIconTip;
   import com.yiTian.view.modules.newRechargeFeedback.View_NewRechargeFeedback;
   import com.yiTian.view.modules.qingMing.ZhuaGuiIconTip;
   import com.yiTian.view.modules.treasureBowl.View_treasureBowl;
   import com.yiTian.view.modules.treeDownCL.TreeIcon;
   import com.yiTian.view.modules.xiaozhao.View_XiaoZhao;
   import com.yiTian.view.modules.xuyuanshu.View_XuYuanShuPanel;
   import com.yiTian.view.modules.yellowDiamond.BaoshiQYTips;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class Child_EnterMenu extends Sprite
   {
      
      private var twoBgIcon:Bitmap;
      
      private var twoIcon:Bitmap;
      
      private var twoTitleIcon:ScaleBitmap;
      
      private var icon:Bitmap = new Bitmap();
      
      private var txt:MyTextField;
      
      private var activityName:String;
      
      public function Child_EnterMenu()
      {
         var sprite:Sprite = null;
         super();
         this.twoBgIcon = ComponentUtil.getBitmap("Round_Back",this,{
            "x":90,
            "y":48
         },Global.WuYue_Imgsdm);
         this.twoIcon = ComponentUtil.getBitmap("Round",this,{
            "x":178,
            "y":57
         },Global.WuYue_Imgsdm);
         this.twoTitleIcon = ComponentUtil.getScaleBitmap("Back_TitleBule",[5,5,2,2],this,{
            "x":5,
            "y":5,
            "width":440,
            "height":30
         },Global.Img_Cdm);
         this.txt = ComponentUtil.getTextField("活动名称",this,{
            "x":189,
            "y":9,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.twoIcon.visible = false;
         sprite = new Sprite();
         addChild(sprite);
         sprite.addChild(this.icon);
         this.icon.x = 184;
         this.icon.y = 62;
         sprite.buttonMode = true;
         sprite.addEventListener(MouseEvent.CLICK,this.onClick);
         sprite.addEventListener(MouseEvent.MOUSE_OUT,this.onOut);
         sprite.addEventListener(MouseEvent.MOUSE_OVER,this.onOver);
      }
      
      public static function get instance() : Child_EnterMenu
      {
         return Singleton.getInstance(Child_EnterMenu);
      }
      
      public function update(name:String, id:int, iconStr:String) : void
      {
         this.activityName = name;
         this.txt.htmlText = name;
         var str:String = "resource/image/activityGuide/" + iconStr + ".png";
         Utils.getLoadBitmap(str,this.icon);
      }
      
      private function onOver(e:MouseEvent) : void
      {
         this.twoIcon.visible = true;
      }
      
      private function onOut(e:MouseEvent) : void
      {
         this.twoIcon.visible = false;
      }
      
      private function onClick(e:MouseEvent) : void
      {
         var tip:BaoshiQYTips = null;
         var pan:QifuPan = null;
         switch(this.activityName)
         {
            case "全民寻宝":
               if(GameUnitManager.hero.level < 30)
               {
                  UIManager.centerBroadcast.addMsg("开启等级30级");
                  return;
               }
               NationalTreasureIconTip.showPanel();
               break;
            case "限购礼包":
               if(GameUnitManager.hero.level < 31)
               {
                  UIManager.centerBroadcast.addMsg("开启等级31级");
                  return;
               }
               View_XianGou_icon.instance.onClickHandle();
               break;
            case "竞技之王":
               if(GameUnitManager.hero.level < 25)
               {
                  UIManager.centerBroadcast.addMsg("开启等级25级");
                  return;
               }
               JingJiChangCGMessage.CG_GET_PAIMING();
               JingJiChangCGMessage.CG_GET_WAR_INFO();
               UIManager.jjc_panel.visible = !UIManager.jjc_panel.visible;
               break;
            case "武林秘辛":
               if(GameUnitManager.hero.level < 30)
               {
                  UIManager.centerBroadcast.addMsg("开启等级30级");
                  return;
               }
               View_WuLinMiXin_MainButton.instance.onClickHandle();
               break;
            case "宠物主题":
               if(Boolean(UIManager.petPanel.petVO))
               {
                  UIManager.petPanel.visible = true;
                  break;
               }
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10172",1) + "</font>");
               break;
            case "驱散阴魂":
            case "狮子绣球":
               NewYearCGMessage.CG_NIANSHOUDATA();
               break;
            case "中秋砸蛋":
            case "欢乐砸蛋":
            case "国庆砸蛋":
               UIManager.jindanBtn.GoldEggBtnClick();
               break;
            case "秘境藏糕":
               UIManager.canggao.show();
               Global.delegate.dosomething(CangGaoPanel.instance,CangGaoPanel.instance.show);
               break;
            case "宝石情缘":
               tip = Singleton.getInstance(BaoshiQYTips) as BaoshiQYTips;
               tip.visible = true;
               break;
            case "降妖除魔":
               if(GameUnitManager.hero.level < 40)
               {
                  UIManager.centerBroadcast.addMsg("开启等级40级");
                  return;
               }
               ZhuaGuiIconTip.showAlert();
               break;
            case "聚宝盆":
               if(!UIManager.treasureBowlPanel)
               {
                  UIManager.treasureBowlPanel = new View_treasureBowl();
                  UIManager.treasureBowlPanel.init();
               }
               UIManager.treasureBowlPanel.visible = !UIManager.treasureBowlPanel.visible;
               break;
            case "神镖侠侣":
               UIManager.paoBiaoPanel.shenBiaoHandler();
               break;
            case "祈福活动":
               if(GameUnitManager.hero.level < 30)
               {
                  UIManager.centerBroadcast.addMsg("开启等级30级");
                  return;
               }
               QifuCGMessage.CG_OPEN_QIFU_PAN();
               pan = Singleton.getInstance(QifuPan) as QifuPan;
               (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pan,function():void
               {
                  pan.visible = true;
               });
               break;
            case "充值转盘":
               BlueDiamondCGMessage.CG_REQUEST_INITDATA();
               break;
            case "累计充值":
               View_NewRechargeFeedback.instance.visible = true;
               break;
            case "快乐渔翁":
            case "中秋渔翁":
            case "喜庆渔翁":
            case "国庆渔翁":
               if(GameUnitManager.hero.level < 30)
               {
                  UIManager.centerBroadcast.addMsg("开启等级30级");
                  return;
               }
               View_FishTipBtn.instance.clickHandle();
               break;
            case "充值排行":
               View_ChongZhiPaiHang_icon.instance.onClickHandle();
               break;
            case "消费转转":
               BlueDiamondCGMessage.CG_XFCJ_OPENPAN();
               Model_xiaoFeiCJ.cjPan(Model_xiaoFeiCJ.XFSTR).titleUrl = "Title_xiaofei";
               break;
            case "充值转转":
               BlueDiamondCGMessage.CG_ZHUANPAN_OPEN();
               Model_xiaoFeiCJ.cjPan(Model_xiaoFeiCJ.XFZP).titleUrl = Model_xiaoFeiCJ.XFZP;
               break;
            case "幸运充值":
               BlueDiamondCGMessage.CG_XINGYUNCHONGZHI_OPEN();
               Model_xiaoFeiCJ.cjPan(Model_xiaoFeiCJ.XYZH).titleUrl = Model_xiaoFeiCJ.XYZH;
               break;
            case "消费排行":
               View_XiaoFeiPaiHang_icon.instance.onClickHandle();
               break;
            case "狮子绣球":
            case "国庆喜狮":
               NewYearCGMessage.CG_NIANSHOUDATA();
               break;
            case "大树乘凉":
               TreeIcon.showPanel();
               break;
            case "七夕月老":
               GameUnitManager.hero.autoMove(51093,UnitType.NPC);
               break;
            case "水果商店":
               UIManager.fruitShop.visible = true;
               break;
            case "神猫探宝":
               if(GameUnitManager.hero.level < 35)
               {
                  UIManager.centerBroadcast.addMsg("开启等级35级");
                  break;
               }
               Global.delegate.dosomething(View_ShenMaoTanBao_menu.instance,function():void
               {
                  View_ShenMaoTanBao_menu.instance.visible = true;
               });
               break;
            case "月饼商城":
               Global.delegate.dosomething(View_YueBingShangCheng.instance,function():void
               {
                  View_YueBingShangCheng.instance.visible = true;
               });
               break;
            case "元宝转盘":
               UIManager.goldCJ.visible = true;
               break;
            case "中秋紫镖":
            case "国庆紫镖":
            case "光棍紫镖":
            case "紫镖节":
               UIManager.paoBiaoPanel.zhiBiaoHandler();
               break;
            case "中秋勇士":
               if(GameUnitManager.hero.level < 25)
               {
                  UIManager.centerBroadcast.addMsg("开启等级25级");
                  return;
               }
               JingJiChangCGMessage.CG_GET_PAIMING();
               JingJiChangCGMessage.CG_GET_WAR_INFO();
               UIManager.jjc_panel.visible = !UIManager.jjc_panel.visible;
               break;
            case "消费转盘":
               BlueDiamondCGMessage.CG_XFCJ2_OPENPAN();
               Model_xiaoFeiCJ.cjPan(Model_xiaoFeiCJ.XFSTR2).titleUrl = "Title_xiaofei2";
               break;
            case "欢乐钻石":
               Model_baby.show(View_hapStone.instance);
               break;
            case "你冲我送":
               Global.delegate.dosomething(LeiJiChongZhiPan.instance,function():void
               {
                  LeiJiChongZhiPan.instance.visible = true;
                  if(LeiJiChongZhiPan.instance.visible)
                  {
                     LeiJiChongZhiCGMessage.CG_LJCZ_SHOWPANEL();
                  }
               });
               break;
            case "雪人祝福":
               NewYearCGMessage.CG_NIANSHOUDATA();
               break;
            case "小昭嫁妆":
               (Singleton.getInstance(Delegate123) as Delegate123).dosomething(View_XiaoZhao.getInstance(),function():void
               {
                  View_XiaoZhao.getInstance().visible = !View_XiaoZhao.getInstance().visible;
               });
               break;
            case "限时疯抢":
               Global.delegate.dosomething(View_MeiRiXianGou.instance,function():void
               {
                  View_MeiRiXianGou.instance.show();
               });
               break;
            case "海底寻宝":
               Global.delegate.dosomething(View_HaiDiXunBao_panel.instance,function():void
               {
                  DailyActCGMessage.CG_HaiDiXunBao_OPEN();
               });
               break;
            case "聚划算":
               (Singleton.getInstance(Delegate123) as Delegate123).dosomething(View_JvHuaSuanPanel.instance,function():void
               {
                  View_JvHuaSuanPanel.instance.visible = !View_JvHuaSuanPanel.instance.visible;
               });
               break;
            case "超值兑换":
               (Singleton.getInstance(Delegate123) as Delegate123).dosomething(Child_ItemWard.instance,function():void
               {
                  Child_ItemWard.instance.visible = !Child_ItemWard.instance.visible;
               });
               break;
            case "许愿树":
               (Singleton.getInstance(Delegate123) as Delegate123).dosomething(View_XuYuanShuPanel.instance,function():void
               {
                  XuYuanShuCGMessage.CG_XuYuanShu_CLICKICON();
               });
               break;
            case "奇珍异果":
               WeiLieCGMessage.CG_WEILIE_OPEN();
               break;
            case "跨服团购":
               XiaoFeiTuanGouCGMessage.CG_XFTG_OPEN();
               break;
            case "奇珍果树":
               WeiLieCGMessage.CG_PPTREE_OPEN();
         }
      }
   }
}

