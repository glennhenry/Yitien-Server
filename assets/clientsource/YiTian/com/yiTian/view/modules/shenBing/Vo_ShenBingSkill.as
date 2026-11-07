package com.yiTian.view.modules.shenBing
{
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.DictionaryTabel;
   import com.yiTian.data.vo.Vo_grid;
   
   public class Vo_ShenBingSkill extends Vo_grid
   {
      
      public static const PT_DISABLED:int = 1;
      
      public static const PT_ENABLE:int = 2;
      
      public static const PT_ENABLEDANDVALUE:int = 3;
      
      public static const PT_IDLE:int = 4;
      
      public var type:Number = 0;
      
      public var quality:int;
      
      public var nextID:int;
      
      public var num_sliverCost:int;
      
      public var id_itemCost:int;
      
      public var num_itemCost:int;
      
      public var color:int;
      
      public var triggleRound:int;
      
      public var trigglePercent:Number;
      
      public var discription:String;
      
      public var triggleDiscription:String;
      
      public var strength:int;
      
      public var sbIndex:int;
      
      public var gridType:int = 2;
      
      public var posType:int;
      
      public function Vo_ShenBingSkill()
      {
         super();
      }
      
      public function init_lib() : void
      {
         if(id == 0)
         {
            return;
         }
         var dic:DictionaryTabel = Data_lib.sbSkill;
         if(this.gridType == 1)
         {
            str_icon = "r" + dic[id][Enum_ShenBing.SKILL_ICON];
         }
         else
         {
            str_icon = dic[id][Enum_ShenBing.SKILL_ICON];
         }
         str_name = dic[id][Enum_ShenBing.SKILL_NAME];
         this.type = dic[id][Enum_ShenBing.SKILL_TYPE];
         this.quality = dic[id][Enum_ShenBing.SKILL_QUALITY];
         this.nextID = dic[id][Enum_ShenBing.SKILL_NEXT_ID];
         this.num_sliverCost = dic[id][Enum_ShenBing.SKILL_NUM_SLIVERCOST];
         this.id_itemCost = dic[id][Enum_ShenBing.SKILL_ID_ITEMCOST];
         this.num_itemCost = dic[id][Enum_ShenBing.SKILL_NUM_ITEMCOST];
         this.triggleRound = dic[id][Enum_ShenBing.SKILL_TRIGGLE_ROUND];
         this.trigglePercent = dic[id][Enum_ShenBing.SKILL_TRIGGLE_PERCENT];
         this.strength = dic[id][Enum_ShenBing.SKILL_STRENGTH];
         this.discription = dic[id][Enum_ShenBing.SKILL_DISCRIPTION];
         this.triggleDiscription = dic[id][Enum_ShenBing.SKILL_TRIGGLE_DISCRIPTION];
      }
      
      public function isMaxQuality() : Boolean
      {
         return this.quality >= 5;
      }
   }
}

