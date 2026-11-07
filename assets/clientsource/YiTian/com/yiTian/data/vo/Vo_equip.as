package com.yiTian.data.vo
{
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_SzCount;
   import com.yiTian.data.config.valuable.Enum_lib_attribute;
   import com.yiTian.data.config.valuable.Enum_lib_equip;
   import com.yiTian.data.config.valuable.Enum_sever_equip_bag;
   
   public class Vo_equip extends Vo_valuable
   {
      
      public static const MAX_HOLE:int = 4;
      
      public static const WARNING_NJ:int = 10;
      
      public static const MAX_LV_INTENSIFY:int = 10;
      
      private static const _keyArr:Array = ["气血","内力","攻击","防御","命中","闪避","暴击","格档","攻速"];
      
      public static var data_zb:Array = [];
      
      public var vec_basic:Vector.<int>;
      
      public var vec_intensify:Vector.<int>;
      
      public var vec_extend:Vector.<int>;
      
      public var vec_gemId:Vector.<int>;
      
      public var cur_hole:int;
      
      public var cur_nj:int;
      
      public var max_nj:int;
      
      public var strength:int;
      
      public var fail_count:int;
      
      public var extral_of_equip_str:String;
      
      public var id_tz:int;
      
      public var model:int;
      
      public var sex:int;
      
      public var time_limit:int;
      
      public var type_group:int;
      
      private var bPreview:Boolean;
      
      public var bDress:Boolean;
      
      public var isColor:int;
      
      public var skillId:int;
      
      public var skillLvl:int;
      
      public var jingLianCount:int;
      
      public var cz_insten_vec:Vector.<int>;
      
      public var maxRefine:int;
      
      public var daoTime:int;
      
      public var kangBao:int;
      
      public var baoShangJC:int;
      
      public var baoShangJM:int;
      
      public var totalData:Array = [];
      
      public var newTaoZhuangId:int = 0;
      
      public var poshStarVec:Vector.<int> = new Vector.<int>();
      
      public function Vo_equip()
      {
         super();
         this.vec_basic = new Vector.<int>();
         this.vec_extend = new Vector.<int>();
         this.vec_gemId = new Vector.<int>();
         this.vec_intensify = new Vector.<int>();
         this.cz_insten_vec = new Vector.<int>();
         this.bDress = false;
         this.bPreview = true;
      }
      
      public function Init_sever_bag(dto:Array) : void
      {
         var j:int = 0;
         var arr:Array = null;
         var len:int = 0;
         this.totalData = dto;
         id_server = dto[Enum_sever_equip_bag.ID_SERVER];
         id = dto[Enum_sever_equip_bag.ID];
         gridId = dto[Enum_sever_equip_bag.GRID_ID];
         color = dto[Enum_sever_equip_bag.COLOR];
         lv = dto[Enum_sever_equip_bag.LV_INTENSIFY];
         this.cur_nj = dto[Enum_sever_equip_bag.CUR_NJ];
         this.cur_hole = dto[Enum_sever_equip_bag.CUR_HOLE];
         price = dto[Enum_sever_equip_bag.PRICE];
         bBind = dto[Enum_sever_equip_bag.BIND];
         this.strength = dto[Enum_sever_equip_bag.STRENGTH];
         this.fail_count = dto[Enum_sever_equip_bag.FAIL_COUNT];
         this.extral_of_equip_str = dto[Enum_sever_equip_bag.STR_EXTRAL];
         this.isColor = dto[Enum_sever_equip_bag.IS_SKILL_COLOR];
         this.skillId = dto[Enum_sever_equip_bag.SKILL_ID];
         this.skillLvl = dto[Enum_sever_equip_bag.SKILL_LEVEL];
         this.jingLianCount = dto[Enum_sever_equip_bag.REFINE_TIMES];
         this.daoTime = dto[Enum_sever_equip_bag.SZ_COUNT];
         if(dto.length >= Enum_sever_equip_bag.baoShangJM)
         {
            this.kangBao = dto[Enum_sever_equip_bag.kangBao];
            this.baoShangJC = dto[Enum_sever_equip_bag.BaoShangJC];
            this.baoShangJM = dto[Enum_sever_equip_bag.baoShangJM];
         }
         this.newTaoZhuangId = dto[Enum_sever_equip_bag.taoZhuangId];
         if(this.daoTime > 0 && bBind)
         {
            Enum_SzCount.szCountHandle(this,this.daoTime);
         }
         arr = dto[Enum_sever_equip_bag.ARR_BASIC];
         len = int(arr.length);
         j = 0;
         while(j < len)
         {
            this.vec_basic.push(arr[j]);
            j++;
         }
         arr = dto[Enum_sever_equip_bag.ARR_EXTRA];
         len = int(arr.length);
         j = 0;
         while(j < len)
         {
            this.vec_extend.push(arr[j]);
            j++;
         }
         arr = dto[Enum_sever_equip_bag.ARR_INTENSIFY];
         len = int(arr.length);
         j = 0;
         while(j < len)
         {
            this.vec_intensify.push(arr[j]);
            j++;
         }
         arr = dto[Enum_sever_equip_bag.ARR_STONE];
         len = int(arr.length);
         j = 0;
         while(j < len)
         {
            this.vec_gemId.push(arr[j]);
            j++;
         }
         arr = dto[Enum_sever_equip_bag.REFINE_ARR];
         len = int(arr.length);
         j = 0;
         while(j < len)
         {
            this.cz_insten_vec.push(arr[j]);
            j++;
         }
         this.bPreview = false;
         this.Init_lib();
      }
      
      private function getMaxRefine() : void
      {
         if(lv_use >= 50 && lv_use <= 69)
         {
            this.maxRefine = 10;
         }
         else if(lv_use >= 70 && lv_use <= 89)
         {
            this.maxRefine = 15;
         }
         else if(lv_use >= 90 && lv_use <= 109)
         {
            this.maxRefine = 20;
         }
         else if(lv_use >= 110 && lv_use <= 129)
         {
            this.maxRefine = 25;
         }
         else if(lv_use >= 130 && lv_use <= 139)
         {
            this.maxRefine = 30;
         }
      }
      
      override public function Init_lib() : void
      {
         if(id == 500000)
         {
            return;
         }
         str_icon = Data_lib.equip[id][Enum_lib_equip.STR_ICON];
         str_name = Data_lib.equip[id][Enum_lib_equip.STR_NAME];
         lv_use = Data_lib.equip[id][Enum_lib_equip.LV_USE];
         job = Data_lib.equip[id][Enum_lib_equip.JOB];
         type = Data_lib.equip[id][Enum_lib_equip.TYPE];
         this.max_nj = Data_lib.equip[id][Enum_lib_equip.MAX_NJ];
         bDiscard = Data_lib.equip[id][Enum_lib_equip.DISCARD];
         color = Data_lib.equip[id][Enum_lib_equip.COLOR];
         this.model = Data_lib.equip[id][Enum_lib_equip.MODEL];
         this.id_tz = Data_lib.equip[id][Enum_lib_equip.ID_TZ];
         this.type_group = Data_lib.equip[id][Enum_lib_equip.TYPE_GROUP];
         this.sex = Data_lib.equip[id][Enum_lib_equip.SEX];
         this.time_limit = Data_lib.equip[id][Enum_lib_equip.TIME_LIMIT];
         str_help = Data_lib.equip[id][Enum_lib_equip.STR_HELP];
         str_describe = Data_lib.equip[id][Enum_lib_equip.STR_DESCRIBE];
         bgIndex = color;
         if(color >= 5)
         {
            this.getMaxRefine();
         }
         if(this.bPreview)
         {
            this.get_vec_basic(Data_lib.equip[id][Enum_lib_equip.STR_BASIC]);
            this.cur_nj = this.max_nj;
         }
         var i:int = 0;
         while(i < this.vec_extend.length / 4)
         {
            this.getPoshStar(this.vec_extend[4 * i],this.vec_extend[4 * i + 1]);
            i++;
         }
      }
      
      private function getPoshStar(id_attribute:int, value:int) : void
      {
         var _n:Number = NaN;
         var _a:int = 0;
         var __color:int = color;
         __color = __color <= 4 ? __color : 4;
         var Lvl:int = lv_use;
         var _key1:int = Math.ceil(Lvl / 10);
         var ss:String = Data_lib.attribute[id_attribute][Enum_lib_attribute.STR_NAME];
         var _keyIndex:int = _keyArr.indexOf(ss);
         if(_keyIndex != -1)
         {
            _a = int(Data_lib.equipPolish[_key1][_keyIndex]);
         }
         var __n:int = Math.pow(1 / (_a * Math.pow(__color,0.5) / value),1 / 0.7) * 10 % 10;
         if(__n >= 5)
         {
            _n = Math.ceil(Math.pow(1 / (_a * Math.pow(__color,0.5) / value),1 / 0.7));
         }
         else
         {
            _n = Math.floor(Math.pow(1 / (_a * Math.pow(__color,0.5) / value),1 / 0.7));
         }
         this.poshStarVec.push(_n);
      }
      
      private function get_vec_basic(str:String) : void
      {
         var arr:Array = null;
         var i:int = 0;
         if(this.vec_basic.length == 0)
         {
            arr = str.split(",");
            i = 0;
            while(i < arr.length)
            {
               arr[i] = (arr[i] as String).split("_");
               this.vec_basic.push(int(arr[i][0]));
               this.vec_basic.push(int(arr[i][1]));
               this.vec_basic.push(0);
               i++;
            }
         }
      }
      
      public function Init_sever_ZB(dto:Array) : void
      {
         gridId = dto[Enum_sever_equip_bag.GRID_ID];
         id = dto[Enum_sever_equip_bag.ID];
         price = dto[3];
         this.Init_lib();
      }
   }
}

