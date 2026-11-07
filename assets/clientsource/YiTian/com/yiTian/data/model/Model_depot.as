package com.yiTian.data.model
{
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.CommandManager;
   
   public class Model_depot
   {
      
      private static const MAX_CANUSE:int = 180;
      
      private var bInit_canUse:Boolean;
      
      private var _canUse:int;
      
      public var vec:Vector.<Vo_valuable>;
      
      public function Model_depot()
      {
         super();
         this.bInit_canUse = false;
      }
      
      public function init(equips:Array, items:Array) : void
      {
         this.vec = new Vector.<Vo_valuable>(this._canUse);
         this.set_vec_equip(equips);
         this.set_vec_item(items);
      }
      
      public function tidy(equips:Array, items:Array) : void
      {
         this.vec = new Vector.<Vo_valuable>(this._canUse);
         this.set_vec_equip(equips);
         this.set_vec_item(items);
      }
      
      public function update(equips:Array, items:Array) : void
      {
         this.set_vec_equip(equips);
         this.set_vec_item(items);
      }
      
      public function empty_some(arr_gridId:Array) : void
      {
         var i:int = 0;
         while(i < arr_gridId.length)
         {
            this.vec[arr_gridId[i] - 1] = null;
            i++;
         }
      }
      
      public function getUsed() : int
      {
         var _used:int = 0;
         var i:int = 0;
         while(i < this._canUse)
         {
            if(Boolean(this.vec[i]))
            {
               _used++;
            }
            i++;
         }
         return _used;
      }
      
      public function get canUse() : int
      {
         return this._canUse;
      }
      
      public function set canUse(value:int) : void
      {
         this._canUse = value;
         if(this._canUse > MAX_CANUSE)
         {
            this._canUse = MAX_CANUSE;
         }
         if(this.bInit_canUse)
         {
            while(this.vec.length < this._canUse)
            {
               this.vec.push(null);
            }
            CommandManager.update_depot();
         }
         else
         {
            this.bInit_canUse = true;
         }
      }
      
      private function set_vec_equip(equips:Array) : void
      {
         var equip_t:Vo_equip = null;
         var i:int = 0;
         while(i < equips.length)
         {
            equip_t = new Vo_equip();
            equip_t.Init_sever_bag(equips[i]);
            this.vec[equip_t.gridId - 1] = equip_t;
            i++;
         }
      }
      
      private function set_vec_item(items:Array) : void
      {
         var item_t:Vo_item = null;
         var i:int = 0;
         while(i < items.length)
         {
            item_t = new Vo_item();
            item_t.Init_sever_bag(items[i]);
            this.vec[item_t.gridId - 1] = item_t;
            i++;
         }
      }
   }
}

