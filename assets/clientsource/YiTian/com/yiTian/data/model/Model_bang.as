package com.yiTian.data.model
{
   import com.yiTian.command.BindObj;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_partyInfo;
   import com.yiTian.utils.HtmlUtil;
   import flash.utils.Dictionary;
   
   public class Model_bang
   {
      
      public static var bang_search_condition_first:String;
      
      public static var bang_search_condition_second:String;
      
      public static var partyInfo:Vo_partyInfo;
      
      public static var ZF_RESEARCH_LV_NEED:Array;
      
      public static var ZF_RESEARCH_COST:Array;
      
      public static var ZF_LEARN_COST:Array;
      
      public static var lastMGQTime:int;
      
      public static var LEADER:int = 1;
      
      public static var FU_LEADER:int = 2;
      
      public static var ZHANGLAO:int = 3;
      
      public static var bang_list_data:Array = [];
      
      public static var bang_search_type:int = 1;
      
      public static var banghuiMemberOpenID:Array = [];
      
      public static var partyType:int = 0;
      
      public static const PARTY_TYPE_NORMAL:int = 0;
      
      public static const PARTY_TYPE_NEWS:int = 1;
      
      public static var position_arr:Array = new Array();
      
      public static var position_arr_combox:Array = new Array();
      
      public static var job_arr:Array = new Array();
      
      public static const BANG_BASIC_ZF_ARR:Array = [80100,80200,80300,80400,80500,80600,80700,80800,80900,81000];
      
      public static var selfZFLevelArr:Array = [0,0,0,0,0,0,0,0,0,0];
      
      public static var bangZFLevelArr:Array = [1,1,1,1,1,1,1,1,1,1];
      
      public static var bangBuildingLevel:Array = [0,0,0,0,0];
      
      public static var bangShopSellItemArr:Array = new Array();
      
      public static var lastTreeGlobalCD:int = -1;
      
      public static var lastTreeSelfCD:int = -1;
      
      public static var treeGlobalCD:int = -1;
      
      public static var treeSelfCD:int = -1;
      
      public static var moneyTreeShakeTimes15:int = -1;
      
      public static var bbRanks:BindObj = new BindObj();
      
      public static var jkLordArr:Array = new Array();
      
      public static var bangQQGroupUnionId:String = "";
      
      public static var bangQQGroupOpenId:String = "";
      
      public static var bangHuiID:Number = 0;
      
      public static var isBindQQGroup:int = 0;
      
      public function Model_bang()
      {
         super();
      }
      
      public static function INIT_ZF() : void
      {
         var key:String = null;
         ZF_RESEARCH_LV_NEED = new Array();
         ZF_RESEARCH_COST = new Array();
         ZF_LEARN_COST = new Array();
         var dic:Dictionary = Data_lib.bangZF;
         for(key in dic)
         {
            ZF_RESEARCH_LV_NEED.push(dic[key][0]);
            ZF_RESEARCH_COST.push(dic[key][1]);
            ZF_LEARN_COST.push(dic[key][2]);
         }
      }
      
      public static function talk(txt:String) : void
      {
         var noHtmlsTxt:String = HtmlUtil.filterHtml(txt);
      }
   }
}

