package com.yiTian.data.vo
{
   import com.utils.Util;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.valuable.Enum_lib_item;
   import com.yiTian.manager.LangConfig;
   
   public class Vo_Skill extends Vo_grid
   {
      
      public static const JOB:int = 0;
      
      public static const NAME:int = 1;
      
      public static const TARGET:int = 2;
      
      public static const TARGET_NUM:int = 3;
      
      public static const SKILL_TYPE:int = 4;
      
      public static const SCOPE:int = 5;
      
      public static const RANGE:int = 6;
      
      public static const COOLTIME:int = 7;
      
      public static const MP_CONSUME:int = 8;
      
      public static const EFFECT1:int = 9;
      
      public static const NUM_VALUE1:int = 10;
      
      public static const EFFECT2:int = 11;
      
      public static const NUM_VALUE2:int = 12;
      
      public static const SPECIAL_EFFECT:int = 13;
      
      public static const EFFECT_VALUE:int = 14;
      
      public static const BUFF_HIT_RATE:int = 15;
      
      public static const SKILL_ICON:int = 16;
      
      public static const RELEASE_SWF_EFFECT:int = 17;
      
      public static const EFFECT_SWF_NUMBER:int = 18;
      
      public static const FILE_DESCRIPTION:int = 19;
      
      public static const EFFECT_DESCRIPTION:int = 20;
      
      public static const PRESET_SKILL:int = 21;
      
      public static const REQUIRED_PROP:int = 22;
      
      public static const STUDY_GRADE:int = 23;
      
      public static const PROMO_SKILL_ID:int = 24;
      
      public static const CURRENT_GRADE:int = 25;
      
      public static const GRADE_LIMIT:int = 26;
      
      public static const BUFF_EFFECT_ID:int = 27;
      
      public static const ZAN_DOU_LI:int = 28;
      
      public static const HAPPEN_RATE:int = 29;
      
      public static const ACTION:int = 33;
      
      public static const ACTION_TIME:int = 34;
      
      public static const HIT_DELAY:int = 35;
      
      public static const RELEASE_TIME:int = 36;
      
      public static const EFFECT_TIME:int = 37;
      
      public static const YAN_SWF:int = 38;
      
      public static const YAN_TIME:int = 39;
      
      public static const DISTANCE:int = 40;
      
      public static const MUSIC:int = 41;
      
      public static const HAS_HURT_EFF:int = 42;
      
      public static const SKILL_SOURCE:int = 43;
      
      public static const SKILL_JIEFENG:int = 44;
      
      public static var data:Array = [];
      
      public static var masterData:Array = [];
      
      public static var barData:Array = [];
      
      private static var comeFromArr:Array = ["杂货店","声望店","声望商城"];
      
      public var target:String;
      
      public var job:String;
      
      public var skill_type:int;
      
      public var target_num:int;
      
      public var scope:String;
      
      public var cooltime:int;
      
      public var mp_consume:int;
      
      public var effect1:String;
      
      public var num_value1:int;
      
      public var effect2:String;
      
      public var num_value2:int;
      
      public var special_effect:int;
      
      public var effect_value:int;
      
      public var buff_hit_rate:int;
      
      public var release_swf_effect:int;
      
      public var effect_swf_number:int;
      
      public var file_description:String;
      
      public var effect_description:String;
      
      public var preset_skill:int;
      
      public var required_prop:int;
      
      public var study_grade:int;
      
      public var promo_skill_id:int;
      
      public var zPromo_skill_id:int;
      
      public var xPromo_skill_id:int;
      
      public var current_grade:int;
      
      public var grade_limit:int;
      
      public var buff_effect_id:int;
      
      public var range:int;
      
      public var skill_sour:int;
      
      public var special_skill_sour:String;
      
      public var skill_jiefeng:String;
      
      public var target_str:String;
      
      public var required_daoju:String;
      
      public var zRequired:int;
      
      public var xRequired:int;
      
      public var isSpecial:Boolean = false;
      
      public var realId:int;
      
      public var isDaBiao:Boolean = false;
      
      public function Vo_Skill(id:int)
      {
         var a:Array = null;
         var aa:Array = null;
         var type:int = 0;
         var sId:int = 0;
         var a2:Array = null;
         var aa2:Array = null;
         var type2:int = 0;
         var sId2:int = 0;
         var tAA:Array = null;
         super();
         this.id = id;
         this.range = Data_lib.skill[id][RANGE];
         this.job = Data_lib.skill[id][JOB];
         this.skill_type = Data_lib.skill[id][SKILL_TYPE];
         if(Data_lib.skill[id][SKILL_TYPE] == 1)
         {
            str_describe = LangConfig.getWord("784",0);
         }
         else if(this.mp_consume == 0)
         {
            str_describe = LangConfig.getWord("785",0);
         }
         else
         {
            str_describe = LangConfig.getWord("786",0);
         }
         str_name = Data_lib.skill[id][NAME];
         if(Data_lib.skill[id][TARGET] == 3)
         {
            this.target = LangConfig.getWord("787",0);
         }
         else if(Data_lib.skill[id][TARGET] == 1)
         {
            this.target = LangConfig.getWord("788",0);
         }
         else if(Data_lib.skill[id][TARGET] == 2)
         {
            this.target = LangConfig.getWord("789",0);
         }
         this.target_num = Data_lib.skill[id][TARGET_NUM];
         if(this.target_num == 1)
         {
            this.target_str = LangConfig.getWord("790",0);
         }
         else if(this.target_num == 2)
         {
            this.target_str = LangConfig.getWord("791",0);
         }
         this.scope = Data_lib.skill[id][SCOPE];
         this.cooltime = Data_lib.skill[id][COOLTIME];
         this.mp_consume = Data_lib.skill[id][MP_CONSUME];
         this.effect1 = Data_lib.skill[id][EFFECT1];
         this.num_value1 = Data_lib.skill[id][NUM_VALUE1];
         this.effect2 = Data_lib.skill[id][EFFECT2];
         this.num_value2 = Data_lib.skill[id][NUM_VALUE2];
         this.special_effect = Data_lib.skill[id][SPECIAL_EFFECT];
         this.effect_value = Data_lib.skill[id][EFFECT_VALUE];
         this.buff_hit_rate = Data_lib.skill[id][BUFF_HIT_RATE];
         str_icon = Data_lib.skill[id][SKILL_ICON];
         this.release_swf_effect = Data_lib.skill[id][RELEASE_SWF_EFFECT];
         this.effect_swf_number = Data_lib.skill[id][EFFECT_SWF_NUMBER];
         this.file_description = Data_lib.skill[id][FILE_DESCRIPTION];
         this.effect_description = Data_lib.skill[id][EFFECT_DESCRIPTION];
         this.preset_skill = Data_lib.skill[id][PRESET_SKILL];
         this.current_grade = Data_lib.skill[id][CURRENT_GRADE];
         this.study_grade = Data_lib.skill[id][STUDY_GRADE];
         var nxtSkillInfoStr:Object = Data_lib.skill[id][PROMO_SKILL_ID];
         if(nxtSkillInfoStr is String)
         {
            a = Util.splicObj(nxtSkillInfoStr as String,",_|") as Array;
            this.promo_skill_id = int(a[0][0][0]);
            for each(aa in a[1])
            {
               type = int(aa[0]);
               sId = int(aa[1]);
               if(type == 1)
               {
                  this.zPromo_skill_id = sId;
               }
               if(type == 2)
               {
                  this.xPromo_skill_id = sId;
               }
            }
         }
         else
         {
            this.promo_skill_id = Data_lib.skill[id][PROMO_SKILL_ID];
            this.zPromo_skill_id = this.xPromo_skill_id = 0;
         }
         nxtSkillInfoStr = Data_lib.skill[id][REQUIRED_PROP];
         if(Data_lib.skill[id][REQUIRED_PROP] is String)
         {
            a2 = Util.splicObj(nxtSkillInfoStr as String,",_|") as Array;
            this.required_prop = int(a2[0][0][0]);
            for each(aa2 in a2[1])
            {
               type2 = int(aa2[0]);
               sId2 = int(aa2[1]);
               if(type2 == 1)
               {
                  this.zRequired = sId2;
               }
               if(type2 == 2)
               {
                  this.xRequired = sId2;
               }
            }
         }
         else
         {
            this.required_prop = Data_lib.skill[id][REQUIRED_PROP];
            this.zRequired = this.xRequired = 0;
         }
         this.handle_of_lvl(this.required_prop);
         this.grade_limit = Data_lib.skill[id][GRADE_LIMIT];
         this.buff_effect_id = Data_lib.skill[id][BUFF_EFFECT_ID];
         if(Data_lib.skill[id][SKILL_SOURCE].toString().indexOf("_") == -1)
         {
            this.skill_sour = Data_lib.skill[id][SKILL_SOURCE];
         }
         else
         {
            tAA = Data_lib.skill[id][SKILL_SOURCE].split("_");
            this.special_skill_sour = comeFromArr[tAA[1] - 1];
         }
         this.skill_jiefeng = Data_lib.skill[id][SKILL_JIEFENG];
      }
      
      public static function getDataById(id:int) : Vo_grid
      {
         var voK:Vo_Skill = null;
         var i:int = 0;
         while(i < data.length)
         {
            if(data[i].id == id)
            {
               return data[i];
            }
            i++;
         }
         for each(voK in masterData)
         {
            if(voK.id == id)
            {
               return voK;
            }
         }
         return null;
      }
      
      private function handle_of_lvl(_num:int) : void
      {
         if(!_num || _num < 40000 || _num > 100000)
         {
            return;
         }
         this.required_daoju = Data_lib.item[_num][Enum_lib_item.STR_NAME];
      }
   }
}

