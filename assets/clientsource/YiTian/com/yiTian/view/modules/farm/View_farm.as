package com.yiTian.view.modules.farm
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.model.Model_farm;
   import com.yiTian.data.vo.Vo_farm_farmer;
   import com.yiTian.data.vo.Vo_farm_land;
   import com.yiTian.data.vo.Vo_farm_master;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.FarmGuideManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.FarmHandler;
   import com.yiTian.net.message.cg.FarmCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.mainUIBtnContainer.Enum_mainUIBtn_hide;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class View_farm extends Panel
   {
      
      public var treasureChest:Sprite;
      
      private var seedbg:Bitmap;
      
      private var _farmerbg:Bitmap;
      
      public var _lands:Vector.<View_farm_land>;
      
      public var _farmMaster:View_farm_master;
      
      private var _farmInfo:Farm_info;
      
      public var _farmerList:Vector.<View_farm_farmer>;
      
      public var _seedList:Vector.<View_Grid>;
      
      public var _seedPage:uint = 1;
      
      private var _seedPrePage:Button;
      
      private var _seedNextPage:Button;
      
      private var _myFarmBtn:Button;
      
      private var _helpBtn:Button;
      
      private var _onekeyPickBtn:Button;
      
      private var _onekeyStealBtn:Button;
      
      private var _onekeywaterBtn:Button;
      
      private var _loadingTxt:MyTextField;
      
      private var _loadingEffect:Effect;
      
      private var isLoadCom:Boolean;
      
      private var _title:Bitmap;
      
      public function View_farm()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":899,
            "height":560
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":850,
            "height":500
         },Global.Img_Cdm);
         move = new Rectangle(0,0,841,36);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":865,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_FUBEN,this.onEnterSceneOk);
         this._loadingTxt = ComponentUtil.getTextField(LangConfig.getWord("186",9),this,{
            "x":410,
            "y":242,
            "realWidth":200
         });
         this._loadingEffect = EffectManager.addEffect("gridloading",this,500,460,275,true);
      }
      
      private function onEnterSceneOk(sid:uint) : void
      {
         var type:uint = uint(SceneConfig.getSceneType());
         if(type == SceneConfig.KUNLUN)
         {
            if(visible)
            {
               this.visible = false;
            }
         }
         else if(type == SceneConfig.BZ_BATTLE)
         {
            if(visible)
            {
               this.visible = false;
            }
         }
         else if(type == SceneConfig.BZ_READY)
         {
            if(visible)
            {
               this.visible = false;
            }
         }
         else if(type == SceneConfig.KFBZ_BATTLE)
         {
            if(visible)
            {
               this.visible = false;
            }
         }
      }
      
      public function update(id:Number) : void
      {
         if(Model_farm.isInitFarm)
         {
            this.clearFarm();
         }
         if(Model_farm.isMine(id))
         {
            FarmGuideManager.instance.show();
         }
         else
         {
            FarmGuideManager.instance.hide();
         }
         if(Model_farm.isMine(id))
         {
            this.hideOrShowSth();
            if(Boolean(Model_farm.instace.seeds))
            {
               FarmCGMessage.gc_farm_data_seed();
            }
            if(Model_farm.instace.masterBasic_mine.id > 0)
            {
               this.updateBasic(id);
               this.updateFarmMaster(id);
               this.updateLand(id);
               this.updateFarmer(id);
               FarmHandler.updateOneKeyBtn(id);
               return;
            }
            FarmCGMessage.cg_get_farm_data(GameUnitManager.hero.id);
         }
         else
         {
            this.hideOrShowSth();
            FarmCGMessage.cg_get_farm_data(id);
         }
      }
      
      private function hideOrShowSth() : void
      {
         var grid:View_Grid = null;
         var i:int = 0;
         if(!Model_farm.isInitFarm)
         {
            return;
         }
         if(Model_farm.isMine(Model_farm.currentFarmId))
         {
            TipManager.bind(this.treasureChest,LangConfig.getWord("1",9));
            this._farmInfo.logBtn.visible = true;
            this._myFarmBtn.visible = false;
            this.seedbg.visible = true;
            this._seedPrePage.visible = true;
            this._seedNextPage.visible = true;
            this.treasureChest.buttonMode = true;
            for each(grid in this._seedList)
            {
               grid.visible = true;
            }
         }
         else
         {
            TipManager.unBind(this.treasureChest);
            i = 0;
            while(i < this._lands.length)
            {
               TipManager.unBind(this._lands[i]);
               i++;
            }
            this._farmInfo.mouseEnabled = false;
            this._myFarmBtn.visible = true;
            this._farmInfo.logBtn.visible = false;
            this.seedbg.visible = false;
            this._seedPrePage.visible = false;
            this._seedNextPage.visible = false;
            this.treasureChest.buttonMode = false;
            for each(grid in this._seedList)
            {
               grid.visible = false;
            }
         }
      }
      
      private function clearFarm() : void
      {
         var i:uint = 0;
         var land:View_farm_land = null;
         this._farmMaster.uqdate(null);
         this._farmInfo.update(null);
         while(i < this._farmerList.length)
         {
            this._farmerList[i].uqdate(null);
            this._farmerList[i].visible = false;
            i++;
         }
         this._farmerbg.visible = false;
         for each(land in this._lands)
         {
            land.update(null,0);
         }
      }
      
      public function updateBasic(id:Number) : void
      {
         if(id != Model_farm.currentFarmId)
         {
            return;
         }
         this.initFarm();
         this.updateFarmMaster(id);
      }
      
      public function updateFarmer(id:Number) : void
      {
         var farmer:Vo_farm_farmer = null;
         var vo:Vo_farm_farmer = null;
         var i:uint = 0;
         if(id != Model_farm.currentFarmId)
         {
            return;
         }
         var farmerList:Dictionary = Model_farm.isMine(id) ? Model_farm.instace.farmerList_mine : Model_farm.instace.farmerList_other;
         var _loc6_:int = 0;
         var _loc7_:* = farmerList;
         for each(vo in _loc7_)
         {
            this._farmerbg.visible = true;
         }
         i = 0;
         while(i < this._farmerList.length)
         {
            farmer = farmerList[i + 1];
            this._farmerList[i].uqdate(farmer);
            if(this._farmerbg.visible)
            {
               this._farmerList[i].visible = true;
            }
            i++;
         }
      }
      
      public function updateFarmMaster(id:Number) : void
      {
         if(id != Model_farm.currentFarmId)
         {
            return;
         }
         this.initFarm();
         var vo:Vo_farm_master = Model_farm.isMine(id) ? Model_farm.instace.masterBasic_mine : Model_farm.instace.masterBasic_other;
         this._farmMaster.uqdate(vo);
         this._farmInfo.update(vo);
      }
      
      public function updateFarmInfo(id:uint) : void
      {
         if(id != Model_farm.currentFarmId)
         {
            return;
         }
         var vo:Vo_farm_master = Model_farm.isMine(id) ? Model_farm.instace.masterBasic_mine : Model_farm.instace.masterBasic_other;
         this._farmInfo.update(vo);
      }
      
      private function countEmptyField() : int
      {
         var i:Vo_farm_land = null;
         var count:int = 0;
         for each(i in Model_farm.instace.landList_mine)
         {
            if(i.status == 0)
            {
               count++;
            }
         }
         return count;
      }
      
      public function updateLand(id:Number) : void
      {
         if(id != Model_farm.currentFarmId)
         {
            return;
         }
         this.initFarm();
         var list:Vector.<Vo_farm_land> = Model_farm.isMine(id) ? Model_farm.instace.landList_mine : Model_farm.instace.landList_other;
         var i:uint = 0;
         while(i < this._lands.length)
         {
            if(i < list.length)
            {
               this._lands[i].update(list[i],id);
            }
            else
            {
               this._lands[i].update(null,id);
            }
            i++;
         }
         ViewFarmIcon.instance.showTime(this.countEmptyField());
         Global.control.sendNotification(Enum_mainUIBtn_hide.SET_COUNT,[Enum_mainUIBtn_hide.WuLinShanZhuang,this.countEmptyField()]);
      }
      
      public function updateLandByPosition(pos:uint, id:Number) : void
      {
         if(id != Model_farm.currentFarmId)
         {
            return;
         }
         var vo:Vo_farm_land = Model_farm.isMine(id) ? Model_farm.instace.landList_mine[pos - 1] : Model_farm.instace.landList_other[pos - 1];
         this._lands[pos - 1].update(vo,id);
         ViewFarmIcon.instance.showTime(this.countEmptyField());
         Global.control.sendNotification(Enum_mainUIBtn_hide.SET_COUNT,[Enum_mainUIBtn_hide.WuLinShanZhuang,this.countEmptyField()]);
      }
      
      public function updateFarmerBuffer(pos:uint) : void
      {
         if(!Model_farm.isMine(Model_farm.currentFarmId))
         {
            return;
         }
         this.getFarmerByPos(pos).updateBufferShowHide();
      }
      
      public function updateFarmerBufferTime() : void
      {
         var farmer:View_farm_farmer = null;
         for each(farmer in this._farmerList)
         {
            if(Boolean(farmer))
            {
               farmer.updateBufferTime();
            }
         }
      }
      
      public function getLandByPos(pos:uint) : View_farm_land
      {
         return this._lands[pos - 1];
      }
      
      public function getFarmerByPos(pos:uint) : View_farm_farmer
      {
         return this._farmerList[pos - 1];
      }
      
      public function updateFarmerByPosition(pos:uint, id:Number) : void
      {
         if(id != Model_farm.currentFarmId)
         {
            return;
         }
         var vo:Vo_farm_farmer = Model_farm.isMine(id) ? Model_farm.instace.farmerList_mine[pos] : Model_farm.instace.farmerList_other[pos];
         this._farmerList[pos - 1].uqdate(vo);
      }
      
      public function updateSeed() : void
      {
         this.initFarm();
         var list:Vector.<Vo_item> = Model_farm.instace.getSeedItems(this._seedPage);
         var i:uint = 0;
         while(i < this._seedList.length)
         {
            if(Boolean(list) && i < list.length)
            {
               this._seedList[i].vo = list[i];
            }
            else
            {
               this._seedList[i].vo = null;
            }
            i++;
         }
      }
      
      private function createFarm() : void
      {
         var xx:Number = NaN;
         var yy:Number = NaN;
         var i:uint = 0;
         var seed:View_Grid = null;
         var farmer:View_farm_farmer = null;
         var land:View_farm_land = null;
         ComponentUtil.getBitmap("BG",this,{
            "x":24,
            "y":40
         },Global.ShanZhuang_Imgsdm);
         this._farmMaster = new View_farm_master();
         this.addChild(this._farmMaster);
         this._farmMaster.x = 50;
         this._farmMaster.y = 50;
         this._farmInfo = new Farm_info();
         this.addChild(this._farmInfo);
         this._farmInfo.x = 200;
         this._farmInfo.y = 168 - 130;
         this._farmerbg = ComponentUtil.getBitmap("Back_Farmer",this,{
            "x":290,
            "y":32
         },Global.ShanZhuang_Imgsdm);
         this._farmerList = new Vector.<View_farm_farmer>();
         xx = 404;
         yy = 52;
         i = 0;
         while(i < Model_farm.farmerMaxCount)
         {
            farmer = new View_farm_farmer();
            farmer.x = xx;
            farmer.y = yy;
            farmer.position = i + 1;
            this.addChild(farmer);
            farmer.visible = false;
            this._farmerList.push(farmer);
            i++;
         }
         this._farmerList[0].x = 404;
         this._farmerList[1].x = 404 + 122;
         this._farmerList[2].x = 404 + 122 + 121;
         this._farmerList[3].x = 404 + 122 + 121 + 118;
         if(!this._lands)
         {
            this._lands = new Vector.<View_farm_land>();
            i = 0;
            while(i < Model_farm.land_count)
            {
               land = new View_farm_land();
               land.type = Model_farm.land_type_close;
               land.index = i;
               this.addChild(land);
               this._lands.push(land);
               if(i % 3 == 0)
               {
                  xx = 339 + i / 3 * (140 / 2 + 8);
                  yy = 215 + i / 3 * (80 / 2);
               }
               else
               {
                  xx -= 140 / 2 + 10;
                  yy += 80 / 2 + 5;
               }
               land.x = xx;
               land.y = yy;
               i++;
            }
         }
         this.treasureChest = new Sprite();
         addChild(this.treasureChest);
         this.treasureChest.x = 49;
         this.treasureChest.y = 399;
         ComponentUtil.getBitmap("Gold_Box",this.treasureChest,{
            "x":0,
            "y":0
         },Global.ShanZhuang_Imgsdm);
         this.treasureChest.addEventListener(MouseEvent.CLICK,this.onClickTreasureChest);
         this.treasureChest.addEventListener(MouseEvent.MOUSE_OVER,this.onOverTreasureChest);
         this.treasureChest.addEventListener(MouseEvent.MOUSE_OUT,this.onOutTreasureChest);
         this._farmerbg.visible = false;
         this.seedbg = new Bitmap();
         this.addChild(this.seedbg);
         this.seedbg.bitmapData = ComponentUtil.getBitmapData("Back_YuLan",Global.ShanZhuang_Imgsdm);
         this.seedbg.x = 283;
         this.seedbg.y = 466 + 16;
         this._seedPrePage = ComponentUtil.getButton("","Button_FishPageUp",this,{
            "x":298,
            "y":481 + 13,
            "textColor":16184781
         },Global.ShanZhuang_Imgsdm);
         this._seedPrePage.addEventListener(MouseEvent.CLICK,this.onClickSeedPrePage);
         this._seedNextPage = ComponentUtil.getButton("","Button_FishPageDown",this,{
            "x":573,
            "y":481 + 13,
            "textColor":16184781
         },Global.ShanZhuang_Imgsdm);
         this._seedNextPage.addEventListener(MouseEvent.CLICK,this.onClickSeedNextPage);
         this._myFarmBtn = ComponentUtil.getButton("","Button_WDShanZhuang",this,{
            "x":723,
            "y":473,
            "textColor":16184781
         },Global.ShanZhuang_Imgsdm);
         this._myFarmBtn.addEventListener(MouseEvent.CLICK,this.onClickMyFarmBtn);
         this._helpBtn = ComponentUtil.getButton("","Button_Quest",this,{
            "x":837,
            "y":6
         },Global.Img_Cdm);
         this._helpBtn.addEventListener(MouseEvent.CLICK,this.onClickOtherFarmBtn);
         TipManager.bind(this._helpBtn,LangConfig.getWord("3",9));
         this._seedList = new Vector.<View_Grid>();
         xx = this.seedbg.x + 36 + 3;
         yy = this.seedbg.y + 17;
         i = 0;
         while(i < Model_farm.seedBarCellCount)
         {
            seed = new View_Grid();
            seed.type = Enum_type_grid.farm_seed_grid;
            seed.set_tf_count();
            seed.set_bmp_bg();
            seed.set_bmp_over();
            this._seedList.push(seed);
            this.addChild(seed);
            seed.x = xx;
            seed.y = yy;
            xx += 42;
            seed.addEventListener(MouseEvent.CLICK,this.onClickSeed);
            i++;
         }
         if(!UIManager.farmFriendList)
         {
            UIManager.farmFriendList = new View_farm_list();
            this.addChild(UIManager.farmFriendList);
            UIManager.farmFriendList.visible = true;
            UIManager.farmFriendList.x = 697;
            UIManager.farmFriendList.y = 157;
         }
      }
      
      private function addOneKeyBtn() : void
      {
         this._onekeyPickBtn = ComponentUtil.getButton("一键收获","Button_Get",this,{
            "x":216,
            "y":56
         },Global.ShanZhuang_Imgsdm);
         this._onekeyPickBtn.addEventListener(MouseEvent.CLICK,this.onclickOnekeyPickBtn);
         this._onekeyStealBtn = ComponentUtil.getButton("一键偷取","Button_Steal",this,{
            "x":216,
            "y":86
         },Global.ShanZhuang_Imgsdm);
         this._onekeyStealBtn.addEventListener(MouseEvent.CLICK,this.onclickOnekeyStealBtn);
         this._onekeywaterBtn = ComponentUtil.getButton("一键浇水","Button_Water",this,{
            "x":216,
            "y":116
         },Global.ShanZhuang_Imgsdm);
         this._onekeywaterBtn.addEventListener(MouseEvent.CLICK,this.onclickOnekeyWaterBtn);
         TipManager.bind(this._onekeyPickBtn,"普通玩家每天一次免费机会。VIP玩家无限使用。");
         TipManager.bind(this._onekeyStealBtn,"每天一次免费机会，武魂玩家额外使用一次。");
         TipManager.bind(this._onekeywaterBtn,"每天一次免费机会，武魂玩家额外使用一次。");
      }
      
      private function onclickOnekeyPickBtn(evt:MouseEvent) : void
      {
         FarmCGMessage.cg_farm_onekey(1,GameUnitManager.hero.id,0);
      }
      
      private function onclickOnekeyStealBtn(evt:MouseEvent) : void
      {
         FarmCGMessage.cg_farm_onekey(3,GameUnitManager.hero.id,Model_farm.currentFarmId);
      }
      
      private function onclickOnekeyWaterBtn(evt:MouseEvent) : void
      {
         FarmCGMessage.cg_farm_onekey(2,GameUnitManager.hero.id,Model_farm.currentFarmId);
      }
      
      private function onClickSeed(evt:MouseEvent) : void
      {
         FarmGuideManager.instance.nextStep(6);
         var target:View_Grid = evt.currentTarget as View_Grid;
         if(target.vo == null)
         {
            return;
         }
         FarmHandler.setMouseType(Model_farm.mouse_type_seed);
         if(Boolean(FarmHandler.seedMouse))
         {
            FarmHandler.seedMouse.bitmapData = null;
         }
         Model_farm.instace.seedIdOnMouse = target.vo.id;
         Model_farm.instace.seedMouseBitmapData = target.get_icon_BitmapData();
      }
      
      private function onClickSeedPrePage(evt:MouseEvent) : void
      {
         if(this._seedPage <= 1)
         {
            return;
         }
         --this._seedPage;
         this.updateSeed();
      }
      
      private function onClickSeedNextPage(evt:MouseEvent) : void
      {
         var list:Vector.<Vo_item> = Model_farm.instace.getSeedItems(this._seedPage + 1);
         if(!list)
         {
            return;
         }
         ++this._seedPage;
         this.updateSeed();
      }
      
      private function onClickListBtn(evt:MouseEvent) : void
      {
         if(!UIManager.farmFriendList)
         {
            UIManager.farmFriendList = new View_farm_list();
            this.addChild(UIManager.farmFriendList);
            UIManager.farmFriendList.visible = true;
            UIManager.farmFriendList.x = 550;
            UIManager.farmFriendList.y = 200;
         }
      }
      
      private function onClickMyFarmBtn(evt:MouseEvent) : void
      {
         Model_farm.currentFarmId = GameUnitManager.hero.id;
         this.update(Model_farm.currentFarmId);
      }
      
      private function onClickOtherFarmBtn(evt:MouseEvent) : void
      {
         FarmHandler.openHelp();
      }
      
      private function setSeedVisible(value:Boolean) : void
      {
         this.seedbg.visible = value;
         var i:uint = 0;
         while(i < this._seedList.length)
         {
            this._seedList[i].visible = value;
            i++;
         }
      }
      
      private function onClickFarmInfo(evt:MouseEvent) : void
      {
         if(Model_farm.isMine(Model_farm.currentFarmId))
         {
            FarmHandler.openLog();
         }
      }
      
      private function onClickTreasureChest(evt:MouseEvent) : void
      {
         if(Model_farm.isMine(Model_farm.currentFarmId) == false)
         {
            return;
         }
         if(!UIManager.treasureChest)
         {
            UIManager.treasureChest = new View_treasureChest();
            UIManager.treasureChest.init();
         }
         UIManager.treasureChest.visible = true;
      }
      
      private function onOverTreasureChest(evt:MouseEvent) : void
      {
         if(Model_farm.isMine(Model_farm.currentFarmId) == false)
         {
            return;
         }
         this.treasureChest.filters = Util.glowFFFF00;
      }
      
      private function onOutTreasureChest(evt:MouseEvent) : void
      {
         this.treasureChest.filters = null;
      }
      
      public function updateFruitTime() : void
      {
         var land:View_farm_land = null;
         for each(land in this._lands)
         {
            land.updateMatureTime();
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!this.isLoadCom)
            {
               this.isLoadCom = true;
               this._title = new Bitmap();
               Utils.loadTitle("lang/ch/ShanZhuang_Imgs.swf","TxtWLShanZhuang",this._title,{
                  "x":370,
                  "y":5
               },this,this.onLoadCom);
            }
            else
            {
               if(Model_farm.isLoadFarm)
               {
                  FarmHandler.updateFarm(GameUnitManager.hero.id);
               }
               this.checkGuide();
            }
         }
      }
      
      private function onLoadCom() : void
      {
         Model_farm.isLoadFarm = true;
         Global.ShanZhuang_Imgsdm = Utils.swfPool["lang/ch/ShanZhuang_Imgs.swf"];
         Model_farm.currentFarmId = GameUnitManager.hero.id;
         this.update(Model_farm.currentFarmId);
      }
      
      private function initEvent() : void
      {
         this.addEventListener(MouseEvent.ROLL_OVER,this.onOverThis);
         this.addEventListener(MouseEvent.ROLL_OUT,this.onOutThis);
      }
      
      private function onOutThis(evt:MouseEvent) : void
      {
         trace("onOut");
         if(Model_farm.instace.mouseType == Model_farm.mouse_type_seed)
         {
            FarmHandler.setMouseType(Model_farm.mouse_type_none);
         }
      }
      
      private function onOverThis(evt:MouseEvent) : void
      {
         trace("onOver");
         if(Model_farm.instace.mouseType == Model_farm.mouse_type_seed)
         {
            FarmHandler.setMouseType(Model_farm.mouse_type_none);
         }
      }
      
      public function hideLandBtnByPosition(pos:uint) : void
      {
         this._lands[pos - 1].hideBtn();
      }
      
      public function hideFarmerBtnByPosition(pos:uint) : void
      {
         this._farmerList[pos - 1].hideBtn();
      }
      
      public function showBtnByPosition(pos:uint) : void
      {
         this._lands[pos - 1].showBtn();
      }
      
      public function updateToolPosition() : void
      {
         var land:View_farm_land = null;
         for each(land in this._lands)
         {
            if(Boolean(land.vo))
            {
               land.updateToolTip();
            }
         }
      }
      
      private function initFarm() : void
      {
         if(!Model_farm.isInitFarm)
         {
            Model_farm.isInitFarm = true;
            this.createFarm();
            this.initEvent();
            this.hideOrShowSth();
            EffectManager.removeEffect(this._loadingEffect);
            this.checkGuide();
         }
      }
      
      public function checkGuide() : void
      {
         if(!Model_farm.isMine(Model_farm.currentFarmId))
         {
            return;
         }
         if(Model_farm.instace.guide_plant_flag)
         {
            if(!UIManager.farmPlantGuide)
            {
               UIManager.farmPlantGuide = new View_farm_plant_guide();
               UIManager.farmPlantGuide.init();
            }
            UIManager.farmPlantGuide.visible = true;
         }
         else if(Model_farm.instace.guide_farmer_flag)
         {
            if(Model_farm.isMine(Model_farm.currentFarmId))
            {
               if(!UIManager.farmFarmerGuide)
               {
                  UIManager.farmFarmerGuide = new View_farm_farmer_guide();
                  UIManager.farmFarmerGuide.init();
               }
               UIManager.farmFarmerGuide.visible = true;
            }
         }
      }
      
      public function showHideOneKeyBtn(status:uint, id:Number) : void
      {
         if(id != Model_farm.currentFarmId)
         {
            return;
         }
         this.hideAllOneKey();
         if(status == 1)
         {
            this._onekeyPickBtn.enabled = true;
         }
         else if(status == 2)
         {
            this._onekeywaterBtn.enabled = true;
         }
         else if(status == 3)
         {
            this._onekeyStealBtn.enabled = true;
         }
      }
      
      public function hideAllOneKey() : void
      {
         this._onekeyPickBtn.enabled = false;
         this._onekeyStealBtn.enabled = false;
         this._onekeywaterBtn.enabled = false;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.width) / 2;
         y = (Global.stage.stageHeight - this.height) / 2;
      }
   }
}

