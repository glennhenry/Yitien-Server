package com.yiTian.data.model
{
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.view.modules.role.Enum_lib_meridian;
   import com.yiTian.view.modules.xunZhang.XunZhang;
   
   public class Model_role
   {
      
      public static var xunZhangVo:Vo_valuable;
      
      public var vec_meridian:Vector.<int>;
      
      public var vec_equip:Vector.<Vo_equip>;
      
      public function Model_role()
      {
         super();
         this.vec_equip = new Vector.<Vo_equip>(12,true);
      }
      
      public function init_vec_meridian(vec:Vector.<int>) : void
      {
         this.vec_meridian = vec;
      }
      
      public function update_vec_meridian(meridianID:int) : void
      {
         this.vec_meridian[Data_lib.meridian[meridianID][Enum_lib_meridian.TYPE] - 1] = meridianID;
      }
      
      public function init_vec_equip(equips:Array) : void
      {
         this.set_vec_equip(equips);
      }
      
      public function update_vec_equip(equips:Array) : void
      {
         this.set_vec_equip(equips);
      }
      
      public function empty_grid(gridId:int) : void
      {
         if(gridId == 13)
         {
            xunZhangVo = null;
         }
         else
         {
            this.vec_equip[gridId - 1] = null;
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
            equip_t.bDress = true;
            if(equip_t.gridId >= 13)
            {
               xunZhangVo = equip_t;
               XunZhang._vo = xunZhangVo;
            }
            else
            {
               this.vec_equip[equip_t.gridId - 1] = equip_t;
            }
            i++;
         }
      }
   }
}

