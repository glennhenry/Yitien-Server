package com.yiTian.data.model
{
   import com.yiTian.data.vo.Vo_farmList;
   import com.yiTian.data.vo.Vo_farm_farmer;
   import com.yiTian.data.vo.Vo_farm_land;
   import com.yiTian.data.vo.Vo_farm_master;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.view.modules.farm.Child_farmListItem;
   import flash.display.BitmapData;
   import flash.utils.Dictionary;
   
   public class Model_farm
   {
      
      public static var isLoadFarm:Boolean;
      
      public static var isInitFarm:Boolean;
      
      public static var currentFarmId:Number;
      
      private static var _instace:Model_farm;
      
      public static const bitmapDir:String = "resource/image/extralPng/replay.png";
      
      public static const farm_land_hot_area:String = "farm_land_hot_area";
      
      public static const farm_master_hot_area:String = "farm_master_hot_area";
      
      public static const farm_famer_hot_area:String = "farm_famer_hot_area";
      
      public static const farm_level_mas:uint = 10;
      
      public static const redeem_money:uint = 20;
      
      public static const land_count:uint = 12;
      
      public static const seedBarCellCount:uint = 6;
      
      public static const farmerMaxCount:uint = 4;
      
      public static const land_type_close:uint = 0;
      
      public static const land_type_open:uint = 1;
      
      public static const land_type_expand:uint = 2;
      
      public static const refreshMoney:uint = 20;
      
      public static const keyRefreshMoney:uint = 200;
      
      public static const fruitColor:Array = [16777215,3604224,38655,11337982,16747008];
      
      public static const fruitColor1:Array = ["#ffffff","#04ff00","#33ccff","#ff00ff","#ff7700"];
      
      public static const fruitColor2:Array = ["0xffffff","0x04ff00","0x33ccff","0xff00ff","0xff7700"];
      
      public static const farmer_num_need_farm_level:Vector.<uint> = new <uint>[0,5,10,15,20];
      
      public static const time_need_water:Number = 20 * 60;
      
      public static const waterMaxCount:uint = 200;
      
      public static const time_farmer_need_request_sleep:uint = 60 * 20;
      
      public static const time_farmer_be_catch:uint = 3600 * 24 * 1;
      
      public static const time_farmer_reward_add_catch_possible:uint = 3600 * 3;
      
      public static var friendsPage:uint = 1;
      
      public static var defeatedPage:uint = 1;
      
      public static const mouse_type_none:uint = 0;
      
      public static const mouse_type_seed:uint = 1;
      
      public static const mouse_type_water_tool:uint = 2;
      
      public static const mouse_type_pick_tool:uint = 3;
      
      public static const mouse_type_sleep:uint = 4;
      
      public var masterBasic_mine:Vo_farm_master;
      
      public var farmerList_mine:Dictionary;
      
      public var landList_mine:Vector.<Vo_farm_land>;
      
      public var masterBasic_other:Vo_farm_master;
      
      public var farmerList_other:Dictionary;
      
      public var landList_other:Vector.<Vo_farm_land>;
      
      public var farm_friend_list:Array;
      
      public var farm_defeated_list:Array;
      
      public var farm_journal:Array;
      
      public var catch_click_farmer_pos:uint;
      
      public var seeds:Vector.<Object>;
      
      public var seedMouseBitmapData:BitmapData = null;
      
      public var seedIdOnMouse:int;
      
      public var farmerPositionMouse:uint;
      
      public var positionOfClickMyLand:uint;
      
      public var positionOfClickFarmer:uint;
      
      public var positionOfOverLand:uint;
      
      public var mouseType:uint = 0;
      
      public var guide_plant_flag:Boolean = false;
      
      public var guide_farmer_flag:Boolean = false;
      
      public function Model_farm()
      {
         super();
         this.masterBasic_mine = new Vo_farm_master();
         this.farmerList_mine = new Dictionary();
         this.masterBasic_other = new Vo_farm_master();
         this.farmerList_other = new Dictionary();
         this.farm_friend_list = new Array();
         this.farm_defeated_list = new Array();
         this.farm_journal = new Array();
      }
      
      public static function get instace() : Model_farm
      {
         if(!_instace)
         {
            _instace = new Model_farm();
         }
         return _instace;
      }
      
      public static function isMine(id:Number) : Boolean
      {
         if(id == GameUnitManager.hero.id)
         {
            return true;
         }
         return false;
      }
      
      public function getSeedItems(page:uint) : Vector.<Vo_item>
      {
         var vo:Vo_item = null;
         if(this.seeds.length == 0)
         {
            return null;
         }
         if(this.seeds.length / Model_farm.seedBarCellCount + 1 < page)
         {
            return null;
         }
         var vec:Vector.<Vo_item> = new Vector.<Vo_item>();
         var start:uint = (page - 1) * Model_farm.seedBarCellCount;
         var end:uint = start + Model_farm.seedBarCellCount > this.seeds.length ? this.seeds.length : uint(start + Model_farm.seedBarCellCount);
         var i:uint = start;
         while(i < end)
         {
            vo = new Vo_item();
            vo.id = this.seeds[i].id;
            vo.count = this.seeds[i].num;
            vo.Init_lib();
            vec.push(vo);
            i++;
         }
         return vec;
      }
      
      public function getVoFarmerMine(pos:uint) : Vo_farm_farmer
      {
         return this.farmerList_mine[pos];
      }
      
      public function getVoFarmerOther(pos:uint) : Vo_farm_farmer
      {
         return this.farmerList_other[pos];
      }
      
      public function clearOtherData() : void
      {
         this.masterBasic_other = new Vo_farm_master();
         this.farmerList_other = new Dictionary();
         this.landList_other = new Vector.<Vo_farm_land>();
      }
      
      public function getSeedNum(id:uint) : uint
      {
         var obj:Object = null;
         for each(obj in this.seeds)
         {
            if(id == obj.id)
            {
               return obj.num;
            }
         }
         return 0;
      }
      
      public function getFarmerPos(farmer_id:Number) : uint
      {
         var vo:Vo_farm_farmer = null;
         var list:Dictionary = this.farmerList_mine;
         for each(vo in list)
         {
            if(vo.id == farmer_id)
            {
               return vo.position;
            }
         }
         return 0;
      }
      
      public function isDefeated(id:int) : Boolean
      {
         return false;
      }
      
      public function getFarmItem(info:Vo_farmList) : Child_farmListItem
      {
         var farmListItem:Child_farmListItem = null;
         if(Boolean(Child_farmListItem.pool.length))
         {
            farmListItem = Child_farmListItem.pool.pop();
            farmListItem.getItem(info);
         }
         else
         {
            farmListItem = new Child_farmListItem(info);
         }
         return farmListItem;
      }
      
      public function checkFruitMature() : Boolean
      {
         var land:Vo_farm_land = null;
         for each(land in this.landList_mine)
         {
            if(Boolean(land) && Boolean(land.fruit_id) && land.status == Vo_farm_land.land_status_mature)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getFarmStatus(id:Number) : uint
      {
         var list:Vector.<Vo_farm_land> = null;
         var land:Vo_farm_land = null;
         if(id == 0)
         {
            return 0;
         }
         if(Model_farm.isMine(id))
         {
            list = this.landList_mine;
         }
         else if(id == Model_farm.currentFarmId)
         {
            list = this.landList_other;
         }
         for each(land in list)
         {
            if(Boolean(land) && Boolean(land.fruit_id) && land.status == Vo_farm_land.land_status_mature)
            {
               if(Model_farm.isMine(id))
               {
                  return 1;
               }
               if(id == Model_farm.currentFarmId && land.canSteal)
               {
                  return 3;
               }
            }
            if(Boolean(land) && Boolean(land.fruit_id) && land.status == Vo_farm_land.land_status_need_water)
            {
               return 2;
            }
         }
         return 0;
      }
   }
}

