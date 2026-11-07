package com.yiTian.data.model
{
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.view.modules.qiJu.MyTeamVo;
   
   public class Model_QiJu
   {
      
      public static var skip_time:int;
      
      public static var qiJuGame_time:int;
      
      public static var qiJuGame_count:int;
      
      public static var inQijuGame:Boolean;
      
      public static var isCaptain:Boolean;
      
      public static var inTeam:Boolean;
      
      public static var team_id:int;
      
      public static var team_captain_id:Number;
      
      public static var qiJuBoss:Npc;
      
      public static var game_type:int = -1;
      
      public static var listVo:Array = [];
      
      public static var myTeamVo:Vector.<MyTeamVo> = new Vector.<MyTeamVo>();
      
      public static var team_Type:int = -1;
      
      public static var leftTime:int = -1;
      
      public static var isJoinPnlShow:Boolean = false;
      
      public function Model_QiJu()
      {
         super();
      }
   }
}

