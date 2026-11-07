package com.yiTian.view.modules.gongce
{
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.NewFeedBackHandler;
   import com.yiTian.net.message.cg.BlueDiamondCGMessage;
   import com.yiTian.net.message.cg.JingJiChangCGMessage;
   import com.yiTian.net.message.cg.QifuCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.ChongZhiPaiHang.View_ChongZhiPaiHang_icon;
   import com.yiTian.view.modules.WuLinMiXin.View_WuLinMiXin_MainButton;
   import com.yiTian.view.modules.XianGou.View_XianGou_icon;
   import com.yiTian.view.modules.actions.qifu.QifuPan;
   import com.yiTian.view.modules.activity.View_ThreeTopicAct;
   import com.yiTian.view.modules.fishing.View_FishTipBtn;
   import com.yiTian.view.modules.nationalTreasure.NationalTreasureIconTip;
   import com.yiTian.view.modules.qingMing.ZhuaGuiIconTip;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class gcPanel extends Panel123
   {
      
      private static var _instance:gcPanel;
      
      private var tipStrarr:Array = ["活动期间，玩家充值元宝累计到一定的额度即可领取各种<font color=\'#00ff00\'>回馈礼包</font>奖励","活动期间，在祈福玩法中<font color=\'#00ff00\'>消耗元宝</font>后将获得<font color=\'#00ff00\'>祈福积分</font>，并且可以使用祈福积分在本活动中兑换物品和进行抽奖","活动期间，每小时根据玩家角色的充值元宝计算<font color=\'#00ff00\'>全服排行</font>，活动结束后<font color=\'#00ff00\'>30分钟</font>，全服充值排行榜<font color=\'#00ff00\'>前100名</font>的角色可以得到丰富的奖励","活动期间，打开活动界面可以进行寻宝，宝藏分布广泛，其中不乏各种豪华丰厚的奖励。","活动期间，玩家可以在江湖黑市参与限购<font color=\'#00ff00\'>公测大礼包</font>活动","活动期间，打开竞技场界面将会发现右边新增的<font color=\'#00ff00\'>守关勇士</font>并且在达到条件后可以进行挑战。玩家当前的竞技场排名越靠前，挑战成功后的奖励越丰厚","活动期间，赠送全部玩家<font color=\'#00ff00\'>1次</font>免费的抽奖机会，当充值累计一定元宝即可获得新的转盘的抽奖机会。","活动期间，玩家每天有<font color=\'#00ff00\'>2次</font>免费抽奖机会，可以花费元宝购买次数，花费元宝可以增加<font color=\'#00ff00\'>奖金池的银两</font>，玩家可以抽得奖金池的银两和道具","活动期间，<font color=\'#00ff00\'>40级以上的玩家</font>每天可以在应天府（百鬼道人）处领取<font color=\'#00ff00\'>10次</font>抓鬼任务，并且可以花费一定银两刷新妖魔的品质而获得更高档次的经验","活动期间，玩家在13:00-14:00钓鱼活动中，有几率钓到<font color=\'#00ff00\'>美人鱼</font>获得更多奖励","活动期间，点击查看更多精彩页面活动！多重好礼！更多选择！"];
      
      private var back:ScaleBitmap;
      
      private var bmArr:Array = new Array();
      
      private var bmxArr:Array = [140,197,262,344,442,552,664,747,757,711,635];
      
      private var bmyArr:Array = [408,311,219,140,82,54,71,151,264,368,452];
      
      private var bmUrl:Array = [];
      
      private var tipTargetarr:Array = new Array();
      
      private var canyuSpr:Sprite;
      
      public function gcPanel()
      {
         super();
         regResource("lang/ch/GongCe_Imgs.swf","GongCe_Imgsdm");
      }
      
      public static function get instance() : gcPanel
      {
         if(!_instance)
         {
            _instance = new gcPanel();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":878,
            "height":565
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Back_Img",this,{
            "x":24,
            "y":40
         },Global.GongCe_Imgsdm);
         ComponentUtil.getBitmap("Title_GongCe",this,{
            "x":359,
            "y":5
         },Global.GongCe_Imgsdm);
         ComponentUtil.getBitmap("DianJiCanYu",this,{
            "x":513,
            "y":487
         },Global.GongCe_Imgsdm);
         ComponentUtil.getBitmap("Round",this,{
            "x":140,
            "y":408
         },Global.GongCe_Imgsdm);
         ComponentUtil.getBitmap("Round",this,{
            "x":197,
            "y":311
         },Global.GongCe_Imgsdm);
         ComponentUtil.getBitmap("Round",this,{
            "x":262,
            "y":219
         },Global.GongCe_Imgsdm);
         ComponentUtil.getBitmap("Round",this,{
            "x":344,
            "y":140
         },Global.GongCe_Imgsdm);
         ComponentUtil.getBitmap("Round",this,{
            "x":442,
            "y":82
         },Global.GongCe_Imgsdm);
         ComponentUtil.getBitmap("Round",this,{
            "x":552,
            "y":54
         },Global.GongCe_Imgsdm);
         ComponentUtil.getBitmap("Round",this,{
            "x":664,
            "y":71
         },Global.GongCe_Imgsdm);
         ComponentUtil.getBitmap("Round",this,{
            "x":747,
            "y":151
         },Global.GongCe_Imgsdm);
         ComponentUtil.getBitmap("Round",this,{
            "x":757,
            "y":264
         },Global.GongCe_Imgsdm);
         ComponentUtil.getBitmap("Round",this,{
            "x":711,
            "y":368
         },Global.GongCe_Imgsdm);
         ComponentUtil.getBitmap("Round",this,{
            "x":635,
            "y":452
         },Global.GongCe_Imgsdm);
         this.canyuSpr = new Sprite();
         this.canyuSpr.graphics.beginFill(16711680,0);
         this.canyuSpr.graphics.drawRect(513,487,72,25);
         this.canyuSpr.graphics.endFill();
         this.canyuSpr.buttonMode = true;
         addChild(this.canyuSpr);
         this.canyuSpr.addEventListener(MouseEvent.CLICK,this.canyuClick);
         this.tipTargetarr.length = 11;
         this.bmArr.length = 11;
         var i:int = 0;
         while(i < this.bmArr.length)
         {
            this.bmArr[i] = new Bitmap();
            this.bmArr[i] = Utils.getLoadBitmap("resource/image/gongce/" + "gc" + i + ".png",this.bmArr[i]);
            this.bmArr[i].x = this.bmxArr[i];
            this.bmArr[i].y = this.bmyArr[i];
            addChild(this.bmArr[i]);
            i++;
         }
         var j:int = 0;
         while(j < this.tipTargetarr.length)
         {
            this.tipTargetarr[j] = new Sprite();
            this.tipTargetarr[j].graphics.beginFill(16711680,0);
            this.tipTargetarr[j].graphics.drawRect(this.bmxArr[j],this.bmyArr[j],78,78);
            this.tipTargetarr[j].graphics.endFill();
            (this.tipTargetarr[j] as Sprite).buttonMode = true;
            addChild(this.tipTargetarr[j]);
            j++;
         }
         ComponentUtil.getBitmap("List_11",this,{
            "x":136,
            "y":461
         },Global.GongCe_Imgsdm);
         ComponentUtil.getBitmap("List_01",this,{
            "x":193,
            "y":364
         },Global.GongCe_Imgsdm);
         ComponentUtil.getBitmap("List_02",this,{
            "x":258,
            "y":272
         },Global.GongCe_Imgsdm);
         ComponentUtil.getBitmap("List_03",this,{
            "x":340,
            "y":193
         },Global.GongCe_Imgsdm);
         ComponentUtil.getBitmap("List_04",this,{
            "x":438,
            "y":135
         },Global.GongCe_Imgsdm);
         ComponentUtil.getBitmap("List_05",this,{
            "x":548,
            "y":107
         },Global.GongCe_Imgsdm);
         ComponentUtil.getBitmap("List_06",this,{
            "x":660,
            "y":124
         },Global.GongCe_Imgsdm);
         ComponentUtil.getBitmap("List_07",this,{
            "x":743,
            "y":204
         },Global.GongCe_Imgsdm);
         ComponentUtil.getBitmap("List_08",this,{
            "x":753,
            "y":317
         },Global.GongCe_Imgsdm);
         ComponentUtil.getBitmap("List_09",this,{
            "x":707,
            "y":421
         },Global.GongCe_Imgsdm);
         ComponentUtil.getBitmap("List_10",this,{
            "x":631,
            "y":507
         },Global.GongCe_Imgsdm);
         move = new Rectangle(0,0,this.back.width,35);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":844,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         CloseButton.callBack = this.close;
         this.addtips();
         this.addclick();
      }
      
      private function addtips() : void
      {
         var i:int = 0;
         while(i < this.tipTargetarr.length)
         {
            if(this.tipStrarr[i] != null)
            {
               TipManager.bind(this.tipTargetarr[i],this.tipStrarr[i]);
            }
            i++;
         }
      }
      
      private function addclick() : void
      {
         var i:int = 0;
         while(i < this.tipTargetarr.length)
         {
            (this.tipTargetarr[i] as Sprite).addEventListener(MouseEvent.CLICK,this.itemClick);
            i++;
         }
      }
      
      private function canyuClick(e:MouseEvent) : void
      {
         View_ThreeTopicAct.instance.visible = true;
      }
      
      private function itemClick(e:MouseEvent) : void
      {
         var pan:QifuPan = null;
         switch(e.target)
         {
            case this.tipTargetarr[0]:
               NewFeedBackHandler.openNewFeedBack();
               break;
            case this.tipTargetarr[1]:
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
            case this.tipTargetarr[2]:
               View_ChongZhiPaiHang_icon.instance.onClickHandle();
               break;
            case this.tipTargetarr[3]:
               if(GameUnitManager.hero.level < 30)
               {
                  UIManager.centerBroadcast.addMsg("开启等级30级");
                  return;
               }
               NationalTreasureIconTip.showPanel();
               break;
            case this.tipTargetarr[4]:
               if(GameUnitManager.hero.level < 31)
               {
                  UIManager.centerBroadcast.addMsg("开启等级31级");
                  return;
               }
               View_XianGou_icon.instance.onClickHandle();
               break;
            case this.tipTargetarr[5]:
               if(GameUnitManager.hero.level < 25)
               {
                  UIManager.centerBroadcast.addMsg("开启等级25级");
                  return;
               }
               JingJiChangCGMessage.CG_GET_PAIMING();
               JingJiChangCGMessage.CG_GET_WAR_INFO();
               UIManager.jjc_panel.visible = !UIManager.jjc_panel.visible;
               break;
            case this.tipTargetarr[6]:
               BlueDiamondCGMessage.CG_REQUEST_INITDATA();
               break;
            case this.tipTargetarr[7]:
               if(GameUnitManager.hero.level < 30)
               {
                  UIManager.centerBroadcast.addMsg("开启等级30级");
                  return;
               }
               View_WuLinMiXin_MainButton.instance.onClickHandle();
               break;
            case this.tipTargetarr[8]:
               if(GameUnitManager.hero.level < 40)
               {
                  UIManager.centerBroadcast.addMsg("开启等级40级");
                  return;
               }
               ZhuaGuiIconTip.showAlert();
               break;
            case this.tipTargetarr[9]:
               if(GameUnitManager.hero.level < 30)
               {
                  UIManager.centerBroadcast.addMsg("开启等级30级");
                  return;
               }
               View_FishTipBtn.instance.clickHandle();
               break;
            case this.tipTargetarr[10]:
               navigateToURL(new URLRequest("http://yi.qq.com/act/a20130415beta/index.htm"),"_blank");
         }
      }
      
      private function close(e:MouseEvent) : void
      {
         visible = false;
      }
      
      public function show() : void
      {
         visible = !visible;
      }
   }
}

