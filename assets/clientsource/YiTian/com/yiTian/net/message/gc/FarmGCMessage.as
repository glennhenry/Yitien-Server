package com.yiTian.net.message.gc
{
   import com.utils.DateUtil;
   import com.utils.LongUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.valuable.Enum_lib_item;
   import com.yiTian.data.model.Model_farm;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.vo.Vo_farmList;
   import com.yiTian.data.vo.Vo_farmStore;
   import com.yiTian.data.vo.Vo_farm_farmer;
   import com.yiTian.data.vo.Vo_farm_fruit;
   import com.yiTian.data.vo.Vo_farm_guide;
   import com.yiTian.data.vo.Vo_farm_land;
   import com.yiTian.data.vo.Vo_farm_master;
   import com.yiTian.manager.BattleManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.FarmHandler;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.net.message.cg.FarmCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.farm.ViewFarmIcon;
   import com.yiTian.view.modules.farm.View_farm_land;
   import com.yiTian.view.modules.farm.View_farm_tip_panel;
   import com.yiTian.view.modules.mainUIBtnContainer.Enum_mainUIBtn_hide;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.ui.Mouse;
   import flash.utils.Dictionary;
   import flash.utils.IDataInput;
   import flash.utils.getTimer;
   
   public class FarmGCMessage
   {
      
      public function FarmGCMessage(index:Array)
      {
         super();
         index[MessageType.gc_farm_data_basic] = this.gc_farm_data_basic;
         index[MessageType.gc_farm_data_land] = this.gc_farm_data_land;
         index[MessageType.gc_farm_data_seed] = this.gc_farm_data_seed;
         index[MessageType.gc_farm_farmer_info] = this.gc_farm_farmer_info;
         index[MessageType.gc_farm_plant] = this.gc_farm_plant;
         index[MessageType.gc_farm_fruit_mature] = this.gc_farm_fruit_mature;
         index[MessageType.gc_farm_level_up] = this.gc_farm_level_up;
         index[MessageType.gc_farm_land_expand] = this.gc_farm_land_expand;
         index[MessageType.gc_farm_pick_fruit] = this.gc_farm_pick_fruit;
         index[MessageType.gc_farm_steal_fruit] = this.gc_farm_steal_fruit;
         index[MessageType.gc_farm_refresh_fruit] = this.gc_farm_refresh_fruit;
         index[MessageType.gc_friends_list] = this.gc_friends_list;
         index[MessageType.gc_farm_catch_farmer] = this.gc_farm_catch_farmer;
         index[MessageType.gc_farm_be_catch] = this.gc_farm_be_catch;
         index[MessageType.gc_farm_be_grab] = this.gc_farm_be_grab;
         index[MessageType.gc_farm_release] = this.gc_farm_release;
         index[MessageType.gc_farm_resist] = this.gc_farm_resist;
         index[MessageType.gc_farm_be_resist] = this.gc_farm_be_resist;
         index[MessageType.gc_farm_redeem] = this.gc_farm_redeem;
         index[MessageType.gc_farm_reward] = this.gc_farm_reward;
         index[MessageType.gc_farm_hit_farmer] = this.gc_farm_hit_farmer;
         index[MessageType.gc_farm_seekHelp_return] = this.gc_farm_seekHelp_return;
         index[MessageType.gc_farm_rescue_result] = this.gc_farm_rescue_result;
         index[MessageType.gc_farm_rescue_success_boardcast] = this.gc_farm_rescue_success_boardcast;
         index[MessageType.gc_renovate_farm_list] = this.gc_renovate_farm_list;
         index[MessageType.gc_farm_journal] = this.gc_farm_journal;
         index[MessageType.gc_farm_defeated_list] = this.gc_farm_defeated_list;
         index[MessageType.gc_farm_everyday_gift] = this.gc_farm_everyday_gift;
         index[MessageType.gc_farm_get_daygift_return] = this.gc_farm_get_daygift_return;
         index[MessageType.gc_farm_guide] = this.gc_farm_guide;
         index[MessageType.gc_farm_add_friends] = this.gc_farm_add_friends;
         index[MessageType.GC_EMPTY_FIELD_COUNT] = this.GC_EMPTY_FIELD_COUNT;
      }
      
      private function gc_farm_one_key_pick(patch:IDataInput) : void
      {
         var value:uint;
         var onSurePayOneMoney:Function = null;
         var id:uint = 0;
         var len:uint = 0;
         var i:uint = 0;
         var pos:uint = 0;
         var exp:uint = 0;
         var getExp:uint = 0;
         var vec:Vector.<uint> = null;
         onSurePayOneMoney = function(evt:MouseEvent):void
         {
            FarmCGMessage.cg_farm_onekey(1,GameUnitManager.hero.id,0,1);
         };
         if(!Model_farm.isInitFarm)
         {
            return;
         }
         value = uint(patch.readByte());
         if(value == 1)
         {
            id = uint(patch.readInt());
            len = uint(patch.readShort());
            i = 0;
            while(i < len)
            {
               pos = uint(patch.readByte());
               if(Model_farm.isMine(id))
               {
                  Model_farm.instace.landList_mine[pos - 1].clear();
               }
               else if(id == Model_farm.currentFarmId)
               {
                  Model_farm.instace.masterBasic_other.farmExp = exp;
                  Model_farm.instace.landList_other[pos - 1].clear();
               }
               UIManager.farm.updateLandByPosition(pos,id);
               i++;
            }
            if(Model_farm.isMine(id))
            {
               exp = uint(patch.readInt());
               getExp = exp - Model_farm.instace.masterBasic_mine.farmExp;
               Model_farm.instace.masterBasic_mine.farmExp = exp;
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("120",9,getExp));
               len = uint(patch.readByte());
               vec = new Vector.<uint>();
               i = 0;
               while(i < len)
               {
                  vec.push(patch.readInt());
                  i++;
               }
               this.flyGoods(vec,0);
               FarmHandler.checkFruitMature();
            }
            UIManager.farm.updateFarmMaster(id);
         }
         else if(value == 2)
         {
            View_Alert.show("<font color = \'#fefefe\'>需要花费</font><font color = \'#f9ff00\'>5元宝</font><font color =\'#fefefe\'>一键收获？</font>\n<font color = \'#fffefe\'>注：武魂玩家免费使用</font>",View_Alert.OK_CANCAL,onSurePayOneMoney);
         }
         else if(value == 3)
         {
            UIManager.centerBroadcast.addMsg("元宝不足");
         }
         FarmHandler.checkFruitMature();
         FarmHandler.updateOneKeyBtn(id);
      }
      
      private function gc_farm_one_key_steal(patch:IDataInput) : void
      {
         var value:uint;
         var id:uint;
         var len:uint;
         var arr:Array;
         var i:uint;
         var onSurePayOneMoney:Function = null;
         var be_id:uint = 0;
         var obj:Object = null;
         var exp:uint = 0;
         var getExp:uint = 0;
         var vec:Vector.<uint> = null;
         var protect:uint = 0;
         onSurePayOneMoney = function(evt:MouseEvent):void
         {
            FarmCGMessage.cg_farm_onekey(3,GameUnitManager.hero.id,be_id,1);
         };
         if(!Model_farm.isInitFarm)
         {
            return;
         }
         value = uint(patch.readByte());
         if(value != 1)
         {
            if(value == 2)
            {
               be_id = uint(patch.readInt());
               View_Alert.show("<font color = \'#fefefe\'>需要花费</font><font color = \'#f9ff00\'>10元宝</font><font color =\'#fefefe\'>一键偷取？</font>\n<font color = \'#fffefe\'>注：武魂玩家额外免费一次</font>",View_Alert.OK_CANCAL,onSurePayOneMoney);
            }
            else if(value == 3)
            {
               UIManager.centerBroadcast.addMsg("元宝不足");
            }
            return;
         }
         be_id = uint(patch.readInt());
         id = uint(patch.readInt());
         len = uint(patch.readShort());
         arr = new Array();
         i = 0;
         while(i < len)
         {
            obj = new Object();
            obj.pos = patch.readByte();
            obj.left = patch.readShort();
            obj.fid = patch.readInt();
            arr.push(obj);
            i++;
         }
         if(Model_farm.isMine(id))
         {
            exp = uint(patch.readInt());
            getExp = exp - Model_farm.instace.masterBasic_mine.farmExp;
            Model_farm.instace.masterBasic_mine.farmExp = exp;
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("120",9,getExp));
            UIManager.farm.updateFarmInfo(id);
            i = 0;
            while(i < arr.length)
            {
               if(Model_farm.currentFarmId == be_id)
               {
                  Model_farm.instace.landList_other[arr[i].pos - 1].output_left = arr[i].left;
                  Model_farm.instace.landList_other[arr[i].pos - 1].canSteal = false;
                  UIManager.farm.updateLandByPosition(arr[i].pos,be_id);
               }
               i++;
            }
            len = uint(patch.readByte());
            vec = new Vector.<uint>();
            i = 0;
            while(i < len)
            {
               vec.push(patch.readInt());
               i++;
            }
            this.flyGoods(vec,0);
         }
         else
         {
            i = 0;
            while(i < arr.length)
            {
               protect = uint(Data_lib.farm_fruit[arr[i].fid][Vo_farm_fruit.protectOutput]);
               if(Model_farm.isMine(be_id))
               {
                  Model_farm.instace.landList_mine[arr[i].pos - 1].output_left = arr[i].left;
               }
               else if(Model_farm.currentFarmId == be_id)
               {
                  Model_farm.instace.landList_other[arr[i].pos - 1].output_left = arr[i].left;
                  if(Model_farm.instace.landList_other[arr[i].pos - 1].canSteal && arr[i].left <= protect)
                  {
                     Model_farm.instace.landList_other[arr[i].pos - 1].canSteal = false;
                  }
               }
               UIManager.farm.updateLandByPosition(arr[i].pos,be_id);
               i++;
            }
         }
         FarmHandler.updateOneKeyBtn(be_id);
      }
      
      private function gc_farm_one_key_water(patch:IDataInput) : void
      {
         var value:uint;
         var onSurePayOneMoney0:Function = null;
         var be_water_id:uint = 0;
         var water_id:uint = 0;
         var len:uint = 0;
         var arr:Array = null;
         var i:uint = 0;
         var silver:Number = NaN;
         var exp:uint = 0;
         var obj:Object = null;
         var getexp:uint = 0;
         onSurePayOneMoney0 = function(evt:MouseEvent):void
         {
            FarmCGMessage.cg_farm_onekey(2,GameUnitManager.hero.id,be_water_id,1);
         };
         if(!Model_farm.isInitFarm)
         {
            return;
         }
         value = uint(patch.readByte());
         if(value == 0)
         {
            return;
         }
         if(value == 1 || value == 2)
         {
            be_water_id = uint(patch.readInt());
            water_id = uint(patch.readInt());
            len = uint(patch.readShort());
            arr = new Array();
            i = 0;
            while(i < len)
            {
               obj = new Object();
               obj.pos = patch.readByte();
               obj.status = patch.readByte();
               arr.push(obj);
               i++;
            }
            silver = patch.readInt();
            exp = uint(patch.readInt());
            if(this.isMine(water_id))
            {
               if(this.isMine(be_water_id))
               {
                  i = 0;
                  while(i < arr.length)
                  {
                     Model_farm.instace.landList_mine[arr[i].pos - 1].status = arr[i].status;
                     i++;
                  }
               }
               else if(be_water_id == Model_farm.currentFarmId)
               {
                  i = 0;
                  while(i < arr.length)
                  {
                     Model_farm.instace.landList_other[arr[i].pos - 1].status = arr[i].status;
                     i++;
                  }
               }
               if(be_water_id == Model_farm.currentFarmId)
               {
                  i = 0;
                  while(i < arr.length)
                  {
                     UIManager.farm.getLandByPos(arr[i].pos).addEffect("35113",500,65,20);
                     i++;
                  }
               }
               getexp = exp - Model_farm.instace.masterBasic_mine.farmExp;
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("114",9,silver) + "，" + LangConfig.getWord("120",9,getexp));
               Model_farm.instace.masterBasic_mine.farmExp = exp;
               UIManager.farm.updateFarmMaster(water_id);
            }
            else if(this.isMine(be_water_id))
            {
               i = 0;
               while(i < arr.length)
               {
                  Model_farm.instace.landList_mine[arr[i].pos - 1].status = arr[i].status;
                  i++;
               }
            }
            else if(be_water_id == Model_farm.currentFarmId)
            {
               i = 0;
               while(i < arr.length)
               {
                  Model_farm.instace.landList_other[arr[i].pos - 1].status = arr[i].status;
                  i++;
               }
            }
            i = 0;
            while(i < arr.length)
            {
               UIManager.farm.updateLandByPosition(arr[i].pos,be_water_id);
               i++;
            }
         }
         if(value == 1)
         {
            FarmHandler.updateOneKeyBtn(be_water_id);
         }
         else if(value == 2)
         {
            if(this.isMine(water_id))
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("116",9,Model_farm.waterMaxCount));
            }
         }
         else if(value == 3)
         {
            be_water_id = uint(patch.readInt());
            View_Alert.show("<font color = \'#fefefe\'>需要花费</font><font color = \'#f9ff00\'>5元宝</font><font color =\'#fefefe\'>一键浇水？</font>\n<font color = \'#fffefe\'>注：武魂玩家额外免费一次</font>",View_Alert.OK_CANCAL,onSurePayOneMoney0);
         }
         else if(value == 4)
         {
            UIManager.centerBroadcast.addMsg("元宝不足");
         }
      }
      
      private function gc_farm_data_basic(patch:IDataInput) : void
      {
         var vo:Vo_farm_master = null;
         var list:Dictionary = null;
         var id:Number = LongUtil.readLong(patch);
         if(id == GameUnitManager.hero.id)
         {
            vo = Model_farm.instace.masterBasic_mine;
            list = Model_farm.instace.farmerList_mine;
         }
         else
         {
            vo = Model_farm.instace.masterBasic_other;
            list = Model_farm.instace.farmerList_other;
         }
         vo.id = id;
         vo.name = Model_heFu.repNameByHero(patch.readUTF());
         vo.sex = patch.readByte();
         vo.profession = patch.readByte();
         vo.captor = LongUtil.readLong(patch);
         vo.time_left = patch.readInt();
         vo.time_pre_system = getTimer();
         vo.time_left_from_timer = vo.time_left;
         vo.captor_name = patch.readUTF();
         vo.farmLevel = patch.readByte();
         vo.farmExp = patch.readInt();
         UIManager.farm.updateBasic(id);
      }
      
      private function gc_farm_farmer_info(patch:IDataInput) : void
      {
         var list:Dictionary = null;
         var farmer:Vo_farm_farmer = null;
         if(!Model_farm.isInitFarm)
         {
            return;
         }
         var id:Number = LongUtil.readLong(patch);
         if(GameUnitManager.hero.id == id)
         {
            list = Model_farm.instace.farmerList_mine;
         }
         else
         {
            list = Model_farm.instace.farmerList_other;
         }
         var len:uint = uint(patch.readByte());
         var i:uint = 0;
         while(i < len)
         {
            farmer = new Vo_farm_farmer();
            farmer.id = LongUtil.readLong(patch);
            farmer.name = Model_heFu.repNameByHero(patch.readUTF());
            farmer.sex = patch.readByte();
            farmer.profession = patch.readByte();
            farmer.time_left = patch.readInt();
            farmer.position = patch.readByte();
            farmer.time_left_from_timer = farmer.time_left;
            farmer.time_pre_system = getTimer();
            farmer.time_all = Model_farm.time_farmer_be_catch;
            farmer.time_buffer_left = patch.readInt();
            farmer.time_buffer_pre_sys = getTimer();
            farmer.time_buffer_left_from_timer = farmer.time_buffer_left;
            farmer.level = patch.readInt();
            list[farmer.position] = farmer;
            i++;
         }
         UIManager.farm.updateFarmer(id);
      }
      
      private function gc_farm_data_land(patch:IDataInput) : void
      {
         var list:Vector.<Vo_farm_land> = null;
         var land:Vo_farm_land = null;
         var seed:uint = 0;
         var id:Number = LongUtil.readLong(patch);
         var len:uint = uint(patch.readByte());
         if(id == GameUnitManager.hero.id)
         {
            Model_farm.instace.landList_mine = new Vector.<Vo_farm_land>(len);
            list = Model_farm.instace.landList_mine;
         }
         else
         {
            Model_farm.instace.landList_other = new Vector.<Vo_farm_land>(len);
            list = Model_farm.instace.landList_other;
         }
         var i:uint = 0;
         while(i < len)
         {
            land = new Vo_farm_land();
            land.roleid = id;
            land.position = patch.readShort();
            land.fruit_id = patch.readInt();
            seed = uint(patch.readInt());
            if(Boolean(Data_lib.Farm_store[seed]))
            {
               land.time_mature = Data_lib.Farm_store[seed][Vo_farmStore.RIPE_TIME];
            }
            else
            {
               land.time_mature = 0;
            }
            land.output_left = patch.readInt();
            if(Boolean(land.fruit_id))
            {
               land.output_max = Data_lib.farm_fruit[land.fruit_id][Vo_farm_fruit.output];
            }
            else
            {
               land.output_max = 0;
            }
            land.time_left = patch.readInt();
            land.time_left_from_timer = land.time_left;
            land.time_pre_request_water = land.time_mature - land.time_left - (land.time_mature - land.time_left) % Model_farm.time_need_water;
            land.canSteal = patch.readByte() == 1 ? true : false;
            land.status = patch.readByte();
            land.refreshTime = patch.readByte();
            if(land.status == Vo_farm_land.land_status_have_fruit)
            {
               land.isNeedCheckWater = true;
            }
            land.time_pre_system = getTimer();
            land.isMine = this.isMine(id);
            list[land.position - 1] = land;
            i++;
         }
         FarmHandler.start();
         UIManager.farm.updateLand(id);
         FarmHandler.checkFruitMature();
         FarmHandler.updateOneKeyBtn(id);
      }
      
      private function gc_farm_data_seed(patch:IDataInput) : void
      {
         var obj:Object = null;
         if(!Model_farm.isInitFarm)
         {
            return;
         }
         var len:uint = uint(patch.readShort());
         Model_farm.instace.seeds = new Vector.<Object>();
         var i:uint = 0;
         while(i < len)
         {
            obj = new Object();
            obj.id = patch.readInt();
            obj.num = patch.readInt();
            if(uint(obj.num) > 0)
            {
               Model_farm.instace.seeds.push(obj);
            }
            i++;
         }
         UIManager.farm._seedPage = 1;
         UIManager.farm.updateSeed();
         if(Boolean(Model_farm.mouse_type_seed) && Boolean(Model_farm.instace.seedIdOnMouse > 0) && Model_farm.instace.getSeedNum(Model_farm.instace.seedIdOnMouse) == 0)
         {
            if(Boolean(FarmHandler.seedMouse))
            {
               FarmHandler.seedMouse.bitmapData = null;
            }
            FarmHandler.setMouseType(Model_farm.mouse_type_none);
         }
      }
      
      private function gc_farm_plant(patch:IDataInput) : void
      {
         var plant_id:Number = NaN;
         var pos:uint = 0;
         var vo:Vo_farm_land = null;
         var seed:uint = 0;
         var canRefresh:uint = 0;
         if(!Model_farm.isInitFarm)
         {
            return;
         }
         var value:uint = uint(patch.readByte());
         if(value != 0)
         {
            if(value == 1)
            {
               plant_id = LongUtil.readLong(patch);
               pos = uint(patch.readByte());
               if(this.isMine(plant_id) || Model_farm.currentFarmId == plant_id)
               {
                  vo = this.isMine(plant_id) ? Model_farm.instace.landList_mine[pos - 1] : Model_farm.instace.landList_other[pos - 1];
                  vo.fruit_id = patch.readInt();
                  seed = uint(patch.readInt());
                  vo.time_left = Data_lib.Farm_store[seed][Vo_farmStore.RIPE_TIME];
                  vo.output_left = Data_lib.farm_fruit[vo.fruit_id][Vo_farm_fruit.output];
                  vo.output_max = vo.output_left;
                  vo.time_mature = vo.time_left;
                  vo.time_left_from_timer = vo.time_left;
                  vo.time_pre_system = getTimer();
                  vo.status = Vo_farm_land.land_status_have_fruit;
                  vo.time_pre_request_water = 0;
                  vo.isNeedCheckWater = true;
               }
               if(this.isMine(plant_id))
               {
                  canRefresh = uint(Data_lib.farm_fruit[vo.fruit_id][Vo_farm_fruit.ifRefresh]);
                  if(canRefresh == 1)
                  {
                     FarmHandler.openRefreshFruit(vo.position,vo.fruit_id);
                     Mouse.show();
                     Model_farm.instace.mouseType = Model_farm.mouse_type_none;
                  }
               }
               UIManager.farm.updateLandByPosition(pos,plant_id);
            }
            else if(value == 2)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("110",9));
            }
            else if(value == 3)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("111",9));
            }
            else if(value == 4)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("112",9));
            }
            else if(value == 5)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("113",9));
            }
         }
      }
      
      private function gc_farm_is_need_water(patch:IDataInput) : void
      {
         var id:uint = 0;
         var pos:uint = 0;
         var vo:Vo_farm_land = null;
         var isNeedWater:uint = 0;
         if(!Model_farm.isInitFarm)
         {
            return;
         }
         if(patch.readByte() == 1)
         {
            id = uint(patch.readInt());
            pos = uint(patch.readByte());
            if(this.isMine(id))
            {
               vo = Model_farm.instace.landList_mine[pos - 1];
            }
            else if(Model_farm.currentFarmId == id)
            {
               vo = Model_farm.instace.landList_other[pos - 1];
            }
            if(Boolean(vo))
            {
               vo.isNeedCheckWater = false;
               isNeedWater = uint(patch.readByte());
               if(isNeedWater == 2)
               {
                  vo.status = Vo_farm_land.land_status_need_water;
               }
               vo.time_pre_request_water = vo.time_mature - vo.time_left;
               UIManager.farm.updateLandByPosition(pos,id);
            }
            FarmHandler.updateOneKeyBtn(id);
         }
      }
      
      private function gc_farm_fruit_mature(patch:IDataInput) : void
      {
         var vo:Vo_farm_land = null;
         if(!Model_farm.isInitFarm)
         {
            return;
         }
         var id:Number = LongUtil.readLong(patch);
         var pos:uint = uint(patch.readByte());
         var result:uint = uint(patch.readByte());
         var time:uint = uint(patch.readInt());
         if(Model_farm.isMine(id))
         {
            if(result == 3)
            {
               if(Boolean(Model_farm.instace.landList_mine) && pos <= Model_farm.instace.landList_mine.length)
               {
                  Model_farm.instace.landList_mine[pos - 1].status = Vo_farm_land.land_status_mature;
               }
            }
            else if(result == 1)
            {
               if(Boolean(Model_farm.instace.landList_mine) && pos <= Model_farm.instace.landList_mine.length)
               {
                  vo = Model_farm.instace.landList_mine[pos - 1];
               }
               if(Boolean(vo))
               {
                  vo.time_left = time;
                  vo.time_left_from_timer = time;
                  vo.time_pre_system = getTimer();
               }
            }
         }
         else if(result == 3 && Model_farm.currentFarmId == id)
         {
            if(Boolean(Model_farm.instace.landList_other) && pos <= Model_farm.instace.landList_other.length)
            {
               Model_farm.instace.landList_other[pos - 1].status = Vo_farm_land.land_status_mature;
               Model_farm.instace.landList_other[pos - 1].canSteal = true;
            }
         }
         else if(result == 1 && Model_farm.currentFarmId == id)
         {
            if(Boolean(Model_farm.instace.landList_other) && pos <= Model_farm.instace.landList_other.length)
            {
               vo = Model_farm.instace.landList_other[pos - 1];
            }
            if(Boolean(vo))
            {
               vo.time_left = time;
               vo.time_left_from_timer = time;
               vo.time_pre_system = getTimer();
            }
         }
         if(Boolean(UIManager.farm))
         {
            UIManager.farm.updateLandByPosition(pos,id);
         }
         FarmHandler.checkFruitMature();
      }
      
      private function gc_farm_water(patch:IDataInput) : void
      {
         var fruit:uint = 0;
         var silver:uint = 0;
         var getExp:uint = 0;
         if(!Model_farm.isInitFarm)
         {
            return;
         }
         var value:uint = uint(patch.readByte());
         if(value == 0)
         {
            return;
         }
         var be_water_id:uint = uint(patch.readInt());
         var water_id:uint = uint(patch.readInt());
         var pos:uint = uint(patch.readByte());
         var status:uint = uint(patch.readByte());
         Number(patch.readUTF());
         var exp:uint = uint(patch.readInt());
         if(this.isMine(water_id))
         {
            if(this.isMine(be_water_id))
            {
               Model_farm.instace.landList_mine[pos - 1].status = status;
            }
            else if(be_water_id == Model_farm.currentFarmId)
            {
               Model_farm.instace.landList_other[pos - 1].status = status;
            }
            Model_farm.instace.masterBasic_mine.farmExp = exp;
            UIManager.farm.updateFarmMaster(water_id);
            if(be_water_id == Model_farm.currentFarmId)
            {
               UIManager.farm.getLandByPos(pos).addEffect("35113",500,65,20);
            }
         }
         else if(this.isMine(be_water_id))
         {
            Model_farm.instace.landList_mine[pos - 1].status = status;
         }
         else if(be_water_id == Model_farm.currentFarmId)
         {
            Model_farm.instace.landList_other[pos - 1].status = status;
         }
         UIManager.farm.updateLandByPosition(pos,be_water_id);
         if(value == 1)
         {
            if(this.isMine(water_id))
            {
               fruit = uint(patch.readInt());
               silver = uint(Data_lib.farm_fruit[fruit][Vo_farm_fruit.waterSilver]);
               getExp = uint(Data_lib.farm_fruit[fruit][Vo_farm_fruit.waterExp]);
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("114",9,silver) + "，" + LangConfig.getWord("120",9,getExp));
            }
         }
         else if(value == 2)
         {
            if(this.isMine(water_id))
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("116",9,Model_farm.waterMaxCount));
            }
         }
         else if(value == 3)
         {
            if(this.isMine(water_id))
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("117",9));
            }
         }
      }
      
      private function gc_farm_level_up(patch:IDataInput) : void
      {
         var farmer:Vo_farm_farmer = null;
         var id:Number = LongUtil.readLong(patch);
         var level:uint = uint(patch.readByte());
         var exp:uint = uint(patch.readInt());
         var addPos:uint = uint(patch.readByte());
         if(Model_farm.isMine(id))
         {
            Model_farm.instace.masterBasic_mine.farmLevel = level;
            Model_farm.instace.masterBasic_mine.farmExp = exp;
            UIManager.farm.updateFarmMaster(id);
            if(addPos > 0)
            {
               farmer = new Vo_farm_farmer();
               farmer.position = addPos;
               Model_farm.instace.farmerList_mine[addPos] = farmer;
               UIManager.farm.updateFarmer(id);
            }
         }
         else if(id == Model_farm.currentFarmId)
         {
            Model_farm.instace.masterBasic_other.farmLevel = level;
            Model_farm.instace.masterBasic_other.farmExp = exp;
            UIManager.farm.updateFarmMaster(id);
            if(addPos > 0)
            {
               farmer = new Vo_farm_farmer();
               farmer.position = addPos;
               Model_farm.instace.farmerList_other[addPos] = farmer;
               UIManager.farm.updateFarmerByPosition(addPos,id);
            }
         }
      }
      
      private function gc_farm_land_expand(patch:IDataInput) : void
      {
         var land:Vo_farm_land = null;
         var pos:uint = 0;
         var level:uint = 0;
         var id:Number = NaN;
         if(!Model_farm.isInitFarm)
         {
            return;
         }
         var value:uint = uint(patch.readByte());
         if(value != 0)
         {
            if(value == 1)
            {
               land = new Vo_farm_land();
               land.isMine = true;
               land.status = Vo_farm_land.land_status_none;
               pos = uint(patch.readByte());
               land.position = pos;
               level = uint(patch.readByte());
               id = LongUtil.readLong(patch);
               if(Model_farm.isMine(id))
               {
                  UIManager.farm.getLandByPos(pos).addEffect("35111",500,50,20);
                  Model_farm.instace.landList_mine.push(land);
                  Model_farm.instace.landList_mine[pos - 1].level = level;
               }
               else if(id == Model_farm.currentFarmId)
               {
                  Model_farm.instace.landList_other.push(land);
                  Model_farm.instace.landList_other[pos - 1].level = level;
               }
               UIManager.farm.updateLand(id);
            }
            else if(value == 2)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("118",9));
            }
            else if(value == 3)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("71",9));
            }
            else if(value == 4)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("89",9));
            }
         }
      }
      
      private function gc_farm_pick_fruit(patch:IDataInput) : void
      {
         var id:Number = NaN;
         var pos:uint = 0;
         var fruit:uint = 0;
         var exp:uint = 0;
         var getSource:uint = 0;
         var getExp:uint = 0;
         var str:String = null;
         var len:uint = 0;
         var vec:Vector.<uint> = null;
         var i:uint = 0;
         if(!Model_farm.isInitFarm)
         {
            return;
         }
         if(patch.readByte() == 1)
         {
            id = LongUtil.readLong(patch);
            pos = uint(patch.readByte());
            fruit = uint(patch.readInt());
            exp = uint(patch.readInt());
            getSource = uint(patch.readInt());
            if(Model_farm.isMine(id))
            {
               Model_farm.instace.landList_mine[pos - 1].clear();
               getExp = uint(Data_lib.farm_fruit[fruit][Vo_farm_fruit.pickExp]);
               str = "";
               if(getSource > 0)
               {
                  str = LangConfig.getWord("215",9) + getSource;
               }
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("120",9,getExp) + str);
               Model_farm.instace.masterBasic_mine.farmExp = exp;
               len = uint(patch.readByte());
               vec = new Vector.<uint>();
               i = 0;
               while(i < len)
               {
                  vec.push(patch.readInt());
                  i++;
               }
               this.flyGoods(vec,pos);
            }
            else if(id == Model_farm.currentFarmId)
            {
               Model_farm.instace.masterBasic_other.farmExp = exp;
               Model_farm.instace.landList_other[pos - 1].clear();
            }
            UIManager.farm.updateLandByPosition(pos,id);
            UIManager.farm.updateFarmMaster(id);
            FarmHandler.checkFruitMature();
         }
      }
      
      private function gc_farm_steal_fruit(patch:IDataInput) : void
      {
         var be_steal_id:Number = NaN;
         var steal_id:Number = NaN;
         var pos:uint = 0;
         var left:uint = 0;
         var exp:uint = 0;
         var isSuccess:uint = 0;
         var fid:uint = 0;
         var getExp:uint = 0;
         var str:String = null;
         var getSource:uint = 0;
         var len:uint = 0;
         var vec:Vector.<uint> = null;
         var i:uint = 0;
         var protect:uint = 0;
         if(!Model_farm.isInitFarm)
         {
            return;
         }
         var value:uint = uint(patch.readByte());
         if(value == 1)
         {
            be_steal_id = LongUtil.readLong(patch);
            steal_id = LongUtil.readLong(patch);
            pos = uint(patch.readByte());
            left = uint(patch.readShort());
            exp = uint(patch.readInt());
            isSuccess = uint(patch.readByte());
            fid = uint(patch.readInt());
            if(Model_farm.isMine(steal_id))
            {
               if(isSuccess == 0)
               {
                  Model_farm.instace.landList_other[pos - 1].canSteal = false;
                  UIManager.farm.updateLandByPosition(pos,be_steal_id);
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("196",9));
                  return;
               }
               Model_farm.instace.masterBasic_mine.farmExp = exp;
               getExp = uint(Data_lib.farm_fruit[fid][Vo_farm_fruit.stealExp]);
               str = "";
               getSource = uint(patch.readInt());
               if(getSource > 0)
               {
                  str = LangConfig.getWord("215",9) + getSource;
               }
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("120",9,getExp) + str);
               UIManager.farm.updateFarmInfo(Model_farm.currentFarmId);
               if(Model_farm.currentFarmId == be_steal_id)
               {
                  Model_farm.instace.landList_other[pos - 1].output_left = left;
                  Model_farm.instace.landList_other[pos - 1].canSteal = false;
               }
               len = uint(patch.readByte());
               vec = new Vector.<uint>();
               i = 0;
               while(i < len)
               {
                  vec.push(patch.readInt());
                  i++;
               }
               this.flyGoods(vec,pos);
            }
            else
            {
               protect = uint(Data_lib.farm_fruit[fid][Vo_farm_fruit.protectOutput]);
               if(Model_farm.isMine(be_steal_id))
               {
                  Model_farm.instace.landList_mine[pos - 1].output_left = left;
               }
               else if(Model_farm.currentFarmId == be_steal_id)
               {
                  Model_farm.instace.landList_other[pos - 1].output_left = left;
                  if(Model_farm.instace.landList_other[pos - 1].canSteal && left <= protect)
                  {
                     Model_farm.instace.landList_other[pos - 1].canSteal = false;
                  }
               }
            }
         }
         else if(value == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("121",9));
         }
         else if(value == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("122",9));
         }
         else if(value == 4)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("123",9));
         }
         else if(value == 5)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("124",9));
         }
         else if(value == 6)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("125",9));
         }
         UIManager.farm.updateLandByPosition(pos,be_steal_id);
      }
      
      private function gc_farm_fruit_kill(patch:IDataInput) : void
      {
         var id:uint = 0;
         var pos:uint = 0;
         if(!Model_farm.isInitFarm)
         {
            return;
         }
         var value:uint = uint(patch.readByte());
         if(value == 1)
         {
            id = uint(patch.readInt());
            pos = uint(patch.readByte());
            if(Model_farm.isMine(id))
            {
               Model_farm.instace.landList_mine[pos - 1].clear();
            }
            else if(id == Model_farm.currentFarmId)
            {
               Model_farm.instace.landList_other[pos - 1].clear();
            }
            UIManager.farm.updateLandByPosition(pos,id);
            FarmHandler.checkFruitMature();
         }
      }
      
      private function gc_farm_land_levelup(patch:IDataInput) : void
      {
         var pos:uint = 0;
         var landLevel:uint = 0;
         var farmRes:Number = NaN;
         var value:int = patch.readByte();
         if(value == 1)
         {
            pos = uint(patch.readByte());
            landLevel = uint(patch.readByte());
            farmRes = Number(patch.readUTF());
            Model_farm.instace.landList_mine[pos - 1].level = landLevel;
            UIManager.farm.updateLandByPosition(pos,GameUnitManager.hero.id);
            UIManager.farm.updateFarmMaster(GameUnitManager.hero.id);
            if(Model_farm.isMine(Model_farm.currentFarmId))
            {
               UIManager.farm.getLandByPos(pos).addEffect("35114",570,50,20);
            }
         }
         else if(value == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("126",9));
         }
         else if(value == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("127",9));
         }
         else if(value == 4)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("70",9));
         }
      }
      
      private function gc_farm_refresh_fruit(patch:IDataInput) : void
      {
         var pos:uint = 0;
         var fruitId:int = 0;
         var refreshNum:uint = 0;
         var vo:Vo_farm_land = null;
         if(!Model_farm.isInitFarm)
         {
            return;
         }
         var value:uint = uint(patch.readByte());
         if(value == 1)
         {
            pos = uint(patch.readByte());
            fruitId = patch.readInt();
            refreshNum = uint(patch.readByte());
            vo = Model_farm.instace.landList_mine[pos - 1];
            vo.fruit_id = fruitId;
            vo.output_left = Data_lib.farm_fruit[vo.fruit_id][Vo_farm_fruit.output];
            vo.output_max = vo.output_left;
            Model_farm.instace.landList_mine[pos - 1].refreshTime = refreshNum;
            UIManager.farm.updateLandByPosition(pos,GameUnitManager.hero.id);
            UIManager.refresh_fruit.updata(pos,fruitId);
            UIManager.refresh_fruit.addEffect();
         }
         else if(value == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("90",9));
         }
         else if(value == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("89",9));
         }
      }
      
      private function gc_friends_list(patch:IDataInput) : void
      {
         var friend_id:Number = NaN;
         var friend_sex:int = 0;
         var friend_name:String = null;
         var friend_status:uint = 0;
         var friend_job:int = 0;
         var arr_friend:Array = null;
         if(!Model_farm.isInitFarm)
         {
            return;
         }
         if(UIManager.farmFriendList.isFirstOpen)
         {
            return;
         }
         EffectManager.removeEffect(UIManager.farmFriendList.eff);
         var friends:Array = [];
         var value:int = patch.readShort();
         var i:int = 0;
         while(i < value)
         {
            friend_id = LongUtil.readLong(patch);
            if(friend_id)
            {
               friend_sex = patch.readByte();
               friend_name = patch.readUTF();
               friend_name = Model_heFu.repNameByHero(friend_name);
               friend_status = uint(patch.readByte());
               friend_job = patch.readByte();
               arr_friend = [];
               arr_friend.push(friend_id,friend_sex,friend_name,friend_status,friend_job);
               friends.push(arr_friend);
            }
            i++;
         }
         FarmHandler.friendInto(friends);
      }
      
      private function gc_renovate_farm_list(patch:IDataInput) : void
      {
         var id:Number = LongUtil.readLong(patch);
         var status:int = patch.readByte();
         if(Model_farm.isMine(id))
         {
            if(Boolean(status))
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
         if(!UIManager.farmFriendList)
         {
            return;
         }
         if(UIManager.farmFriendList.isFirstOpen)
         {
            return;
         }
         UIManager.farmFriendList.updateFriend(id,status);
      }
      
      private function gc_farm_catch_farmer(patch:IDataInput) : void
      {
         var be_catch_id:Number = NaN;
         var be_catch_name:String = null;
         var catch_grab:uint = 0;
         var onSendCatch:Function = null;
         var str:String = null;
         var vo:Vo_farm_farmer = null;
         onSendCatch = function(evt:MouseEvent):void
         {
            if(BattleManager.isPlaying)
            {
               return;
            }
            FarmCGMessage.cg_farm_catch_farmer(GameUnitManager.hero.id,be_catch_id,1,catch_grab,Model_farm.instace.catch_click_farmer_pos);
         };
         var value:uint = uint(patch.readByte());
         var time:uint = uint(patch.readInt());
         var catch_id:Number = LongUtil.readLong(patch);
         var catch_name:String = Model_heFu.repNameByHero(patch.readUTF());
         be_catch_id = LongUtil.readLong(patch);
         be_catch_name = Model_heFu.repNameByHero(patch.readUTF());
         catch_grab = uint(patch.readByte());
         var farmer_pos:uint = uint(patch.readByte());
         var farmer_pro:uint = uint(patch.readByte());
         var farmer_sex:uint = uint(patch.readByte());
         var bid:uint = uint(patch.readInt());
         var level:uint = uint(patch.readInt());
         if(value == 0)
         {
            if(Model_farm.isMine(catch_id))
            {
               str = LangConfig.getWord("167",9,catch_name,be_catch_name);
               UIManager.battleReplay.add(bid,str,"");
            }
         }
         else if(value == 1)
         {
            if(Model_farm.isMine(catch_id))
            {
               str = LangConfig.getWord("166",9,catch_name,be_catch_name);
               UIManager.battleReplay.add(bid,str,"",function():void
               {
                  var txt:String = null;
                  txt = HtmlUtil.font(LangConfig.getWord("119",9),"#fefeff") + HtmlUtil.font(be_catch_name,"#fefe00");
                  UIManager.battleReplay.addTxt(txt,true);
                  UIManager.battleReplay.align();
               });
               vo = Model_farm.instace.farmerList_mine[farmer_pos];
               if(Model_farm.currentFarmId == be_catch_id)
               {
                  Model_farm.instace.masterBasic_other.captor = catch_id;
                  Model_farm.instace.masterBasic_other.captor_name = catch_name;
                  UIManager.farm.updateFarmMaster(be_catch_id);
               }
            }
            else if(Model_farm.isMine(be_catch_id))
            {
               Model_farm.instace.masterBasic_mine.captor = catch_id;
               Model_farm.instace.masterBasic_mine.captor_name = catch_name;
               if(Model_farm.currentFarmId == be_catch_id)
               {
                  UIManager.farm.updateFarmMaster(be_catch_id);
               }
               else if(Model_farm.currentFarmId == catch_id)
               {
                  vo = Model_farm.instace.farmerList_other[farmer_pos];
               }
            }
            else if(Model_farm.currentFarmId == catch_id)
            {
               vo = Model_farm.instace.farmerList_other[farmer_pos];
            }
            else if(Model_farm.currentFarmId == be_catch_id)
            {
               Model_farm.instace.masterBasic_other.captor = catch_id;
               Model_farm.instace.masterBasic_other.captor_name = catch_name;
               UIManager.farm.updateFarmMaster(be_catch_id);
            }
            if(Boolean(vo))
            {
               vo.id = be_catch_id;
               vo.name = Model_heFu.repNameByHero(be_catch_name);
               vo.position = farmer_pos;
               vo.profession = farmer_pro;
               vo.sex = farmer_sex;
               vo.time_left = Model_farm.time_farmer_be_catch;
               vo.time_all = Model_farm.time_farmer_be_catch;
               vo.time_pre_system = getTimer();
               vo.time_left_from_timer = vo.time_left;
               vo.status = Vo_farm_farmer.farmer_status_normal;
               vo.time_pre_request_sleep = 0;
               vo.level = level;
               UIManager.farm.updateFarmerByPosition(vo.position,catch_id);
            }
            if(!UIManager.farmArrestList)
            {
               return;
            }
            UIManager.farmArrestList.visible = false;
            this.changeStatus(be_catch_id);
         }
         else if(value == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("128",9));
         }
         else if(value == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("129",9));
         }
         else if(value == 4)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("130",9));
         }
         else if(value == 5)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("131",9,DateUtil.getHMSBySecond2(time)));
         }
         else if(value == 6)
         {
            str = LangConfig.getWord("197",9);
            View_Alert.show(str,View_Alert.OK_CANCAL,onSendCatch);
         }
         else if(value == 7)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("89",9));
         }
      }
      
      private function changeStatus(id:int) : void
      {
         var i:int = 0;
         while(i < Model_farm.instace.farm_defeated_list.length)
         {
            if(id == Model_farm.instace.farm_defeated_list[i].id)
            {
               Model_farm.instace.farm_defeated_list[i].masterID = GameUnitManager.hero.id;
               Model_farm.instace.farm_defeated_list[i].masterName = GameUnitManager.hero.name;
            }
            i++;
         }
         UIManager.farmArrestList.update(Model_farm.defeatedPage);
      }
      
      private function gc_farm_be_catch(patch:IDataInput) : void
      {
         var info:Object = new Object();
         info.noticeType = View_farm_tip_panel.type_battle_video;
         var name:String = Model_heFu.repNameByHero(patch.readUTF());
         var id:Number = LongUtil.readLong(patch);
         var bid:uint = uint(patch.readInt());
         info.text = HtmlUtil.createLink(name,true,id.toString()) + HtmlUtil.font(LangConfig.getWord("133",9),"#ffffff");
         info.battle_id = bid;
         FarmHandler.addNotice(info);
         Model_farm.instace.masterBasic_mine.captor = id;
         Model_farm.instace.masterBasic_mine.captor_name = name;
         if(Model_farm.isMine(Model_farm.currentFarmId))
         {
            UIManager.farm.updateFarmMaster(Model_farm.currentFarmId);
         }
      }
      
      private function gc_farm_be_grab(patch:IDataInput) : void
      {
         var info:Object = new Object();
         info.noticeType = View_farm_tip_panel.type_battle_video;
         var catch_name:String = Model_heFu.repNameByHero(patch.readUTF());
         var catch_id:Number = LongUtil.readLong(patch);
         var be_catch_name:String = Model_heFu.repNameByHero(patch.readUTF());
         var be_catch_id:uint = LongUtil.readLong(patch);
         var bid:uint = uint(patch.readInt());
         info.text = HtmlUtil.createLink(catch_name,true,catch_id.toString()) + HtmlUtil.font(LangConfig.getWord("134",9),"#ffffff") + HtmlUtil.createLink(be_catch_name,true,be_catch_id.toString()) + HtmlUtil.font(LangConfig.getWord("135",9),"#ffffff");
         info.battle_id = bid;
         FarmHandler.addNotice(info);
         if(!Model_farm.isInitFarm)
         {
            return;
         }
         var pos:uint = uint(patch.readByte());
         var vo:Vo_farm_farmer = Model_farm.instace.farmerList_mine[pos];
         vo.clear();
         if(Model_farm.isMine(Model_farm.currentFarmId))
         {
            UIManager.farm.updateFarmerByPosition(pos,Model_farm.currentFarmId);
         }
         if(!UIManager.farmArrestList)
         {
            return;
         }
         var i:int = 0;
         while(i < Model_farm.instace.farm_defeated_list.length)
         {
            if(be_catch_id == Model_farm.instace.farm_defeated_list[i].id)
            {
               Model_farm.instace.farm_defeated_list[i].masterID = catch_id;
               Model_farm.instace.farm_defeated_list[i].masterName = catch_name;
            }
            i++;
         }
         UIManager.farmArrestList.update(Model_farm.defeatedPage);
      }
      
      private function gc_farm_release(patch:IDataInput) : void
      {
         var id:Number = NaN;
         var be_realse_id:Number = NaN;
         var pos:uint = 0;
         var vo:Vo_farm_farmer = null;
         var i:int = 0;
         if(!Model_farm.isInitFarm)
         {
            return;
         }
         var type:uint = uint(patch.readByte());
         if(patch.readByte() == 1)
         {
            id = LongUtil.readLong(patch);
            be_realse_id = LongUtil.readLong(patch);
            pos = uint(patch.readByte());
            if(type == 0 && Model_farm.isMine(id))
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("136",9));
            }
            if(Model_farm.isMine(id))
            {
               vo = Model_farm.instace.farmerList_mine[pos];
               vo.clear();
               if(id == Model_farm.currentFarmId)
               {
                  UIManager.farm.updateFarmerByPosition(pos,id);
               }
               else if(be_realse_id == Model_farm.currentFarmId)
               {
                  Model_farm.instace.masterBasic_other.captor = 0;
                  Model_farm.instace.masterBasic_other.captor_name = "";
                  UIManager.farm.updateFarmMaster(be_realse_id);
               }
            }
            else if(Model_farm.isMine(be_realse_id))
            {
               Model_farm.instace.masterBasic_mine.captor = 0;
               Model_farm.instace.masterBasic_mine.captor_name = "";
               if(be_realse_id == Model_farm.currentFarmId)
               {
                  UIManager.farm.updateFarmMaster(be_realse_id);
               }
               else if(id == Model_farm.currentFarmId)
               {
                  vo = Model_farm.instace.farmerList_other[pos];
                  vo.clear();
                  UIManager.farm.updateFarmerByPosition(pos,id);
               }
            }
            else
            {
               vo = Model_farm.instace.farmerList_other[pos];
               if(Boolean(vo))
               {
                  vo.clear();
               }
               if(Model_farm.currentFarmId == id)
               {
                  Model_farm.instace.masterBasic_other.captor = 0;
                  Model_farm.instace.masterBasic_other.captor_name = "";
                  UIManager.farm.updateFarmMaster(id);
               }
               else if(Model_farm.currentFarmId == be_realse_id)
               {
                  UIManager.farm.updateFarmerByPosition(pos,be_realse_id);
               }
            }
            if(!UIManager.farmArrestList)
            {
               return;
            }
            i = 0;
            while(i < Model_farm.instace.farm_defeated_list.length)
            {
               if(be_realse_id == Model_farm.instace.farm_defeated_list[i].id)
               {
                  Model_farm.instace.farm_defeated_list[i].masterID = 0;
                  Model_farm.instace.farm_defeated_list[i].masterName = "";
               }
               i++;
            }
            UIManager.farmArrestList.update(Model_farm.defeatedPage);
         }
      }
      
      private function gc_farm_resist(patch:IDataInput) : void
      {
         var value:uint;
         var id:Number;
         var be_id:Number;
         var pos:uint;
         var bid:uint;
         var be_name:String = null;
         var vo:Vo_farm_farmer = null;
         var str:String = null;
         var i:int = 0;
         if(!Model_farm.isInitFarm)
         {
            return;
         }
         value = uint(patch.readByte());
         id = LongUtil.readLong(patch);
         be_name = Model_heFu.repNameByHero(patch.readUTF());
         be_id = LongUtil.readLong(patch);
         pos = uint(patch.readByte());
         bid = uint(patch.readInt());
         if(Boolean(value))
         {
            if(Model_farm.isMine(id))
            {
               if(Model_farm.currentFarmId == id)
               {
                  Model_farm.instace.masterBasic_mine.captor = 0;
                  Model_farm.instace.masterBasic_mine.captor_name = "";
                  UIManager.farm.updateFarmMaster(id);
               }
               else if(Model_farm.currentFarmId == be_id)
               {
                  vo = Model_farm.instace.farmerList_other[pos];
                  if(Boolean(vo))
                  {
                     vo.clear();
                  }
                  UIManager.farm.updateFarmerByPosition(pos,be_id);
               }
               str = LangConfig.getWord("168",9,Model_heFu.repNameByHero(GameUnitManager.hero.name),be_name);
               UIManager.battleReplay.add(bid,str,"",function():void
               {
                  var txt:String = null;
                  txt = HtmlUtil.font(LangConfig.getWord("137",9),"#ffffff") + HtmlUtil.font(be_name,"#fefe00") + HtmlUtil.font(LangConfig.getWord("138",9),"#ffffff");
                  UIManager.battleReplay.addTxt(txt,true);
                  UIManager.battleReplay.align();
               });
               if(!UIManager.farmArrestList)
               {
                  return;
               }
               i = 0;
               while(i < Model_farm.instace.farm_defeated_list.length)
               {
                  if(id == Model_farm.instace.farm_defeated_list[i].id)
                  {
                     Model_farm.instace.farm_defeated_list[i].masterID = 0;
                     Model_farm.instace.farm_defeated_list[i].masterName = "";
                  }
                  i++;
               }
               UIManager.farmArrestList.update(Model_farm.defeatedPage);
            }
            else if(Model_farm.isMine(be_id))
            {
               vo = Model_farm.instace.farmerList_mine[pos];
               vo.clear();
               if(Model_farm.currentFarmId == be_id)
               {
                  UIManager.farm.updateFarmerByPosition(pos,be_id);
               }
               else if(Model_farm.currentFarmId == id)
               {
                  Model_farm.instace.masterBasic_other.captor = 0;
                  Model_farm.instace.masterBasic_other.captor_name = "";
                  UIManager.farm.updateFarmMaster(id);
               }
            }
            else if(Model_farm.currentFarmId == id)
            {
               Model_farm.instace.masterBasic_other.captor = 0;
               Model_farm.instace.masterBasic_other.captor_name = "";
               UIManager.farm.updateFarmMaster(id);
            }
            else if(Model_farm.currentFarmId == be_id)
            {
               vo = Model_farm.instace.farmerList_other[pos];
               vo.clear();
               UIManager.farm.updateFarmerByPosition(pos,be_id);
            }
         }
         else if(Model_farm.isMine(id))
         {
            str = LangConfig.getWord("169",9,GameUnitManager.hero.name,be_name);
            UIManager.battleReplay.add(bid,str,"");
         }
      }
      
      private function gc_farm_be_resist(patch:IDataInput) : void
      {
         var info:Object = new Object();
         info.noticeType = View_farm_tip_panel.type_battle_video;
         var name:String = Model_heFu.repNameByHero(patch.readUTF());
         var id:Number = LongUtil.readLong(patch);
         var bid:uint = uint(patch.readInt());
         info.text = HtmlUtil.font(LangConfig.getWord("139",9),"#ffffff") + HtmlUtil.createLink(name,true,id.toString()) + HtmlUtil.font(LangConfig.getWord("140",9),"#ffffff");
         info.battle_id = bid;
         FarmHandler.addNotice(info);
      }
      
      private function gc_farm_redeem(patch:IDataInput) : void
      {
         var vo:Vo_farm_farmer = null;
         var id:Number = NaN;
         var master_id:Number = NaN;
         var pos:uint = 0;
         var value:uint = uint(patch.readByte());
         if(value == 1)
         {
            id = LongUtil.readLong(patch);
            master_id = LongUtil.readLong(patch);
            pos = uint(patch.readByte());
            if(Model_farm.isMine(id))
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("141",9));
               Model_farm.instace.masterBasic_mine.captor = 0;
               Model_farm.instace.masterBasic_mine.captor_name = "";
               if(Model_farm.currentFarmId == id)
               {
                  UIManager.farm.updateFarmMaster(id);
               }
               else if(Model_farm.currentFarmId == master_id)
               {
                  vo = Model_farm.instace.farmerList_other[pos];
                  vo.clear();
                  UIManager.farm.updateFarmerByPosition(pos,master_id);
               }
            }
            else if(Model_farm.isMine(master_id))
            {
               vo = Model_farm.instace.farmerList_mine[pos];
               vo.clear();
               if(master_id == Model_farm.currentFarmId)
               {
                  UIManager.farm.updateFarmerByPosition(pos,master_id);
               }
               else if(id == Model_farm.currentFarmId)
               {
                  Model_farm.instace.masterBasic_other.captor = 0;
                  Model_farm.instace.masterBasic_other.captor_name = "";
                  UIManager.farm.updateFarmMaster(id);
               }
            }
            else
            {
               vo = Model_farm.instace.farmerList_other[pos];
               vo.clear();
               if(Model_farm.currentFarmId == id)
               {
                  Model_farm.instace.masterBasic_other.captor = 0;
                  Model_farm.instace.masterBasic_other.captor_name = "";
                  UIManager.farm.updateFarmMaster(id);
               }
               else if(Model_farm.currentFarmId == master_id)
               {
                  UIManager.farm.updateFarmerByPosition(pos,master_id);
               }
            }
         }
         else if(value == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("89",9));
         }
      }
      
      private function gc_farm_reward(patch:IDataInput) : void
      {
         var pos:uint = 0;
         var time:uint = 0;
         var vo:Vo_farm_farmer = null;
         var value:uint = uint(patch.readByte());
         if(value == 1)
         {
            pos = uint(patch.readByte());
            time = uint(patch.readInt());
            vo = Model_farm.instace.farmerList_mine[pos];
            if(Boolean(vo))
            {
               vo.time_buffer_left = time;
               vo.time_buffer_pre_sys = getTimer();
               vo.time_buffer_left_from_timer = vo.time_buffer_left;
               UIManager.farm.updateFarmerBuffer(pos);
            }
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("142",9));
         }
         else if(value == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("71",9));
         }
      }
      
      private function gc_farm_hit_farmer(patch:IDataInput) : void
      {
         if(!Model_farm.isInitFarm)
         {
            return;
         }
         var hit:uint = uint(patch.readInt());
         var master:uint = uint(patch.readInt());
         var pos:uint = uint(patch.readByte());
         var status:uint = uint(patch.readByte());
         if(Model_farm.isMine(hit))
         {
            if(Model_farm.isMine(master))
            {
               Model_farm.instace.farmerList_mine[pos].status = status;
            }
            else
            {
               Model_farm.instace.farmerList_other[pos].status = status;
            }
            UIManager.farm.getFarmerByPos(pos).addEffect("35112",500,45,30);
         }
         else if(Model_farm.isMine(master))
         {
            Model_farm.instace.farmerList_mine[pos].status = status;
         }
         else if(master == Model_farm.currentFarmId)
         {
            Model_farm.instace.farmerList_other[pos].status = status;
         }
         UIManager.farm.updateFarmerByPosition(pos,master);
      }
      
      private function gc_farm_request_sleep(patch:IDataInput) : void
      {
         var vo:Vo_farm_farmer = null;
         var status:uint = uint(patch.readByte());
         var farmer:uint = uint(patch.readInt());
         var pos:uint = uint(patch.readByte());
         var master:uint = uint(patch.readInt());
         if(Model_farm.isMine(master))
         {
            vo = Model_farm.instace.farmerList_mine[pos];
            if(Boolean(vo))
            {
               vo.status = status;
               vo.time_pre_request_sleep = vo.time_all - vo.time_left;
            }
         }
         else if(master == Model_farm.currentFarmId)
         {
            vo = Model_farm.instace.farmerList_other[pos];
            if(Boolean(vo))
            {
               vo.status = status;
               vo.time_pre_request_sleep = vo.time_all - vo.time_left;
            }
         }
         if(Boolean(UIManager.farm))
         {
            UIManager.farm.updateFarmerByPosition(pos,master);
         }
      }
      
      private function gc_farm_seekHelp_return(patch:IDataInput) : void
      {
         var name:String = null;
         var info:Object = null;
         var str:String = null;
         var type:uint = uint(patch.readByte());
         var value:uint = uint(patch.readByte());
         var time:uint = uint(patch.readInt());
         name = Model_heFu.repNameByHero(patch.readUTF());
         var id:Number = LongUtil.readLong(patch);
         var master_name:String = Model_heFu.repNameByHero(patch.readUTF());
         var master_id:Number = LongUtil.readLong(patch);
         var be_id:Number = LongUtil.readLong(patch);
         var rescue_info:String = patch.readUTF();
         var bid:uint = uint(patch.readInt());
         if(type == 1)
         {
            if(value == 1)
            {
               info = new Object();
               info.noticeType = View_farm_tip_panel.type_rescue;
               info.seek_id = id;
               info.be_seek_id = be_id;
               info.seek_master_id = master_id;
               info.text = HtmlUtil.createLink(name,true,id.toString()) + HtmlUtil.font(LangConfig.getWord("198",9),"#ffffff");
               info.text_1 = HtmlUtil.font(LangConfig.getWord("143",9),"#ffffff") + HtmlUtil.createLink(master_name,true,master_id.toString()) + HtmlUtil.font(LangConfig.getWord("144",9),"#ffffff") + "\n" + HtmlUtil.font(LangConfig.getWord("145",9),"#ffffff");
               info.battle_id = bid;
               FarmHandler.addNotice(info);
            }
            else if(value == 2)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("146",9,DateUtil.getHMSBySecond(time)));
            }
         }
         else if(type == 2)
         {
            if(value == 1)
            {
               str = LangConfig.getWord("170",9,Model_heFu.repNameByHero(GameUnitManager.hero.name));
               UIManager.battleReplay.add(bid,"","",function():void
               {
                  var txt:String = null;
                  txt = HtmlUtil.font(LangConfig.getWord("148",9),"#ffffff") + HtmlUtil.font(name,"#fefe00");
                  UIManager.battleReplay.addTxt(txt,true);
                  UIManager.battleReplay.align();
               });
            }
            else if(value == 3)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("147",9));
            }
            else
            {
               str = LangConfig.getWord("171",9,Model_heFu.repNameByHero(GameUnitManager.hero.name),name,master_name);
               UIManager.battleReplay.add(bid,"","");
            }
         }
      }
      
      private function gc_farm_rescue_result(patch:IDataInput) : void
      {
         if(patch.readByte() != 1)
         {
            return;
         }
         var info:Object = new Object();
         info.noticeType = View_farm_tip_panel.type_battle_video;
         var name:String = Model_heFu.repNameByHero(patch.readUTF());
         var id:Number = LongUtil.readLong(patch);
         var be_name:String = Model_heFu.repNameByHero(patch.readUTF());
         var be_id:Number = LongUtil.readLong(patch);
         var bid:uint = uint(patch.readInt());
         info.text = HtmlUtil.createLink(be_name,true,be_id.toString()) + HtmlUtil.font(LangConfig.getWord("149",9),"#ffffff") + HtmlUtil.createLink(name,true,id.toString()) + HtmlUtil.font(LangConfig.getWord("150",9),"#ffffff");
         info.battle_id = bid;
         FarmHandler.addNotice(info);
         var pos:uint = Model_farm.instace.getFarmerPos(id);
         var vo:Vo_farm_farmer = Model_farm.instace.farmerList_mine[pos];
         if(Boolean(vo))
         {
            vo.clear();
         }
         if(Model_farm.isMine(Model_farm.currentFarmId))
         {
            UIManager.farm.updateFarmerByPosition(pos,Model_farm.currentFarmId);
         }
         else if(id == Model_farm.currentFarmId)
         {
            Model_farm.instace.masterBasic_other.captor = 0;
            Model_farm.instace.masterBasic_other.captor_name = "";
            UIManager.farm.updateFarmMaster(id);
         }
      }
      
      private function gc_farm_rescue_success_boardcast(patch:IDataInput) : void
      {
         var vo:Vo_farm_farmer = null;
         var id:Number = LongUtil.readLong(patch);
         var farmer:Number = LongUtil.readLong(patch);
         var pos:uint = uint(patch.readByte());
         if(Model_farm.isMine(id))
         {
            vo = Model_farm.instace.farmerList_mine[pos];
            if(Boolean(vo))
            {
               vo.clear();
            }
            UIManager.farm.updateFarmerByPosition(pos,id);
         }
         if(Model_farm.isMine(farmer))
         {
            Model_farm.instace.masterBasic_mine.captor = 0;
            Model_farm.instace.masterBasic_mine.captor_name = "";
            UIManager.farm.updateFarmMaster(farmer);
         }
         else if(id == Model_farm.currentFarmId)
         {
            vo = Model_farm.instace.farmerList_other[pos];
            if(Boolean(vo))
            {
               vo.clear();
            }
            UIManager.farm.updateFarmerByPosition(pos,id);
         }
         else if(farmer == Model_farm.currentFarmId)
         {
            Model_farm.instace.masterBasic_other.captor = 0;
            Model_farm.instace.masterBasic_other.captor_name = "";
            UIManager.farm.updateFarmMaster(farmer);
         }
      }
      
      private function gc_farm_journal(patch:IDataInput) : void
      {
         var type:int = 0;
         var name:String = null;
         var id:Number = NaN;
         var sex:uint = 0;
         var num:int = 0;
         var fruitId:Number = NaN;
         var farmerName:String = null;
         var farmerSex:uint = 0;
         var timer:int = 0;
         var value:int = patch.readByte();
         var i:int = 0;
         while(i < value)
         {
            type = patch.readByte();
            name = Model_heFu.repNameByHero(patch.readUTF());
            id = LongUtil.readLong(patch);
            sex = uint(patch.readByte());
            num = patch.readByte();
            fruitId = LongUtil.readLong(patch);
            farmerName = Model_heFu.repNameByHero(patch.readUTF());
            farmerSex = uint(patch.readByte());
            timer = patch.readInt();
            UIManager.farmJournal.updateJournal(type,name,id,sex,num,fruitId,farmerName,farmerSex,timer);
            i++;
         }
         UIManager.farmJournal.update(1);
      }
      
      private function gc_farm_defeated_list(patch:IDataInput) : void
      {
         var arr:Array = null;
         var vo_info:Vo_farmList = null;
         if(!Model_farm.isInitFarm)
         {
            return;
         }
         if(!UIManager.farmArrestList)
         {
            return;
         }
         Model_farm.instace.farm_defeated_list = [];
         var value:int = patch.readShort();
         var i:int = 0;
         while(i < value)
         {
            arr = [];
            vo_info = new Vo_farmList();
            vo_info.id = LongUtil.readLong(patch);
            if(vo_info.id)
            {
               vo_info.sex = patch.readByte();
               vo_info.name = Model_heFu.repNameByHero(patch.readUTF());
               vo_info.job = patch.readByte();
               vo_info.masterID = LongUtil.readLong(patch);
               vo_info.masterName = Model_heFu.repNameByHero(patch.readUTF());
               vo_info.faction = patch.readUTF();
               vo_info.level = patch.readInt();
               Model_farm.instace.farm_defeated_list.push(vo_info);
            }
            i++;
         }
         if(!UIManager.farmArrestList.visible)
         {
            return;
         }
         UIManager.farmArrestList.update(Model_farm.defeatedPage);
      }
      
      private function gc_farm_everyday_gift(patch:IDataInput) : void
      {
         if(patch.readByte() == 1)
         {
            FarmHandler.addFarmGiftIcon();
         }
      }
      
      private function gc_farm_get_daygift_return(patch:IDataInput) : void
      {
         var id:uint = 0;
         var silver:uint = 0;
         var level:uint = 0;
         var name:String = null;
         var str:String = null;
         FarmHandler.removeFarmGiftIcon();
         if(patch.readByte() == 1)
         {
            id = uint(patch.readInt());
            silver = uint(patch.readInt());
            level = uint(patch.readByte());
            name = Model_heFu.repNameByHero(Data_lib.item[id][Enum_lib_item.STR_NAME]);
            str = LangConfig.getWord("199",9,level,name,silver);
            UIManager.centerBroadcast.addMsg(str,1);
         }
      }
      
      private function gc_farm_guide(patch:IDataInput) : void
      {
         var value:uint = uint(patch.readByte());
         if(value == Vo_farm_guide.type_guide_plant)
         {
            Model_farm.instace.guide_plant_flag = true;
            if(Boolean(UIManager.farm) && UIManager.farm.visible)
            {
               UIManager.farm.checkGuide();
            }
         }
         else if(value == Vo_farm_guide.type_guide_farmer)
         {
            Model_farm.instace.guide_farmer_flag = true;
            if(Boolean(UIManager.farm) && UIManager.farm.visible)
            {
               UIManager.farm.checkGuide();
            }
         }
      }
      
      private function flyGoods(list:Vector.<uint>, pos:uint) : void
      {
         var id:uint = 0;
         var land:View_farm_land = null;
         var point:Point = null;
         var pic:String = null;
         if(!UIManager.farm)
         {
            return;
         }
         if(list.length == 0)
         {
            return;
         }
         if(pos > 0)
         {
            land = UIManager.farm.getLandByPos(pos);
            point = UIManager.farm.localToGlobal(new Point(land.x + land.width / 2,land.y + land.height / 2));
         }
         else
         {
            land = UIManager.farm.getLandByPos(5);
            point = UIManager.farm.localToGlobal(new Point(land.x + land.width / 2 + 50,land.y + land.height / 2 + 20));
         }
         for each(id in list)
         {
            pic = Data_lib.item[id][Enum_lib_item.STR_ICON];
            Tween.gridToBagBezierFuncDef(pic,-1,point.x,point.y);
         }
      }
      
      private function isMine(id:Number) : Boolean
      {
         if(GameUnitManager.hero.id == id)
         {
            return true;
         }
         return false;
      }
      
      private function gc_farm_add_friends(patch:IDataInput) : void
      {
         if(!Model_farm.isInitFarm)
         {
            return;
         }
         if(UIManager.farmFriendList.isFirstOpen)
         {
            return;
         }
         var vo:Vo_farmList = new Vo_farmList();
         vo.id = LongUtil.readLong(patch);
         if(!vo.id)
         {
            return;
         }
         vo.sex = patch.readByte();
         vo.name = patch.readUTF();
         vo.name = Model_heFu.repNameByHero(vo.name);
         vo.status = patch.readByte();
         vo.job = patch.readByte();
         UIManager.farmFriendList.addItem(vo);
         UIManager.farmFriendList.update(Model_farm.friendsPage);
      }
      
      private function GC_EMPTY_FIELD_COUNT(patch:IDataInput) : void
      {
         var count:int = patch.readByte();
         ViewFarmIcon.instance.showTime(count);
         Global.control.sendNotification(Enum_mainUIBtn_hide.SET_COUNT,[Enum_mainUIBtn_hide.WuLinShanZhuang,count]);
      }
   }
}

