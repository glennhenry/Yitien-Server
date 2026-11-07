package com.yiTian.data.vo
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.valuable.Enum_item_type;
   import com.yiTian.data.config.valuable.Enum_lib_item;
   import com.yiTian.data.config.valuable.Enum_sever_item_bag;
   import com.yiTian.manager.GameUnitManager;
   
   public class Vo_item extends Vo_valuable
   {
      
      public static const MAX_LV_GEM:int = 9;
      
      public var result:int;
      
      public var type_result:int;
      
      public var num_combining:int;
      
      public var id_combining:int;
      
      public var bUseable:int;
      
      public var cold_time:int;
      
      public var Arran_order:int;
      
      public var combin_cost:int;
      
      public var big_type:int;
      
      public var source:String;
      
      public var face_effect_days:int;
      
      public var face_icon_id:int;
      
      private var pool:Array = [];
      
      public function Vo_item()
      {
         super();
      }
      
      public function Init_sever_bag(dto:Array) : void
      {
         id = dto[Enum_sever_item_bag.ID];
         gridId = dto[Enum_sever_item_bag.GRID_ID];
         bBind = dto[Enum_sever_item_bag.BIND];
         count = dto[Enum_sever_item_bag.COUNT];
         this.Init_lib();
      }
      
      override public function Init_lib() : void
      {
         var arr:Array = Data_lib.item[id];
         if(arr == null)
         {
            return;
         }
         str_icon = arr[Enum_lib_item.STR_ICON];
         str_name = arr[Enum_lib_item.STR_NAME];
         type = arr[Enum_lib_item.TYPE];
         this.type_result = arr[Enum_lib_item.TYPE_RESULT];
         this.result = arr[Enum_lib_item.RESULT];
         price = arr[Enum_lib_item.PRICE];
         lv_use = arr[Enum_lib_item.LV_USE];
         this.num_combining = arr[Enum_lib_item.NUM_COMBINING];
         this.id_combining = arr[Enum_lib_item.ID_COMBINING];
         bDiscard = arr[Enum_lib_item.DISCARD];
         this.bUseable = arr[Enum_lib_item.USEABLE];
         color = arr[Enum_lib_item.COLOR];
         lv = arr[Enum_lib_item.LV];
         this.cold_time = arr[Enum_lib_item.COLD_TIME];
         job = arr[Enum_lib_item.JOB];
         str_describe = arr[Enum_lib_item.STR_DESCRIBE];
         str_help = arr[Enum_lib_item.STR_HELP];
         this.Arran_order = arr[Enum_lib_item.ORDER];
         this.combin_cost = arr[Enum_lib_item.COMBIN_COST];
         this.big_type = arr[Enum_lib_item.BIG_TYPE];
         this.source = arr[Enum_lib_item.SOURCE];
         this.face_effect_days = arr[Enum_lib_item.FACE_EFFECT_DAYS];
         this.face_icon_id = arr[Enum_lib_item.FACE_ICON_ID];
         bgIndex = color;
         if(type == Enum_item_type.LVGIFT)
         {
            this.Init_lvGift();
            return;
         }
      }
      
      public function Init_sever_ZHD(dto:Array) : void
      {
         gridId = dto[Enum_sever_item_bag.ID];
         id = dto[Enum_sever_item_bag.GRID_ID];
         type = dto[Enum_sever_item_bag.BIND];
         price = dto[Enum_sever_item_bag.COUNT];
         this.Init_lib();
      }
      
      public function Init_lvGift() : void
      {
         var lib:Array = Data_lib.item[id];
         var usLv:Array = String(lib[Enum_lib_item.USERLVL]).split(",");
         var lvArr:Array = [];
         var i:int = 0;
         while(i < usLv.length)
         {
            lvArr.push(String(usLv[i]).split("~")[0]);
            i++;
         }
         var index:int = this.getIndex(lvArr);
         var giftID:int = int(String(usLv[index]).split("_")[1]);
         var arr:Array = Data_lib.dengjilibao[giftID];
         lv_use = String(arr[3]).split("_")[0];
         str_describe = arr[4];
         if(this.pool.indexOf(id) == -1)
         {
            this.pool.push(id);
         }
         Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP_2,this.refreshTip);
      }
      
      public function refreshTip() : void
      {
         var ids:int = 0;
         var lib:Array = null;
         var usLv:Array = null;
         var lvArr:Array = null;
         var b:int = 0;
         var index:int = 0;
         var giftID:int = 0;
         var arr:Array = null;
         var i:int = this.pool.length - 1;
         while(i >= 0)
         {
            ids = int(this.pool[i]);
            lib = Data_lib.item[ids];
            usLv = String(lib[Enum_lib_item.USERLVL]).split(",");
            lvArr = [];
            b = 0;
            while(b < usLv.length)
            {
               lvArr.push(String(usLv[b]).split("~")[0]);
               b++;
            }
            index = this.getIndex(lvArr);
            giftID = int(String(usLv[index]).split("_")[1]);
            arr = Data_lib.dengjilibao[giftID];
            lv_use = String(arr[3]).split("_")[0];
            str_describe = arr[4];
            i--;
         }
      }
      
      private function getIndex(arr:Array) : int
      {
         var algin:int = 0;
         var lvs:int = GameUnitManager.hero.level;
         if(lvs <= arr[0])
         {
            return arr[0];
         }
         var tempArr:Array = [];
         var aa:int = arr.length - 1;
         while(aa >= 0)
         {
            algin = lvs - arr[aa];
            if(algin >= 0)
            {
               tempArr.push({
                  "type":algin,
                  "index":aa
               });
            }
            aa--;
         }
         tempArr.sortOn("type",Array.NUMERIC);
         return tempArr[0]["index"];
      }
   }
}

