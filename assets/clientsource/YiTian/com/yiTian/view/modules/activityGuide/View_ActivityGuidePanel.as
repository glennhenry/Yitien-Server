package com.yiTian.view.modules.activityGuide
{
   import com.ui.constants.ScrollAutoType;
   import com.ui.containers.Canvas;
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.data.model.Model_bag;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.ActivityCGMessage;
   import com.yiTian.net.message.cg.DailyActCGMessage;
   import com.yiTian.net.message.cg.WingCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.MiJingCangZong.View_MiJingCangZong_menu;
   import com.yiTian.view.modules.YueBingShangCheng.View_YueBingShangCheng;
   import com.yiTian.view.modules.cast.baishiZengyi.View_baoshiZY;
   import com.yiTian.view.modules.cast.baishiZengyi.Vo_baoshiZY;
   import com.yiTian.view.modules.chat.EffecObj;
   import com.yiTian.view.modules.horse.HorseUtil;
   import com.yiTian.view.modules.horse.View_horsePanel;
   import com.yiTian.view.modules.loading.View_loading;
   import com.yiTian.view.modules.pet.JingXiuPanel;
   import com.yiTian.view.modules.pet.PetPanel;
   import com.yiTian.view.modules.shenBing.ShenBingUtil;
   import com.yiTian.view.modules.wing.View_wing_menu;
   import com.yiTian.view.modules.wuXing.WuxingIconTip;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   
   public class View_ActivityGuidePanel extends Panel
   {
      
      protected static var canvas:Canvas;
      
      private var bg:DisplayObject;
      
      private var titleBg:DisplayObject;
      
      private var tbtn_now:TabButton;
      
      private var itemVec:Vector.<Child_ActivityGuide> = new Vector.<Child_ActivityGuide>();
      
      private var vec_tbtn:Vector.<TabButton> = new Vector.<TabButton>();
      
      private var txtTitle:MyTextField;
      
      private var txtDes:MyTextField;
      
      private var txtTime:MyTextField;
      
      private var washIcon:Bitmap;
      
      private var washButton:Button;
      
      private var menuItem:Child_EnterMenu;
      
      private var jiangliItem:Child_jiangliItem;
      
      private var shopMenu:Child_shopMenu;
      
      public var consumeRwardItem:Child_ConsumeReward;
      
      private var nowVo:ActivityGuideVo;
      
      private var child_ItemWard:Child_ItemWard;
      
      private var specilItem:Child_SpecilItem;
      
      private var inited:Boolean;
      
      private var tempIndex:int = -1;
      
      private var _awardDes:MyTextField;
      
      public function View_ActivityGuidePanel()
      {
         super();
      }
      
      public static function get instance() : View_ActivityGuidePanel
      {
         return Singleton.getInstance(View_ActivityGuidePanel);
      }
      
      override protected function initStaticView() : void
      {
         this.bg = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":2,
            "y":0,
            "width":648,
            "height":485
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":24,
            "y":40,
            "width":600,
            "height":435
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this,{
            "x":164,
            "y":50,
            "width":450,
            "height":200
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this,{
            "x":34,
            "y":50,
            "width":125,
            "height":415
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this,{
            "x":164,
            "y":255,
            "width":450,
            "height":210
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this.bg.width,38);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":this.bg.width - 28,
            "y":6,
            "textColor":16184781,
            "callBack":this.hide
         },Global.Img_Cdm);
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
         canvas = new Canvas(115,410);
         canvas.x = 39;
         canvas.y = 55;
         addChild(canvas);
         canvas.scrollAutoType = ScrollAutoType.REMAIN;
         this.txtDes = ComponentUtil.getTextField("活动期间可以在全民寻宝地图内通过挖宝要是对地图进行挖掘，可获得坐骑碎片。",this,{
            "x":190,
            "y":170,
            "color":13424242,
            "size":12,
            "leading":0
         });
         this.txtDes.realWidth = 388;
         this.txtDes.multiline = true;
         this.txtDes.wordWrap = true;
         this.txtDes.mouseEnabled = true;
         this.txtDes.addEventListener(TextEvent.LINK,this.onLink);
         this.txtTime = ComponentUtil.getTextField("2013年05月10日 - 2013年05月13日",this,{
            "x":190,
            "y":214,
            "color":13424242,
            "size":12,
            "leading":0
         });
         Model_ActivityGuide.setActivityData();
         Model_ActivityGuide.setActivityVoData();
         this.createBtn();
         this._awardDes = ComponentUtil.getTextField("",this,{
            "x":190,
            "y":230,
            "color":13424242,
            "size":12,
            "leading":0
         });
      }
      
      private function initT() : void
      {
         this.updateBtn();
         this.titleBg = ComponentUtil.getBitmap("Title_QiYue",this,{
            "x":244,
            "y":5
         },Global.WuYue_Imgsdm);
         ComponentUtil.getBitmap("JuanZhou",this,{
            "x":174,
            "y":55
         },Global.WuYue_Imgsdm);
         this.jiangliItem = new Child_jiangliItem();
         this.jiangliItem.x = 164;
         this.jiangliItem.y = 255;
         addChild(this.jiangliItem);
         this.txtTitle = ComponentUtil.getTextField("全民寻宝  稀有碎片齐相随",this,{
            "x":288,
            "y":88,
            "color":16777011,
            "size":24,
            "leading":0
         });
         this.txtTitle.realWidth = 400;
         this.txtTitle.wordWrap = true;
         this.txtTitle.autoSize = TextFieldAutoSize.CENTER;
         this.menuItem = new Child_EnterMenu();
         this.menuItem.x = 164;
         this.menuItem.y = 255;
         addChild(this.menuItem);
         this.menuItem.visible = false;
         this.shopMenu = new Child_shopMenu();
         this.shopMenu.x = 164;
         this.shopMenu.y = 255;
         addChild(this.shopMenu);
         this.shopMenu.visible = false;
         this.washButton = ComponentUtil.getButton("我要洗满星","Button_RedFour",this,{
            "x":516,
            "y":210,
            "textColor":16184781,
            "callBack":this.wash
         },Global.Img_Cdm);
         this.washIcon = ComponentUtil.getBitmap("bazhe",this,{
            "x":481 + 21,
            "y":186 + 15,
            "width":30,
            "height":30
         },Global.WuYue_Imgsdm);
         this.checkWashVisible(false);
         this.consumeRwardItem = new Child_ConsumeReward();
         this.consumeRwardItem.x = 164;
         this.consumeRwardItem.y = 255;
         this.consumeRwardItem.visible = false;
         addChild(this.consumeRwardItem);
         this.child_ItemWard = new Child_ItemWard();
         this.child_ItemWard.x = 164;
         this.child_ItemWard.y = 255;
         this.child_ItemWard.visible = false;
         addChild(this.child_ItemWard);
         this.specilItem = new Child_SpecilItem();
         this.specilItem.x = 164;
         this.specilItem.y = 255;
         this.specilItem.visible = false;
         addChild(this.specilItem);
         this.inited = true;
         this.show();
      }
      
      private function createBtn() : void
      {
         var i:int = 0;
         var tbtn:TabButton = null;
         var len:int = int(Model_ActivityGuide.activityVoData.length);
         i = 0;
         while(i < len)
         {
            tbtn = ComponentUtil.getTabButton((Model_ActivityGuide.activityVoData[i] as ActivityGuideVo).name,"ClassButton",canvas,{
               "x":0,
               "y":2 + i * 37,
               "textColor":16773818,
               "chooseColor":16773818
            },Global.Img_Cdm);
            tbtn.addEventListener(MouseEvent.CLICK,this.CLICK_TBTN);
            tbtn.tabIndex = i;
            tbtn.textColor = 14155520;
            tbtn.chooseColor = 8437092;
            this.vec_tbtn.push(tbtn);
            i++;
         }
         canvas.reset();
         canvas.align();
      }
      
      private function updateBtn() : void
      {
         var i:int = 0;
         while(i < this.vec_tbtn.length)
         {
            if((Model_ActivityGuide.activityVoData[i] as ActivityGuideVo).isShowHot == 1)
            {
               ComponentUtil.getBitmap("Text_Hot",canvas,{
                  "x":64,
                  "y":0 + i * 37
               },Global.WuYue_Imgsdm);
            }
            else if((Model_ActivityGuide.activityVoData[i] as ActivityGuideVo).isShowHot == 2)
            {
               ComponentUtil.getBitmap("BQ_XYiT",canvas,{
                  "x":64,
                  "y":0 + i * 37
               },Global.WuYue_Imgsdm);
            }
            i++;
         }
      }
      
      public function setBtnEff(id:int, type:int) : void
      {
         var i:int = 0;
         while(i < this.vec_tbtn.length)
         {
            if((Model_ActivityGuide.activityVoData[i] as ActivityGuideVo).id == id)
            {
               if(type == Enum_ActivityGuide.HIGHT_LIGHT)
               {
                  EffecObj.getEffec(this.vec_tbtn[i]);
               }
               else
               {
                  EffecObj.removeEffect(this.vec_tbtn[i]);
               }
            }
            i++;
         }
      }
      
      public function onLink(e:TextEvent) : void
      {
         switch(e.text)
         {
            case "mijing":
               UIManager.special_btn.smsHandle();
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!Global.WuYue_Imgsdm)
            {
               this.load();
            }
            else if(!this.titleBg)
            {
               this.initT();
            }
         }
      }
      
      public function selectedBTN(ss:String) : void
      {
         var i:int = 0;
         while(i < this.vec_tbtn.length)
         {
            if(this.vec_tbtn[i].text == ss)
            {
               View_ActivityGuidePanel.instance.visible = true;
               if(this.inited)
               {
                  this.vec_tbtn[i].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                  canvas.setScrollView(i / (this.vec_tbtn.length - 1));
               }
               else
               {
                  this.tempIndex = i;
               }
               return;
            }
            i++;
         }
      }
      
      private function load() : void
      {
         var arr:Array = [];
         arr.push(["lang/ch/WuYue_Imgs.swf",this.onComplete,LangConfig.getWord("20000",2),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
         View_loading.instance.load(arr,function():void
         {
            View_loading.instance.visible = false;
         });
      }
      
      private function onComplete(info:Object) : void
      {
         Global.WuYue_Imgsdm = info.applicationDomain;
         this.initT();
      }
      
      private function checkWashVisible(value:Boolean) : void
      {
         this.washIcon.visible = value;
         this.washButton.visible = value;
      }
      
      private function wash(e:MouseEvent) : void
      {
         var pnl:View_horsePanel = null;
         var pan:View_baoshiZY = null;
         var pnl2:JingXiuPanel = null;
         switch(this.nowVo.id)
         {
            case Enum_ActivityGuide.WASH_ID:
            case Enum_ActivityGuide.CHENGZHUANG_WASH_ID:
            case Enum_ActivityGuide.STRENGHTEN_ID:
               if(!UIManager.castPanel.visible)
               {
                  UIManager.castPanel.visible = true;
                  this.openPanel();
                  break;
               }
               this.openPanel();
               break;
            case Enum_ActivityGuide.NEIDAN_ID:
            case Enum_ActivityGuide.ChongWuNeiDan2:
               if(Boolean(UIManager.petPanel.petVO))
               {
                  UIManager.petPanel.visible = !UIManager.petPanel.visible;
                  if(UIManager.petPanel.visible)
                  {
                     UIManager.petPanel.openView(PetPanel.NEIDAN,0);
                  }
                  break;
               }
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10172",1) + "</font>");
               break;
            case Enum_ActivityGuide.WUXING_ID:
               WuxingIconTip.cliHd();
               break;
            case Enum_ActivityGuide.HORSE_ID:
               pnl = Singleton.getInstance(View_horsePanel);
               Global.delegate.dosomething(pnl,function():void
               {
                  pnl.show(0);
               });
               break;
            case Enum_ActivityGuide.MiJingCangZong:
               Global.delegate.dosomething(View_MiJingCangZong_menu.instance,function():void
               {
                  View_MiJingCangZong_menu.instance.visible = true;
               });
               break;
            case Enum_ActivityGuide.XIQINGYUWENG_ID:
            case Enum_ActivityGuide.DUANWUZONGZI_ID:
               Global.delegate.dosomething(View_YueBingShangCheng.instance,function():void
               {
                  View_YueBingShangCheng.instance.visible = true;
               });
               break;
            case Enum_ActivityGuide.PET_EQUIP_ID:
               if(Boolean(UIManager.petPanel.petVO))
               {
                  UIManager.petPanel.visible = !UIManager.petPanel.visible;
                  if(UIManager.petPanel.visible)
                  {
                     UIManager.petPanel.openView(PetPanel.ZHUANGBEI,0);
                  }
                  break;
               }
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10172",1) + "</font>");
               break;
            case Enum_ActivityGuide.MeiRiHuiKui:
               UIManager.yuanBaoXiang.visible = !UIManager.yuanBaoXiang.visible;
               break;
            case Enum_ActivityGuide.STONE_ID:
               if(GameUnitManager.hero.level < 40)
               {
                  UIManager.centerBroadcast.addMsg("等级不够");
                  return;
               }
               pan = Singleton.getInstance(View_baoshiZY) as View_baoshiZY;
               pan.visible = true;
               (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pan,function():void
               {
                  pan.updata(Vo_baoshiZY.StoneLvl);
               });
               break;
            case Enum_ActivityGuide.PET_GROW_ID:
               if(Boolean(UIManager.petPanel.petVO))
               {
                  UIManager.petPanel.visible = !UIManager.petPanel.visible;
                  if(UIManager.petPanel.visible)
                  {
                     UIManager.petPanel.openView(PetPanel.LIANHUA,0);
                  }
               }
               else
               {
                  UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10172",1) + "</font>");
               }
            case Enum_ActivityGuide.SHENBING_ID:
               ShenBingUtil.askOpenShenBingPanel();
               break;
            case Enum_ActivityGuide.CHIBANG_GIFT:
            case Enum_ActivityGuide.CHIBANG_ZHUTI:
               if(!View_wing_menu.instance.visible)
               {
                  Global.delegate.dosomething(View_wing_menu.instance,function():void
                  {
                     WingCGMessage.CG_WING_OPEN();
                  });
               }
               break;
            case Enum_ActivityGuide.XINGLEI_GIFT:
               HorseUtil.openHorsePnl();
               break;
            case Enum_ActivityGuide.JINGXIU:
               if(Model_bag.pwdLockState == Model_bag.PWD_STATE_LOCK_T)
               {
                  UIManager.bagPwdPutIn.visible = true;
                  return;
               }
               if(UIManager.petPanel.petVO.hxjx > 0)
               {
                  pnl2 = UIManager.jingxiu;
                  (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pnl2,function():void
                  {
                     pnl2.visible = true;
                  });
                  break;
               }
               UIManager.centerBroadcast.addMsg("您的宠物尚未化形，未开启精修功能！");
         }
      }
      
      private function openPanel() : void
      {
         switch(this.nowVo.id)
         {
            case Enum_ActivityGuide.WASH_ID:
               UIManager.castPanel.openView(Enum_ActivityGuide.OPEN_WASH_PANEL);
               break;
            case Enum_ActivityGuide.CHENGZHUANG_WASH_ID:
               UIManager.castPanel.openView(Enum_ActivityGuide.OPEN_CHENGZHUANG_JINGLIAN_PANEL);
               break;
            case Enum_ActivityGuide.STRENGHTEN_ID:
               UIManager.castPanel.openView(Enum_ActivityGuide.OPEN_STRENGHTEN_PANEL);
         }
      }
      
      private function CLICK_TBTN(e:MouseEvent) : void
      {
         var tbtn:TabButton = e.target as TabButton;
         if(this.tbtn_now != null)
         {
            this.tbtn_now.choose = false;
         }
         tbtn.choose = true;
         this.tbtn_now = tbtn;
         this.nowVo = Model_ActivityGuide.activityVoData[this.tbtn_now.tabIndex] as ActivityGuideVo;
         this.jiangliItem.updateItem(this.nowVo);
         this.setData(this.nowVo);
         this.washButtonSet();
         if(this.nowVo.id == Enum_ActivityGuide.XIAOFEIHUIKUI)
         {
            DailyActCGMessage.CG_XIAOFEIHUIKUI();
         }
         else if(this.nowVo.id == Enum_ActivityGuide.DAOJUDUIHUAN)
         {
            DailyActCGMessage.CG_DAOJUDUIHUAN();
         }
      }
      
      private function washButtonSet() : void
      {
         switch(this.nowVo.id)
         {
            case Enum_ActivityGuide.WASH_ID:
               this.checkWashVisible(true);
               this.washButton.label = "装备洗练";
               DailyActCGMessage.CG_WASH_LEVEL();
               break;
            case Enum_ActivityGuide.CHENGZHUANG_WASH_ID:
               this.washButton.visible = true;
               this.washIcon.visible = false;
               this.washButton.label = "橙装精炼";
               DailyActCGMessage.CG_CHENGZHUANG_WASH_STATUS();
               break;
            case Enum_ActivityGuide.NEIDAN_ID:
               this.washButton.visible = true;
               this.washIcon.visible = false;
               this.washButton.label = "提升宠物内丹";
               DailyActCGMessage.CG_REWARD_STATUS(Enum_ActivityGuide.NEIDAN_REWARD_STATUS);
               break;
            case Enum_ActivityGuide.ChongWuNeiDan2:
               this.washButton.visible = true;
               this.washIcon.visible = false;
               this.washButton.label = "提升宠物内丹";
               DailyActCGMessage.CG_ChongWuNeiDan2_OPEN();
               break;
            case Enum_ActivityGuide.WUXING_ID:
               this.washButton.visible = true;
               this.washIcon.visible = false;
               this.washButton.label = "我要点五行";
               DailyActCGMessage.CG_REWARD_STATUS(Enum_ActivityGuide.WUXING_REWARD_STATUS);
               break;
            case Enum_ActivityGuide.COSTREWARD_ID:
               this.washButton.visible = false;
               this.washIcon.visible = false;
               DailyActCGMessage.CG_ACTIVITY_CONREWARD();
               break;
            case Enum_ActivityGuide.ChongZhiFanLi_ID:
               this.washButton.visible = false;
               this.washIcon.visible = false;
               DailyActCGMessage.CG_ChongZhiFanLi();
               break;
            case Enum_ActivityGuide.HORSE_ID:
               this.washButton.visible = true;
               this.washIcon.visible = false;
               this.washButton.label = "坐骑锻造";
               DailyActCGMessage.CG_HORSE_REWARD();
               break;
            case Enum_ActivityGuide.PET_EQUIP_ID:
               this.washButton.visible = true;
               this.washIcon.visible = false;
               this.washButton.label = "宠物装备";
               if(Boolean(Model_ActivityGuide.petEquipVo))
               {
                  this.updateData(Model_ActivityGuide.petEquipVo);
               }
               break;
            case Enum_ActivityGuide.STRENGHTEN_ID:
               this.washButton.visible = true;
               this.washIcon.visible = false;
               this.washButton.label = "强化装备";
               if(Boolean(Model_ActivityGuide.strengthenVo))
               {
                  this.updateData(Model_ActivityGuide.strengthenVo);
               }
               break;
            case Enum_ActivityGuide.MiJingCangZong:
               this.washButton.visible = true;
               this.washIcon.visible = false;
               this.washButton.label = "粽子商城";
               break;
            case Enum_ActivityGuide.XIQINGYUWENG_ID:
            case Enum_ActivityGuide.DUANWUZONGZI_ID:
               this.washButton.visible = true;
               this.washIcon.visible = false;
               this.washButton.label = "月饼商城";
               break;
            case Enum_ActivityGuide.MeiRiHuiKui:
               this.washButton.visible = true;
               this.washIcon.visible = false;
               this.washButton.label = "充值";
               DailyActCGMessage.CG_MeiRiHuiKui_OPEN();
               break;
            case Enum_ActivityGuide.STONE_ID:
               this.washButton.visible = true;
               this.washIcon.visible = false;
               this.washButton.label = "宝石增益";
               if(Boolean(Model_ActivityGuide.stoneVo))
               {
                  this.updateData(Model_ActivityGuide.stoneVo);
               }
               break;
            case Enum_ActivityGuide.PET_GROW_ID:
               this.washButton.visible = true;
               this.washIcon.visible = false;
               this.washButton.label = "宠物成长";
               DailyActCGMessage.CG_PET_GROW_REWARD();
               break;
            case Enum_ActivityGuide.SHENBING_ID:
               this.washButton.visible = true;
               this.washIcon.visible = false;
               this.washButton.label = "立即淬炼神兵";
               DailyActCGMessage.CG_SHENBING_REWARD();
               break;
            case Enum_ActivityGuide.CHIBANG_ZHUTI:
               this.washButton.visible = true;
               this.washIcon.visible = false;
               this.washButton.label = "翅膀进阶";
               DailyActCGMessage.CG_CHIBANG_OPENWIN();
               break;
            case Enum_ActivityGuide.CHIBANG_GIFT:
               this.washButton.visible = true;
               this.washIcon.visible = false;
               this.washButton.label = "翅膀进阶";
               break;
            case Enum_ActivityGuide.XINGLEI_GIFT:
               this.washButton.visible = true;
               this.washIcon.visible = false;
               this.washButton.label = "星点激活";
               break;
            case Enum_ActivityGuide.ZINVZHUTI:
               this.washButton.visible = false;
               this.washIcon.visible = false;
               break;
            case Enum_ActivityGuide.DENGLUYOULI:
               this.washButton.visible = false;
               this.washIcon.visible = false;
               DailyActCGMessage.CG_DengLuYouLi_OPEN();
               break;
            case Enum_ActivityGuide.YUANBAO:
               this.washButton.visible = false;
               this.washIcon.visible = false;
               this.checkWashVisible(false);
               break;
            case Enum_ActivityGuide.JINGXIU:
               this.washButton.visible = true;
               this.washIcon.visible = false;
               this.washButton.label = "宠物精修";
               ActivityCGMessage.CG_ACTIVITY_CWJX_OPEN();
               break;
            default:
               this.checkWashVisible(false);
         }
      }
      
      private function checkVisible() : void
      {
         if(Boolean(this.nowVo))
         {
            switch(this.nowVo.type)
            {
               case Enum_ActivityGuide.ACTIVITY_ICON:
                  this.specilItem.visible = false;
                  this.menuItem.visible = true;
                  this.jiangliItem.visible = false;
                  this.shopMenu.visible = false;
                  this.consumeRwardItem.visible = false;
                  this.child_ItemWard.visible = false;
                  this.menuItem.update(this.nowVo.name,this.nowVo.id,this.nowVo.icon);
                  break;
               case Enum_ActivityGuide.ACTIVITY_REWARD:
                  this.specilItem.visible = false;
                  this.menuItem.visible = false;
                  this.jiangliItem.visible = true;
                  this.shopMenu.visible = false;
                  this.consumeRwardItem.visible = false;
                  this.child_ItemWard.visible = false;
                  break;
               case Enum_ActivityGuide.ACTIVITY_SHOP:
               case Enum_ActivityGuide.ACTIVITY_MORE_SHOP:
                  this.specilItem.visible = false;
                  this.menuItem.visible = false;
                  this.jiangliItem.visible = false;
                  this.shopMenu.visible = true;
                  this.consumeRwardItem.visible = false;
                  this.child_ItemWard.visible = false;
                  this.shopMenu.update(this.nowVo.name,this.nowVo.shopArr,this.nowVo.type);
                  break;
               case Enum_ActivityGuide.ACTIVITY_COSTREWARD:
                  this.specilItem.visible = false;
                  this.menuItem.visible = false;
                  this.jiangliItem.visible = false;
                  this.shopMenu.visible = false;
                  this.consumeRwardItem.visible = true;
                  this.child_ItemWard.visible = false;
                  break;
               case Enum_ActivityGuide.ACTIVITY_ITEM_REWARD:
                  this.specilItem.visible = false;
                  this.menuItem.visible = false;
                  this.jiangliItem.visible = false;
                  this.shopMenu.visible = false;
                  this.consumeRwardItem.visible = false;
                  this.child_ItemWard.visible = true;
                  break;
               case Enum_ActivityGuide.ACTIVITY_YBSS:
                  this.specilItem.visible = true;
                  this.menuItem.visible = false;
                  this.jiangliItem.visible = false;
                  this.shopMenu.visible = false;
                  this.consumeRwardItem.visible = false;
                  this.child_ItemWard.visible = false;
            }
         }
      }
      
      public function show() : void
      {
         var temp:int = Enum_ActivityGuide.ACTIVITY_FRIST;
         if(this.tempIndex != -1)
         {
            temp = this.tempIndex;
            canvas.setScrollView(temp / (this.vec_tbtn.length - 1));
         }
         if(Boolean(this.vec_tbtn) && Boolean(this.vec_tbtn.length))
         {
            this.tbtn_now = this.vec_tbtn[temp];
            this.tbtn_now.choose = true;
         }
         this.nowVo = Model_ActivityGuide.activityVoData[temp] as ActivityGuideVo;
         this.setData(this.nowVo);
         this.washButtonSet();
         this.tempIndex = -1;
      }
      
      public function setData(nowVo:ActivityGuideVo) : void
      {
         this.jiangliItem.updateItem(nowVo);
         this.txtTitle.htmlText = nowVo.title;
         this.txtDes.htmlText = nowVo.des;
         this.txtTime.htmlText = nowVo.time;
         this.checkVisible();
         this.txtTitle.y = 65 + (92 - this.txtTitle.height) / 2;
         this.txtTitle.x = 186 + (this.txtTitle.width - this.txtTitle.textWidth) / 2;
         if(nowVo.type == Enum_ActivityGuide.ACTIVITY_COSTREWARD)
         {
            this.txtTime.y = 204;
         }
         else
         {
            this.txtTime.y = 214;
         }
         if(nowVo.id == Enum_ActivityGuide.DENGLUYOULI)
         {
            this.txtTime.y = 230;
         }
         if(nowVo.id == Enum_ActivityGuide.JVHUASUAN)
         {
            this._awardDes.htmlText = Data_lib.jvhuasuan[1][6];
         }
         else
         {
            this._awardDes.htmlText = "";
         }
      }
      
      public function getData() : ActivityGuideVo
      {
         return this.nowVo;
      }
      
      public function updateData(vo:ActivityGuideVo) : void
      {
         if(Boolean(this.nowVo))
         {
            if(this.nowVo.id == vo.id)
            {
               this.setData(vo);
            }
         }
      }
      
      public function flyIcon(i:int) : void
      {
         this.jiangliItem.flyIcon(i);
      }
      
      public function flyIcon2(i:int) : void
      {
         if(Boolean(this.child_ItemWard))
         {
            this.child_ItemWard.flyIcon(i);
         }
      }
      
      public function hide(prm:* = null) : void
      {
         this.visible = false;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.width) / 2;
         y = (Global.stage.stageHeight - this.height) / 2;
      }
      
      override public function get height() : Number
      {
         if(!this.bg)
         {
            return super.height;
         }
         return this.bg.height;
      }
      
      override public function get width() : Number
      {
         if(!this.bg)
         {
            return super.width;
         }
         return this.bg.width;
      }
   }
}

