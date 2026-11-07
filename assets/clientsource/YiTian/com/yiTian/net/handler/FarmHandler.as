package com.yiTian.net.handler
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.model.Model_farm;
   import com.yiTian.data.vo.Vo_farmList;
   import com.yiTian.data.vo.Vo_farm_farmer;
   import com.yiTian.data.vo.Vo_farm_land;
   import com.yiTian.data.vo.Vo_farm_master;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.FarmCGMessage;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.farm.ViewFarmIcon;
   import com.yiTian.view.modules.farm.View_arrestList;
   import com.yiTian.view.modules.farm.View_farm_gift_icon;
   import com.yiTian.view.modules.farm.View_farm_help;
   import com.yiTian.view.modules.farm.View_farm_journal;
   import com.yiTian.view.modules.farm.View_farm_tip_panel;
   import com.yiTian.view.modules.farm.View_farm_tool;
   import com.yiTian.view.modules.farm.View_land_rank;
   import com.yiTian.view.modules.farm.View_refresh_fruit;
   import com.yiTian.view.modules.farm.View_seek_help;
   import com.yiTian.view.modules.guaji.BitmapBtn;
   import com.yiTian.view.modules.mainUIBtnContainer.Enum_mainUIBtn_hide;
   import com.yiTian.view.modules.mainUIBtnContainer.View_TipBtnContainer;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class FarmHandler
   {
      
      public static var viewFarmIcon:ViewFarmIcon;
      
      private static var isStart:Boolean;
      
      public static var seedMouse:Bitmap;
      
      public static var pickToolMouse:View_farm_tool;
      
      public static var waterToolMouse:View_farm_tool;
      
      private static var sleepToolMouse:View_farm_tool;
      
      public function FarmHandler()
      {
         super();
      }
      
      public static function start() : void
      {
         if(isStart)
         {
            return;
         }
         isStart = true;
         Global.stage.addEventListener(Event.ENTER_FRAME,onEnterFrame);
         Global.stage.addEventListener(MouseEvent.CLICK,onClickStage);
      }
      
      private static function onClickStage(evt:MouseEvent) : void
      {
         var grid:View_Grid = null;
         var target:DisplayObject = evt.target as DisplayObject;
         if(target.name != Model_farm.farm_master_hot_area)
         {
            if(Boolean(UIManager.farm))
            {
            }
         }
         if(target.name != Model_farm.farm_famer_hot_area)
         {
            if(Boolean(UIManager.farm))
            {
               if(Model_farm.instace.positionOfClickFarmer > 0)
               {
                  Model_farm.instace.positionOfClickFarmer = 0;
               }
            }
         }
         if(Model_farm.instace.mouseType == Model_farm.mouse_type_none)
         {
            if(Model_farm.instace.positionOfClickMyLand > 0 && target.name != Model_farm.farm_land_hot_area)
            {
               UIManager.farm.hideLandBtnByPosition(Model_farm.instace.positionOfClickMyLand);
               Model_farm.instace.positionOfClickMyLand = 0;
            }
            return;
         }
         if(Boolean(target as View_Grid))
         {
            grid = target as View_Grid;
            if(grid.type == Enum_type_grid.farm_seed_grid)
            {
            }
         }
         else if(target.name != Model_farm.farm_land_hot_area)
         {
            FarmHandler.setMouseType(Model_farm.mouse_type_none);
         }
      }
      
      private static function onEnterFrame(evt:Event) : void
      {
         var land:Vo_farm_land = null;
         var now:Number = NaN;
         var time:uint = 0;
         if(Boolean(UIManager.farm))
         {
            UIManager.farm.updateToolPosition();
         }
         var lands:Vector.<Vo_farm_land> = Model_farm.instace.landList_mine;
         if(Boolean(lands) && Boolean(lands.length))
         {
            for each(land in lands)
            {
               if(land.time_left != 0)
               {
                  now = getTimer();
                  time = (now - land.time_pre_system) / 1000;
                  if(land.time_left_from_timer >= time)
                  {
                     land.time_left = land.time_left_from_timer - time;
                  }
                  else
                  {
                     land.time_left = 0;
                  }
                  if(land.time_left == 0)
                  {
                     if(land.status != Vo_farm_land.land_status_none && land.status != Vo_farm_land.land_status_mature)
                     {
                        FarmCGMessage.cg_farm_fruit_mature(Model_farm.instace.masterBasic_mine.id,land.position);
                     }
                  }
               }
            }
         }
         lands = Model_farm.instace.landList_other;
         if(Boolean(lands) && Boolean(lands.length))
         {
            for each(land in lands)
            {
               if(land.time_left != 0)
               {
                  now = getTimer();
                  time = (now - land.time_pre_system) / 1000;
                  if(land.time_left_from_timer >= time)
                  {
                     land.time_left = land.time_left_from_timer - time;
                  }
                  else
                  {
                     land.time_left = 0;
                  }
                  if(land.time_left == 0)
                  {
                     if(land.status != Vo_farm_land.land_status_none && land.status != Vo_farm_land.land_status_mature)
                     {
                        FarmCGMessage.cg_farm_fruit_mature(Model_farm.instace.masterBasic_other.id,land.position);
                     }
                  }
               }
            }
         }
         UIManager.farm.updateFruitTime();
         updateFarmerTime();
         updateFarmerBufferTime();
         updateMasterBeCatchTime();
         if(Model_farm.instace.mouseType == Model_farm.mouse_type_seed)
         {
            if(!seedMouse)
            {
               seedMouse = new Bitmap();
               Global.stage.addChild(seedMouse);
            }
            if(seedMouse.bitmapData == null)
            {
               seedMouse.bitmapData = Model_farm.instace.seedMouseBitmapData;
            }
            seedMouse.x = Global.stage.mouseX - seedMouse.width / 2;
            seedMouse.y = Global.stage.mouseY - seedMouse.height / 2;
         }
         else if(Model_farm.instace.mouseType == Model_farm.mouse_type_water_tool)
         {
            if(!waterToolMouse)
            {
               waterToolMouse = new View_farm_tool();
               waterToolMouse.type = View_farm_tool.type_water;
               waterToolMouse.setBitmapData(ComponentUtil.getBitmapData("waterTool",Global.ShanZhuang_Imgsdm));
               Global.stage.addChild(waterToolMouse);
            }
            else
            {
               waterToolMouse.visible = true;
            }
            waterToolMouse.x = Global.stage.mouseX;
            waterToolMouse.y = Global.stage.mouseY;
            if(Boolean(seedMouse) && Boolean(seedMouse.bitmapData))
            {
               seedMouse.bitmapData = null;
            }
         }
         else if(Model_farm.instace.mouseType == Model_farm.mouse_type_pick_tool)
         {
            if(!pickToolMouse)
            {
               pickToolMouse = new View_farm_tool();
               pickToolMouse.type = View_farm_tool.type_pick;
               pickToolMouse.setBitmapData(ComponentUtil.getBitmapData("Hand",Global.ShanZhuang_Imgsdm));
               Global.stage.addChild(pickToolMouse);
            }
            else
            {
               pickToolMouse.visible = true;
            }
            pickToolMouse.x = Global.stage.mouseX;
            pickToolMouse.y = Global.stage.mouseY;
            if(Boolean(seedMouse) && Boolean(seedMouse.bitmapData))
            {
               seedMouse.bitmapData = null;
            }
         }
         else if(Model_farm.instace.mouseType == Model_farm.mouse_type_sleep)
         {
            if(!sleepToolMouse)
            {
               sleepToolMouse = new View_farm_tool();
               sleepToolMouse.type = View_farm_tool.type_sleep;
               sleepToolMouse.setBitmapData(ComponentUtil.getBitmapData("ChuiZi",Global.ShanZhuang_Imgsdm));
               Global.stage.addChild(sleepToolMouse);
            }
            else
            {
               sleepToolMouse.visible = true;
            }
            sleepToolMouse.x = Global.stage.mouseX;
            sleepToolMouse.y = Global.stage.mouseY;
            if(Boolean(seedMouse) && Boolean(seedMouse.bitmapData))
            {
               seedMouse.bitmapData = null;
            }
         }
         else
         {
            if(Boolean(seedMouse) && Boolean(seedMouse.bitmapData))
            {
               seedMouse.bitmapData = null;
            }
            if(Boolean(pickToolMouse))
            {
               pickToolMouse.visible = false;
               pickToolMouse.stop();
            }
            if(Boolean(waterToolMouse))
            {
               waterToolMouse.visible = false;
               waterToolMouse.stop();
            }
            if(Boolean(sleepToolMouse))
            {
               sleepToolMouse.visible = false;
               sleepToolMouse.stop();
            }
         }
      }
      
      public static function openLandLevelup(pos:uint, level:uint, str:String) : void
      {
         if(!UIManager.land_upgrade)
         {
            UIManager.land_upgrade = new View_land_rank();
            UIManager.land_upgrade.init();
         }
         UIManager.land_upgrade.visible = !UIManager.land_upgrade.visible;
         UIManager.land_upgrade.updata(level,pos,str);
      }
      
      public static function openRefreshFruit(pos:uint, fruitId:uint) : void
      {
         if(!UIManager.refresh_fruit)
         {
            UIManager.refresh_fruit = new View_refresh_fruit();
            UIManager.refresh_fruit.init();
         }
         UIManager.refresh_fruit.visible = !UIManager.refresh_fruit.visible;
         UIManager.refresh_fruit.updata(pos,fruitId);
      }
      
      public static function openLog() : void
      {
         if(!UIManager.farmJournal)
         {
            UIManager.farmJournal = new View_farm_journal();
            UIManager.farmJournal.init();
         }
         UIManager.farmJournal.visible = !UIManager.farmJournal.visible;
      }
      
      public static function setMouseType(type:uint) : void
      {
         Model_farm.instace.mouseType = type;
         if(type == Model_farm.mouse_type_none)
         {
            Mouse.show();
         }
         else
         {
            Mouse.hide();
         }
      }
      
      public static function refreshFarm(id:Number) : void
      {
         Model_farm.currentFarmId = id;
         UIManager.farm.update(id);
      }
      
      public static function updateFarm(id:Number) : void
      {
         Model_farm.currentFarmId = id;
         Model_farm.instace.clearOtherData();
         UIManager.farm.update(id);
      }
      
      public static function addNotice(info:Object) : void
      {
         var tip:BitmapBtn = new BitmapBtn();
         tip.init();
         tip.extraObject = info;
         tip.setBgDir(Model_farm.bitmapDir);
         UIManager.tipBtnContainer.addItem(tip);
         tip.clickCallBack = onClickNotice;
      }
      
      public static function addFarmGiftIcon() : void
      {
         var container:View_TipBtnContainer = UIManager.tipBtnContainer;
         if(!container.hasItem(View_farm_gift_icon.instance))
         {
            UIManager.mainUiBtnContainer.addBTN(View_farm_gift_icon.instance);
         }
      }
      
      public static function removeFarmGiftIcon() : void
      {
         var container:View_TipBtnContainer = UIManager.tipBtnContainer;
         UIManager.mainUiBtnContainer.removeBTN(View_farm_gift_icon.instance);
      }
      
      private static function updateFarmerTime() : void
      {
         var farmer:Vo_farm_farmer = null;
         var now:Number = NaN;
         var time:uint = 0;
         var list:Dictionary = Model_farm.instace.farmerList_mine;
         if(Boolean(list))
         {
            for each(farmer in list)
            {
               if(farmer.time_left != 0)
               {
                  now = getTimer();
                  time = (now - farmer.time_pre_system) / 1000;
                  if(farmer.time_left_from_timer >= time)
                  {
                     farmer.time_left = farmer.time_left_from_timer - time;
                  }
                  else
                  {
                     farmer.time_left = 0;
                  }
                  if(farmer.time_left == 0)
                  {
                     FarmCGMessage.cg_farm_release(Model_farm.instace.masterBasic_mine.id,farmer.id,farmer.position,1);
                  }
               }
            }
         }
         list = Model_farm.instace.farmerList_other;
         if(Boolean(list))
         {
            for each(farmer in list)
            {
               if(farmer.time_left != 0)
               {
                  now = getTimer();
                  time = (now - farmer.time_pre_system) / 1000;
                  if(farmer.time_left_from_timer >= time)
                  {
                     farmer.time_left = farmer.time_left_from_timer - time;
                  }
                  else
                  {
                     farmer.time_left = 0;
                  }
                  if(farmer.time_left == 0)
                  {
                     FarmCGMessage.cg_farm_release(Model_farm.instace.masterBasic_other.id,farmer.id,farmer.position,1);
                  }
               }
            }
         }
      }
      
      private static function updateFarmerBufferTime() : void
      {
         var vo:Vo_farm_farmer = null;
         var now:Number = NaN;
         var time:uint = 0;
         var list:Dictionary = Model_farm.instace.farmerList_mine;
         if(Boolean(list))
         {
            for each(vo in list)
            {
               if(vo.time_buffer_left != 0)
               {
                  now = getTimer();
                  time = (now - vo.time_buffer_pre_sys) / 1000;
                  if(vo.time_buffer_left_from_timer >= time)
                  {
                     vo.time_buffer_left = vo.time_buffer_left_from_timer - time;
                  }
                  else
                  {
                     vo.time_buffer_left = 0;
                     vo.time_buffer_pre_sys = 0;
                     UIManager.farm.updateFarmerBuffer(vo.position);
                  }
               }
            }
            UIManager.farm.updateFarmerBufferTime();
         }
      }
      
      private static function updateMasterBeCatchTime() : void
      {
         var now:Number = NaN;
         var time:uint = 0;
         var vo:Vo_farm_master = Model_farm.instace.masterBasic_mine;
         if(Boolean(vo) && Boolean(vo.captor) && vo.time_left > 0)
         {
            now = getTimer();
            time = (now - vo.time_pre_system) / 1000;
            if(vo.time_left_from_timer >= time)
            {
               vo.time_left = vo.time_left_from_timer - time;
            }
            else
            {
               vo.time_left = 0;
            }
            if(vo.time_left == 0)
            {
               FarmCGMessage.cg_farm_master_request_release(vo.id);
            }
         }
         vo = Model_farm.instace.masterBasic_other;
         if(Boolean(vo) && Boolean(vo.captor) && vo.time_left > 0)
         {
            now = getTimer();
            time = (now - vo.time_pre_system) / 1000;
            if(vo.time_left_from_timer >= time)
            {
               vo.time_left = vo.time_left_from_timer - time;
            }
            else
            {
               vo.time_left = 0;
            }
            if(vo.time_left == 0)
            {
               FarmCGMessage.cg_farm_master_request_release(vo.id);
            }
         }
      }
      
      private static function onClickNotice(evt:MouseEvent) : void
      {
         var panel:View_farm_tip_panel = null;
         panel = View_farm_tip_panel.getInstace();
         panel.visible = true;
         var target:BitmapBtn = evt.target as BitmapBtn;
         panel.update(target.extraObject);
         if(Boolean(target) && UIManager.tipBtnContainer.contains(target))
         {
            UIManager.tipBtnContainer.removeItem(target);
         }
      }
      
      public static function openSeekHelpPanel(enemy_id:Number, enemy_name:String) : void
      {
         if(!UIManager.seekHelp)
         {
            UIManager.seekHelp = new View_seek_help();
            UIManager.seekHelp.init();
         }
         UIManager.seekHelp.visible = !UIManager.seekHelp.visible;
         if(UIManager.seekHelp.visible)
         {
            UIManager.seekHelp.updateMaster(enemy_id,enemy_name);
         }
      }
      
      public static function hideLandBtnByPosition(pos:uint) : void
      {
         if(pos == 0)
         {
            return;
         }
         UIManager.farm.hideLandBtnByPosition(pos);
      }
      
      public static function hideFarmerBtnByPosition(pos:uint) : void
      {
         if(pos == 0)
         {
            return;
         }
         UIManager.farm.hideFarmerBtnByPosition(pos);
      }
      
      public static function friendInto(friendArr:Array = null) : void
      {
         var k:int = 0;
         var obj:Object = null;
         var vo_info:Vo_farmList = null;
         if(!UIManager.farmFriendList)
         {
            return;
         }
         if(Boolean(friendArr))
         {
            k = 0;
            while(k < Model_farm.instace.farm_friend_list.length)
            {
               Model_farm.instace.farm_friend_list[k].visible = false;
               Model_farm.instace.farm_friend_list[k].dispose();
               if(Boolean(Model_farm.instace.farm_friend_list[k].parent))
               {
                  Model_farm.instace.farm_friend_list[k].parent.removeChild(Model_farm.instace.farm_friend_list[k]);
               }
               k++;
            }
            Model_farm.instace.farm_friend_list = [];
            for each(obj in friendArr)
            {
               vo_info = new Vo_farmList();
               vo_info.id = obj[0];
               vo_info.sex = obj[1];
               vo_info.name = obj[2];
               vo_info.status = obj[3];
               vo_info.job = obj[4];
               UIManager.farmFriendList.addItem(vo_info);
            }
         }
         if(UIManager.farmFriendList.isFirstOpen)
         {
            return;
         }
         UIManager.farmFriendList.update(1);
      }
      
      public static function checkFruitMature() : void
      {
         if(!FarmHandler.viewFarmIcon)
         {
            return;
         }
         if(Model_farm.instace.checkFruitMature())
         {
            FarmHandler.viewFarmIcon.addEffect();
            Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.WuLinShanZhuang,-1,1]);
            Global.control.sendNotification(Enum_mainUIBtn_hide.ICON_EFFECT,[Enum_mainUIBtn_hide.WuLinShanZhuang,1]);
         }
         else
         {
            FarmHandler.viewFarmIcon.removeEffect();
            Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.WuLinShanZhuang,-1,0]);
            Global.control.sendNotification(Enum_mainUIBtn_hide.ICON_EFFECT,[Enum_mainUIBtn_hide.WuLinShanZhuang,0]);
         }
      }
      
      public static function updateOneKeyBtn(id:Number) : void
      {
      }
      
      public static function openHelp() : void
      {
         if(!UIManager.farmHelp)
         {
            UIManager.farmHelp = new View_farm_help();
            UIManager.farmHelp.init();
         }
         UIManager.farmHelp.visible = !UIManager.farmHelp.visible;
      }
      
      public static function openDefeatList() : void
      {
         if(!UIManager.farmArrestList)
         {
            UIManager.farmArrestList = new View_arrestList();
            UIManager.farmArrestList.init();
         }
         UIManager.farmArrestList.visible = true;
      }
      
      public function updataBingSilver(bingSilver:int) : void
      {
         if(!UIManager.treasureChest)
         {
            return;
         }
         UIManager.treasureChest.updataBingSilver(bingSilver);
      }
   }
}

