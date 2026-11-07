package com.yiTian.data.vo
{
   public class Vo_partyInfo
   {
      
      public static var PARTY_ID:int = 0;
      
      public static var PARTY_NAME:int = 1;
      
      public static var LEADER_NAME:int = 2;
      
      public static var PARTY_LVL:int = 3;
      
      public static var PARTY_PAIMING:int = 4;
      
      public static var PARTY_MEM_NUM:int = 5;
      
      public static var PARTY_MEM_NUM_LIM:int = 6;
      
      public static var PARTY_FORTURN:int = 7;
      
      public static var PARTY_VOICE_CHANNEL:int = 8;
      
      public static var PARTY_QQ:int = 9;
      
      public static var PARTY_DECLARATION:int = 10;
      
      public static var PARTY_ANNOUNCE:int = 11;
      
      public static var PARTY_WEIHU_COST:int = 12;
      
      public static var PARTY_POSITION:int = 13;
      
      public static var PARTY_SELF_GONG:int = 14;
      
      public static var PARTY_GONG:int = 15;
      
      public static var PARTY_BENEFIT:int = 16;
      
      public static var PARTU_BENEFIT_COST:int = 17;
      
      public var party_id:Number;
      
      public var party_name:String;
      
      public var leader_name:String;
      
      public var party_lvl:int;
      
      public var party_paiming:int;
      
      public var party_mem_num:int;
      
      public var party_mem_num_lim:int;
      
      public var party_forturn:int;
      
      public var party_voice_channel:String;
      
      public var party_qq:String;
      
      public var party_declaration:String;
      
      public var party_announce:String;
      
      public var party_position:int;
      
      public var party_self_gong:int;
      
      public var party_gong:int;
      
      public var party_benefit:int;
      
      public var party_benefit_cost:int;
      
      public var party_weihu_cost:int;
      
      public function Vo_partyInfo()
      {
         super();
      }
      
      public function init(arr:Array) : void
      {
         this.party_id = arr[PARTY_ID];
         this.party_name = arr[PARTY_NAME];
         this.leader_name = arr[LEADER_NAME];
         this.party_lvl = arr[PARTY_LVL];
         this.party_paiming = arr[PARTY_PAIMING];
         this.party_mem_num = arr[PARTY_MEM_NUM];
         this.party_mem_num_lim = arr[PARTY_MEM_NUM_LIM];
         this.party_forturn = arr[PARTY_FORTURN];
         this.party_voice_channel = arr[PARTY_VOICE_CHANNEL];
         this.party_qq = arr[PARTY_QQ];
         this.party_declaration = arr[PARTY_DECLARATION];
         this.party_announce = arr[PARTY_ANNOUNCE];
         this.party_position = arr[PARTY_POSITION];
         this.party_self_gong = arr[PARTY_SELF_GONG];
         this.party_gong = arr[PARTY_GONG];
         this.party_benefit = arr[PARTY_BENEFIT];
         this.party_benefit_cost = arr[PARTU_BENEFIT_COST];
         this.party_weihu_cost = arr[PARTY_WEIHU_COST];
      }
   }
}

